package com.gmhub.qs;

import java.io.IOException;
import java.util.Objects;
import java.util.concurrent.Executor;
import java.util.function.IntSupplier;

/** Connects editor previews to background persistence. Only accepted edits reach
 * storage, never pointer moves; a failed write restores the accepted layout.
 * The owner supplies SystemUI's main executor and private per-user storage.
 * This class owns neither a native controller nor a background service.
 */
public final class EditorSession implements AutoCloseable {
    public interface Observer {
        void render(LayoutPersistence.Saved state, boolean editing, boolean saving);
        void failed(Exception error);
    }
    private final Thread owner = Thread.currentThread();
    private final Executor background, main;
    private final LayoutPersistence store;
    private final Observer observer;
    private final IntSupplier activeUser;
    private final int user;
    private volatile boolean closed;
    private boolean loading, saving, editing;
    private LayoutPersistence.Saved accepted, draft;

    public EditorSession(int user, IntSupplier activeUser, LayoutPersistence store,
                         Executor background, Executor main, Observer observer) {
        if (user < 0) throw new IllegalArgumentException("Invalid QS user");
        this.user = user; this.activeUser = Objects.requireNonNull(activeUser);
        this.store = Objects.requireNonNull(store); this.background = Objects.requireNonNull(background);
        this.main = Objects.requireNonNull(main); this.observer = Objects.requireNonNull(observer);
    }
    private boolean current() {
        if (Thread.currentThread() != owner) throw new IllegalStateException("QS main thread required");
        if (closed) return false;
        if (activeUser.getAsInt() != user) { close(); return false; }
        return true;
    }
    private void render() { observer.render(editing ? draft : accepted, editing, saving); }
    public boolean ready() { return current() && accepted != null && !loading && !saving; }
    /** Defaults are used only for a genuinely absent file, never corrupt data. */
    public boolean load(LayoutPersistence.Saved defaults) {
        if (!current() || loading || saving || accepted != null) return false;
        if (defaults == null || defaults.revision != 0) throw new IllegalArgumentException("Invalid defaults");
        loading = true;
        try {
            background.execute(() -> {
                if (closed) return;
                LayoutPersistence.Saved loaded = null; Exception failure = null;
                try { loaded = store.load(); } catch (Exception error) { failure = error; }
                final LayoutPersistence.Saved result = loaded;
                final Exception error = failure;
                main.execute(() -> {
                    if (!current()) return;
                    loading = false;
                    if (error != null) { observer.failed(error); return; }
                    accepted = result == null ? defaults : result; render();
                });
            });
        } catch (RuntimeException error) { loading = false; observer.failed(error); return false; }
        return true;
    }
    public boolean begin() {
        if (!ready() || editing) return false;
        draft = accepted; editing = true; render(); return true;
    }
    public boolean preview(LayoutPersistence.Saved candidate) {
        if (!current() || !editing || saving || candidate == null
                || candidate.revision != accepted.revision) return false;
        // Geometry changes must retain the current portrait board. A renderer
        // can derive a separate landscape snapshot without mutating portrait.
        if (candidate.portrait.board != accepted.portrait.board) return false;
        draft = candidate; render(); return true;
    }
    public boolean cancel() {
        if (!current() || !editing || saving) return false;
        draft = null; editing = false; render(); return true;
    }
    /** Finish is one asynchronous transaction, with touch editing suspended
     * until completion. A stale external editor is reloaded, not overwritten. */
    public boolean finish() {
        if (!current() || !editing || saving) return false;
        final LayoutPersistence.Saved candidate = draft;
        saving = true; render();
        try {
            background.execute(() -> {
                if (closed) return;
                LayoutPersistence.Saved saved = null, latest = null; Exception failure = null;
                try {
                    saved = store.save(candidate.revision, candidate);
                    if (saved == null) {
                        latest = store.load();
                        failure = new IOException("QS layout changed in another editor");
                    }
                } catch (Exception error) { failure = error; }
                final LayoutPersistence.Saved result = saved, external = latest;
                final Exception error = failure;
                main.execute(() -> {
                    if (!current()) return;
                    saving = false; editing = false; draft = null;
                    if (result != null) accepted = result;
                    else if (external != null) accepted = external;
                    render();
                    if (error != null) observer.failed(error);
                });
            });
        } catch (RuntimeException error) {
            saving = false; editing = false; draft = null; render(); observer.failed(error); return false;
        }
        return true;
    }
    @Override public void close() {
        if (Thread.currentThread() != owner) throw new IllegalStateException("QS main thread required");
        // In-flight writes may finish atomically in the old user's private
        // directory. Their completion can never render into the next user.
        closed = true; draft = null; accepted = null; editing = false;
    }
}
