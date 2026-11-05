package com.gmhub.refresh;

import android.content.Context;
import android.content.ContentResolver;
import android.hardware.display.DisplayManager;
import android.provider.Settings;
import android.util.Log;
import android.view.Display;
import android.widget.Toast;
import java.util.*;

/** Apply only advertised physical modes. No kernel/sysfs write or process restart. */
public final class RefreshSettings {
    private RefreshSettings() { }
    private static final String MIN = "min_refresh_rate", MAX = "peak_refresh_rate", MODE = "refresh_rate_mode";
    private static SortedSet<Integer> rates(Context context) {
        DisplayManager manager = context.getSystemService(DisplayManager.class);
        Display display = manager == null ? null : manager.getDisplay(Display.DEFAULT_DISPLAY);
        if (display == null) throw new IllegalStateException("Display unavailable");
        Display.Mode current = display.getMode();
        SortedSet<Integer> rates = new TreeSet<>();
        for (Display.Mode candidate : display.getSupportedModes()) {
            float hz = candidate.getRefreshRate();
            if (candidate.getPhysicalWidth() != current.getPhysicalWidth()
                    || candidate.getPhysicalHeight() != current.getPhysicalHeight()
                    || !Float.isFinite(hz) || hz <= 0) continue;
            int rounded = Math.round(hz);
            if (rounded > 0) rates.add(rounded);
        }
        if (rates.isEmpty()) throw new IllegalStateException("No native modes");
        return rates;
    }
    private static String read(ContentResolver resolver, String key) {
        return key.equals(MODE) ? Settings.Secure.getString(resolver, key) : Settings.System.getString(resolver, key);
    }
    private static void write(ContentResolver resolver, String key, String value) {
        boolean accepted = key.equals(MODE) ? Settings.Secure.putString(resolver, key, value)
            : Settings.System.putString(resolver, key, value);
        if (!accepted || !Objects.equals(read(resolver, key), value)) throw new IllegalStateException("Refresh setting not confirmed");
    }
    private static int existing(ContentResolver resolver, String key, SortedSet<Integer> supported, int fallback) {
        try {
            float value = Float.parseFloat(read(resolver, key));
            if (Float.isFinite(value) && supported.contains(Math.round(value))) return Math.round(value);
        } catch (RuntimeException unset) { }
        return fallback;
    }
    public static String value(Context context, boolean minimum) {
        try {
            SortedSet<Integer> rates = rates(context);
            return Integer.toString(existing(context.getContentResolver(), minimum ? MIN : MAX,
                rates, minimum ? rates.first() : rates.last()));
        } catch (RuntimeException unavailable) { return null; }
    }
    public static boolean applySingle(Context context, String preferenceKey, String value) {
        try {
            if (!preferenceKey.equals(MIN) && !preferenceKey.equals("max_refresh_rate")) return false;
            SortedSet<Integer> supported = rates(context);
            int selected = Integer.parseInt(value);
            if (!supported.contains(selected)) return false;
            ContentResolver resolver = context.getContentResolver();
            int min = existing(resolver, MIN, supported, supported.first());
            int max = existing(resolver, MAX, supported, supported.last());
            if (preferenceKey.equals(MIN)) { min = selected; max = Math.max(max, selected); }
            else { max = selected; min = Math.min(min, selected); }
            return pair(context, min, max);
        } catch (RuntimeException failure) { Log.w("GMHubRefresh", "Refresh change rejected", failure); return false; }
    }
    public static boolean reset(Context context) {
        try { SortedSet<Integer> rates = rates(context); return pair(context, rates.first(), rates.last()); }
        catch (RuntimeException failure) { return false; }
    }
    private static synchronized boolean pair(Context context, int min, int max) {
        ContentResolver resolver = context.getContentResolver();
        LinkedHashMap<String, String> before = new LinkedHashMap<>(), target = new LinkedHashMap<>();
        List<String> attempted = new ArrayList<>();
        try {
            SortedSet<Integer> supported = rates(context);
            if (min > max || !supported.contains(min) || !supported.contains(max)) return false;
            target.put(MODE, "1");
            // Keep an existing range ordered when moving below its old minimum.
            int previousMin = existing(resolver, MIN, supported, supported.first());
            if (max < previousMin) { target.put(MIN, min + ".0"); target.put(MAX, max + ".0"); }
            else { target.put(MAX, max + ".0"); target.put(MIN, min + ".0"); }
            for (String key : target.keySet()) before.put(key, read(resolver, key));
            for (Map.Entry<String, String> entry : target.entrySet()) {
                if (Objects.equals(before.get(entry.getKey()), entry.getValue())) continue;
                attempted.add(entry.getKey()); write(resolver, entry.getKey(), entry.getValue());
            }
            return true;
        } catch (RuntimeException failure) {
            Collections.reverse(attempted);
            for (String key : attempted) try {
                String actual = read(resolver, key);
                if (Objects.equals(actual, before.get(key))) continue;
                // Do not undo a simultaneous change by another system component.
                if (!Objects.equals(actual, target.get(key))) throw new IllegalStateException("External refresh change");
                write(resolver, key, before.get(key));
            } catch (RuntimeException restoreFailure) { Log.w("GMHubRefresh", "Refresh rollback not confirmed", restoreFailure); }
            return false;
        }
    }
    public static void report(Context context, boolean success) {
        String key = success ? "paradox_toast_refresh" : "gm_refresh_failed";
        int id = context.getResources().getIdentifier(key, "string", context.getPackageName());
        String message = id == 0 ? (success ? "Refresh settings confirmed" : "Refresh settings not confirmed") : context.getString(id);
        Toast.makeText(context, message, Toast.LENGTH_LONG).show();
    }
}
