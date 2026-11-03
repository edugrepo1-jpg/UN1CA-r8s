if ! $BETA; then
    LOG "\033[0;33m! Beta flag not set. Skipping\033[0m"
    return 0
fi

LOG "- Injecting beta build notice into SystemUI"

SYSTEMUI_PARTITION="system_ext"
SYSTEMUI_FILE="priv-app/SystemUI/SystemUI.apk"
SYSTEMUI_PATH="$APKTOOL_DIR/$SYSTEMUI_PARTITION/$SYSTEMUI_FILE"

DECODE_APK "$SYSTEMUI_PARTITION" "$SYSTEMUI_FILE"

mkdir -p "$SYSTEMUI_PATH/smali/com/android/systemui/unica"
cp -a "$MODPATH/BetaNotice.smali" \
    "$SYSTEMUI_PATH/smali/com/android/systemui/unica/BetaNotice.smali"

# The locked-boot receiver is the inner class that calls setBootComplete() and
# notifies the CoreStartable services. On One UI 9 it is $2; upstream's $1 no
# longer exists in SystemUI, so patching that path silently does nothing.
SMALI_PATCH "$SYSTEMUI_PARTITION" "$SYSTEMUI_FILE" \
    'smali/com/android/systemui/application/impl/SystemUIApplicationImpl$2.smali' \
    "replace" \
    "onReceive(Landroid/content/Context;Landroid/content/Intent;)V" \
    ".locals 1" \
    "    .locals 1\n\n    invoke-static {p1}, Lcom/android/systemui/unica/BetaNotice;->show(Landroid/content/Context;)V"
