package com.gmhub.qs;

import android.content.Context;
import android.database.ContentObserver;
import android.os.Handler;
import android.os.Looper;
import android.provider.Settings;
import android.util.Log;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.lang.reflect.Proxy;
import java.util.List;

/** The API37 Samsung scene remains the content owner, including its player,
 * controls, authentication, editor, gallery and DataStore. This bridge provides
 * a user-scoped appearance value inside that scene; it creates no second QS
 * window, tile host or media controller. There is no composition retry after a
 * native function has emitted nodes. The installer verifies the exact ABI.
 */
public final class ComposePanelRoot {
    public static final String SETTING = "gmhub_qs_style";
    private static final String TAG = "GMHubQs";
    private static final String SCENE = "com.android.systemui.samsung.quicksetting.ui.";
    private static final String RUNTIME = "androidx.compose.runtime.";
    private static final String GRID = SCENE + "base.spannablegrid.";
    private static final int ROOT_KEY = 0x474d5101, SESSION_KEY = 0x474d5102;
    private static final int CONTENT_KEY = 0x474d5103, LAMBDA_KEY = 0x474d5104;
    private static volatile Abi abi;
    private static volatile Method original;
    private static boolean attempted;
    private static volatile int removeIcon, resizeIcon;

    private ComposePanelRoot() { }

    public static void header(Object modifier, Object focus, Object composer, int flags) {
        IosHeader.content(modifier, focus, composer, flags);
    }

    public static void grid(Object scope,long size,long parent,Object state,Object grid,Object scroll,
            Object before,Object menu,int mode,Object top,Object bottom,Object composer,int changed) {
        IosGridPanel.content(new Object[]{scope,size,parent,state,grid,scroll,before,menu,mode,top,bottom,composer,changed});
    }

    static boolean ios(Object composer) {
        Abi api = abi;
        return api != null && Integer.valueOf(1).equals(call(api.consume, composer, api.localStyle));
    }

    /** Change the native measure policy, not only the drawn corner shape.
     * GridLayoutInfo and the native drag/resize hit tests receive the same
     * square cell pitch. Do not repack or write a different tile list here. */
    public static float cellAspect(float nativeAspect, Object composer) {
        if (!Float.isFinite(nativeAspect) || nativeAspect <= 0f || !iosPhone(composer))
            return nativeAspect;
        return 1f;
    }

    static boolean iosPhone(Object composer) {
        Abi api=abi;if(api==null || !ios(composer))return false;
        try {
            Object model = call(api.consume, composer, api.localModel);
            Context context = (Context)call(api.userContext, api.host.get(model));
            if (context == null || !Boolean.TRUE.equals(call(api.portrait, model,
                    context.getResources().getConfiguration()))
                    || Boolean.TRUE.equals(call(api.tablet, model))
                    || Boolean.TRUE.equals(call(api.popover, model))) return false;
            return true;
        } catch (IllegalAccessException unavailable) {
            return false;
        }
    }

    /** Reserve the actual trailing rail width in the same native measure pass.
     * It cannot cover a tile or consume its pointer target. RTL follows Compose. */
    public static Object gridModifier(Object nativeModifier,Object composer) {
        Abi api=abi;
        if(api==null || !iosPhone(composer) || !IosGridPanel.active(composer))return nativeModifier;
        Object padding=call(api.padding,null,api.modifier,0f,0f,48f,0f);
        return call(api.then,padding,nativeModifier);
    }

    /** Change only editor artwork at the original painter lookup. Native hit
     * targets, drag/resize handlers, permissions and save callbacks stay owned
     * by Samsung. No replacement editor is installed over the native one. */
    public static int editResource(int nativeResource, Object composer, int kind) {
        Abi api = abi;
        if (api == null || (kind != 0 && kind != 1)) return nativeResource;
        // Height-only/width-only affordances retain their native direction.
        // These IDs belong to the exact pinned painter call-site contracts.
        if (kind == 0 && nativeResource != 0x7e080fe4) return nativeResource;
        if (kind == 1 && nativeResource != 0x7e080820 && nativeResource != 0x7e0809cf)
            return nativeResource;
        if (!Integer.valueOf(1).equals(call(api.consume, composer, api.localStyle))) return nativeResource;
        int cached = kind == 0 ? removeIcon : resizeIcon;
        if (cached != 0) return cached;
        try {
            Object model = call(api.consume, composer, api.localModel);
            Context context = (Context)call(api.userContext, api.host.get(model));
            if (context == null) return nativeResource;
            int id = context.getResources().getIdentifier(
                kind == 0 ? "gmhub_qs_remove" : "gmhub_qs_resize", "drawable", "com.android.systemui");
            if (id == 0) return nativeResource;
            if (kind == 0) removeIcon = id; else resizeIcon = id;
            return id;
        } catch (IllegalAccessException | SecurityException unavailable) {
            return nativeResource;
        }
    }

