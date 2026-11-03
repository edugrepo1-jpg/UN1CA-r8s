SET_PROP "vendor" "debug.hwc.winupdate" "0"
SET_PROP "vendor" "debug.sf.disable_backpressure" "0"
SET_PROP "vendor" "debug.sf.follower_display_backpressure" "1"

mkdir -p "$WORK_DIR/vendor/bin" "$WORK_DIR/vendor/etc/init"

cat << "EOF" > "$WORK_DIR/vendor/bin/dex_hwc_fix"
#!/system/bin/sh
while [ "$(getprop sys.boot_completed)" != "1" ]; do
    sleep 3
done

prev_state=""
while true; do
    dex_state="0"
    [ "$(cat /sys/class/dp_sec/dex 2>/dev/null)" = "1" ] && dex_state="1"
    [ "$dex_state" = "0" ] && grep -q "DP=1" /sys/devices/platform/10ab0000.displayport/extcon/extcon*/state 2>/dev/null && dex_state="1"

    if [ "$dex_state" != "$prev_state" ]; then
        if [ "$dex_state" = "1" ]; then
            service call SurfaceFlinger 1008 i32 1 >/dev/null 2>&1
        elif [ "$dex_state" = "0" ] && [ -n "$prev_state" ]; then
            service call SurfaceFlinger 1008 i32 0 >/dev/null 2>&1
        fi
        prev_state="$dex_state"
    fi
    sleep 2
done
EOF

chmod 755 "$WORK_DIR/vendor/bin/dex_hwc_fix"
SET_METADATA "vendor" "bin/dex_hwc_fix" 0 2000 755 "u:object_r:vendor_file:s0"

cat << "EOF" > "$WORK_DIR/vendor/etc/init/dex_hwc_fix.rc"
service dex_hwc_fix /vendor/bin/dex_hwc_fix
    class main
    user root
    group root system graphics
    disabled
    seclabel u:r:su:s0

on property:sys.boot_completed=1
    start dex_hwc_fix
EOF

SET_METADATA "vendor" "etc/init/dex_hwc_fix.rc" 0 0 644 "u:object_r:vendor_configs_file:s0"
