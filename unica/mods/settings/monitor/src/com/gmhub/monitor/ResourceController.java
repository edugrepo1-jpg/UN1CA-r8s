package com.gmhub.monitor;

import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.BatteryManager;
import android.os.Handler;
import android.os.Looper;
import android.os.SystemClock;
import android.text.format.Formatter;
import java.io.File;
import java.util.*;
import java.util.concurrent.*;

/** Visibility-bound native preference monitor. No polling, Binder or disk I/O on UI. */
public final class ResourceController {
    public interface Host {
        Context context();
        void row(String key, String title, String value);
    }
    private static final class Row {
        final String title, value;
        Row(String title, String value) { this.title = title; this.value = value; }
    }
    private final Host host;
    private final Context context;
    private final boolean battery;
    private final Handler main = new Handler(Looper.getMainLooper());
    private final ExecutorService worker = Executors.newSingleThreadExecutor();
    private final Map<String, Row> shown = new HashMap<>();
    private boolean active, closed;
    private int generation;
    private Future<?> pending;
    private SamsungBatteryReader.Snapshot gauge;
    private int gaugeEpoch = -1;
    private long nextGaugeRead;
    private final Runnable tick = () -> sample();
    public ResourceController(Host host, boolean battery) {
        this.host = host; context = host.context(); this.battery = battery;
    }
    public void resume() {
        if (closed) return;
        if (pending != null) pending.cancel(true);
        active = true; generation++; shown.clear(); main.removeCallbacks(tick); sample();
    }
    public void pause() {
        active = false; generation++; main.removeCallbacks(tick);
        if (pending != null) pending.cancel(true);
    }
    public void close() { pause(); closed = true; worker.shutdownNow(); }
    private String text(String key) {
        int id = context.getResources().getIdentifier(key, "string", context.getPackageName());
        return id == 0 ? key : context.getString(id);
    }
    private String bytes(Long value) { return value == null ? text("gm_resource_unavailable") : Formatter.formatFileSize(context, value); }
    private String pair(Long used, Long total) {
        return used == null || total == null ? text("gm_resource_unavailable") : bytes(used) + " / " + bytes(total);
    }
    private void sample() {
        if (!active || closed) return;
        int epoch = generation;
        pending = worker.submit(() -> {
            Map<String, Row> rows;
            try { rows = battery ? battery(epoch) : memory(); }
            catch (RuntimeException failure) { rows = unavailable(); }
            final Map<String, Row> snapshot = rows;
            main.post(() -> {
                if (!active || closed || epoch != generation) return;
                for (Map.Entry<String, Row> e : snapshot.entrySet()) {
                    Row previous = shown.get(e.getKey()), row = e.getValue();
                    if (previous == null || !previous.title.equals(row.title) || !previous.value.equals(row.value))
                        host.row(e.getKey(), row.title, row.value);
                }
                shown.clear(); shown.putAll(snapshot);
                main.postDelayed(tick, 2000);
            });
        });
    }
    private Map<String, Row> unavailable() {
        Map<String, Row> rows = new LinkedHashMap<>();
        if (battery) {
            for (String[] item : new String[][]{{"bat_current", "gm_battery_current"},
                    {"bat_capacity", "gm_battery_full_capacity"}, {"bat_cycles", "gm_battery_cycles"},
                    {"bat_health", "gm_battery_asoc"}, {"gm_battery_charge_remaining", "gm_battery_remaining_charge"},
                    {"gm_battery_condition", "gm_battery_health_status"}})
                rows.put(item[0], new Row(text(item[1]), text("gm_resource_unavailable")));
        } else {
            for (String[] item : new String[][]{{"ram_monitor", "gm_resource_ram"},
                    {"active_monitor", "gm_resource_active"}, {"cached_monitor", "gm_resource_cached"},
                    {"zram_monitor", "gm_resource_zram"}, {"gm_swap_monitor", "gm_resource_swap"}})
                rows.put(item[0], new Row(text(item[1]), text("gm_resource_unavailable")));
        }
        return rows;
    }
    private Map<String, Row> memory() {
        MemoryReader.Snapshot value = MemoryReader.read(new File("/proc/meminfo"), new File("/sys/block"));
        Map<String, Row> rows = new LinkedHashMap<>();
        rows.put("ram_monitor", new Row(text("gm_resource_ram"), pair(value.usedBytes, value.totalBytes)));
        rows.put("active_monitor", new Row(text("gm_resource_active"), bytes(value.activeBytes)));
        rows.put("cached_monitor", new Row(text("gm_resource_cached"), bytes(value.cachedBytes)));
        String zram = pair(value.zramLogicalBytes, value.zramCapacityBytes);
        if (value.zramRamBytes != null) zram += "\n" + text("gm_resource_zram_ram") + ": " + bytes(value.zramRamBytes);
        rows.put("zram_monitor", new Row(text("gm_resource_zram"), zram));
        // Keep total swap visible separately, including any non-ZRAM devices.
        rows.put("gm_swap_monitor", new Row(text("gm_resource_swap"), pair(value.swapUsedBytes, value.swapTotalBytes)));
        return rows;
    }
    private int property(BatteryManager manager, int property) {
        try { return manager == null ? Integer.MIN_VALUE : manager.getIntProperty(property); }
        catch (RuntimeException unreadable) { return Integer.MIN_VALUE; }
    }
    private Map<String, Row> battery(int epoch) {
        long now = SystemClock.elapsedRealtime();
        if (gauge == null || gaugeEpoch != epoch || now >= nextGaugeRead) {
            gauge = SamsungBatteryReader.read(new File("/sys/class/power_supply/battery"));
            gaugeEpoch = epoch; nextGaugeRead = now + 30000;
        }
        BatteryManager manager = context.getSystemService(BatteryManager.class);
        Intent data;
        try { data = context.registerReceiver(null, new IntentFilter(Intent.ACTION_BATTERY_CHANGED)); }
        catch (RuntimeException unreadable) { data = null; }
        Locale locale = context.getResources().getConfiguration().getLocales().get(0);
        String unavailable = text("gm_resource_unavailable");
        String current = BatteryUnits.current(property(manager, BatteryManager.BATTERY_PROPERTY_CURRENT_NOW), locale, unavailable);
        int status = data == null ? BatteryManager.BATTERY_STATUS_UNKNOWN : data.getIntExtra(BatteryManager.EXTRA_STATUS, BatteryManager.BATTERY_STATUS_UNKNOWN);
        String state;
        switch (status) {
            case BatteryManager.BATTERY_STATUS_CHARGING: state = "gm_battery_charging"; break;
            case BatteryManager.BATTERY_STATUS_DISCHARGING: state = "gm_battery_discharging"; break;
            case BatteryManager.BATTERY_STATUS_FULL: state = "gm_battery_full"; break;
            case BatteryManager.BATTERY_STATUS_NOT_CHARGING: state = "gm_battery_paused"; break;
            default: state = "gm_resource_unavailable";
        }
        int health = data == null ? BatteryManager.BATTERY_HEALTH_UNKNOWN : data.getIntExtra(BatteryManager.EXTRA_HEALTH, BatteryManager.BATTERY_HEALTH_UNKNOWN);
        String healthKey;
        switch (health) {
            case BatteryManager.BATTERY_HEALTH_GOOD: healthKey = "gm_battery_health_good"; break;
            case BatteryManager.BATTERY_HEALTH_OVERHEAT: healthKey = "gm_battery_health_hot"; break;
            case BatteryManager.BATTERY_HEALTH_COLD: healthKey = "gm_battery_health_cold"; break;
            case BatteryManager.BATTERY_HEALTH_DEAD: healthKey = "gm_battery_health_dead"; break;
            case BatteryManager.BATTERY_HEALTH_OVER_VOLTAGE: healthKey = "gm_battery_health_voltage"; break;
            case BatteryManager.BATTERY_HEALTH_UNSPECIFIED_FAILURE: healthKey = "gm_battery_health_failure"; break;
            default: healthKey = "gm_resource_unavailable";
        }
        String cycles = unavailable;
        if (data != null && data.hasExtra(BatteryManager.EXTRA_CYCLE_COUNT)) {
            int count = data.getIntExtra(BatteryManager.EXTRA_CYCLE_COUNT, -1);
            if (count >= 0) cycles = String.format(locale, "%d", count);
        }
        if (cycles.equals(unavailable) && gauge.cycles != null) cycles = String.format(locale, "%d", gauge.cycles);
        Map<String, Row> rows = new LinkedHashMap<>();
        rows.put("bat_current", new Row(text("gm_battery_current"), current + " · " + text(state)));
        rows.put("bat_capacity", new Row(text("gm_battery_full_capacity"), gauge.fullCapacityMah == null ? unavailable : String.format(locale, "%d mAh", gauge.fullCapacityMah)));
        rows.put("bat_cycles", new Row(text("gm_battery_cycles"), cycles));
        rows.put("bat_health", new Row(text("gm_battery_asoc"), gauge.asocPercent == null ? unavailable : String.format(locale, "%d%%", gauge.asocPercent)));
        rows.put("gm_battery_charge_remaining", new Row(text("gm_battery_remaining_charge"), BatteryUnits.charge(property(manager, BatteryManager.BATTERY_PROPERTY_CHARGE_COUNTER), locale, unavailable)));
        rows.put("gm_battery_condition", new Row(text("gm_battery_health_status"), text(healthKey)));
        return rows;
    }
}
