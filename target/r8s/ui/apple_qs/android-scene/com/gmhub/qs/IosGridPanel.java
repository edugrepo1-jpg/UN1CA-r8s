package com.gmhub.qs;

import android.content.Context;
import android.graphics.Color;
import android.util.Log;
import android.util.TypedValue;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageButton;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.lang.reflect.Proxy;

/** Original Compose grid plus a trailing viewport rail. The native renderer,
 * scroll state, editor, media and content store remain the only owners. */
public final class IosGridPanel {
    private static final String C="androidx.compose.runtime.",P="com.android.systemui.samsung.quicksetting.ui.panel.";
    private static final int ROOT=0x474d5301,NATIVE=0x474d5302,CUSTOM=0x474d5303,SESSION=0x474d5304;
    private static Runtime api;
    private static Method original;
    private static boolean attempted;
    private IosGridPanel(){}
    static boolean active(Object composer){Runtime a=api;return a!=null && Boolean.TRUE.equals(call(a.consume,composer,a.localRail));}
    static void content(Object[] arguments){
        Runtime a=get(arguments[11].getClass().getClassLoader());
        if(a==null){call(original,null,arguments);return;}
        a.render(arguments);
    }
    private static synchronized Runtime get(ClassLoader loader){
        if(attempted)return api;attempted=true;
        try{
            original=type(loader,P+"QuickSettingTileGridKt").getMethod("QuickSettingTileGrid-RLNbq1o",
                type(loader,"com.android.compose.animation.scene.ContentScope"),
                long.class,long.class,type(loader,C+"State"),
                type(loader,"com.android.systemui.samsung.quicksetting.ui.base.spannablegrid.SpannableGridState"),
                type(loader,"androidx.compose.foundation.ScrollState"),type(loader,"kotlin.jvm.functions.Function0"),
                type(loader,P+"ContextMenuScope"),int.class,
                type(loader,"com.android.systemui.samsung.quicksetting.ui.banner.TopBannerViewModel"),
                type(loader,"com.android.systemui.samsung.quicksetting.ui.banner.BottomBannerViewModel"),
                type(loader,C+"Composer"),int.class);
            api=new Runtime(loader);
        }catch(ReflectiveOperationException | LinkageError | SecurityException error){
            Log.e("GMHubQs","Page rail contract unavailable; preserving native grid",error);
            if(original==null)throw new IllegalStateException("Native grid missing",error);
        }
        return api;
    }
    private static Class<?> type(ClassLoader l,String n)throws ClassNotFoundException{return Class.forName(n,false,l);}
    private static Field field(Class<?> t,String n)throws NoSuchFieldException{Field f=t.getField(n);f.setAccessible(true);return f;}
    private static Method method(Class<?> t,String n,Class<?>... p)throws NoSuchMethodException{Method m=t.getMethod(n,p);m.setAccessible(true);return m;}
    private static Object call(Method m,Object target,Object... p){
        try{return m.invoke(target,p);}
        catch(InvocationTargetException e){Throwable t=e.getCause();if(t instanceof RuntimeException)throw (RuntimeException)t;
            if(t instanceof Error)throw (Error)t;throw new IllegalStateException(t);}
        catch(ReflectiveOperationException e){throw new IllegalStateException(e);}
    }
    private interface Callback{Object invoke(Object[] args);}
    private static final class Runtime {
        final ClassLoader loader;final Class<?> f1,f2,f3;
        final Method start,end,replace,endReplace,consume,changed,changedInt,remembered,remember,updateScope;
        final Method box,composable,androidView,align,fillWidth,width,height,value,setValue,state,derived,policy,launched,getContext,getUser,effect,provider,provides;
        final Object unit,empty,modifier,localModel,localRail,topStart,centerEnd,boxScope,failed=new Object();
        final Class<?> disposable;
        final Field host;
        Runtime(ClassLoader l)throws ReflectiveOperationException{
            loader=l;Class<?> composer=type(l,C+"Composer"),mod=type(l,"androidx.compose.ui.Modifier"),alignment=type(l,"androidx.compose.ui.Alignment");
            f1=type(l,"kotlin.jvm.functions.Function1");f2=type(l,"kotlin.jvm.functions.Function2");f3=type(l,"kotlin.jvm.functions.Function3");
            start=method(composer,"startRestartGroup",int.class);end=method(composer,"endRestartGroup");
            replace=method(composer,"startReplaceGroup",int.class);endReplace=method(composer,"endReplaceGroup");
            consume=method(composer,"consume",type(l,C+"CompositionLocal"));changed=method(composer,"changedInstance",Object.class);
            changedInt=method(composer,"changed",int.class);
            remembered=method(composer,"rememberedValue");remember=method(composer,"updateRememberedValue",Object.class);
            empty=method(type(l,C+"Composer$Companion"),"getEmpty").invoke(field(composer,"Companion").get(null));
            updateScope=method(type(l,C+"ScopeUpdateScope"),"updateScope",f2);
            unit=field(type(l,"kotlin.Unit"),"INSTANCE").get(null);modifier=field(mod,"Companion").get(null);
            localModel=field(type(l,"com.android.systemui.samsung.quicksetting.ui.SecQuickSettingSceneKt"),"LocalViewModel").get(null);
            host=field(type(l,P+"QuickSettingSceneViewModel"),"qsHost");getContext=method(type(l,"com.android.systemui.qs.QSHost"),"getUserContext");
            getUser=method(type(l,"com.android.systemui.qs.QSHost"),"getUserId");
            disposable=type(l,C+"DisposableEffectResult");effect=method(type(l,C+"EffectsKt"),"DisposableEffect",Object.class,f1,composer);
            localRail=method(type(l,C+"CompositionLocalKt"),"compositionLocalOf$default",type(l,"kotlin.jvm.functions.Function0"))
                .invoke(null,fn(type(l,"kotlin.jvm.functions.Function0"),p->Boolean.FALSE));
            provider=method(type(l,C+"CompositionLocalKt"),"CompositionLocalProvider",type(l,C+"ProvidedValue"),f2,composer,int.class);
            provides=method(type(l,C+"ProvidableCompositionLocal"),"provides",Object.class);
            box=method(type(l,"androidx.compose.foundation.layout.BoxWithConstraintsKt"),"BoxWithConstraints",mod,alignment,f3,composer,int.class,int.class);
            composable=method(type(l,C+"internal.ComposableLambdaKt"),"rememberComposableLambda",int.class,boolean.class,Object.class,composer,int.class);
            androidView=method(type(l,"androidx.compose.ui.viewinterop.AndroidView_androidKt"),"AndroidView",f1,mod,f1,f1,f1,composer,int.class,int.class);
            Class<?> sizes=type(l,"androidx.compose.foundation.layout.SizeKt");
            fillWidth=method(sizes,"fillMaxWidth",mod,float.class);width=method(sizes,"width-3ABfNKs",mod,float.class);height=method(sizes,"height-3ABfNKs",mod,float.class);
            Class<?> bs=type(l,"androidx.compose.foundation.layout.BoxScopeInstance");boxScope=field(bs,"INSTANCE").get(null);align=method(bs,"align",mod,alignment);
            Class<?> ac=type(l,"androidx.compose.ui.Alignment$Companion");topStart=field(ac,"TopStart").get(null);centerEnd=field(ac,"CenterEnd").get(null);
            value=method(type(l,C+"State"),"getValue");setValue=method(type(l,C+"MutableState"),"setValue",Object.class);
            state=method(type(l,C+"SnapshotStateKt"),"mutableStateOf$default",Object.class);
            policy=method(type(l,C+"SnapshotStateKt"),"structuralEqualityPolicy");
            derived=method(type(l,C+"SnapshotStateKt"),"derivedStateOf",type(l,C+"SnapshotMutationPolicy"),type(l,"kotlin.jvm.functions.Function0"));
            launched=method(type(l,C+"EffectsKt"),"LaunchedEffect",composer,Object.class,f2);
        }
        Object fn(Class<?> t,Callback callback){return Proxy.newProxyInstance(loader,new Class<?>[]{t},(self,m,args)->{
            if(m.getDeclaringClass()==Object.class){if(m.getName().equals("equals"))return self==args[0];
                if(m.getName().equals("hashCode"))return System.identityHashCode(self);return "GMHubNativePages";}
            return callback.invoke(args==null?new Object[0]:args);
        });}
        void render(Object[] args){
            Object c=call(start,args[11],ROOT);boolean custom=ComposePanelRoot.iosPhone(c);
            call(replace,c,custom?CUSTOM:NATIVE);
            if(!custom){Object[] nativeArgs=args.clone();nativeArgs[11]=c;call(original,null,nativeArgs);}
            else{
                Object model=call(consume,c,localModel);call(replace,c,SESSION);
                boolean changedOwner=(Boolean)call(changed,c,model);changedOwner|=(Boolean)call(changed,c,args[4]);changedOwner|=(Boolean)call(changed,c,args[5]);
                Object qsHost;
                try{qsHost=host.get(model);}catch(IllegalAccessException e){throw new IllegalStateException(e);}
                changedOwner|=(Boolean)call(changedInt,c,((Number)call(getUser,qsHost)).intValue());
                Object session=call(remembered,c);
                if(changedOwner || session==empty){
                    try{session=new Session(this,model,args[4],args[5],(Context)call(getContext,host.get(model)));}
                    catch(ReflectiveOperationException | IllegalStateException e){Log.e("GMHubQs","Native page binding unavailable",e);session=failed;}
                    call(remember,c,session);
                }
                call(endReplace,c);
                if(session==failed){Object[] nativeArgs=args.clone();nativeArgs[11]=c;call(original,null,nativeArgs);}
                else{
                    Session s=(Session)session;
                    call(effect,null,s,s.effect,c);
                    NativePageNavigation.Pages pages=(NativePageNavigation.Pages)call(value,s.pages);
                    NativePageNavigation.Request request=(NativePageNavigation.Request)call(value,s.request);
                    Object active=s.navigation.accepts(request)?request:null;
                    call(launched,null,c,active,fn(f2,p->active==null?unit:s.navigation.animate(request,p[1],unit)));
                    Object body=fn(f3,p->{
                        Object[] nativeArgs=args.clone();nativeArgs[11]=p[1];nativeArgs[12]=0;
                        call(original,null,nativeArgs);
                        if(pages.count>0){
                            Object rail=call(align,boxScope,modifier,centerEnd);
                            rail=call(width,null,rail,48f);
                            float dp=Math.min(pages.count*48f,pages.viewport/s.context.getResources().getDisplayMetrics().density);
                            rail=call(height,null,rail,Math.max(1f,dp));
                            Object update=fn(f1,v->{((RailView)v[0]).bind(s,pages);return unit;});
                            call(androidView,null,s.factory,rail,null,s.release,update,p[1],0,0);
                        }
                        return unit;
                    });
                    Object content=call(composable,null,0x474d5305,true,body,c,0);
                    Object wrapped=call(composable,null,0x474d5306,true,fn(f2,p->{
                        call(box,null,call(fillWidth,null,modifier,1f),topStart,content,p[0],0,0);return unit;
                    }),c,0);
                    call(provider,null,call(provides,localRail,Boolean.TRUE),wrapped,c,0);
                }
            }
            call(endReplace,c);Object restart=call(end,c);
            if(restart!=null)call(updateScope,restart,fn(f2,p->{Object[] next=args.clone();next[11]=p[0];next[12]=((Number)args[12]).intValue()|1;content(next);return unit;}));
        }
    }
    private static final class Session {
        final Runtime api;final Context context;final NativePageNavigation navigation;
        final Object request,pages,factory,release,effect;
        Session(Runtime api,Object model,Object grid,Object scroll,Context context)throws ReflectiveOperationException{
            if(context==null)throw new IllegalStateException("Missing native user context");
            this.api=api;this.context=context;
            for(String name:new String[]{"favorite","page"})id(context,"gmhub_qs_"+name,"drawable");
            id(context,"gmhub_qs_page_number","string");
            navigation=new NativePageNavigation(model,grid,scroll);
            pages=call(api.derived,null,call(api.policy,null),api.fn(type(api.loader,"kotlin.jvm.functions.Function0"),p->navigation.pages()));
            request=call(api.state,null,(Object)null);
            factory=api.fn(api.f1,p->new RailView((Context)p[0]));
            release=api.fn(api.f1,p->{((RailView)p[0]).release();return api.unit;});
            effect=api.fn(api.f1,p->api.fn(api.disposable,v->{navigation.close();return null;}));
        }
        void select(int page){NativePageNavigation.Request next=navigation.request(page);if(next!=null)call(api.setValue,request,next);}
    }
    private static int id(Context c,String n,String kind){int value=c.getResources().getIdentifier(n,kind,"com.android.systemui");
        if(value==0)throw new IllegalStateException("Missing page resource: "+n);return value;}
    private static final class RailView extends ScrollView {
        final LinearLayout buttons;int density,count=-1;Session session;
        RailView(Context c){super(c);setFillViewport(false);setVerticalScrollBarEnabled(false);setOverScrollMode(OVER_SCROLL_NEVER);
            buttons=new LinearLayout(c);buttons.setOrientation(LinearLayout.VERTICAL);addView(buttons,new LayoutParams(LayoutParams.MATCH_PARENT,LayoutParams.WRAP_CONTENT));}
        int dp(int value){return Math.round(value*getResources().getDisplayMetrics().density);}
        void bind(Session s,NativePageNavigation.Pages pages){
            session=s;int dpi=getResources().getDisplayMetrics().densityDpi;
            if(count!=pages.count || density!=dpi){count=pages.count;density=dpi;buttons.removeAllViews();
                for(int i=0;i<count;i++){
                    final int page=i;ImageButton b=new ImageButton(getContext());
                    b.setImageResource(id(getContext(),"gmhub_qs_"+(i==0?"favorite":"page"),"drawable"));
                    b.setPadding(dp(14),dp(14),dp(14),dp(14));
                    TypedValue ripple=new TypedValue();if(getContext().getTheme().resolveAttribute(android.R.attr.selectableItemBackgroundBorderless,ripple,true) && ripple.resourceId!=0)b.setBackgroundResource(ripple.resourceId);
                    b.setOnClickListener(v->{Session current=session;if(current!=null)try{current.select(page);}catch(RuntimeException e){Log.e("GMHubQs","Native page navigation failed",e);}});
                    buttons.addView(b,new LinearLayout.LayoutParams(dp(48),dp(48)));
                }
            }
            for(int i=0;i<count;i++){
                ImageButton b=(ImageButton)buttons.getChildAt(i);boolean selected=i==pages.selected;
                b.setImageTintList(android.content.res.ColorStateList.valueOf(selected?Color.WHITE:0xff9a9a9a));
                b.setSelected(selected);b.setEnabled(s.navigation.current());
                b.setContentDescription(getContext().getString(id(getContext(),"gmhub_qs_page_number","string"),i+1,count));
            }
        }
        void release(){session=null;for(int i=0;i<buttons.getChildCount();i++)buttons.getChildAt(i).setOnClickListener(null);}
    }
}
