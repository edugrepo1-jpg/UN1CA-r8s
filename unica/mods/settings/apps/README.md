# GMHUB application manager

The existing Settings page now uses `AppsController` and the current user's
native PackageManager instead of unchecked `Runtime.exec("pm ...")` commands.
Search, system-app visibility, icons and individual enable/disable controls remain.
The previous five optional-package candidates remain available through explicit
selection dialogs for both enabling and disabling. Opening the page changes no app.

All mutations require a saved private, user-scoped journal entry before the native
call and a confirmed native state afterward. Restore handles only this Hub's
journal and preserves the original DEFAULT/ENABLED/DISABLED/DISABLED_USER/
DISABLED_UNTIL_USED setting. It refuses to overwrite a different subsequent state.
It does not enable unrelated disabled apps. Uninstalled packages lose only their
stale journal entries. A failed/unconfirmed restore retains its entry for retry.

Persistent/core services, the Settings app, the current launcher and keyboard,
active accessibility services and device administrators cannot be disabled.
Protection is checked again before mutation; a disabled app can still be enabled.
Native permission or policy failures are reported, not converted into UI success.

Package metadata, preferences disk I/O and changes run on a serial worker.
Inventory requests use immutable search snapshots, cancellation and generation
checks. Preference creation is split across frames. App icons load only for bound
native rows and use a bounded 12-entry cache. Pausing discards obsolete UI updates
and pending icon work; an already requested mutation finishes with readback even
if the page is paused. No root, shell command, daemon or boot service is added.

`compile.py` uses SDK 37, D8 and the shared official Apktool decoder to generate
the shipped smali. `verify.py` rejects stale sources/generated classes before ROM
patching. Host contracts exercise the real state engine, including permission,
storage, ignored-write, external-change and restore-isolation cases. These checks
do not establish physical-device UI behavior or OEM permission grants.
