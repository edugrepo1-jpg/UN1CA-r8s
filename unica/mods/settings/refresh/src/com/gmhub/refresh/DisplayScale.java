package com.gmhub.refresh;

import android.content.Context;
import android.graphics.Point;
import android.provider.Settings;
import android.util.Log;
import android.widget.Toast;
import java.util.Objects;

/** Logical render scaling for r8s; never advertises a new physical panel mode. */
public final class DisplayScale {
    private DisplayScale() { }
    static final class State {
        final int width, height, density;
        final String sizeSetting, densitySetting;
        State(int w, int h, int d, String s, String dpi) {
            width=w; height=h; density=d; sizeSetting=s; densitySetting=dpi;
        }
    }
    interface Port {
        State read() throws Exception;
        boolean sameUser() throws Exception;
        void size(int width, int height, boolean clear) throws Exception;
        void density(int density, boolean clear) throws Exception;
    }
    private static boolean unset(String s) { return s==null || s.isEmpty(); }
    private static boolean sizeMatches(State s, int w, int h) { return s.width==w && s.height==h; }
    private static boolean sameSize(State a, State b) {
        return sizeMatches(a,b.width,b.height) && Objects.equals(a.sizeSetting,b.sizeSetting);
    }
    private static boolean sameDensity(State a, State b) {
        return a.density==b.density && Objects.equals(a.densitySetting,b.densitySetting);
    }
    private static boolean coherent(State s) {
        return s.width>0 && s.height>0 && s.density>=160 && s.density<=800
            && (unset(s.sizeSetting) || s.sizeSetting.equals(s.width+","+s.height))
            && (unset(s.densitySetting) || s.densitySetting.equals(Integer.toString(s.density)));
    }
    // The port is narrow so rejection, partial changes and user switches can be checked on the host.
    static synchronized boolean apply(Port port, String value) {
        State before=null, sizeTarget=null, densityTarget=null;
        boolean triedSize=false, triedDensity=false;
        try {
            if (!port.sameUser()) return false;
            before=port.read();
            if (!coherent(before)) return false;
            int width, height;
            if ("720x1600".equals(value)) { width=720; height=1600; }
            else if ("1080x2400".equals(value)) { width=1080; height=2400; }
            else return false;
            int density=(int)Math.round((double)before.density * width / before.width);
            if (density<160 || density>800) return false;
            if (!sizeMatches(before,width,height)) {
                triedSize=true;
                sizeTarget=new State(width,height,before.density,width+","+height,before.densitySetting);
                port.size(width,height,false);
                State actual=port.read();
                if (!port.sameUser() || !sameSize(actual,sizeTarget) || !sameDensity(actual,before))
                    throw new IllegalStateException("Size not confirmed");
            }
            if (density!=before.density) {
                triedDensity=true;
                State actual=port.read();
                if (!port.sameUser() || !sameSize(actual,sizeTarget==null?before:sizeTarget)
                        || !sameDensity(actual,before)) throw new IllegalStateException("Display changed");
                densityTarget=new State(width,height,density,actual.sizeSetting,Integer.toString(density));
                port.density(density,false);
            }
            State actual=port.read();
            if (!port.sameUser() || !sameSize(actual,sizeTarget==null?before:sizeTarget)
                    || !sameDensity(actual,densityTarget==null?before:densityTarget))
                throw new IllegalStateException("Scale not confirmed");
            return true;
        } catch (Exception failure) {
            Log.w("GMHubDisplay", "Logical scale not confirmed", failure);
            if (before!=null) try {
                // Do not overwrite another user or an independent display-settings change.
                if (!port.sameUser()) return false;
                State actual=port.read();
                if (triedDensity && !sameDensity(actual,before)) {
                    if (densityTarget==null || !sameDensity(actual,densityTarget))
                        throw new IllegalStateException("External density change");
                    port.density(before.density,unset(before.densitySetting));
                    if (!sameDensity(port.read(),before)) throw new IllegalStateException("Density rollback rejected");
                }
                actual=port.read();
                if (triedSize && !sameSize(actual,before)) {
                    if (sizeTarget==null || !sameSize(actual,sizeTarget))
                        throw new IllegalStateException("External size change");
                    port.size(before.width,before.height,unset(before.sizeSetting));
                    if (!sameSize(port.read(),before)) throw new IllegalStateException("Size rollback rejected");
                }
            } catch (Exception restoreFailure) { Log.w("GMHubDisplay", "Scale rollback not confirmed", restoreFailure); }
            return false;
        }
    }
    private static final class NativePort implements Port {
        final Context context; final Class<?> api; final Object wm; final int user;
        NativePort(Context c) throws Exception {
            context=c;
            api=Class.forName("android.view.IWindowManager");
            wm=Class.forName("android.view.WindowManagerGlobal").getMethod("getWindowManagerService").invoke(null);
            user=(Integer)Class.forName("android.os.UserHandle").getMethod("myUserId").invoke(null);
            Point initial=new Point();
            api.getMethod("getInitialDisplaySize",int.class,Point.class).invoke(wm,0,initial);
            if (initial.x!=1080 || initial.y!=2400) throw new IllegalStateException("Not an r8s display");
        }
        public boolean sameUser() throws Exception {
            return user==(Integer)Class.forName("android.app.ActivityManager").getMethod("getCurrentUser").invoke(null);
        }
        public State read() throws Exception {
            if (!sameUser()) throw new IllegalStateException("User changed");
            Point point=new Point();
            api.getMethod("getBaseDisplaySize",int.class,Point.class).invoke(wm,0,point);
            int density=(Integer)api.getMethod("getBaseDisplayDensity",int.class).invoke(wm,0);
            return new State(point.x,point.y,density,
                Settings.Global.getString(context.getContentResolver(),"display_size_forced"),
                Settings.Secure.getString(context.getContentResolver(),"display_density_forced"));
        }
        public void size(int w,int h,boolean clear) throws Exception {
            if (!sameUser()) throw new IllegalStateException("User changed");
            if (clear) api.getMethod("clearForcedDisplaySize",int.class).invoke(wm,0);
            else api.getMethod("setForcedDisplaySize",int.class,int.class,int.class).invoke(wm,0,w,h);
        }
        public void density(int dpi,boolean clear) throws Exception {
            if (!sameUser()) throw new IllegalStateException("User changed");
            if (clear) api.getMethod("clearForcedDisplayDensityForUser",int.class,int.class).invoke(wm,0,user);
            else api.getMethod("setForcedDisplayDensityForUser",int.class,int.class,int.class).invoke(wm,0,dpi,user);
        }
    }
    public static boolean apply(Context context,String value) {
        try { return apply(new NativePort(context),value); }
        catch (Exception unavailable) { Log.w("GMHubDisplay","WindowManager unavailable",unavailable); return false; }
    }
    public static String value(Context context) {
        try { State s=new NativePort(context).read(); return s.width+"x"+s.height; }
        catch (Exception unavailable) { return null; }
    }
    public static void report(Context context,boolean success) {
        String key=success?"gm_resolution_confirmed":"gm_resolution_failed";
        int id=context.getResources().getIdentifier(key,"string",context.getPackageName());
        String message=id==0?(success?"Logical scale confirmed":"Logical scale not confirmed"):context.getString(id);
        Toast.makeText(context,message,Toast.LENGTH_LONG).show();
    }
}
