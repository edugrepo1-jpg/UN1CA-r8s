package com.gmhub.qs;

import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.Objects;

/** Bind UI actions to the pinned Samsung owner, never to shell/root commands.
 * A requested native save is not a claim that its repository finished writing. */
public final class NativeHeaderActions implements AutoCloseable {
    private static final String PANEL = "com.android.systemui.samsung.quicksetting.ui.panel.";
    private final Thread owner = Thread.currentThread();
    private final Object model, host, edit, keyguard, available, gallerySource, galleryVisible;
    private final Object quickPanel, done;
    private final Method userId, launchEdit, launchPower, editingValue, unlocked, visible;
    private final Method hasAvailableValue, sourceValue, sourceWrite, galleryValue, galleryWrite, doneInvoke;
    private final Object hasAvailable;
    private final int user;
    private boolean closed, doneRequested, wasEditing;

    public static final class State {
        public final boolean current, editing, unlocked, canAdd, canFinish;
        State(boolean current, boolean editing, boolean unlocked, boolean canAdd, boolean canFinish) {
            this.current=current;this.editing=editing;this.unlocked=unlocked;this.canAdd=canAdd;this.canFinish=canFinish;
        }
    }
    public NativeHeaderActions(Object model) throws ReflectiveOperationException {
        this.model=Objects.requireNonNull(model);
        host=field(model,"qsHost");edit=field(model,"$$delegate_0");
        keyguard=field(model,"keyguardStateController");available=field(model,"$$delegate_3");
        userId=method(host,"getUserId");user=((Number)call(userId,host)).intValue();
        launchEdit=method(model,"launchEditMode");launchPower=method(model,"launchPowerMenu");
        Object editFlow=field(edit,"editMode");editingValue=method(editFlow,"getValue");
        unlocked=method(keyguard,"isUnlocked");visible=method(keyguard,"isVisible");
        hasAvailable=field(available,"hasAvailableTiles");hasAvailableValue=method(hasAvailable,"getValue");
        gallerySource=field(available,"_availableTilesSource");galleryVisible=field(available,"_showAvailableTiles");
        sourceValue=method(gallerySource,"getValue");sourceWrite=method(gallerySource,"setValue",Object.class);
        galleryValue=method(galleryVisible,"getValue");galleryWrite=method(galleryVisible,"setValue",Object.class);
        ClassLoader loader=model.getClass().getClassLoader();
        Class<?> source=Class.forName(PANEL+"AvailableTilesSource",false,loader);
        quickPanel=source.getField("QUICK_PANEL").get(null);
        Class<?> callback=Class.forName(PANEL+"SecQuickSettingHeaderKt$$ExternalSyntheticLambda35",false,loader);
        // The verified native HeaderContainer uses class-id 0 for Done. This
        // retains its toggle, ViewModelScope coroutine and repository write.
        done=callback.getConstructor(int.class).newInstance(0);
        callback.getField("f$0").set(done,model);doneInvoke=callback.getMethod("invoke");
    }
    private static Object field(Object target,String name) throws ReflectiveOperationException {
        Field f=target.getClass().getField(name);f.setAccessible(true);return f.get(target);
    }
    private static Method method(Object target,String name,Class<?>... args) throws NoSuchMethodException {
        Method m=target.getClass().getMethod(name,args);m.setAccessible(true);return m;
    }
    private static Object call(Method method,Object target,Object... args) {
        try{return method.invoke(target,args);}
        catch(InvocationTargetException failed){
            Throwable cause=failed.getCause();
            if(cause instanceof RuntimeException)throw (RuntimeException)cause;
            if(cause instanceof Error)throw (Error)cause;
            throw new IllegalStateException("Native header action failed",cause);
        }catch(ReflectiveOperationException failed){throw new IllegalStateException(failed);}
    }
    private static boolean bool(Object value) {
        if(!(value instanceof Boolean))throw new IllegalStateException("Changed native header boolean");
        return (Boolean)value;
    }
    private void ui(){if(Thread.currentThread()!=owner)throw new IllegalStateException("QS UI owner required");}
    public boolean current(){ui();return !closed && ((Number)call(userId,host)).intValue()==user;}
    private boolean editing(){
        try{return bool(call(editingValue,field(edit,"editMode")));}
        catch(ReflectiveOperationException failed){throw new IllegalStateException(failed);}
    }
    private boolean unlocked(){return bool(call(unlocked,keyguard)) && !bool(call(visible,keyguard));}
    public State state(){
        if(!current())return new State(false,false,false,false,false);
        boolean now=editing();
        if(now && !wasEditing)doneRequested=false;
        wasEditing=now;
        boolean allowed=unlocked();
        return new State(true,now,allowed,bool(call(hasAvailableValue,hasAvailable)),now && allowed && !doneRequested);
    }
    public boolean edit(){
        if(!current() || editing() || !unlocked())return false;
        call(launchEdit,model);return true; // Knox/authentication remains in Samsung's method.
    }
    public boolean power(){if(!current())return false;call(launchPower,model);return true;}
    public boolean done(){
        if(!current() || !editing() || !unlocked() || doneRequested)return false;
        wasEditing=true;doneRequested=true;
        call(doneInvoke,done);return true;
    }
    public boolean gallery(){
        if(!current() || !editing() || !unlocked() || !bool(call(hasAvailableValue,hasAvailable)))return false;
        Object previous=call(sourceValue,gallerySource);
        if(previous==quickPanel && bool(call(galleryValue,galleryVisible)))return true;
        try {
            call(sourceWrite,gallerySource,quickPanel);
            if(call(sourceValue,gallerySource)!=quickPanel)return false;
            if(!current() || !editing() || !unlocked())return false;
            call(galleryWrite,galleryVisible,Boolean.TRUE);
            return current() && bool(call(galleryValue,galleryVisible)) && call(sourceValue,gallerySource)==quickPanel;
        } finally {
            // A rejected/failed open can undo only this user's still-owned
            // source. Never reverse an already displayed sheet or another user.
            if(current() && !bool(call(galleryValue,galleryVisible))
                    && call(sourceValue,gallerySource)==quickPanel && previous!=quickPanel)
                call(sourceWrite,gallerySource,previous);
        }
    }
    @Override public void close(){ui();closed=true;}
}
