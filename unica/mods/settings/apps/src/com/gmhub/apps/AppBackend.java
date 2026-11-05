package com.gmhub.apps;

import android.app.admin.DevicePolicyManager;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageManager;
import android.content.pm.ResolveInfo;
import android.os.Process;
import android.provider.Settings;
import java.io.IOException;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;
import java.util.TreeSet;

/** Uses the caller's user-scoped native PackageManager, never root or user 0. */
public final class AppBackend implements AppStateEngine.Access, AppStateEngine.Journal {
    private static final int FLAGS = PackageManager.MATCH_DISABLED_COMPONENTS
        | PackageManager.MATCH_DISABLED_UNTIL_USED_COMPONENTS;
    private static final Set<String> CORE = new HashSet<>(Arrays.asList(
        "android", "com.android.systemui", "com.android.settings", "com.android.phone",
        "com.android.providers.settings", "com.android.providers.telephony",
        "com.android.permissioncontroller", "com.google.android.permissioncontroller",
        "com.samsung.android.permissioncontroller", "com.android.packageinstaller",
        "com.google.android.packageinstaller", "com.samsung.android.packageinstaller"));
    private final Context context;
    private final PackageManager packages;
    private final SharedPreferences journal;
    public final AppStateEngine engine;
    public AppBackend(Context context) {
        this.context = context; packages = context.getPackageManager();
        journal = context.getSharedPreferences("gmhub_app_states_v1", Context.MODE_PRIVATE);
        engine = new AppStateEngine(this, this);
    }
    public ApplicationInfo info(String pkg) throws Exception {
        AppStateEngine.packageName(pkg); return packages.getApplicationInfo(pkg, FLAGS);
    }
    @Override public int read(String pkg) throws Exception {
        info(pkg); return packages.getApplicationEnabledSetting(pkg);
    }
    @Override public void write(String pkg, int state) {
        packages.setApplicationEnabledSetting(pkg, state, 0);
    }
    @Override public boolean canDisable(String pkg) throws Exception {
        ApplicationInfo app = info(pkg);
        DevicePolicyManager policy = context.getSystemService(DevicePolicyManager.class);
        if (policy != null && (policy.isDeviceOwnerApp(pkg) || policy.isProfileOwnerApp(pkg))) return false;
        return canDisable(app, protectedPackages());
    }
    public boolean canDisable(ApplicationInfo app, Set<String> protectedApps) {
        return !protectedApps.contains(app.packageName) && Process.isApplicationUid(app.uid)
            && (app.flags & ApplicationInfo.FLAG_PERSISTENT) == 0;
    }
    /** One snapshot per inventory; take a fresh snapshot before every mutation. */
    public Set<String> protectedPackages() {
        Set<String> protectedApps = new HashSet<>(CORE);
        protectedApps.add(context.getPackageName());
        ResolveInfo home = packages.resolveActivity(new Intent(Intent.ACTION_MAIN).addCategory(Intent.CATEGORY_HOME), PackageManager.MATCH_DEFAULT_ONLY);
        if (home != null && home.activityInfo != null) protectedApps.add(home.activityInfo.packageName);
        String keyboard = Settings.Secure.getString(context.getContentResolver(), Settings.Secure.DEFAULT_INPUT_METHOD);
        ComponentName input = keyboard == null ? null : ComponentName.unflattenFromString(keyboard);
        if (input != null) protectedApps.add(input.getPackageName());
        String accessibility = Settings.Secure.getString(context.getContentResolver(), Settings.Secure.ENABLED_ACCESSIBILITY_SERVICES);
        if (accessibility != null) for (String service : accessibility.split(":")) {
            ComponentName component = ComponentName.unflattenFromString(service);
            if (component != null) protectedApps.add(component.getPackageName());
        }
        DevicePolicyManager policy = context.getSystemService(DevicePolicyManager.class);
        if (policy != null) {
            java.util.List<ComponentName> admins = policy.getActiveAdmins();
            if (admins != null) for (ComponentName admin : admins) protectedApps.add(admin.getPackageName());
        }
        return protectedApps;
    }
    @Override public AppStateEngine.Record get(String pkg) {
        String value = journal.getString("pkg:" + pkg, null);
        return value == null ? null : AppStateEngine.Record.decode(value);
    }
    @Override public void put(String pkg, AppStateEngine.Record value) throws IOException {
        if (!journal.edit().putString("pkg:" + pkg, value.encode()).commit()) throw new IOException("Cannot save app-state journal");
    }
    @Override public void remove(String pkg) throws IOException {
        if (!journal.edit().remove("pkg:" + pkg).commit()) throw new IOException("Cannot update app-state journal");
    }
    @Override public Set<String> keys() {
        Set<String> result = new TreeSet<>();
        for (String key : journal.getAll().keySet()) if (key.startsWith("pkg:")) {
            String pkg = key.substring(4); AppStateEngine.packageName(pkg); result.add(pkg);
        }
        return result;
    }
}
