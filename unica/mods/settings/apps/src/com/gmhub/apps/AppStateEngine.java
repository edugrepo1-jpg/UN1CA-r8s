package com.gmhub.apps;

import java.util.Set;

/** Journal only changes made by this Hub. No shell commands or blanket restore. */
public final class AppStateEngine {
    public interface Access {
        int read(String pkg) throws Exception;
        void write(String pkg, int state) throws Exception;
        boolean canDisable(String pkg) throws Exception;
    }
    public interface Journal {
        Record get(String pkg) throws Exception;
        void put(String pkg, Record value) throws Exception;
        void remove(String pkg) throws Exception;
        Set<String> keys() throws Exception;
    }
    public static final class Record {
        public final int original, applied;
        public Record(int original, int applied) {
            valid(original); valid(applied); this.original = original; this.applied = applied;
        }
        public String encode() { return original + ":" + applied; }
        public static Record decode(String encoded) {
            if (encoded == null || !encoded.matches("[0-4]:[0-4]"))
                throw new IllegalArgumentException("Invalid app-state journal");
            return new Record(encoded.charAt(0) - '0', encoded.charAt(2) - '0');
        }
    }
    private final Access access;
    private final Journal journal;
    public AppStateEngine(Access access, Journal journal) { this.access = access; this.journal = journal; }
    private static void valid(int state) {
        if (state < 0 || state > 4) throw new IllegalArgumentException("Invalid package state");
    }
    public static void packageName(String name) {
        if (name == null || name.length() > 255 || !name.matches("[A-Za-z_][A-Za-z0-9_]*(\\.[A-Za-z_][A-Za-z0-9_]*)*"))
            throw new IllegalArgumentException("Invalid package name");
    }
    /** Native state 1=enabled and 3=disabled-user. Persist intent BEFORE mutation. */
    public synchronized boolean change(String pkg, boolean enabled) throws Exception {
        packageName(pkg);
        if (!enabled && !access.canDisable(pkg)) throw new SecurityException("Protected app");
        int before = access.read(pkg), target = enabled ? 1 : 3;
        valid(before);
        if (before == target) return false;
        Record previous = journal.get(pkg);
        int original = previous != null && (before == previous.applied || before == previous.original)
            ? previous.original : before;
        journal.put(pkg, new Record(original, target));
        try {
            access.write(pkg, target);
            if (access.read(pkg) != target) throw new IllegalStateException("Package state not confirmed");
            return true;
        } catch (Exception failure) {
            try {
                int actual = access.read(pkg);
                if (actual == target) return true;
                if (actual == before) {
                    if (previous == null) journal.remove(pkg); else journal.put(pkg, previous);
                }
            } catch (Exception recovery) { failure.addSuppressed(recovery); }
            throw failure;
        }
    }
    public synchronized boolean restore(String pkg) throws Exception {
        packageName(pkg);
        Record record = journal.get(pkg);
        if (record == null) return false;
        int actual = access.read(pkg);
        if (actual == record.original) { journal.remove(pkg); return false; }
        if (actual != record.applied) throw new IllegalStateException("App changed outside the Hub");
        if (record.original != 1 && !access.canDisable(pkg)) throw new SecurityException("Protected app");
        access.write(pkg, record.original);
        if (access.read(pkg) != record.original) throw new IllegalStateException("Restore not confirmed");
        journal.remove(pkg);
        return true;
    }
}
