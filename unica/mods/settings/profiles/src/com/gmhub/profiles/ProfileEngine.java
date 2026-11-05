package com.gmhub.profiles;

import java.util.*;

/** Source-owned transaction journal. Opening a page performs no writes. */
public final class ProfileEngine {
    public interface Access {
        String read(String key) throws Exception;
        void write(String key, String value) throws Exception;
    }
    public interface Store {
        State load() throws Exception;
        void save(State value) throws Exception;
    }
    public static final class Entry {
        public final String original, applied;
        public final List<String> owned;
        public Entry(String original, String applied, Collection<String> owned) {
            this.original = original; this.applied = applied;
            this.owned = Collections.unmodifiableList(new ArrayList<>(owned));
        }
        public Entry(String original, String applied) {
            this(original, applied, Collections.singletonList(applied));
        }
    }
    public static final class State {
        public final String mode;
        public final boolean pending;
        public final Map<String, Entry> entries;
        public State(String mode, boolean pending, Map<String, Entry> entries) {
            if (!Arrays.asList("stock", "smooth", "gaming", "battery").contains(mode))
                throw new IllegalArgumentException("Unknown profile");
            this.mode = mode; this.pending = pending;
            this.entries = Collections.unmodifiableMap(new LinkedHashMap<>(entries));
        }
        public static State empty() { return new State("stock", false, Collections.emptyMap()); }
    }
    public static final class RestoreResult {
        public final int changed, conflicts, failed;
        RestoreResult(int changed, int conflicts, int failed) { this.changed = changed; this.conflicts = conflicts; this.failed = failed; }
    }
    private final Access access;
    private final Store store;
    public ProfileEngine(Access access, Store store) { this.access = access; this.store = store; }
    public synchronized State state() throws Exception { return store.load(); }
    public synchronized String status() throws Exception {
        State state = store.load();
        if (state.pending) return "pending";
        for (Map.Entry<String, Entry> e : state.entries.entrySet())
            if (!Objects.equals(access.read(e.getKey()), e.getValue().applied)) return "custom";
        return state.mode;
    }
    public synchronized void apply(String mode, Map<String, String> plan) throws Exception {
        if (!Arrays.asList("smooth", "gaming", "battery").contains(mode) || plan.isEmpty())
            throw new IllegalArgumentException("Invalid profile plan");
        State before = store.load();
        if (before.pending) throw new IllegalStateException("Restore the incomplete transaction first");
        LinkedHashMap<String, String> desired = new LinkedHashMap<>(plan);
        LinkedHashMap<String, String> current = new LinkedHashMap<>();
        // Values changed only by the previous mode must also be restored on a mode switch.
        for (Map.Entry<String, Entry> e : before.entries.entrySet()) if (!desired.containsKey(e.getKey())) {
            String value = access.read(e.getKey());
            if (Objects.equals(value, e.getValue().applied)) desired.put(e.getKey(), e.getValue().original);
        }
        LinkedHashMap<String, Entry> pending = new LinkedHashMap<>(), committed = new LinkedHashMap<>();
        for (Map.Entry<String, String> e : desired.entrySet()) {
            String key = e.getKey(), value = access.read(key), target = e.getValue();
            current.put(key, value);
            Entry old = before.entries.get(key);
            String original = old != null && Objects.equals(value, old.applied) ? old.original : value;
            pending.put(key, new Entry(original, target, Arrays.asList(value, target)));
            if (!Objects.equals(original, target)) committed.put(key, new Entry(original, target));
        }
        // Save recovery intent before the FIRST mutation, not after showing success.
        store.save(new State(mode, true, pending));
        List<String> attempted = new ArrayList<>();
        try {
            for (Map.Entry<String, String> e : desired.entrySet()) {
                if (Objects.equals(current.get(e.getKey()), e.getValue())) continue;
                attempted.add(e.getKey());
                set(e.getKey(), e.getValue());
            }
            store.save(new State(mode, false, committed));
        } catch (Exception failure) {
            boolean restored = true;
            Collections.reverse(attempted);
            for (String key : attempted) {
                try {
                    String actual = access.read(key);
                    if (Objects.equals(actual, current.get(key))) continue;
                    if (!Objects.equals(actual, desired.get(key)))
                        throw new IllegalStateException("Changed outside this transaction: " + key);
                    set(key, current.get(key));
                } catch (Exception recovery) { restored = false; failure.addSuppressed(recovery); }
            }
            if (restored) {
                try { store.save(before); }
                catch (Exception recovery) { failure.addSuppressed(recovery); }
            }
            throw failure;
        }
    }
    private void set(String key, String value) throws Exception {
        try { access.write(key, value); }
        catch (Exception failure) {
            // A Binder exception can occur after the requested change has taken effect.
            if (!Objects.equals(access.read(key), value)) throw failure;
        }
        if (!Objects.equals(access.read(key), value)) throw new IllegalStateException("Unconfirmed setting: " + key);
    }
    public synchronized RestoreResult restore() throws Exception {
        State state = store.load();
        LinkedHashMap<String, Entry> remaining = new LinkedHashMap<>(state.entries);
        if (!remaining.isEmpty()) store.save(new State(state.mode, true, remaining));
        int changed = 0, conflicts = 0, failed = 0;
        for (Map.Entry<String, Entry> e : state.entries.entrySet()) {
            try {
                String actual = access.read(e.getKey());
                Entry entry = e.getValue();
                if (!Objects.equals(actual, entry.original)) {
                    if (!entry.owned.contains(actual)) conflicts++;
                    else { set(e.getKey(), entry.original); changed++; }
                }
                remaining.remove(e.getKey());
                store.save(remaining.isEmpty() ? State.empty() : new State(state.mode, true, remaining));
            } catch (Exception failure) { failed++; }
        }
        if (remaining.isEmpty()) store.save(State.empty());
        else store.save(new State(state.mode, true, remaining));
        return new RestoreResult(changed, conflicts, failed);
    }
}
