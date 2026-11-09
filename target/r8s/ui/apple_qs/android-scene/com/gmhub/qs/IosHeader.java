package com.gmhub.qs;

import android.content.Context;
import android.content.res.Configuration;
import android.graphics.Color;
import android.text.TextUtils;
import android.util.Log;
import android.util.TypedValue;
import android.view.Gravity;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.ImageButton;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.Space;
import android.widget.Toast;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.lang.reflect.Proxy;

/** A header inside Samsung's existing Compose hierarchy, not a new window.
 * AndroidView owns its lifetime; the native model owns all actions and flows. */
public final class IosHeader {
    private static final String PANEL="com.android.systemui.samsung.quicksetting.ui.panel.";
    private static final String RUNTIME="androidx.compose.runtime.";
    private static final int ROOT=0x474d5201, CUSTOM=0x474d5202, NATIVE=0x474d5203, SESSION=0x474d5204;
    private static Runtime api;
    private static Method original;
    private static boolean attempted;
    private IosHeader(){ }

    public static void content(Object modifier,Object focus,Object composer,int flags) {
        Runtime a=get(composer.getClass().getClassLoader());
        if(a==null){call(original,null,modifier,focus,composer,flags);return;}
        a.render(modifier,focus,composer,flags);
    }
    private static synchronized Runtime get(ClassLoader loader) {
        if(attempted)return api;attempted=true;
        try {
            original=type(loader,PANEL+"SecQuickSettingHeaderKt").getMethod("HeaderContainer",
                type(loader,"androidx.compose.ui.Modifier"),type(loader,"androidx.compose.ui.focus.FocusRequester"),
                type(loader,RUNTIME+"Composer"),int.class);
            api=new Runtime(loader);
        }catch(ReflectiveOperationException | LinkageError | SecurityException error){
            Log.e("GMHubQs","Header contract unavailable; preserving Samsung header",error);
            if(original==null)throw new IllegalStateException("Native header missing",error);
        }
        return api;
    }
    private static Class<?> type(ClassLoader loader,String name)throws ClassNotFoundException{return Class.forName(name,false,loader);}
    private static Field field(Class<?> type,String name)throws NoSuchFieldException{Field f=type.getField(name);f.setAccessible(true);return f;}
    private static Object field(Object object,String name)throws ReflectiveOperationException{return field(object.getClass(),name).get(object);}
    private static Method method(Class<?> type,String name,Class<?>... args)throws NoSuchMethodException{Method m=type.getMethod(name,args);m.setAccessible(true);return m;}
    private static Object call(Method method,Object target,Object... args){
        try{return method.invoke(target,args);}
        catch(InvocationTargetException failed){
            Throwable cause=failed.getCause();
            if(cause instanceof RuntimeException)throw (RuntimeException)cause;
            if(cause instanceof Error)throw (Error)cause;
            throw new IllegalStateException(cause);
        }catch(ReflectiveOperationException failed){throw new IllegalStateException(failed);}
    }
    private interface Callback{Object invoke(Object[] args);}
    private static final class Runtime {
        final ClassLoader loader;
        final Class<?> function1,function2;
        final Method start,end,replace,endReplace,consume,changed,changedInt,remembered,remember;
        final Method getUser,getContext,collect,stateValue,androidView,fillWidth,height,focusModifier,updateScope;
        final Method portrait,tablet,popover;
        final Field host,edit,available;
        final Object localModel,empty,unit,failed=new Object();
        Runtime(ClassLoader loader)throws ReflectiveOperationException {
            this.loader=loader;
            Class<?> composer=type(loader,RUNTIME+"Composer"),modifier=type(loader,"androidx.compose.ui.Modifier");
            function1=type(loader,"kotlin.jvm.functions.Function1");function2=type(loader,"kotlin.jvm.functions.Function2");
            start=method(composer,"startRestartGroup",int.class);end=method(composer,"endRestartGroup");
            replace=method(composer,"startReplaceGroup",int.class);endReplace=method(composer,"endReplaceGroup");
            consume=method(composer,"consume",type(loader,RUNTIME+"CompositionLocal"));
            changed=method(composer,"changedInstance",Object.class);changedInt=method(composer,"changed",int.class);
            remembered=method(composer,"rememberedValue");remember=method(composer,"updateRememberedValue",Object.class);
            Object companion=field(composer,"Companion").get(null);
            empty=method(type(loader,RUNTIME+"Composer$Companion"),"getEmpty").invoke(companion);
            unit=field(type(loader,"kotlin.Unit"),"INSTANCE").get(null);
            localModel=field(type(loader,"com.android.systemui.samsung.quicksetting.ui.SecQuickSettingSceneKt"),"LocalViewModel").get(null);
            Class<?> model=type(loader,PANEL+"QuickSettingSceneViewModel");
            host=field(model,"qsHost");edit=field(model,"$$delegate_0");available=field(model,"$$delegate_3");
            portrait=method(model,"isPortraitPanel",Configuration.class);tablet=method(model,"isTablet");popover=method(model,"isPopOverEnabled");
            Class<?> qsHost=type(loader,"com.android.systemui.qs.QSHost");
            getUser=method(qsHost,"getUserId");getContext=method(qsHost,"getUserContext");
            collect=method(type(loader,"androidx.lifecycle.compose.FlowExtKt"),"collectAsStateWithLifecycle",
                type(loader,"kotlinx.coroutines.flow.StateFlow"),composer,int.class);
            stateValue=method(type(loader,RUNTIME+"State"),"getValue");
            androidView=method(type(loader,"androidx.compose.ui.viewinterop.AndroidView_androidKt"),"AndroidView",
                function1,modifier,function1,function1,function1,composer,int.class,int.class);
            Class<?> size=type(loader,"androidx.compose.foundation.layout.SizeKt");
            fillWidth=method(size,"fillMaxWidth",modifier,float.class);
            height=method(size,"height-3ABfNKs",modifier,float.class);
            focusModifier=method(type(loader,"androidx.compose.ui.focus.FocusRequesterModifierKt"),"focusRequester",
                modifier,type(loader,"androidx.compose.ui.focus.FocusRequester"));
            updateScope=method(type(loader,RUNTIME+"ScopeUpdateScope"),"updateScope",function2);
        }
        Object function(Class<?> type,Callback callback){
            return Proxy.newProxyInstance(loader,new Class<?>[]{type},(self,called,args)->{
                if(called.getDeclaringClass()==Object.class){
                    if(called.getName().equals("equals"))return self==args[0];
                    if(called.getName().equals("hashCode"))return System.identityHashCode(self);
                    if(called.getName().equals("toString"))return "GMHubHeader/"+type.getSimpleName();
                }
                return callback.invoke(args==null?new Object[0]:args);
            });
        }
        void render(Object modifier,Object focus,Object incoming,int flags){
            Object c=call(start,incoming,ROOT);
            boolean custom=ComposePanelRoot.ios(c);
            Object model=custom?call(consume,c,localModel):null,qsHost;
            Context context=null;int user=-1;
            if(custom)try{
                qsHost=host.get(model);context=(Context)call(getContext,qsHost);user=((Number)call(getUser,qsHost)).intValue();
                custom &= context!=null && Boolean.TRUE.equals(call(portrait,model,context.getResources().getConfiguration()))
                    && !Boolean.TRUE.equals(call(tablet,model)) && !Boolean.TRUE.equals(call(popover,model));
            }catch(IllegalAccessException unavailable){custom=false;}
            call(replace,c,custom?CUSTOM:NATIVE);
            if(!custom)call(original,null,modifier,focus,c,flags);
            else {
                call(replace,c,SESSION);
                boolean rebind=(Boolean)call(changed,c,model);
                rebind|=(Boolean)call(changedInt,c,user);
                Object stored=call(remembered,c);
                if(rebind || stored==empty){
                    try{stored=new Session(this,model,context);}
                    catch(ReflectiveOperationException | IllegalStateException error){
                        Log.e("GMHubQs","Header action binding unavailable; preserving native controls",error);stored=failed;
                    }
                    call(remember,c,stored);
                }
                call(endReplace,c);
                if(stored==failed)call(original,null,modifier,focus,c,flags);
                else {
                    Session s=(Session)stored;
                    // Lifecycle-aware native flow collectors trigger update; no
                    // timer, second QSHost, receiver or service is introduced.
                    call(stateValue,call(collect,null,s.editFlow,c,0));
                    call(stateValue,call(collect,null,s.availableFlow,c,0));
                    if(!s.actions.current())call(original,null,modifier,focus,c,flags);
                    else {
                        Object viewModifier=call(fillWidth,null,modifier,1f);
                        float scale=context.getResources().getConfiguration().fontScale;
                        float dp=Math.max(56f,(scale>1.5f?44f:24f)*scale+16f);
                        viewModifier=call(height,null,viewModifier,dp);
                        if(focus!=null)viewModifier=call(focusModifier,null,viewModifier,focus);
                        call(androidView,null,s.factory,viewModifier,null,s.release,s.update,c,0,0);
                    }
                }
            }
            call(endReplace,c);
            Object restart=call(end,c);
            if(restart!=null)call(updateScope,restart,function(function2,args->{content(modifier,focus,args[0],flags|1);return unit;}));
        }
    }
    private static final class Session {
        final NativeHeaderActions actions;
        final Object editFlow,availableFlow,factory,update,release;
        Session(Runtime a,Object model,Context context)throws ReflectiveOperationException {
            // Resolve required resources before emitting an AndroidView node.
            id(context,"gmhub_qs_plus","drawable");id(context,"gmhub_qs_power","drawable");
            for(String name:new String[]{"edit","add","done","power","action_failed"})id(context,"gmhub_qs_"+name,"string");
            actions=new NativeHeaderActions(model);
            editFlow=field(a.edit.get(model),"editMode");availableFlow=field(a.available.get(model),"hasAvailableTiles");
            factory=a.function(a.function1,args->new HeaderView((Context)args[0]));
            update=a.function(a.function1,args->{((HeaderView)args[0]).bind(actions);return a.unit;});
            release=a.function(a.function1,args->{((HeaderView)args[0]).release();return a.unit;});
        }
    }
    private static int id(Context context,String name,String kind){
        int value=context.getResources().getIdentifier(name,kind,"com.android.systemui");
        if(value==0)throw new IllegalStateException("Missing header resource: "+name);return value;
    }
    private static final class HeaderView extends LinearLayout {
        private final ImageButton add,power;
        private final Button done;
        private final int editText,addText,doneText,powerText,errorText;
        private NativeHeaderActions actions;
        private int densityDpi;
        private float fontScale;
        HeaderView(Context context){
            super(context);setOrientation(HORIZONTAL);setGravity(Gravity.CENTER_VERTICAL);
            editText=id(context,"gmhub_qs_edit","string");addText=id(context,"gmhub_qs_add","string");
            doneText=id(context,"gmhub_qs_done","string");powerText=id(context,"gmhub_qs_power","string");
            errorText=id(context,"gmhub_qs_action_failed","string");
            setPaddingRelative(dp(8),0,dp(8),0);setMinimumHeight(dp(56));
            add=icon("gmhub_qs_plus");power=icon("gmhub_qs_power");
            done=new Button(context);done.setAllCaps(false);done.setTextSize(20);done.setTextColor(Color.WHITE);
            done.setSingleLine(true);done.setEllipsize(TextUtils.TruncateAt.END);done.setMinWidth(dp(48));
            done.setMinHeight(dp(48));done.setPadding(dp(8),0,dp(8),0);ripple(done);
            addView(add,new LayoutParams(dp(48),dp(48)));gap();
            addView(done,new LayoutParams(0,ViewGroup.LayoutParams.MATCH_PARENT,1));gap();
            addView(power,new LayoutParams(dp(48),dp(48)));
            add.setOnClickListener(v->run(0));done.setOnClickListener(v->run(1));power.setOnClickListener(v->run(2));
        }
        private int dp(float value){return Math.round(value*getResources().getDisplayMetrics().density);}
        private void gap(){Space space=new Space(getContext());addView(space,new LayoutParams(dp(8),1));}
        private ImageButton icon(String name){
            ImageButton button=new ImageButton(getContext());button.setImageResource(id(getContext(),name,"drawable"));
            button.setScaleType(ImageView.ScaleType.CENTER_INSIDE);button.setPadding(dp(12),dp(12),dp(12),dp(12));
            button.setMinimumWidth(dp(48));button.setMinimumHeight(dp(48));ripple(button);return button;
        }
        private void ripple(View button){
            TypedValue value=new TypedValue();
            if(getContext().getTheme().resolveAttribute(android.R.attr.selectableItemBackgroundBorderless,value,true) && value.resourceId!=0)
                button.setBackgroundResource(value.resourceId);
        }
        void bind(NativeHeaderActions next){
            if(actions!=null && actions!=next)actions.close();actions=next;
            NativeHeaderActions.State state=next.state();Context c=getContext();
            updateMetrics();
            String addLabel=c.getString(state.editing?addText:editText);
            if(!TextUtils.equals(add.getContentDescription(),addLabel))add.setContentDescription(addLabel);
            String doneLabel=state.editing?c.getString(doneText):"";
            if(!TextUtils.equals(done.getText(),doneLabel))done.setText(doneLabel);
            done.setContentDescription(doneLabel);done.setEnabled(state.current && state.canFinish);
            done.setImportantForAccessibility(state.editing?View.IMPORTANT_FOR_ACCESSIBILITY_YES:View.IMPORTANT_FOR_ACCESSIBILITY_NO);
            done.setClickable(state.editing);
            power.setContentDescription(c.getString(powerText));
            add.setEnabled(state.current && state.unlocked && (!state.editing || state.canAdd));power.setEnabled(state.current);
        }
        private void updateMetrics(){
            int density=getResources().getDisplayMetrics().densityDpi;
            float scale=getResources().getConfiguration().fontScale;
            if(densityDpi!=density){
                densityDpi=density;setPaddingRelative(dp(8),0,dp(8),0);setMinimumHeight(dp(56));
                for(ImageButton button:new ImageButton[]{add,power}){
                    button.setLayoutParams(new LayoutParams(dp(48),dp(48)));
                    button.setPadding(dp(12),dp(12),dp(12),dp(12));
                    button.setMinimumWidth(dp(48));button.setMinimumHeight(dp(48));
                }
                getChildAt(1).setLayoutParams(new LayoutParams(dp(8),1));
                getChildAt(3).setLayoutParams(new LayoutParams(dp(8),1));
                done.setMinWidth(dp(48));done.setMinHeight(dp(48));done.setPadding(dp(8),0,dp(8),0);
            }
            if(fontScale!=scale){
                fontScale=scale;done.setTextSize(20);done.setSingleLine(scale<=1.5f);done.setMaxLines(scale>1.5f?2:1);
            }
        }
        private void run(int action){
            NativeHeaderActions current=actions;if(current==null)return;
            try{
                if(action==0){if(current.state().editing)current.gallery();else current.edit();}
                else if(action==1)current.done();else current.power();
                bind(current);
            }catch(RuntimeException error){
                Log.e("GMHubQs","Native header action failed",error);
                Toast.makeText(getContext(),errorText,Toast.LENGTH_LONG).show();
            }
        }
        void release(){
            if(actions!=null){actions.close();actions=null;}
            add.setOnClickListener(null);done.setOnClickListener(null);power.setOnClickListener(null);
        }
    }
}
