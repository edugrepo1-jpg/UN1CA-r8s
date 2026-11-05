package com.gmhub.monitor;

import java.io.*;
import java.nio.charset.StandardCharsets;

/** Read-only Samsung gauge fields retained from the original Hub page. */
public final class SamsungBatteryReader {
    private SamsungBatteryReader() { }
    public static final class Snapshot {
        public final Integer fullCapacityMah, cycles, asocPercent;
        Snapshot(Integer capacity, Integer cycles, Integer asoc) {
            fullCapacityMah = capacity; this.cycles = cycles; asocPercent = asoc;
        }
    }
    private static Integer read(File directory, String name) {
        try (Reader input = new InputStreamReader(new FileInputStream(new File(directory, name)), StandardCharsets.US_ASCII)) {
            StringBuilder value = new StringBuilder();
            for (int i = 0; i <= 64; i++) {
                int c = input.read();
                if (c == -1) {
                    String text = value.toString().trim();
                    if (!text.matches("[0-9]{1,10}")) return null;
                    int number = Integer.parseInt(text);
                    return number == Integer.MAX_VALUE ? null : number;
                }
                if (i == 64) return null;
                value.append((char)c);
            }
        } catch (IOException | SecurityException | NumberFormatException unavailable) { }
        return null;
    }
    public static Snapshot read(File directory) {
        Integer capacity = read(directory, "fg_fullcapnom");
        if (capacity != null && capacity == 0) capacity = null;
        return new Snapshot(capacity, read(directory, "battery_cycle"), read(directory, "fg_asoc"));
    }
}
