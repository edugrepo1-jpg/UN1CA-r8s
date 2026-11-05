package com.gmhub.qs;

import java.io.IOException;
import java.lang.reflect.Constructor;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.lang.reflect.Proxy;
import java.util.Objects;
import java.util.concurrent.Executor;
import java.util.function.Consumer;

/** Completion-aware adapter for Samsung's original editor save coroutine.
 * Exiting edit mode or publishing a StateFlow is not persistence. The original
 * SaveEventCoordinator/converters/repository remain responsible for writing.
 * No player, media controller, coroutine scope or preference store is replaced.
 * A completed native job is not evidence of a tested reboot or rendered panel.
 */
public final class NativeEditorSave implements AutoCloseable {
    public enum Status { IDLE, SAVING, UNKNOWN, CLOSED }
    public interface Pending { void detach() throws Exception; }
    /** Narrow native boundary, also used by failure/lifecycle host contracts. */
    public interface Port {
        boolean isCurrent() throws Exception;
        boolean canFinish() throws Exception;
        boolean writable() throws Exception;
        Pending start(Consumer<Throwable> completed) throws Exception;
    }
    private static final class Request {
        volatile RuntimeException deliveryFailure;
    }
    private final Thread owner = Thread.currentThread();
    private final Port port;
    private final Executor main;
    private volatile boolean closed;
    private Status status = Status.IDLE;
    private Request request;
    private Pending pending;
    private Consumer<Throwable> observer;

    public NativeEditorSave(SamsungScene scene, Executor main) throws Exception {
        this(new SamsungPort(scene), main);
    }
    public NativeEditorSave(Port port, Executor main) {
        this.port = Objects.requireNonNull(port); this.main = Objects.requireNonNull(main);
    }
    private void ui() {
        if (Thread.currentThread() != owner) throw new IllegalStateException("QS UI thread required");
    }
    private void detach() {
        Pending old = pending; pending = null;
        if (old != null) try { old.detach(); } catch (Exception ignored) {
            // A disposed native owner can already have destroyed its handle.
            // Request identity/closed checks reject late completion callbacks.
        }
    }
    private void report(Throwable failure) {
        Consumer<Throwable> callback = observer; observer = null;
        if (callback != null) callback.accept(failure);
    }
    private void settleDeliveryFailure() {
        if (!closed && status == Status.SAVING && request.deliveryFailure != null) {
            Throwable failure = request.deliveryFailure;
            status = Status.UNKNOWN; request = null; detach();
            if (currentOwner()) report(failure);
        }
    }
    private boolean currentOwner() {
        try { if (port.isCurrent()) return true; }
        catch (Exception unavailable) { /* The old owner is no longer safe to update. */ }
        close(); return false;
    }
    public Status status() { ui(); settleDeliveryFailure(); return status; }

    /** True means the original save request was launched, not that it finished.
     * The callback receives null only after the native job completed normally
     * and the repository is still writable. Unknown outcomes are never retried
     * automatically: the native owner must be rebound/read back first.
     */
    public boolean finish(Consumer<Throwable> completed) {
        ui(); settleDeliveryFailure();
        if (closed || status != Status.IDLE) return false;
        Objects.requireNonNull(completed);
        if (!currentOwner()) return false;
        Throwable preflightFailure = null;
        try {
            if (!port.canFinish()) return false;
            if (!port.writable()) preflightFailure = new IOException("Native QS preferences are in write safe mode");
        } catch (Exception error) { preflightFailure = error; }
        // Observer exceptions must not be mistaken for native preflight errors
        // and invoke the observer a second time.
        if (preflightFailure != null) { completed.accept(preflightFailure); return false; }
        final Request started = new Request();
        request = started;
        observer = completed; status = Status.SAVING;
        try {
            Pending launched = Objects.requireNonNull(port.start(error -> {
                if (closed) return;
                try { main.execute(() -> {
                    if (Thread.currentThread() != owner) {
                        started.deliveryFailure = new IllegalStateException("QS completion executor is not the UI owner");
                        return;
                    }
                    complete(started, error);
                }); }
                catch (RuntimeException rejected) { if (!closed) started.deliveryFailure = rejected; }
            }), "Native completion handle is missing");
            // invokeOnCompletion may run inline for an already completed job.
            if (!closed && status == Status.SAVING && request == started) pending = launched;
            else try { launched.detach(); } catch (Exception ignored) { }
            return true;
        } catch (Exception failure) {
            // A launch/registration implementation can fail after dispatching.
            // Do not pretend nothing happened, roll back a possible disk write,
            // or dispatch a second save while the first outcome is unknown.
            if (!closed && request == started && status == Status.SAVING) {
                status = Status.UNKNOWN; request = null; detach();
                if (currentOwner()) report(failure);
            }
            return false;
        }
    }
    private void complete(Request started, Throwable cause) {
        ui();
        if (closed || status != Status.SAVING || request != started) return;
        detach();
        if (!currentOwner()) return;
        Throwable failure = cause;
        if (failure == null) try {
            if (!port.writable()) failure = new IOException("QS write safe mode became active during save");
        } catch (Exception error) { failure = error; }
        // Even a failing native job may have performed part of its work.
        // Recovery belongs to the existing native repository, not a guessed
        // reverse write to the live flow or a second editor transaction.
        status = failure == null ? Status.IDLE : Status.UNKNOWN; request = null;
        report(failure);
    }
    @Override public void close() {
        ui(); if (closed) return;
        closed = true; request = null; status = Status.CLOSED; observer = null; detach();
        // Samsung owns the launched job and ViewModelScope. Do not cancel them.
    }

