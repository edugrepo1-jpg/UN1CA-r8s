# SPDX-License-Identifier: GPL-3.0-or-later
SKIPUNZIP=1

if [[ "$TARGET_CODENAME" != "r8s" || "$SOURCE_PLATFORM_SDK_VERSION" -ne 37 ]]; then
    return 0
fi

# Settings owns the checked native theme installer and capability marker.
# Do not permanently rewrite resources or advertise a QS-only substitute.
LOG "- Pure Black uses the native per-user system theme; stock resources remain intact"
