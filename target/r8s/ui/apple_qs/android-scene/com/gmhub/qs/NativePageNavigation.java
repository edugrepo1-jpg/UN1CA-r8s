package com.gmhub.qs;

import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

/** Read-only viewport navigation over Samsung's original grid. It never
 * filters, duplicates, reorders or persists panel items. */
public final class NativePageNavigation implements AutoCloseable {
    private final Thread owner=Thread.currentThread();
    private final Object host,scroll,grid,viewport;
    private final int user;
    private final Method userId,value,max,intValue,dragging,animate;
    private boolean closed;
    public static final class Pages {
        public final int viewport,max,count,selected;
        Pages(int viewport,int max,int value) {
            this.viewport=viewport;this.max=max;
            long n=viewport<=0 || max<0 || max==Integer.MAX_VALUE?0:((long)max+viewport-1)/viewport+1;
            count=n>32?0:(int)n;
            int best=0;long distance=Long.MAX_VALUE;
            for(int i=0;i<count;i++){
                long d=Math.abs((long)target(i)-value);
                if(d<distance){best=i;distance=d;}
            }
            selected=best;
        }
        public int target(int page) {
            if(page<0 || page>=count)throw new IllegalArgumentException("Unknown native viewport");
            return (int)Math.min((long)page*viewport,max);
        }
        @Override public boolean equals(Object other){
            if(!(other instanceof Pages))return false;Pages p=(Pages)other;
            return viewport==p.viewport && max==p.max && count==p.count && selected==p.selected;
        }
        @Override public int hashCode(){return ((viewport*31+max)*31+count)*31+selected;}
    }
    public static final class Request {
        private final NativePageNavigation owner;
        private final int target,viewport,max;
        private boolean cancelled;
        Request(NativePageNavigation owner,int target,Pages pages){
            this.owner=owner;this.target=target;viewport=pages.viewport;max=pages.max;
        }
    }
    public NativePageNavigation(Object model,Object grid,Object scroll)throws ReflectiveOperationException {
        this.host=field(model,"qsHost");this.grid=grid;this.scroll=scroll;
        userId=method(host,"getUserId");user=((Number)call(userId,host)).intValue();
        value=method(scroll,"getValue");max=method(scroll,"getMaxValue");
        viewport=field(scroll,"viewportSize$delegate");intValue=method(viewport,"getIntValue");
        dragging=method(grid,"isDragging");
        ClassLoader loader=model.getClass().getClassLoader();
        Class<?> scrollType=Class.forName("androidx.compose.foundation.ScrollState",false,loader);
        Class<?> continuation=Class.forName("kotlin.coroutines.Continuation",false,loader);
        animate=scrollType.getMethod("animateScrollTo$default",scrollType,int.class,continuation);
    }
    private static Object field(Object target,String name)throws ReflectiveOperationException{
        Field f=target.getClass().getField(name);f.setAccessible(true);return f.get(target);
    }
    private static Method method(Object target,String name)throws NoSuchMethodException{
        Method m=target.getClass().getMethod(name);m.setAccessible(true);return m;
    }
    private static Object call(Method method,Object target,Object... args){
        try{return method.invoke(target,args);}
        catch(InvocationTargetException failed){
            Throwable cause=failed.getCause();
            if(cause instanceof RuntimeException)throw (RuntimeException)cause;
            if(cause instanceof Error)throw (Error)cause;
            throw new IllegalStateException(cause);
        }catch(ReflectiveOperationException failed){throw new IllegalStateException(failed);}
    }
    private void ui(){if(Thread.currentThread()!=owner)throw new IllegalStateException("QS UI owner required");}
    public boolean current(){ui();return !closed && ((Number)call(userId,host)).intValue()==user;}
    public Pages pages(){
        if(!current())return new Pages(0,0,0);
        return new Pages(((Number)call(intValue,viewport)).intValue(),
            ((Number)call(max,scroll)).intValue(),((Number)call(value,scroll)).intValue());
    }
    public Request request(int page){
        Pages p=pages();
        if(p.count==0 || page<0 || page>=p.count || Boolean.TRUE.equals(call(dragging,grid)))return null;
        return new Request(this,p.target(page),p);
    }
    public boolean accepts(Request request){
        ui();
        if(request==null || request.owner!=this || request.cancelled)return false;
        // Do not read the per-pixel scroll position from composition here.
        // Only the derived page indicator needs that changing dependency.
        boolean allowed=current() && !Boolean.TRUE.equals(call(dragging,grid))
            && ((Number)call(intValue,viewport)).intValue()==request.viewport
            && ((Number)call(max,scroll)).intValue()==request.max;
        // An old click must not restart its animation when dragging ends or
        // dimensions happen to return to their previous values.
        if(!allowed)request.cancelled=true;
        return allowed;
    }
    /** Called as the tail of a real LaunchedEffect suspend lambda. Samsung's
     * ScrollState/MutatorMutex owns animation and user-gesture cancellation.
     * The supplied continuation is passed through; never resumed manually. */
    public Object animate(Request request,Object continuation,Object unit){
        if(!accepts(request))return unit;
        return call(animate,null,scroll,request.target,continuation);
    }
    @Override public void close(){ui();closed=true;}
}
