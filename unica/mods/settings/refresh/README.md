# Checked native refresh-rate controls

The existing `ParadoxRefreshModes.configure` already populates the two native
ListPreferences from the active display's supported resolution/mode combinations.
That integration is preserved. No second 60/96/120 selector is added. A 96-Hz
selection remains available only if the installed panel/kernel advertises it.

The new SDK-owned writer fixes the incomplete update path: previously adjusting
the other bound could succeed before the selected bound failed. It snapshots
native mode/minimum/maximum values, verifies writes/readback, and rolls back its
own partial changes. It does not overwrite a different concurrent value during
rollback. The controls synchronize from the settings actually read back, even
when the request fails. Reset uses the display's current advertised range instead
of assuming every panel supports 120 Hz. Non-finite or stale modes are rejected.

No process is restarted and no kernel node is written. This is settings-level
validation; it does not establish that the panel physically scans at the selected
rate under power-saving, thermal or application policies. A failure to roll back
is logged and the UI rereads the resulting values rather than reporting success.

Tests run the actual writer against narrow native-service fixtures covering
60/96/120-Hz lists, another resolution, changed displays, absent services, failed
and ignored writes, and rollback. These are host contracts, not a display emulator.
SDK37/D8 compilation and whole-Hub smali assembly validate the shipped adapter.
