# Verified Core Modes

Preserves the Smooth, Gaming, Battery and Stock/Restore controls. Package/provider
I/O, native service calls and journal persistence run on one worker. Selection is
displayed only after readback; no Settings write runs from the native preference
listener on the main thread. Opening the page reads state without applying a mode.

The old code used `wifi_scan_throttling`, a UI preference identifier, as a Global
setting. Scan throttling is now changed/read through WifiManager's native service
APIs. Battery saver likewise uses PowerManager's setter and actual reported state.
Privileged public system methods are looked up on the native service objects; no
hidden-API exemption, root process or substitute service is installed. Failure is
reported and the profile transaction is rolled back. Native readback has a bounded
500 ms wait on the worker, not on the UI.

The source-owned journal saves original/default-null values and recovery intent
before the first mutation. A failed step rolls back confirmed writes. If recovery
fails or the process dies midway, a pending record blocks a new profile until
Restore is requested. Restore preserves values changed elsewhere and retains
records for native/storage failures. Switching modes also restores settings owned
only by the previous mode, such as Battery's AOD and screen timeout changes.
Developer/accessibility animation scale zero remains disabled. Display modes are
checked against the active display's advertised resolution/refresh combinations.

The journal is private to Settings and the current user. Since profiles include
device-wide controls, editing is restricted to the system user. The old Global
backups remain readable on upgrade, with owned values limited to the legacy
presets; merely entering the page does not consume or erase them. Once a new
journal is durably written, it becomes the recovery source. The existing Hub banner
label entry point remains available; its Global value is compatibility metadata.

The inherited Samsung enhanced-processing setting values are retained, not
claimed as measured CPU boosts. OEM consumers, all physical effects, jank, battery
and persistence through a new complete ROM installation still require validation.
The transaction tests validate settings/ownership behavior, not performance gains.

Primary API references:
- https://android.googlesource.com/platform/packages/apps/Settings/+/d80647ea37a096b29172bc7257cedc60180ff83a/src/com/android/settings/development/WifiScanThrottlingPreferenceController.java
- https://android.googlesource.com/platform/frameworks/base/+/HEAD/core/java/android/os/PowerManager.java

Rebuild the owned Java code with `compile.py` using SDK 37, D8 and official Apktool.
`verify.py` rejects stale or missing generated code before firmware modification.