    /** The only rewritten call site is the outer scene's original main call.
     * Samsung's main function and its own restart lambda are left untouched. */
    public static void content(Object scope, Object modifier, List<?> items,
                               Object tileBox, Object composer, int flags) {
        Abi api = get(composer.getClass().getClassLoader());
        if (api == null) {
            call(original, null, scope, modifier, items, tileBox, composer, flags);
            return;
        }
        api.content(scope, modifier, items, tileBox, composer, flags);
    }

    /** Called at the donor's shape read, without modifying its captured fields.
     * The player's frame and renderer always receive their original objects. */
    public static Object shape(Object holder, Object nativeShape, Object composer) {
        Abi api = abi;
        if (api == null) return nativeShape;
        Object mode = call(api.consume, composer, api.localStyle);
        if (!Integer.valueOf(1).equals(mode)) return nativeShape;
        try {
            Object item = api.tileItem.get(holder);
            if (api.media.isInstance(item) || api.legacyMedia.isInstance(item)) return nativeShape;
            Object tileScope = api.tileScope.get(holder);
            // Gallery previews keep native spans/content, with the same frame
            // treatment as placed controls. Expanded detail geometry stays native.
            if (api.expanded.getBoolean(tileScope))
                return nativeShape;
            long span = api.spanSize.getLong(tileScope);
            int width = (int)(span >> 32), height = (int)span;
            if (width < 1 || height < 1) return nativeShape;
            if(width == 1 || height == 1)return api.capsule;
            return api.inAvailableGrid.getBoolean(tileScope) ? api.galleryCard : api.card;
        } catch (IllegalAccessException changedContract) {
            // All these fields were checked before composition. A shape can
            // fall back locally; never rerun a partially emitted whole scene.
            return nativeShape;
        }
    }

    private static synchronized Abi get(ClassLoader loader) {
        if (attempted) return abi;
        attempted = true;
        try {
            original = type(loader, SCENE + "SecQuickSettingSceneKt").getMethod(
                "SecQuickSettingSceneMain", type(loader, "com.android.compose.animation.scene.ContentScope"),
                type(loader, "androidx.compose.ui.Modifier"), List.class,
                type(loader, SCENE + "panel.QuickTileBoxViewModel"),
                type(loader, RUNTIME + "Composer"), int.class);
            abi = new Abi(loader);
        } catch (ReflectiveOperationException | LinkageError | SecurityException unavailable) {
            Log.e(TAG, "Native QS appearance contract unavailable; using One UI", unavailable);
            if (original == null) throw new IllegalStateException("Native Samsung scene missing", unavailable);
        }
        return abi;
    }

    private static Class<?> type(ClassLoader loader, String name) throws ClassNotFoundException {
        return Class.forName(name, false, loader);
    }
    private static Field field(Class<?> type, String name) throws NoSuchFieldException {
        Field result = type.getField(name); result.setAccessible(true); return result;
    }
    private static Method method(Class<?> type, String name, Class<?>... args) throws NoSuchMethodException {
        Method result = type.getMethod(name, args); result.setAccessible(true); return result;
    }
    private static Object call(Method method, Object receiver, Object... args) {
        try { return method.invoke(receiver, args); }
        catch (InvocationTargetException failed) {
            Throwable cause = failed.getCause();
            if (cause instanceof RuntimeException) throw (RuntimeException)cause;
            if (cause instanceof Error) throw (Error)cause;
            throw new IllegalStateException("Native QS callback failed", cause);
        } catch (ReflectiveOperationException failed) {
            throw new IllegalStateException("Native QS invocation contract changed", failed);
        }
    }
    private interface Callback { Object invoke(Object[] args); }

    private static final class Abi {
        final ClassLoader loader;
        final Class<?> function0, function1, function2, disposable, media, legacyMedia;
        final Method start, end, startReplace, endReplace, changedObject, changedInt;
        final Method remembered, remember, consume, state, value, setValue, disposableEffect;
        final Method provide, provider, composable, updateScope, userId, userContext, portrait, tablet, popover, padding, then;
        final Field host, tileItem, tileScope, spanSize, inAvailableGrid, expanded;
        final Object empty, unit, localModel, localStyle, capsule, card, galleryCard, modifier;

