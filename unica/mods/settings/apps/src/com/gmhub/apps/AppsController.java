package com.gmhub.apps;

import android.app.AlertDialog;
import android.content.Context;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageManager;
import android.graphics.drawable.Drawable;
import android.os.Handler;
import android.os.Looper;
import android.util.Log;
import android.util.LruCache;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.ImageView;
import android.widget.Toast;
import java.lang.ref.WeakReference;
import java.text.Collator;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Locale;
import java.util.Set;
import java.util.WeakHashMap;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.ArrayBlockingQueue;
import java.util.concurrent.TimeUnit;

/** Background package operations, native Settings preferences, user-scoped journal. */
public final class AppsController {
    public interface Host {
        Context context();
        void clear(String message);
        void row(String pkg, String label, boolean enabled, boolean editable, String summary);
        void busy(boolean value);
    }
    private static final String[] OPTIONAL = {
        "com.samsung.android.bixby.agent", "com.samsung.android.app.spage",
        "com.sec.android.app.sbrowser", "com.samsung.android.game.gametools",
        "com.samsung.android.kidsinstaller"
    };
    private static final class Row {
        final String pkg, label; final boolean enabled, editable;
        Row(ApplicationInfo app, String label, boolean editable) {
            this.pkg = app.packageName; this.label = label;
            enabled = app.enabled; this.editable = editable;
        }
    }
    private final Host host;
    private final Context context;
    private final Handler main = new Handler(Looper.getMainLooper());
    private final ExecutorService worker = Executors.newSingleThreadExecutor();
    private final ThreadPoolExecutor icons = new ThreadPoolExecutor(1, 1, 0, TimeUnit.SECONDS,
        new ArrayBlockingQueue<Runnable>(16), new ThreadPoolExecutor.DiscardOldestPolicy());
    private final LruCache<String, Drawable.ConstantState> iconCache = new LruCache<>(12);
    private final WeakHashMap<ImageView, String> iconBindings = new WeakHashMap<>();
    private AppBackend backend; // Created/used only by worker, including preferences disk I/O.
    private Future<?> inventory;
    private volatile boolean active, closed;
    private int generation;
    private boolean busy;
    private boolean showSystem;
    private String query = "";
    private AlertDialog dialog;
    private final Runnable search = () -> reload();