    private static final class SamsungPort implements Port {
        private static final String PANEL = "com.android.systemui.samsung.quicksetting.ui.panel.";
        private final SamsungScene scene;
        private final Object model, edit, repository;
        private final ClassLoader loader;
        SamsungPort(SamsungScene scene) throws Exception {
            this.scene = Objects.requireNonNull(scene); model = scene.nativeModel();
            edit = field(model, "$$delegate_0");
            repository = field(field(model, "saveEventCoordinator"), "gridTileRepository");
            loader = model.getClass().getClassLoader();
            // All reflection contracts are resolved before changing native state.
            method(edit, "toggleEditMode"); method(repository, "isGridPrefsWriteSafeModeActive");
            type(PANEL + "QuickSettingSceneViewModel$commitDataChanged$1").getDeclaredConstructor(
                type(PANEL + "QuickSettingSceneViewModel"), type("kotlin.coroutines.Continuation"));
            scopeMethod(); launchMethod();
            type("kotlinx.coroutines.Job").getMethod("invokeOnCompletion", type("kotlin.jvm.functions.Function1"));
            type("kotlinx.coroutines.DisposableHandle").getMethod("dispose");
        }
        private Class<?> type(String name) throws ClassNotFoundException { return Class.forName(name, false, loader); }
        private static Object field(Object target, String name) throws Exception {
            Field f = target.getClass().getField(name); f.setAccessible(true); return f.get(target);
        }
        private static Method method(Object target, String name, Class<?>... args) throws Exception {
            Method m = target.getClass().getMethod(name, args); m.setAccessible(true); return m;
        }
        private static boolean bool(Object value) {
            if (!(value instanceof Boolean)) throw new IllegalStateException("Changed native QS boolean contract");
            return (Boolean)value;
        }
        private boolean editing() throws Exception {
            Object flow = field(edit, "editMode");
            return bool(method(flow, "getValue").invoke(flow));
        }
        private Method scopeMethod() throws Exception {
            return type("androidx.lifecycle.ViewModelKt").getMethod("getViewModelScope", type("androidx.lifecycle.ViewModel"));
        }
        private Method launchMethod() throws Exception {
            return type("kotlinx.coroutines.BuildersKt").getMethod("launch$default",
                type("kotlinx.coroutines.CoroutineScope"), type("kotlin.coroutines.CoroutineContext"),
                type("kotlinx.coroutines.CoroutineStart"), type("kotlin.jvm.functions.Function2"), int.class);
        }
        @Override public boolean canFinish() throws Exception {
            return scene.geometryAllowed() && !scene.geometryInProgress() && editing();
        }
        @Override public boolean isCurrent() throws Exception { return scene.geometryOwned(); }
        @Override public boolean writable() throws Exception {
            return !bool(method(repository, "isGridPrefsWriteSafeModeActive").invoke(repository));
        }
        @Override public Pending start(Consumer<Throwable> completed) throws Exception {
            if (!canFinish() || !writable()) throw new IllegalStateException("Native QS editor changed before save");
            Constructor<?> constructor = type(PANEL + "QuickSettingSceneViewModel$commitDataChanged$1")
                .getDeclaredConstructor(type(PANEL + "QuickSettingSceneViewModel"), type("kotlin.coroutines.Continuation"));
            constructor.setAccessible(true);
            Object block = constructor.newInstance(model, null);
            Method scopeGetter = scopeMethod(); scopeGetter.setAccessible(true);
            Object scope = scopeGetter.invoke(null, model);
            Method launch = launchMethod(); launch.setAccessible(true);
            Class<?> function = type("kotlin.jvm.functions.Function1");
            Object unit = type("kotlin.Unit").getField("INSTANCE").get(null);
            Object callback = Proxy.newProxyInstance(loader, new Class<?>[]{function}, (self, called, args) -> {
                switch (called.getName()) {
                    case "hashCode": return System.identityHashCode(self);
                    case "equals": return args != null && args.length == 1 && self == args[0];
                    case "toString": return "GMHubNativeQSSaveCompletion";
                    case "invoke":
                        Throwable cause = args != null && args.length == 1 && args[0] == null ? null
                            : args != null && args.length == 1 && args[0] instanceof Throwable ? (Throwable)args[0]
                            : new IllegalStateException("Changed native QS completion contract");
                        completed.accept(cause); return unit;
                    default: throw new IllegalStateException("Unexpected native completion callback");
                }
            });
            // This is the same sequence used by the donor's own Done action.
            // Do not invokeSuspend manually or create another coroutine scope.
            method(edit, "toggleEditMode").invoke(edit);
            if (editing()) throw new IllegalStateException("Native editor did not leave edit mode");
            Object job = Objects.requireNonNull(launch.invoke(null, scope, null, null, block, 3));
            Method onCompletion = type("kotlinx.coroutines.Job").getMethod("invokeOnCompletion", function);
            Object handle = Objects.requireNonNull(onCompletion.invoke(job, callback));
            Method dispose = type("kotlinx.coroutines.DisposableHandle").getMethod("dispose");
            return () -> dispose.invoke(handle);
        }
    }
}
