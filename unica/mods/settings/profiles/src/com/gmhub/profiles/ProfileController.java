package com.gmhub.profiles;

import android.content.Context;
import android.os.Handler;
import android.os.Looper;
import android.util.Log;
import android.widget.Toast;
import java.util.Arrays;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

/** Native preference bridge; all provider, Binder and journal I/O stays off the UI. */
public final class ProfileController {
    public interface Host {
        Context context();
        void show(String value, String summary, boolean enabled);
    }
    private final Host host;
    private final Context context;
    private final Handler main = new Handler(Looper.getMainLooper());
    private final ExecutorService worker = Executors.newSingleThreadExecutor();
    private ProfileBackend backend;
    private boolean active, busy, closed;
    private String last = "", summary = "";
    public ProfileController(Host host) { this.host = host; context = host.context(); }
    private ProfileBackend backend() {
        if (backend == null) backend = new ProfileBackend(context);
        return backend;
    }
    private String text(String key) {
        int id = context.getResources().getIdentifier(key, "string", context.getPackageName());
        return id == 0 ? key : context.getString(id);
    }
    private String description(String status) {
        if (status.equals("custom")) return text("gm_profiles_custom");
        if (status.equals("pending")) return text("gm_profiles_pending");
        return text("paradox_core_mode_" + status + "_desc");
    }
    public static String label(Context context, String status) {
        String key = status.equals("custom") ? "gm_profiles_custom_label"
            : status.equals("pending") ? "gm_profiles_pending_label" : "paradox_core_mode_" + status;
        int id = context.getResources().getIdentifier(key, "string", context.getPackageName());
        return id == 0 ? status : context.getString(id);
    }
    public void resume() {
        active = true;
        if (!busy && !closed) execute(null); else if (!closed) host.show(last, summary, false);
    }
    public void pause() { active = false; }
    public void close() { active = false; closed = true; worker.shutdown(); }
    /** Native preference keeps its old value until the complete operation is confirmed. */
    public boolean select(String mode) {
        if (!Arrays.asList("stock", "smooth", "gaming", "battery").contains(mode)) return false;
        if (active && !closed && !busy) execute(mode);
        return false;
    }
    public void restore() { if (active && !closed && !busy) execute("stock"); }
    private void execute(String request) {
        busy = true; host.show(last, text("gm_profiles_working"), false);
        worker.submit(() -> {
            String status = "", message = "", toast = null;
            boolean editable = true;
            try {
                ProfileBackend service = backend();
                if (request != null) {
                    if (request.equals("stock")) {
                        ProfileEngine.RestoreResult result = service.engine.restore();
                        toast = result.failed != 0 ? text("gm_profiles_restore_conflict")
                            : result.conflicts != 0 ? text("gm_profiles_preserved") : text("paradox_core_restored");
                    } else {
                        service.engine.apply(request, service.plan(request));
                        toast = text("gm_profiles_confirmed");
                    }
                }
                status = service.engine.status();
                if (request != null) service.publishStatus(status);
                message = description(status);
            } catch (Exception failure) {
                Log.w("GMHubProfiles", "Profile operation not confirmed", failure);
                toast = text("gm_profiles_failed");
                if (backend == null) { editable = false; message = text("gm_profiles_unavailable"); }
                else {
                    try {
                        status = backend.engine.status(); message = description(status);
                        if (request != null) backend.publishStatus(status);
                    }
                    catch (Exception unreadable) { message = text("gm_profiles_unreadable"); }
                }
            }
            final String completed = status, detail = message, notification = toast;
            final boolean enabled = editable;
            main.post(() -> {
                busy = false; last = completed; summary = detail;
                if (active && !closed) {
                    host.show(last, summary, enabled);
                    if (notification != null && request != null) Toast.makeText(context, notification, Toast.LENGTH_LONG).show();
                }
            });
        });
    }
}
