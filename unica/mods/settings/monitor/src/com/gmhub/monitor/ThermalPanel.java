package com.gmhub.monitor;

import android.content.Context;
import android.os.Handler;
import android.os.Looper;
import android.util.AttributeSet;
import android.view.View;
import android.widget.LinearLayout;
import android.widget.TextView;
import java.io.File;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

/** Visible-page-only monitor. No root command, sysfs write or main-thread I/O. */
public final class ThermalPanel extends LinearLayout {
    private static final String TAG = "gmhub_thermal_panel";
    private final Handler main = new Handler(Looper.getMainLooper());
    private final TextView status;
    private final LinearLayout readings;
    private final Map<String, TextView> values = new LinkedHashMap<>();
    private List<String> identities = new ArrayList<>();
    private ScheduledExecutorService worker;
    private int generation;
    private boolean attached, visible, active = true;

    public ThermalPanel(Context context, AttributeSet attrs) {
        super(context, attrs);
        setTag(TAG); setOrientation(VERTICAL);
        int padding = dp(16); setPadding(padding, dp(8), padding, dp(8));
        status = new TextView(context);
        status.setTextAppearance(android.R.style.TextAppearance_DeviceDefault_Small);
        status.setText(text("gm_thermal_loading", "Reading sensors…"));
        status.setPadding(0, dp(8), 0, dp(8));
        addView(status, new LayoutParams(LayoutParams.MATCH_PARENT, LayoutParams.WRAP_CONTENT));
        readings = new LinearLayout(context); readings.setOrientation(VERTICAL);
        addView(readings, new LayoutParams(LayoutParams.MATCH_PARENT, LayoutParams.WRAP_CONTENT));
    }
    private int dp(int value) { return Math.round(value * getResources().getDisplayMetrics().density); }
    private String text(String name, String fallback) {
        int id = getResources().getIdentifier(name, "string", getContext().getPackageName());
        return id == 0 ? fallback : getResources().getString(id);
    }
    /** Called by the Settings fragment on pause/resume as well as view visibility. */
    public static void setActive(View root, boolean enabled) {
        if (root == null) return;
        View view = root.findViewWithTag(TAG);
        if (view instanceof ThermalPanel) {
            ThermalPanel panel = (ThermalPanel)view;
            panel.active = enabled; panel.refreshLifecycle();
        }
    }
    private void refreshLifecycle() {
        if (Looper.myLooper() != Looper.getMainLooper()) throw new IllegalStateException("Settings UI thread required");
        boolean run = attached && visible && active;
        if (run && worker == null) {
            final int epoch = ++generation;
            worker = Executors.newSingleThreadScheduledExecutor(runnable -> {
                Thread thread = new Thread(runnable, "GMHubThermal"); thread.setDaemon(true); return thread;
            });
            worker.scheduleWithFixedDelay(() -> {
                List<ThermalReader.Reading> result = ThermalReader.read(new File("/sys/class/thermal"));
                main.post(() -> { if (worker != null && generation == epoch) render(result); });
            }, 0, 2, TimeUnit.SECONDS);
        } else if (!run && worker != null) {
            generation++; worker.shutdownNow(); worker = null;
            main.removeCallbacksAndMessages(null);
        }
    }
    @Override protected void onAttachedToWindow() {
        super.onAttachedToWindow(); attached = true; visible = isShown(); refreshLifecycle();
    }
    @Override protected void onDetachedFromWindow() {
        attached = false; refreshLifecycle(); super.onDetachedFromWindow();
    }
    @Override public void onVisibilityAggregated(boolean isVisible) {
        super.onVisibilityAggregated(isVisible); visible = isVisible; refreshLifecycle();
    }
    private void render(List<ThermalReader.Reading> sample) {
        List<String> current = new ArrayList<>();
        for (ThermalReader.Reading reading : sample) current.add(reading.zone + ":" + reading.sensor);
        if (!current.equals(identities)) {
            readings.removeAllViews(); values.clear(); identities = current;
            for (ThermalReader.Reading reading : sample) {
                TextView row = new TextView(getContext());
                row.setTextAppearance(android.R.style.TextAppearance_DeviceDefault_Medium);
                row.setPadding(0, dp(12), 0, dp(12));
                // Frequent values must not become competing TalkBack announcements.
                row.setAccessibilityLiveRegion(View.ACCESSIBILITY_LIVE_REGION_NONE);
                readings.addView(row, new LayoutParams(LayoutParams.MATCH_PARENT, LayoutParams.WRAP_CONTENT));
                values.put(reading.zone, row);
            }
        }
        String unavailable = text("gm_thermal_unavailable", "Unavailable");
        String message = text(sample.isEmpty() ? "gm_thermal_empty" : "gm_thermal_read_only",
            sample.isEmpty() ? "No readable thermal sensors." : "Read-only sensor temperatures.");
        if (!message.contentEquals(status.getText())) status.setText(message);
        for (ThermalReader.Reading reading : sample) {
            String value = reading.temperature(Locale.getDefault(), unavailable);
            TextView row = values.get(reading.zone);
            String displayed = reading.sensor + "\n" + value;
            if (!displayed.contentEquals(row.getText())) row.setText(displayed);
        }
    }
}