        Abi(ClassLoader loader) throws ReflectiveOperationException {
            this.loader = loader;
            function0 = type(loader, "kotlin.jvm.functions.Function0");
            function1 = type(loader, "kotlin.jvm.functions.Function1");
            function2 = type(loader, "kotlin.jvm.functions.Function2");
            Class<?> composer = type(loader, RUNTIME + "Composer");
            Class<?> local = type(loader, RUNTIME + "CompositionLocal");
            Class<?> locals = type(loader, RUNTIME + "CompositionLocalKt");
            start = method(composer, "startRestartGroup", int.class);
            end = method(composer, "endRestartGroup");
            startReplace = method(composer, "startReplaceGroup", int.class);
            endReplace = method(composer, "endReplaceGroup");
            changedObject = method(composer, "changedInstance", Object.class);
            changedInt = method(composer, "changed", int.class);
            remembered = method(composer, "rememberedValue");
            remember = method(composer, "updateRememberedValue", Object.class);
            consume = method(composer, "consume", local);
            Object companion = field(composer, "Companion").get(null);
            empty = method(type(loader, RUNTIME + "Composer$Companion"), "getEmpty").invoke(companion);
            unit = field(type(loader, "kotlin.Unit"), "INSTANCE").get(null);
            state = method(type(loader, RUNTIME + "SnapshotStateKt"), "mutableStateOf$default", Object.class);
            value = method(type(loader, RUNTIME + "State"), "getValue");
            setValue = method(type(loader, RUNTIME + "MutableState"), "setValue", Object.class);
            disposable = type(loader, RUNTIME + "DisposableEffectResult");
            disposableEffect = method(type(loader, RUNTIME + "EffectsKt"), "DisposableEffect",
                Object.class, function1, composer);
            updateScope = method(type(loader, RUNTIME + "ScopeUpdateScope"), "updateScope", function2);
            provider = method(locals, "CompositionLocalProvider", type(loader, RUNTIME + "ProvidedValue"),
                function2, composer, int.class);
            provide = method(type(loader, RUNTIME + "ProvidableCompositionLocal"), "provides", Object.class);
            composable = method(type(loader, RUNTIME + "internal.ComposableLambdaKt"),
                "rememberComposableLambda", int.class, boolean.class, Object.class, composer, int.class);
            localModel = field(type(loader, SCENE + "SecQuickSettingSceneKt"), "LocalViewModel").get(null);
            localStyle = method(locals, "compositionLocalOf$default", function0)
                .invoke(null, function(function0, args -> Integer.valueOf(0)));
            Class<?> model = type(loader, SCENE + "panel.QuickSettingSceneViewModel");
            host = field(model, "qsHost");
            portrait = method(model, "isPortraitPanel", android.content.res.Configuration.class);
            tablet = method(model, "isTablet"); popover = method(model, "isPopOverEnabled");
            Class<?> modifierType=type(loader,"androidx.compose.ui.Modifier");
            modifier=field(modifierType,"Companion").get(null);
            padding=method(type(loader,"androidx.compose.foundation.layout.PaddingKt"),"padding-qDBjuR0",
                modifierType,float.class,float.class,float.class,float.class);
            then=method(modifierType,"then",modifierType);
            Class<?> qsHost = type(loader, "com.android.systemui.qs.QSHost");
            userId = method(qsHost, "getUserId"); userContext = method(qsHost, "getUserContext");
            Class<?> tile = type(loader, GRID + "SpannableGridTileKt$$ExternalSyntheticLambda6");
            tileItem = field(tile, "f$1"); tileScope = field(tile, "f$22");
            Class<?> scope = type(loader, GRID + "SpannableGridTileScopeImpl");
            spanSize = field(scope, "spanSize");
            inAvailableGrid = field(scope, "inAvailableGrid"); expanded = field(scope, "expanded");
            String items = "com.android.systemui.samsung.quicksetting.domain.model.items.";
            media = type(loader, items + "MediaPlayer"); legacyMedia = type(loader, items + "LegacyMediaPlayer");
            Class<?> shapes = type(loader, "androidx.compose.foundation.shape.RoundedCornerShapeKt");
            capsule = method(shapes, "RoundedCornerShape", int.class).invoke(null, 50);
            galleryCard = method(shapes, "RoundedCornerShape", int.class).invoke(null, 16);
            card = method(shapes, "RoundedCornerShape-0680j_4", float.class).invoke(null, 32f);
        }

