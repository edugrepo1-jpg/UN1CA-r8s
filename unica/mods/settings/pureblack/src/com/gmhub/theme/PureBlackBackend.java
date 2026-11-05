package com.gmhub.theme;

import android.app.UiModeManager;
import android.content.Context;
import android.content.SharedPreferences;
import android.content.pm.ApplicationInfo;
import android.content.res.Resources;
import android.os.Process;
import android.provider.Settings;
import com.gmhub.profiles.ProfileEngine;
import java.io.IOException;
import java.util.*;
import org.json.*;

/** Theme operations use the existing durable/read-back transaction engine.
 * No shell, root, process kill, continuous polling or global color filter. */
public final class PureBlackBackend implements ProfileEngine.Access,ProfileEngine.Store {
    final Context context; final Object manager; final int user;
    final SharedPreferences journal;
    public final ProfileEngine engine;
    public PureBlackBackend(Context context) throws Exception {
        if(Process.myUid()%100000!=1000)throw new SecurityException("Native Settings identity required");
        String scope=(String)Class.forName("android.os.SystemProperties").getMethod("get",String.class).invoke(null,"ro.gmhub.pure_black.scope");
        if(!"system_theme".equals(scope))throw new IllegalStateException("Native theme integration not installed");
        this.context=context;
        user=(Integer)Class.forName("android.os.UserHandle").getMethod("myUserId").invoke(null);
        manager=context.getSystemService(Class.forName("android.content.om.OverlayManager"));
        if(manager==null)throw new IllegalStateException("Overlay service unavailable");
        journal=context.getSharedPreferences("gmhub_pure_black_v1",Context.MODE_PRIVATE);
        engine=new ProfileEngine(this,this);
    }
    void user() throws Exception {
        int active=(Integer)Class.forName("android.app.ActivityManager").getMethod("getCurrentUser").invoke(null);
        if(active!=user)throw new IllegalStateException("User changed");
    }
    static void key(String key) {
        if(!key.equals("night")&&!key.equals("enabled")&&!key.matches("overlay:[a-zA-Z0-9_.]+"))throw new IllegalArgumentException("Unknown theme field");
    }
    public LinkedHashMap<String,String> plan() throws Exception {
        user();LinkedHashSet<String> targets=new LinkedHashSet<>(Arrays.asList("android","com.android.settings","com.android.systemui"));
        for(ApplicationInfo app:context.getPackageManager().getInstalledApplications(0))targets.add(app.packageName);
        LinkedHashMap<String,String> plan=new LinkedHashMap<>();
        for(String target:targets) {
            Resources resources=context.getPackageManager().getResourcesForApplication(target);
            List<String> roles=PureBlackPolicy.roles(resources,target);
            if(target.equals("android")&&!roles.contains("system_surface_dark"))throw new IllegalStateException("Native dark theme resources unavailable");
            if(!roles.isEmpty())plan.put("overlay:"+target,"1");
        }
        if(plan.size()>512)throw new IllegalStateException("Too many theme targets");
        plan.put("night",Integer.toString(UiModeManager.MODE_NIGHT_YES));plan.put("enabled","1");return plan;
    }
    public String read(String key) throws Exception {
        key(key);user();
        if(key.equals("night"))return Integer.toString(context.getSystemService(UiModeManager.class).getNightMode());
        if(key.equals("enabled"))return Settings.Secure.getString(context.getContentResolver(),PureBlackPolicy.KEY);
        return PureBlackPolicy.enabled(manager,key.substring(8),user)?"1":"0";
    }
    public void write(String key,String value) throws Exception {
        key(key);user();
        if(key.equals("night")) {
            int mode=Integer.parseInt(value);
            if(mode<0||mode>3)throw new IllegalArgumentException("Invalid night mode");
            context.getSystemService(UiModeManager.class).setNightMode(mode);return;
        }
        if(key.equals("enabled")) {
            if(value!=null&&!value.equals("0")&&!value.equals("1"))throw new IllegalArgumentException("Invalid theme flag");
            if(!Settings.Secure.putString(context.getContentResolver(),PureBlackPolicy.KEY,value))throw new IllegalStateException("Theme flag rejected");return;
        }
        if(!"0".equals(value)&&!"1".equals(value))throw new IllegalArgumentException("Invalid overlay state");
        String target=key.substring(8);Object transaction=PureBlackPolicy.builder();
        if(value.equals("1")) {
            Resources resources=context.getPackageManager().getResourcesForApplication(target);
            List<String> roles=PureBlackPolicy.roles(resources,target);
            if(roles.isEmpty())throw new IllegalStateException("Theme resources disappeared: "+target);
            Object overlay=Class.forName("android.content.om.FabricatedOverlay$Builder")
                .getConstructor(String.class,String.class,String.class).newInstance(PureBlackPolicy.OWNER,PureBlackPolicy.name(target,user),target);
            for(String role:roles)PureBlackPolicy.call(overlay,"setResourceValue",new Class<?>[]{String.class,int.class,int.class,String.class},target+":color/"+role,28,0xff000000,"night");
            Object built=PureBlackPolicy.call(overlay,"build",new Class<?>[0]);
            PureBlackPolicy.call(transaction,"registerFabricatedOverlay",new Class<?>[]{Class.forName("android.content.om.FabricatedOverlay")},built);
        } else if(!PureBlackPolicy.enabled(manager,target,user))return;
        PureBlackPolicy.set(transaction,target,user,value.equals("1"));PureBlackPolicy.commit(manager,transaction);
    }
    private static Object json(String value){return value==null?JSONObject.NULL:value;}
    private static String string(JSONObject object,String key) throws JSONException {
        if(!object.has(key))throw new JSONException("Missing theme journal value");return object.isNull(key)?null:object.getString(key);
    }
    public ProfileEngine.State load() throws Exception {
        user();String data=journal.getString("state",null);if(data==null)return ProfileEngine.State.empty();
        JSONObject root=new JSONObject(data);
        if(root.getInt("version")!=1||root.getInt("user")!=user)throw new IOException("Theme journal version/user mismatch");
        String mode=root.getString("mode");if(!mode.equals("stock")&&!mode.equals("pure_black"))throw new IOException("Invalid theme journal mode");
        JSONObject values=root.getJSONObject("entries");if(values.length()>514)throw new IOException("Theme journal too large");
        LinkedHashMap<String,ProfileEngine.Entry> entries=new LinkedHashMap<>();Iterator<String> keys=values.keys();
        while(keys.hasNext()){
            String key=keys.next();key(key);JSONObject value=values.getJSONObject(key);JSONArray owned=value.getJSONArray("owned");
            if(owned.length()>3)throw new IOException("Invalid owned theme values");
            List<String> states=new ArrayList<>();for(int i=0;i<owned.length();i++)states.add(owned.isNull(i)?null:owned.getString(i));
            entries.put(key,new ProfileEngine.Entry(string(value,"original"),string(value,"applied"),states));
        }
        return new ProfileEngine.State(mode,root.getBoolean("pending"),entries);
    }
    public void save(ProfileEngine.State state) throws Exception {
        user();JSONObject entries=new JSONObject();
        for(Map.Entry<String,ProfileEngine.Entry> e:state.entries.entrySet()){
            key(e.getKey());ProfileEngine.Entry entry=e.getValue();JSONArray owned=new JSONArray();for(String v:entry.owned)owned.put(json(v));
            entries.put(e.getKey(),new JSONObject().put("original",json(entry.original)).put("applied",json(entry.applied)).put("owned",owned));
        }
        String data=new JSONObject().put("version",1).put("user",user).put("mode",state.mode).put("pending",state.pending).put("entries",entries).toString();
        if(!journal.edit().putString("state",data).commit())throw new IOException("Cannot save theme recovery journal");
    }
    public void enable() throws Exception {
        ProfileEngine.State before=engine.state();
        if(before.pending){ProfileEngine.RestoreResult result=engine.restore();if(result.failed!=0)throw new IllegalStateException("Incomplete theme recovery");}
        engine.apply("pure_black",plan());
    }
    public void disable() throws Exception {
        ProfileEngine.RestoreResult result=engine.restore();
        if(result.failed!=0)throw new IllegalStateException("Theme restore not confirmed");
        // Own overlays can survive app data recovery. Disable only our user-
        // specific IDs; an absent journal cannot authorize restoring night mode.
        LinkedHashSet<String> targets=new LinkedHashSet<>(Arrays.asList("android","com.android.settings","com.android.systemui"));
        for(ApplicationInfo app:context.getPackageManager().getInstalledApplications(0))targets.add(app.packageName);
        for(String target:targets)if(PureBlackPolicy.enabled(manager,target,user)){
            write("overlay:"+target,"0");if(!"0".equals(read("overlay:"+target)))throw new IllegalStateException("Owned overlay restore failed");
        }
        if("1".equals(read("enabled")))write("enabled","0");
    }
    public boolean enabled() throws Exception {
        return "pure_black".equals(engine.status())&&"1".equals(read("enabled"))&&"1".equals(read("overlay:android"));
    }
}
