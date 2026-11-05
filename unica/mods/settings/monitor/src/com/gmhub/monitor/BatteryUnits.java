package com.gmhub.monitor;

import java.util.Locale;

/** Public BatteryManager units; never infer units or charging state from sysfs/sign. */
public final class BatteryUnits {
    private BatteryUnits() { }
    public static String current(int microamps, Locale locale, String unavailable) {
        return microamps == Integer.MIN_VALUE || microamps == Integer.MAX_VALUE ? unavailable
            : String.format(locale, "%.1f mA", microamps / 1000.0);
    }
    public static String charge(int microampHours, Locale locale, String unavailable) {
        return microampHours < 0 || microampHours == Integer.MAX_VALUE ? unavailable
            : String.format(locale, "%.1f mAh", microampHours / 1000.0);
    }
}
