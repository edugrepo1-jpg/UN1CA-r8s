# GMHUB read-only monitors

Thermal, memory and battery pages retain native One UI Settings preferences/theme.
Thermal uses the device's actual zone names. Memory reads one bounded meminfo
snapshot per sample; ZRAM comes from each initialized zram device's disksize and
mm_stat, with logical data, capacity and actual physical RAM usage distinguished.
Aggregate swap is shown separately, never relabeled as ZRAM.

The battery page retains the original Samsung gauge measurements `fg_fullcapnom`,
`battery_cycle` and `fg_asoc` through a bounded read-only reader. Their mappings
were checked against the pinned GMKernel's sec_battery_sysfs and max77705 gauge
driver. Full-charge capacity and ASOC are gauge estimates, not design capacity or
a health percentage derived from unrelated values. These slowly changing fields
refresh on page entry and every 30 seconds, without root commands.

BatteryManager supplies instantaneous current in microamperes converted to mA and
remaining charge in microampere-hours converted to mAh. Remaining charge is a
separate additional row, not a replacement for full-charge capacity. The current
sticky broadcast supplies charging state and categorical battery condition in a
separate row. State is not guessed from current sign. The public cycle-count extra
is preferred when available; otherwise the original Samsung counter is used.
Missing/invalid measurements remain unavailable, not zero.

Primary unit reference:
https://source.android.com/docs/core/power/device

Exact Samsung source:
https://github.com/edugrepo1-jpg/android_kernel_samsung_exynos990/blob/2fba3af513f2b2e831cc4ddddc0b3a100ecd9f47/drivers/battery_v2/sec_battery_sysfs.c
https://github.com/edugrepo1-jpg/android_kernel_samsung_exynos990/blob/2fba3af513f2b2e831cc4ddddc0b3a100ecd9f47/drivers/battery_v2/max77705_fuelgauge.c

ResourceController samples on a worker only while its fragment is resumed, at a
two-second interval after the previous sample completes. Pause cancels pending
work; generation checks prevent obsolete callbacks from updating a new page.
Only changed values update native preferences. It adds no root command, idle
service, sysfs write, charging override or thermal-policy change. The legacy
memory/battery UpdateTask classes were replaced, not dropped without a controller.

Host contracts exercise actual parsers/converters with absent, malformed,
duplicate, overflow and multi-ZRAM inputs. SDK37/D8 and whole-Hub smali assembly
check packaging/type signatures. Physical r8s data availability, HAL unit
conformance and page behavior remain separate device validation.
