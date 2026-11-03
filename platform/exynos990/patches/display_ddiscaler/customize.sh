# DDIScaler boot scaling is only required on QHD+ panels.
if [[ "$TARGET_CODENAME" == "c1s" || "$TARGET_CODENAME" == "r8s" ]]; then
    return 0
fi

HEX_PATCH "$WORK_DIR/vendor/lib64/libexynosdisplay.so" \
    "8a010034940000370b2540f96b554539" \
    "8a010034040000140b2540f96b554539"

if [ -f "$WORK_DIR/vendor/lib/libexynosdisplay.so" ]; then
    HEX_PATCH "$WORK_DIR/vendor/lib/libexynosdisplay.so" \
        "92b11db98b6b93f86d30" \
        "92b103e08b6b93f86d30"
fi
