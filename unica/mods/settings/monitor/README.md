# GMHUB read-only monitors

Thermal, memory and battery pages retain native One UI Settings preferences/theme.
Thermal uses the device's actual zone names. Memory reads one bounded meminfo
snapshot per sample; ZRAM comes from each initialized zram device's disksize and
mm_stat, with logical data, capacity and actual physical RAM usage distinguished.
Aggregate swap is shown separately, never relabeled as ZRAM.

The battery page now populates its rows from BatteryManager and the current sticky
battery status broadcast. Current uses microamperes converted to mA; remaining
charge uses microampere-hours converted to mAh. It is labeled remaining charge,
not total/design capacity. Charging status comes from the reported state, not the
sign of an OEM sysfs value. The condition is the reported categorical battery
health, not an invented health percentage. Cycle count is shown only when the
platform supplies it. Missing/invalid measurements remain unavailable, not zero.

Primary unit reference:
https://source.android.com/docs/core/power/device

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
