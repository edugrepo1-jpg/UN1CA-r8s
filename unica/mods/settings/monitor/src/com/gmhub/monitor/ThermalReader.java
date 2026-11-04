package com.gmhub.monitor;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Locale;

/** Read-only Linux thermal ABI. Zone numbers never imply a CPU/GPU identity. */
public final class ThermalReader {
    private ThermalReader() { }
    public static final class Reading {
        public final String zone, sensor;
        public final Integer milliCelsius;
        Reading(String zone, String sensor, Integer value) {
            this.zone = zone; this.sensor = sensor; milliCelsius = value;
        }
        public String temperature(Locale locale, String unavailable) {
            return milliCelsius == null ? unavailable
                : String.format(locale, "%.1f °C", milliCelsius / 1000.0);
        }
    }
    private static String line(File file) throws IOException {
        try (BufferedReader reader = new BufferedReader(new InputStreamReader(
                new FileInputStream(file), StandardCharsets.UTF_8))) {
            StringBuilder result = new StringBuilder();
            for (int i = 0; i <= 160; i++) {
                int value = reader.read();
                if (value == -1 || value == '\n') return result.toString().trim();
                if (i == 160) throw new IOException("Thermal field too long");
                result.append((char)value);
            }
            throw new IOException("Invalid thermal field");
        }
    }
    public static List<Reading> read(File directory) {
        File[] zones;
        try {
            zones = directory.listFiles(file -> file.getName().matches("thermal_zone[0-9]{1,4}"));
        } catch (SecurityException error) { return Collections.emptyList(); }
        if (zones == null) return Collections.emptyList();
        Arrays.sort(zones, Comparator.comparingInt(file -> Integer.parseInt(file.getName().substring(12))));
        List<Reading> result = new ArrayList<>();
        for (int i = 0; i < Math.min(zones.length, 128); i++) {
            File zone = zones[i];
            String sensor;
            try {
                sensor = line(new File(zone, "type"));
                if (sensor.isEmpty() || sensor.chars().anyMatch(Character::isISOControl)) continue;
            } catch (IOException | SecurityException error) { continue; }
            Integer temperature = null;
            try {
                int value = Integer.parseInt(line(new File(zone, "temp")));
                // Linux thermal zones report millidegrees. Reject disconnected
                // sensor sentinels; this is display validation, never a limit.
                if (value >= -100000 && value <= 250000) temperature = value;
            } catch (IOException | SecurityException | NumberFormatException error) { }
            result.add(new Reading(zone.getName(), sensor, temperature));
        }
        return Collections.unmodifiableList(result);
    }
}
