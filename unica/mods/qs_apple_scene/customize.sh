SKIPUNZIP=1

if [[ "$TARGET_CODENAME" == "r8s" ]]; then
    DECODE_APK "system_ext" "priv-app/SystemUI/SystemUI.apk"
    python3 "$MODPATH/install.py" \
        "$APKTOOL_DIR/system_ext/priv-app/SystemUI/SystemUI.apk" || \
        ABORT "Samsung QS scene contract changed; no alternate scene installed"
    SET_PROP "system" "ro.gmhub.qs.scene" "1"
fi
