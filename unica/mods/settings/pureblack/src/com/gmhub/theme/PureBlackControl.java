package com.gmhub.theme;

import android.content.Context;
import android.os.Handler;
import android.os.Looper;
import android.util.Log;
import android.widget.Toast;
import java.lang.ref.WeakReference;
import java.util.*;
import java.util.concurrent.*;

/** Theme work stays off the Settings UI thread; no resident service is added. */
public final class PureBlackControl {
    private static final Handler MAIN=new Handler(Looper.getMainLooper());
    private static final ThreadPoolExecutor WORK=new ThreadPoolExecutor(0,1,15,TimeUnit.SECONDS,new LinkedBlockingQueue<Runnable>());
    private static final List<WeakReference<Object>> CONTROLS=new ArrayList<>();
    private static boolean busy;
    private PureBlackControl() { }
    private static void control(Object preference,boolean checked,boolean enabled) {
        try {PureBlackPolicy.call(preference,"setChecked",new Class<?>[]{boolean.class},checked);
            PureBlackPolicy.call(preference,"setEnabled",new Class<?>[]{boolean.class},enabled);}
        catch(Exception unavailable){Log.w("GMHubBlack","Preference no longer available",unavailable);}
    }
    private static void watch(Object preference) {
        for(Iterator<WeakReference<Object>> it=CONTROLS.iterator();it.hasNext();) {
            Object old=it.next().get();if(old==null)it.remove();else if(old==preference)return;
        }
        CONTROLS.add(new WeakReference<>(preference));
    }
    public static void sync(Context context,Object preference) {
        if(Looper.myLooper()!=Looper.getMainLooper())throw new IllegalStateException("Main thread required");
        watch(preference);if(busy){control(preference,false,false);return;}
        submit(context,null);
    }
    public static void change(Context context,Object preference,boolean enabled) {
        if(Looper.myLooper()!=Looper.getMainLooper())throw new IllegalStateException("Main thread required");
        watch(preference);if(!busy)submit(context,enabled);
    }
    private static void submit(Context context,Boolean requested) {
        busy=true;for(WeakReference<Object> ref:CONTROLS){Object p=ref.get();if(p!=null)try{PureBlackPolicy.call(p,"setEnabled",new Class<?>[]{boolean.class},false);}catch(Exception ignored){}}
        Context app=context.getApplicationContext();
        WORK.execute(()->{
            boolean checked=false,available=false;Exception failure=null;
            try {
                PureBlackBackend backend=new PureBlackBackend(app);available=true;
                if(requested!=null){if(requested)backend.enable();else backend.disable();}
                checked=backend.enabled();
            } catch(Exception error){failure=error;Log.w("GMHubBlack","Theme operation not confirmed",error);}
            final boolean value=checked,ready=available;final Exception error=failure;
            MAIN.post(()->{
                busy=false;for(Iterator<WeakReference<Object>> it=CONTROLS.iterator();it.hasNext();){Object p=it.next().get();if(p==null)it.remove();else control(p,value,ready||requested!=null);}
                if(error!=null&&requested!=null){int id=app.getResources().getIdentifier("gm_pure_black_failed","string",app.getPackageName());
                    Toast.makeText(app,id==0?"Pure Black could not be confirmed; reopen to check recovery.":app.getString(id),Toast.LENGTH_LONG).show();}
            });
        });
    }
}
