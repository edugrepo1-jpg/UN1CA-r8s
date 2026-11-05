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

The overlay supplies menu alternatives for dragging/resizing and uses
48dp Android touch regions. Cancelling a pointer before a native transaction has
started must not send an unmatched transaction-end callback.

Host lifecycle/failure contracts and SDK37/D8 compilation are separate from
native UI and physical-device validation. They do not establish renderer
performance or that the complete Apple-style panel is installed.

A measured native-grid size change cancels an open geometry transaction even
when screen type and active flow identity remain unchanged (window/density
changes). Cancellation restores only wrappers still owned by that transaction.
The bounded immutable layout supports up to 16 columns, matching the existing
native geometry adapter; this does not force a 16-column layout on the device.

## Visual reference selected by the user

The source of truth is Apple's **iOS 26** guide, pinned to its versioned URL:
https://support.apple.com/pt-pt/guide/iphone/iph59095ec58/26/ios/26

The four-column portrait composition, circular small controls, capsule sliders
and wide pills, grouped larger cards, right-side group navigation and control
gallery are the target. The earlier generated illustrations are not the design
specification. The three optional glass engines do not define three different
layouts. The native One UI player keeps its own artwork/content/design; its
placement and dimensions remain editable within its real native constraints.

`Ios26Design` and `GridEditOverlay` now share measured, density-aware edit chrome:
top-left minus badges and curved lower-right grips, including small controls.
The binding must supply actual `canResize`/`canRemove` values. Expanded 48dp
corner targets select the nearest actual corner when neighbors overlap; the
center remains available for movement. There are no permanent rectangular
selection frames, diagonal resize arrows or changes to the media surface.
Long-press/accessibility action menus retain alternatives to drag gestures.
An ordinary tap on a card does not open an invented editing popup. Empty edit
slots use faint circles, not a rectangular grid. Their path is rebuilt on layout
changes; drawing does not allocate or scan the board every frame.

The linked Apple video
https://help.apple.com/assets/69F8EBBDF3B89A4F6E0C704C/69F8EBC43862495245036393/pt_PT/e1f4ce10f6f12b39b36e8079f4f6db45.mp4
is a 3.67-second, 60fps opening demonstration from the lockscreen. It is not an
editing or gallery demonstration. Edit behavior is specified by the guide and
its screenshots. No Apple artwork or font files are bundled in this source.

`references.json` records visually reviewed official and external images, their
purpose and version evidence. Official versioned images are authoritative;
beta images and accessibility appearance variants are marked separately. It
contains links and our observations, not copied image/font assets. The gallery
target is the official mix of compact, wide and large control previews, rather
than uniform two-column rows with extra plus buttons. The base reference has no
permanent "Edit controls" action or invented "Done" toolbar requirement.

These changes prepare the editor's appearance and touch behavior. They do not
install the full alternate panel; the status at the top of this file still
applies. Visual identity, transitions, group navigation and the final gallery
need verification in the completed SystemUI binding before claiming parity.
