package com.gmhub.theme;

import android.content.Context;
import android.content.res.Resources;
import android.provider.Settings;
import android.util.Log;
import java.lang.reflect.Method;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.util.*;

/** Native theme resources only: never transforms text, video, authentication or framebuffers. */
public final class PureBlackPolicy {
    public static final String KEY="gmhub_pure_black", OWNER="com.android.settings";
    public static final String[] ROLES={
        "system_background_dark", "system_surface_dark", "system_surface_dim_dark",
        "system_surface_bright_dark", "system_surface_variant_dark", "system_surface_container_dark",
        "system_surface_container_lowest_dark", "system_surface_container_low_dark",
        "system_surface_container_high_dark", "system_surface_container_highest_dark",
        "background_material_dark", "background_dark",
        "basic_token_sys_background_dark", "basic_token_sys_background_variant_dark",
        "basic_token_sys_surface_dark", "basic_token_sys_surface_variant_dark",
        "basic_token_sys_surface_bright_dark", "basic_token_sys_surface_brightest_dark",
        "basic_token_sys_surface_container_dark", "basic_token_sys_surface_container_lowest_dark",
        "basic_token_sys_surface_container_low_dark", "basic_token_sys_surface_container_high_dark",
        "basic_token_sys_surface_container_higher_dark", "basic_token_sys_surface_container_highest_dark",
        "sesl_background_color_dark", "sesl_action_bar_background_color_dark",
        "sesl_dialog_window_background_color_material_dark", "sesl_menu_popup_background_color_dark",
        "sesl_round_and_bgcolor"
    };
    private PureBlackPolicy() { }
    public static Object call(Object target,String name,Class<?>[] types,Object...args) throws Exception {
        Method method=target.getClass().getMethod(name,types);method.setAccessible(true);return method.invoke(target,args);
    }
    public static String name(String target,int user) throws Exception {
        byte[] hash=MessageDigest.getInstance("SHA-256").digest(target.getBytes(StandardCharsets.UTF_8));
        StringBuilder out=new StringBuilder("gmhub_black_u"+user+"_");
        for(byte b:hash)out.append(String.format(Locale.ROOT,"%02x",b&255));return out.toString();
    }
    public static Object id(String target,int user) throws Exception {
        return Class.forName("android.content.om.OverlayIdentifier").getConstructor(String.class,String.class)
            .newInstance(OWNER,name(target,user));
    }
    public static Object user(int user) throws Exception {
        return Class.forName("android.os.UserHandle").getMethod("of",int.class).invoke(null,user);
    }
    public static boolean enabled(Object manager,String target,int user) throws Exception {
        Object info=call(manager,"getOverlayInfo",new Class<?>[]{Class.forName("android.content.om.OverlayIdentifier"),Class.forName("android.os.UserHandle")},id(target,user),user(user));
        return info!=null && Boolean.TRUE.equals(call(info,"isEnabled",new Class<?>[0]));
    }
    public static List<String> roles(Resources resources,String target) {
        List<String> found=new ArrayList<>();
        for(String name:ROLES)if(resources.getIdentifier(name,"color",target)!=0)found.add(name);
        return found;
    }
    public static Object builder() throws Exception {
        return Class.forName("android.content.om.OverlayManagerTransaction$Builder").getConstructor().newInstance();
    }
    public static void set(Object transaction,String target,int user,boolean enabled) throws Exception {
        call(transaction,"setEnabled",new Class<?>[]{Class.forName("android.content.om.OverlayIdentifier"),boolean.class,int.class},id(target,user),enabled,user);
    }
    public static void commit(Object manager,Object transaction) throws Exception {
        Object built=call(transaction,"build",new Class<?>[0]);
        call(manager,"commit",new Class<?>[]{Class.forName("android.content.om.OverlayManagerTransaction")},built);
    }
    /** Appended LAST to Samsung's own Monet transaction. Re-enabling raises the
     * owned overlay's priority without disabling/replacing any native palette. */
    public static void append(Object manager,Object transaction,int user) {
        try {
            Context context=(Context)Class.forName("android.app.AppGlobals").getMethod("getInitialApplication").invoke(null);
            if(context==null)return;
            Method read=Settings.Secure.class.getMethod("getIntForUser",android.content.ContentResolver.class,String.class,int.class,int.class);
            if(((Integer)read.invoke(null,context.getContentResolver(),KEY,0,user))!=1)return;
            if(enabled(manager,"android",user))set(transaction,"android",user,true);
        } catch(Exception | LinkageError unavailable) { Log.w("GMHubBlack","Native theme priority retained",unavailable); }
    }
}
