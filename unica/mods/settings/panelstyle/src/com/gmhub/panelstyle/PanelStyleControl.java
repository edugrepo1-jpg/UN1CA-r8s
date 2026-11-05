package com.gmhub.panelstyle;

import android.content.Context;
import android.os.Build;
import android.provider.Settings;
import android.util.Log;
import android.widget.Toast;
import java.lang.reflect.Method;

/** Settings uses its current user's resolver, matching QSHost.getUserContext().
 * A failed or unconfirmed write is restored and never reported as successful.
 * The preference itself does not persist a second copy in SharedPreferences.
 */
public final class PanelStyleControl {
    private static final String KEY = "gmhub_qs_style";
    private PanelStyleControl() { }

    private static boolean installed() {
        if (Build.VERSION.SDK_INT < 37) return false;
        try {
            Class<?> props = Class.forName("android.os.SystemProperties");
            return Integer.valueOf(1).equals(props.getMethod("getInt", String.class, int.class)
                .invoke(null, "ro.gmhub.qs.scene", 0));
        } catch (ReflectiveOperationException unavailable) { return false; }
    }
    private static Object invoke(Object target, String name, Class<?> type, Object arg) throws ReflectiveOperationException {
        Method method = target.getClass().getMethod(name, type);
        method.setAccessible(true);
        return method.invoke(target, arg);
    }
    private static int read(Context context) {
        int value = Settings.Secure.getInt(context.getContentResolver(), KEY, 0);
        return value == 1 ? 1 : 0;
    }
    private static void message(Context context, String name) {
        int id = context.getResources().getIdentifier(name, "string", context.getPackageName());
        if (id != 0) Toast.makeText(context, id, Toast.LENGTH_LONG).show();
    }
    public static void sync(Context context, Object preference) {
        if (context == null || preference == null) return;
        try {
            invoke(preference, "setPersistent", boolean.class, false);
            boolean available = installed();
            invoke(preference, "setEnabled", boolean.class, available);
            invoke(preference, "setValue", String.class, Integer.toString(read(context)));
            int id = context.getResources().getIdentifier(available ? "gm_qs_selection_summary" : "gm_qs_unavailable",
                "string", context.getPackageName());
            if (id != 0) invoke(preference, "setSummary", int.class, id);
        } catch (ReflectiveOperationException | RuntimeException failure) {
            Log.e("GMHubQs", "Cannot synchronize QS preference", failure);
        }
    }
    public static boolean change(Context context, Object preference, Object selected) {
        if (context == null || preference == null || !installed() || !(selected instanceof String)) return false;
        String text = (String)selected;
        if (!"0".equals(text) && !"1".equals(text)) return false;
        int desired = "1".equals(text) ? 1 : 0;
        int previous;
        try { previous = Settings.Secure.getInt(context.getContentResolver(), KEY, 0); }
        catch (RuntimeException unavailable) { message(context, "gm_qs_save_error"); return false; }
        boolean saved = false;
        try {
            saved = Settings.Secure.putInt(context.getContentResolver(), KEY, desired)
                && Settings.Secure.getInt(context.getContentResolver(), KEY, -1) == desired;
        } catch (RuntimeException failure) { Log.w("GMHubQs", "Cannot save QS appearance", failure); }
        if (!saved) {
            try {
                if (!Settings.Secure.putInt(context.getContentResolver(), KEY, previous)
                        || Settings.Secure.getInt(context.getContentResolver(), KEY, -1) != previous)
                    Log.e("GMHubQs", "QS preference recovery could not be confirmed");
            } catch (RuntimeException unavailable) { Log.e("GMHubQs", "QS preference recovery failed", unavailable); }
            message(context, "gm_qs_save_error");
        }
        sync(context, preference);
        // The value above comes from the provider's readback, not the widget's
        // automatic update. Returning false also prevents a second disk writer.
        return false;
    }
}
