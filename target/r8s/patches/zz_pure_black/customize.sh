# SPDX-License-Identifier: GPL-3.0-or-later
SKIPUNZIP=1

if [[ "$TARGET_CODENAME" != "r8s" || "$SOURCE_PLATFORM_SDK_VERSION" -lt 36 ]]; then
    return 0
fi

# The captured-background adapter owns the opt-in effect. Do not recolor
# original resources permanently: disabling the switch must restore them.
SET_PROP "system" "ro.gmhub.pure_black.available" "1"
LOG "- Pure Black is selectable at runtime; native colors remain intact"
