package com.gmhub.monitor;

import java.io.*;
import java.nio.charset.StandardCharsets;
import java.util.*;

/** One bounded meminfo snapshot. ZRAM statistics are not aggregate SwapTotal. */
public final class MemoryReader {
    private MemoryReader() { }
    private static final Set<String> KEYS = new HashSet<>(Arrays.asList(
        "MemTotal", "MemAvailable", "Active", "Cached", "SwapTotal", "SwapFree"));
    public static final class Snapshot {
        public final Long totalBytes, usedBytes, activeBytes, cachedBytes;
        public final Long swapTotalBytes, swapUsedBytes, zramLogicalBytes, zramCapacityBytes, zramRamBytes;
        Snapshot(Map<String, Long> values, Long[] zram) {
            Long total = values.get("MemTotal");
            totalBytes = total == null || total == 0 ? null : total;
            usedBytes = used(totalBytes, values.get("MemAvailable"));
            activeBytes = values.get("Active"); cachedBytes = values.get("Cached");
            swapTotalBytes = values.get("SwapTotal");
            swapUsedBytes = used(swapTotalBytes, values.get("SwapFree"));
            zramLogicalBytes = zram[0]; zramCapacityBytes = zram[1]; zramRamBytes = zram[2];
        }
    }
    private static Long used(Long total, Long free) {
        return total == null || free == null || free > total ? null : total - free;
    }
    private static String read(File path, int limit) throws IOException {
        try (Reader input = new InputStreamReader(new FileInputStream(path), StandardCharsets.US_ASCII)) {
            StringBuilder text = new StringBuilder();
            for (int i = 0; i <= limit; i++) {
                int c = input.read(); if (c == -1) return text.toString();
                if (i == limit) throw new IOException("Oversized memory field");
                text.append((char)c);
            }
            throw new IOException("Invalid memory field");
        }
    }
    private static long unsigned(String text) {
        if (!text.matches("[0-9]{1,19}")) throw new NumberFormatException("Unsigned bytes required");
        return Long.parseLong(text);
    }
    public static Snapshot read(File meminfo, File blockDirectory) {
        Map<String, Long> values = new HashMap<>();
        Set<String> duplicates = new HashSet<>();
        try {
            for (String line : read(meminfo, 65536).split("\n")) {
                int colon = line.indexOf(':'); if (colon < 0) continue;
                String key = line.substring(0, colon);
                if (!KEYS.contains(key)) continue;
                if (!duplicates.add(key)) {
                    values.remove(key); continue;
                }
                String[] field = line.substring(colon + 1).trim().split("\\s+");
                try {
                    if (field.length != 2 || !field[1].equals("kB")) continue;
                    long kib = unsigned(field[0]);
                    if (kib > Long.MAX_VALUE / 1024) continue;
                    values.put(key, kib * 1024);
                } catch (NumberFormatException invalid) { }
            }
        } catch (IOException | SecurityException unreadable) { }
        return new Snapshot(values, zram(blockDirectory));
    }
    private static Long[] zram(File directory) {
        long logical = 0, capacity = 0, ram = 0;
        try {
            File[] devices = directory.listFiles(file -> file.getName().matches("zram[0-9]{1,2}"));
            if (devices == null || devices.length == 0 || devices.length > 16) return new Long[3];
            for (File device : devices) {
                long size = unsigned(read(new File(device, "disksize"), 64).trim());
                // Uninitialized devices contribute nothing; mm_stat need not exist yet.
                if (size == 0) continue;
                String[] stats = read(new File(device, "mm_stat"), 512).trim().split("\\s+");
                if (stats.length < 3) return new Long[3];
                long data = unsigned(stats[0]), physical = unsigned(stats[2]);
                if (data > size) return new Long[3];
                logical = Math.addExact(logical, data); capacity = Math.addExact(capacity, size);
                ram = Math.addExact(ram, physical);
            }
            return new Long[]{logical, capacity, ram};
        } catch (IOException | SecurityException | NumberFormatException | ArithmeticException invalid) {
            return new Long[3];
        }
    }
}