    public AppsController(Host host) { this.host = host; context = host.context(); }
    private AppBackend backend() {
        if (backend == null) backend = new AppBackend(context);
        return backend;
    }
    private String text(String key) {
        int id = context.getResources().getIdentifier(key, "string", context.getPackageName());
        return id == 0 ? key : context.getString(id);
    }
    public void resume() { if (!closed) { active = true; host.busy(busy); reload(); } }
    public void pause() {
        active = false; generation++; main.removeCallbacks(search);
        if (inventory != null) inventory.cancel(true);
        if (dialog != null) { dialog.dismiss(); dialog = null; }
        icons.getQueue().clear(); iconBindings.clear(); iconCache.evictAll();
    }
    public void close() {
        pause(); closed = true; worker.shutdown(); icons.shutdownNow();
    }
    public void search(String value) {
        query = value == null ? "" : value.trim();
        // Invalidate the old result immediately, not after the debounce.
        generation++; if (inventory != null) inventory.cancel(true);
        main.removeCallbacks(search); main.postDelayed(search, 250);
    }
    private boolean current(int epoch) { return active && !closed && epoch == generation; }
    private void reload() {
        if (!active || closed || busy) return;
        int epoch = ++generation;
        if (inventory != null) inventory.cancel(true);
        String filter = query.toLowerCase(Locale.ROOT);
        boolean includeSystem = showSystem;
        host.busy(true);
        host.clear(text("paradox_mgr_loading"));
        inventory = worker.submit(() -> {
            try {
                AppBackend access = backend();
                PackageManager pm = context.getPackageManager();
                Set<String> protectedApps = access.protectedPackages();
                List<Row> rows = new ArrayList<>();
                for (ApplicationInfo app : pm.getInstalledApplications(PackageManager.MATCH_DISABLED_COMPONENTS
                        | PackageManager.MATCH_DISABLED_UNTIL_USED_COMPONENTS)) {
                    if (Thread.currentThread().isInterrupted() || closed) return;
                    if (!includeSystem && (app.flags & ApplicationInfo.FLAG_SYSTEM) != 0) continue;
                    String label = app.loadLabel(pm).toString();
                    if (!app.packageName.toLowerCase(Locale.ROOT).contains(filter)
                            && !label.toLowerCase(Locale.ROOT).contains(filter)) continue;
                    rows.add(new Row(app, label, !app.enabled || access.canDisable(app, protectedApps)));
                }
                Collator order = Collator.getInstance(context.getResources().getConfiguration().getLocales().get(0));
                Collections.sort(rows, (a, b) -> {
                    int result = order.compare(a.label, b.label);
                    return result != 0 ? result : a.pkg.compareTo(b.pkg);
                });
                main.post(() -> { if (current(epoch)) render(rows, 0, epoch); });
            } catch (Exception failure) {
                Log.w("GMHubApps", "Cannot list applications", failure);
                main.post(() -> { if (current(epoch)) {
                    host.clear(text("gm_apps_load_failed")); host.busy(false);
                } });
            }
        });
    }
    private void render(List<Row> rows, int offset, int epoch) {
        if (!current(epoch)) return;
        if (offset == 0) host.clear(rows.isEmpty() ? text("gm_apps_empty") : "");
        int end = Math.min(offset + 8, rows.size());
        for (int i = offset; i < end; i++) {
            Row row = rows.get(i);
            host.row(row.pkg, row.label, row.enabled, row.editable,
                row.pkg + (row.editable ? "" : "\n" + text("gm_apps_protected")));
        }
        if (end < rows.size()) main.postDelayed(() -> render(rows, end, epoch), 16);
        else host.busy(false);
    }
    /** Return false to the preference: the new state is shown only after native readback. */
    public boolean change(String pkg, boolean enabled) {
        if (!active || busy || closed) return false;
        perform(Collections.singletonList(pkg), enabled, false);
        return false;
    }
    private void perform(List<String> packages, boolean enabled, boolean restore) {
        if (!active || busy || closed) return;
        busy = true; generation++; if (inventory != null) inventory.cancel(true);
        host.busy(true);
        worker.submit(() -> {
            int changed = 0, failed = 0;
            try {
                AppBackend access = backend();
                Set<String> saved = restore ? access.keys() : null;
                for (String pkg : restore ? saved : packages) {
                    try {
                        if (restore ? access.engine.restore(pkg) : access.engine.change(pkg, enabled)) changed++;
                    } catch (PackageManager.NameNotFoundException removed) {
                        // An uninstalled app cannot be modified. Discard only our own stale record.
                        if (restore) access.remove(pkg); else failed++;
                    } catch (Exception failure) {
                        failed++; Log.w("GMHubApps", "Cannot change " + pkg, failure);
                    }
                }
            } catch (Exception failure) { failed++; Log.w("GMHubApps", "App operation failed", failure); }
            final int count = changed, errors = failed;
            main.post(() -> {
                // This callback is retained across pause, even when no view may be updated.
                busy = false;
                if (active && !closed) {
                    host.busy(false);
                    Toast.makeText(context, String.format(context.getResources().getConfiguration().getLocales().get(0),
                        text("gm_apps_result"), count, errors), Toast.LENGTH_LONG).show();
                    reload();
                }
            });
        });
    }
    public void createMenu(Menu menu) {
        menu.add(0, 1, 0, text("gm_apps_restore"));
        menu.add(0, 2, 1, text("gm_apps_disable_selected"));
        menu.add(0, 4, 2, text("gm_apps_enable_selected"));
        menu.add(0, 3, 3, text("paradox_mgr_show_sys"));
    }
    public void prepareMenu(Menu menu) {
        for (int id : new int[] {1, 2, 3, 4}) {
            MenuItem item = menu.findItem(id);
            if (item != null) item.setEnabled(!busy);
        }
        MenuItem system = menu.findItem(3);
        if (system != null) system.setTitle(text(showSystem ? "paradox_mgr_hide_sys" : "paradox_mgr_show_sys"));
    }
    public boolean select(MenuItem item) {
        int id = item.getItemId();
        if (id < 1 || id > 4) return false;
        if (!active || busy || closed) return true;
        if (id == 3) { showSystem = !showSystem; reload(); return true; }
        if (id == 1) {
            dialog = new AlertDialog.Builder(context).setTitle(text("gm_apps_restore"))
                .setMessage(text("gm_apps_restore_summary"))
                .setNegativeButton(android.R.string.cancel, null)
                .setPositiveButton(android.R.string.ok, (d, which) -> perform(Collections.emptyList(), true, true)).show();
        } else chooseOptional(id == 4);
        return true;
    }
    private void chooseOptional(boolean enable) {
        int epoch = generation;
        worker.submit(() -> {
            List<String> names = new ArrayList<>(), packages = new ArrayList<>();
            for (String pkg : OPTIONAL) {
                try {
                    ApplicationInfo app = backend().info(pkg);
                    packages.add(pkg); names.add(app.loadLabel(context.getPackageManager()) + "\n" + pkg);
                } catch (Exception unavailable) { /* Optional package not installed for this user. */ }
            }
            main.post(() -> {
                if (!current(epoch)) return;
                if (packages.isEmpty()) {
                    Toast.makeText(context, text("gm_apps_empty"), Toast.LENGTH_SHORT).show(); return;
                }
                boolean[] selected = new boolean[packages.size()];
                dialog = new AlertDialog.Builder(context)
                    .setTitle(text(enable ? "gm_apps_enable_selected" : "gm_apps_disable_selected"))
                    .setMultiChoiceItems(names.toArray(new String[0]), selected, (d, i, checked) -> selected[i] = checked)
                    .setNegativeButton(android.R.string.cancel, null)
                    .setPositiveButton(android.R.string.ok, (d, which) -> {
                        List<String> chosen = new ArrayList<>();
                        for (int i = 0; i < selected.length; i++) if (selected[i]) chosen.add(packages.get(i));
                        if (!chosen.isEmpty()) perform(chosen, enable, false);
                    }).show();
            });
        });
    }
    /** Called only when a recycled native row is bound; no full-list icon allocation. */
    public void bindIcon(View row, String pkg) {
        ImageView image = row.findViewById(android.R.id.icon);
        if (image == null || !active || closed) return;
        image.setImageResource(android.R.drawable.sym_def_app_icon);
        iconBindings.put(image, pkg);
        Drawable.ConstantState cached = iconCache.get(pkg);
        if (cached != null) { image.setImageDrawable(cached.newDrawable(context.getResources())); return; }
        int epoch = generation;
        WeakReference<ImageView> view = new WeakReference<>(image);
        icons.execute(() -> {
            Drawable icon;
            try { icon = context.getPackageManager().getApplicationIcon(pkg); }
            catch (Exception unavailable) { return; }
            main.post(() -> {
                if (!current(epoch)) return;
                ImageView target = view.get();
                if (target == null || !pkg.equals(iconBindings.get(target))) return;
                if (icon.getConstantState() != null) iconCache.put(pkg, icon.getConstantState());
                target.setImageDrawable(icon);
            });
        });
    }
}
