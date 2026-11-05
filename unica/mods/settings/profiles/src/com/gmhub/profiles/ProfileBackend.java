package com.gmhub.profiles;

import android.content.Context;
import android.content.ContentResolver;
import android.content.SharedPreferences;
import android.net.wifi.WifiManager;
import android.os.PowerManager;
import android.os.UserManager;
import android.provider.Settings;
import android.hardware.display.DisplayManager;
import android.view.Display;
import java.io.IOException;
import java.lang.reflect.Method;
import java.util.*;
import org.json.*;

/** Runs exclusively on the controller's worker. No shell, root or thermal bypass. */
public final class ProfileBackend implements ProfileEngine.Access, ProfileEngine.Store {
    private static final Set<String> KEYS = new HashSet<>(Arrays.asList(
        "system:min_refresh_rate", "system:peak_refresh_rate", "secure:refresh_rate_mode",
        "system:touch_sensitivity_enabled", "system:screen_off_timeout", "system:aod_mode",
        "global:enhanced_processing", "global:sem_enhanced_cpu_responsiveness",
        "global:cached_apps_freezer", "global:window_animation_scale",
        "global:transition_animation_scale", "global:animator_duration_scale",
        "native:power_save", "native:wifi_scan_throttle"));
    private final Context context;
    private final ContentResolver resolver;
    private final SharedPreferences journal;
    public final ProfileEngine engine;
    public ProfileBackend(Context context) {
        this.context = context;
        UserManager users = context.getSystemService(UserManager.class);
        if (users == null || !users.isSystemUser()) throw new SecurityException("System-user control only");
        resolver = context.getContentResolver();
        journal = context.getSharedPreferences("gmhub_profiles_v1", Context.MODE_PRIVATE);
        engine = new ProfileEngine(this, this);
    }
    private static void key(String key) {
        if (!KEYS.contains(key)) throw new IllegalArgumentException("Unknown profile setting");
    }
    private Object nativeCall(Object service, String name, Class<?>[] signature, Object... args) throws Exception {
        if (service == null) throw new IllegalStateException("Native service unavailable");
        Method method = service.getClass().getMethod(name, signature);
        return method.invoke(service, args);
    }
    @Override public String read(String key) throws Exception {
        key(key);
        if (key.equals("native:power_save")) return context.getSystemService(PowerManager.class).isPowerSaveMode() ? "1" : "0";
        if (key.equals("native:wifi_scan_throttle")) return Boolean.TRUE.equals(nativeCall(
            context.getSystemService(WifiManager.class), "isScanThrottleEnabled", new Class<?>[0])) ? "1" : "0";
        String name = key.substring(key.indexOf(':') + 1);
        if (key.startsWith("system:")) return Settings.System.getString(resolver, name);
        if (key.startsWith("secure:")) return Settings.Secure.getString(resolver, name);
        return Settings.Global.getString(resolver, name);
    }
    @Override public void write(String key, String value) throws Exception {
        key(key);
        if (key.startsWith("native:")) {
            if (!"0".equals(value) && !"1".equals(value)) throw new IllegalArgumentException("Invalid native toggle");
            boolean enabled = value.equals("1");
            if (key.equals("native:power_save")) {
                if (!Boolean.TRUE.equals(nativeCall(context.getSystemService(PowerManager.class),
                        "setPowerSaveModeEnabled", new Class<?>[]{boolean.class}, enabled)))
                    throw new IllegalStateException("Battery saver request refused");
            } else nativeCall(context.getSystemService(WifiManager.class), "setScanThrottleEnabled",
                new Class<?>[]{boolean.class}, enabled);
            // Native services may invalidate cached state after returning; never poll on UI.
            for (int i = 0; i < 10 && !Objects.equals(read(key), value); i++) Thread.sleep(50);
            if (!Objects.equals(read(key), value)) throw new IllegalStateException("Native state not confirmed");
            return;
        }
        String name = key.substring(key.indexOf(':') + 1);
        boolean accepted;
        if (key.startsWith("system:")) accepted = Settings.System.putString(resolver, name, value);
        else if (key.startsWith("secure:")) accepted = Settings.Secure.putString(resolver, name, value);
        else accepted = Settings.Global.putString(resolver, name, value);
        if (!accepted || !Objects.equals(read(key), value)) throw new IllegalStateException("Setting rejected: " + key);
    }
    private static Object json(String value) { return value == null ? JSONObject.NULL : value; }
    private static String string(JSONObject object, String name) throws JSONException {
        if (!object.has(name)) throw new JSONException("Missing journal value");
        return object.isNull(name) ? null : object.getString(name);
    }
    @Override public ProfileEngine.State load() throws Exception {
        String data = journal.getString("state", null);
        if (data == null) return legacy();
        JSONObject root = new JSONObject(data);
        if (root.getInt("version") != 1) throw new IOException("Unsupported profile journal");
        JSONObject values = root.getJSONObject("entries");
        LinkedHashMap<String, ProfileEngine.Entry> entries = new LinkedHashMap<>();
        Iterator<String> keys = values.keys();
        while (keys.hasNext()) {
            String key = keys.next(); key(key);
            JSONObject value = values.getJSONObject(key);
            JSONArray owned = value.getJSONArray("owned");
            if (owned.length() > 3) throw new IOException("Invalid owned states");
            List<String> states = new ArrayList<>();
            for (int i = 0; i < owned.length(); i++) states.add(owned.isNull(i) ? null : owned.getString(i));
            entries.put(key, new ProfileEngine.Entry(string(value, "original"), string(value, "applied"), states));
        }
        return new ProfileEngine.State(root.getString("mode"), root.getBoolean("pending"), entries);
    }
    @Override public void save(ProfileEngine.State state) throws Exception {
        JSONObject values = new JSONObject();
        for (Map.Entry<String, ProfileEngine.Entry> e : state.entries.entrySet()) {
            key(e.getKey()); ProfileEngine.Entry entry = e.getValue(); JSONArray owned = new JSONArray();
            for (String value : entry.owned) owned.put(json(value));
            values.put(e.getKey(), new JSONObject().put("original", json(entry.original))
                .put("applied", json(entry.applied)).put("owned", owned));
        }
        String data = new JSONObject().put("version", 1).put("mode", state.mode)
            .put("pending", state.pending).put("entries", values).toString();
        if (!journal.edit().putString("state", data).commit()) throw new IOException("Cannot save profile journal");
    }
    /** Read legacy backups without consuming/deleting them on page entry. */
    private ProfileEngine.State legacy() throws Exception {
        if (Settings.Global.getInt(resolver, "paradox_core_backup_done", 0) != 1) return ProfileEngine.State.empty();
        String mode = Settings.Global.getString(resolver, "paradox_core_mode");
        if (!Arrays.asList("smooth", "gaming", "battery").contains(mode)) mode = "stock";
        boolean gaming = mode.equals("gaming"), battery = mode.equals("battery");
        LinkedHashMap<String, ProfileEngine.Entry> entries = new LinkedHashMap<>();
        for (String key : KEYS) {
            // The legacy Wi-Fi alias did not control the native scan-throttle state.
            if (key.startsWith("native:")) continue;
            String original = Settings.Global.getString(resolver, "paradox_core_backup_" + key.replace(':', '_'));
            if (original == null) continue;
            if (original.equals("__paradox_null__")) original = null;
            // Do not relabel arbitrary current values as owned legacy changes.
            List<String> owned;
            if (key.endsWith("animation_scale") || key.endsWith("animator_duration_scale")) owned = Arrays.asList("0.75", "0.85");
            else if (key.equals("system:screen_off_timeout")) owned = Collections.singletonList("30000");
            else if (key.equals("system:aod_mode")) owned = Collections.singletonList("0");
            else if (key.equals("system:min_refresh_rate")) owned = Collections.singletonList(gaming ? "120.0" : "60.0");
            else if (key.equals("system:peak_refresh_rate")) owned = Collections.singletonList(battery ? "60.0" : "120.0");
            else if (key.equals("secure:refresh_rate_mode")) owned = Collections.singletonList("1");
            else if (key.equals("global:cached_apps_freezer")) owned = Collections.singletonList("enabled");
            else owned = Collections.singletonList(gaming ? "1" : "0");
            String actual = read(key), applied = owned.contains(actual) ? actual : owned.get(0);
            entries.put(key, new ProfileEngine.Entry(original, applied, owned));
        }
        String oldPower = Settings.Global.getString(resolver, "paradox_core_backup_global_low_power");
        if (oldPower != null) entries.put("native:power_save", new ProfileEngine.Entry(
            oldPower.equals("1") ? "1" : "0", battery ? "1" : "0"));
        return new ProfileEngine.State(mode, false, entries);
    }
    public Map<String, String> plan(String mode) throws Exception {
        if (!Arrays.asList("smooth", "gaming", "battery").contains(mode)) throw new IllegalArgumentException("Unknown mode");
        boolean battery = mode.equals("battery"), gaming = mode.equals("gaming");
        Display display = context.getSystemService(DisplayManager.class).getDisplay(Display.DEFAULT_DISPLAY);
        if (display == null) throw new IllegalStateException("Display unavailable");
        boolean has60 = false, has120 = false;
        Display.Mode current = display.getMode();
        for (Display.Mode supported : display.getSupportedModes()) {
            if (supported.getPhysicalWidth() != current.getPhysicalWidth() || supported.getPhysicalHeight() != current.getPhysicalHeight()) continue;
            has60 |= Math.abs(supported.getRefreshRate() - 60) < 0.5f;
            has120 |= Math.abs(supported.getRefreshRate() - 120) < 0.5f;
        }
        if (!has60 || (!battery && !has120)) throw new IllegalStateException("Panel mode unavailable");
        LinkedHashMap<String, String> plan = new LinkedHashMap<>();
        plan.put("native:power_save", battery ? "1" : "0");
        plan.put("secure:refresh_rate_mode", "1");
        plan.put("system:peak_refresh_rate", battery ? "60.0" : "120.0");
        plan.put("system:min_refresh_rate", gaming ? "120.0" : "60.0");
        plan.put("system:touch_sensitivity_enabled", gaming ? "1" : "0");
        plan.put("global:enhanced_processing", gaming ? "1" : "0");
        plan.put("global:sem_enhanced_cpu_responsiveness", gaming ? "1" : "0");
        plan.put("native:wifi_scan_throttle", battery ? "1" : "0");
        plan.put("global:cached_apps_freezer", "enabled");
        if (battery) { plan.put("system:aod_mode", "0"); plan.put("system:screen_off_timeout", "30000"); }
        else for (String animation : Arrays.asList("window_animation_scale", "transition_animation_scale", "animator_duration_scale")) {
            String value = read("global:" + animation);
            // Keep animations disabled when requested by accessibility/developer settings.
            if (value != null && Float.parseFloat(value) == 0) continue;
            plan.put("global:" + animation, gaming ? "0.75" : "0.85");
        }
        return plan;
    }
    /** Compatibility metadata used by the existing Hub banner; never the recovery source. */
    public void publishStatus(String mode) throws Exception {
        if (!Settings.Global.putString(resolver, "paradox_core_mode", mode)
                || !Objects.equals(Settings.Global.getString(resolver, "paradox_core_mode"), mode))
            throw new IOException("Cannot publish profile status");
    }
}
