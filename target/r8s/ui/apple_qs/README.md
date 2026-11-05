# Editable QS integration status

This directory is staged, not installed by the ROM pipeline yet. The native
Samsung API37 panel, controls and Compose media player remain authoritative.
Do not advertise the alternate panel as available until the complete entry point,
editor, native control lifecycle and installer are connected and validated.

The exact donor contract includes every native field used by geometry copying,
the synthetic public constructor and the active-flow writer. Validation of the
contract is read-only and must run before modifying a decoded SystemUI.

Geometry previews preserve the native item identity, expansion metadata,
translations and native state flags. The writer reads back the actual active
flow. Kotlin StateFlow suppresses equal values, so an equal preview can legitimately
retain the old wrapper objects. Ownership follows those actual objects; it must
not follow newly allocated copies which were never published.

An ignored update is an error. A failure after publishing rolls back only the
editor's own state. Cancellation must not overwrite a rotated grid, another user
or a concurrent native edit. Keyguard appearance cancels uncommitted geometry.

`commit()` accepts in-memory geometry only. Durable layout writes belong to
`EditorSession`/`LayoutPersistence` and still require the final panel binding;
do not describe the geometry adapter alone as reboot persistence.

The overlay supplies single-tap menu alternatives for dragging/resizing and uses
48dp Android touch regions. Cancelling a pointer before a native transaction has
started must not send an unmatched transaction-end callback.

Host lifecycle/failure contracts and SDK37/D8 compilation are separate from
native UI and physical-device validation. They do not establish renderer
performance or that the complete Apple-style panel is installed.