        Object function(Class<?> contract, Callback callback) {
            return Proxy.newProxyInstance(loader, new Class<?>[]{contract}, (proxy, method, args) -> {
                if (method.getDeclaringClass() == Object.class) {
                    switch (method.getName()) {
                        case "equals": return proxy == args[0];
                        case "hashCode": return System.identityHashCode(proxy);
                        case "toString": return "GMHubQs/" + contract.getSimpleName();
                        default: throw new UnsupportedOperationException(method.getName());
                    }
                }
                return callback.invoke(args == null ? new Object[0] : args);
            });
        }

        void content(Object scope, Object modifier, List<?> items, Object tileBox,
                     Object incoming, int flags) {
            Object c = call(start, incoming, ROOT_KEY);
            Object model = call(consume, c, localModel);
            Object qsHost;
            Context context;
            try {
                qsHost = host.get(model);
                context = (Context)call(userContext, qsHost);
                if (context == null) throw new IllegalStateException("Native QS user context unavailable");
            } catch (IllegalAccessException impossible) { throw new IllegalStateException(impossible); }
            int user = ((Number)call(userId, qsHost)).intValue();
            call(startReplace, c, SESSION_KEY);
            // Both slots must always be visited; do not short-circuit || here.
            boolean changed = (Boolean)call(changedObject, c, model);
            changed |= (Boolean)call(changedInt, c, user);
            Object stored = call(remembered, c);
            Session session;
            if (changed || stored == empty || !(stored instanceof Session)) {
                session = new Session(this, context, user);
                call(remember, c, session);
            } else session = (Session)stored;
            call(endReplace, c);
            call(disposableEffect, null, session, session.effect, c);
            Object style = call(value, session.selection);

            call(startReplace, c, CONTENT_KEY);
            boolean newContent = (Boolean)call(changedObject, c, scope);
            newContent |= (Boolean)call(changedObject, c, modifier);
            newContent |= (Boolean)call(changedObject, c, items);
            newContent |= (Boolean)call(changedObject, c, tileBox);
            newContent |= (Boolean)call(changedInt, c, flags);
            Object content = call(remembered, c);
            if (newContent || content == empty) {
                content = function(function2, args -> {
                    call(original, null, scope, modifier, items, tileBox, args[0], flags);
                    return unit;
                });
                call(remember, c, content);
            }
            call(endReplace, c);
            Object slot = call(composable, null, LAMBDA_KEY, true, content, c, 0);
            call(provider, null, call(provide, localStyle, style), slot, c, 0);
            Object restart = call(end, c);
            if (restart != null) call(updateScope, restart, function(function2, args -> {
                content(scope, modifier, items, tileBox, args[0], flags | 1);
                return unit;
            }));
        }
    }

    /** One observer per remembered user/scene. It starts only after composition
     * commits and is disposed by Samsung's normal Compose lifecycle. */
    private static final class Session {
        final Abi api;
        final Context context;
        final int user;
        final Object selection, effect, result;
        final ContentObserver observer;
        boolean registered, closed;

        Session(Abi api, Context context, int user) {
            this.api = api; this.context = context; this.user = user;
            selection = call(api.state, null, Integer.valueOf(read()));
            observer = new ContentObserver(new Handler(Looper.getMainLooper())) {
                @Override public void onChange(boolean self) { refresh(); }
            };
            result = api.function(api.disposable, args -> { close(); return null; });
            effect = api.function(api.function1, args -> { activate(); return result; });
        }
        int read() {
            try {
                int value = Settings.Secure.getInt(context.getContentResolver(), SETTING, 0);
                return value == 1 ? 1 : 0;
            } catch (RuntimeException unavailable) { return 0; }
        }
        void refresh() {
            if (!closed) call(api.setValue, selection, Integer.valueOf(read()));
        }
        void activate() {
            if (closed || registered) return;
            try {
                context.getContentResolver().registerContentObserver(Settings.Secure.getUriFor(SETTING), false, observer);
                registered = true;
                refresh(); // Close the read/register race without a polling loop.
            } catch (RuntimeException unavailable) {
                call(api.setValue, selection, Integer.valueOf(0));
                Log.w(TAG, "Cannot observe QS appearance for user " + user, unavailable);
            }
        }
        void close() {
            if (closed) return;
            closed = true;
            if (!registered) return;
            registered = false;
            try { context.getContentResolver().unregisterContentObserver(observer); }
            catch (RuntimeException unavailable) { Log.w(TAG, "QS observer already unavailable", unavailable); }
        }
    }
}
