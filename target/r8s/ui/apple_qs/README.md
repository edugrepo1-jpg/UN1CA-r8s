# Editable QS integration status

`unica/mods/qs_apple_scene` now installs an appearance provider at the exact
Samsung API37 Compose entry. The Hub's **Central de controles / Formato dos
controles** preference connects to this provider through per-user Secure
settings. The native panel, editor, gallery, controls and Compose player remain
authoritative. This is an installed scene binding in the build source, not yet
a complete iOS 26 panel or an installed/validated change on the physical phone.

The current iOS choice changes the generic frames to circles/capsules and large
rounded cards. It explicitly excludes both native media item types, expanded
details and gallery previews. Returning to One UI returns the original frame
object; no native lambda field is modified. iOS header/group navigation, gallery
presentation, edit chrome and independent per-style geometry remain unfinished.
The pre-existing `NativeGridEditor` is still staged; it is not mounted as a
second editor over Samsung's functioning editor.

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

`commit()` accepts in-memory geometry only. `NativeEditorSave` dispatches the
original Samsung editor coroutine and observes its actual Job completion. It
keeps the native ViewModel scope, converters, media item and repository; it does
not invoke a suspend method manually or mistake leaving edit mode for a write.
Write-safe mode, partial dispatch failure, stale-user callbacks and a rejected
UI executor cannot be reported as successful persistence. Disposal detaches the
completion observer, never cancels Samsung's scope/job. The final scene binding
must close this adapter with its owner. `EditorSession`/`LayoutPersistence` remain
available for alternate-profile metadata; they must not overwrite Samsung's
native geometry store or act as a second writer for the same edit.

Neither the geometry adapter nor a normally completed job alone demonstrates
reboot persistence. The final panel/installer and physical cold-load check are
still required.

The native One UI 9 player is not redesigned or replaced. Its exact donor
`MediaPlayer.resizeConstraints` permits 2x1 or 2x2 minimum spans (depending on
the native screen flag) and up to 4x4; these are grid spans, not pixel dimensions.
`NativeGeometry.sizePolicy()` freezes those real limits for layout calculations,
including background reads, and `preview()` rechecks live limits before writing.
An unsupported width/height is rejected instead of scaling or cropping media
controls. Only geometry wrappers change; the original item, media ViewModel,
artwork and native callbacks remain owned by Samsung. Geometry edits require
the unlocked native editor to remain open. The renderer must preserve the same
native item/Compose key and use its original content, not render a substitute
player from these spans.

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

## Native editor controller and researched implementation

`NativeGridEditor` now connects the edit handles to `NativeGeometry`,
`NativePanelActions` and the original `NativeEditorSave` coroutine. It takes the
native measured cell pitch, viewport origin and screen flags; it does not infer
them from display size. The final Compose scene must create it in `AndroidView`,
update those measurements from the native grid and close it on permanent
`onRelease`. Temporary detach cancels the pointer without destroying a reusable
view. Rotation, another native edit, user changes and keyguard invalidate an
owned geometry transaction before it can overwrite newer state.

Adding uses the donor gallery's `canPlaceTopLeft-Bjo55l4` and
`commitAddTile-3UiIcl8` with the ordinary-tap flags `false,false`. A preview is
not inserted directly into StateFlow: the native factory supplies the working
control/provider. Removal filters the original UUID and calls the native
`eliminateEmptyLines`, honoring `isRemovable`. Unrelated native items and the
media ViewModel retain identity. Stale gallery tokens, write-safe mode, ignored
writes and partial mutations are not reported as successful edits.

Geometry resolves its immutable donor fields/constructor once per transaction,
reuses wrappers for unchanged controls and skips duplicate StateFlow writes for
the same snapped geometry. Position and size change in one layout calculation;
neighbors are derived from the gesture baseline rather than repeatedly repacked
from the previous preview. These changes remove unnecessary work; they are not
a measured device FPS improvement.

Research was checked against pinned source, not feature lists:

* LineageOS `lineage-24.0`, `696a5773fa284f53429dbb6c3e5dcc96bf5bd0b3`:
  [edit state](https://github.com/LineageOS/android_frameworks_base/blob/696a5773fa284f53429dbb6c3e5dcc96bf5bd0b3/packages/SystemUI/src/com/android/systemui/qs/panels/ui/compose/EditTileListState.kt),
  [edit actions](https://github.com/LineageOS/android_frameworks_base/blob/696a5773fa284f53429dbb6c3e5dcc96bf5bd0b3/packages/SystemUI/src/com/android/systemui/qs/panels/ui/viewmodel/EditModeViewModel.kt),
  [single-user persistence](https://github.com/LineageOS/android_frameworks_base/blob/696a5773fa284f53429dbb6c3e5dcc96bf5bd0b3/packages/SystemUI/src/com/android/systemui/qs/pipeline/data/repository/UserTileSpecRepository.kt).
  Adopt atomic native operations, stable identities and one writer per user.
  Its AOSP interactor and repository cannot replace Samsung's Compose store.
* crDroid `17.0`, `21a2fd02bba542df0438f2465bb288b42590714f`:
  [grid selection](https://github.com/crdroidandroid/android_frameworks_base/blob/21a2fd02bba542df0438f2465bb288b42590714f/packages/SystemUI/src/com/android/systemui/qs/panels/data/repository/GridLayoutTypeRepository.kt).
  A layout choice is separate from the control/provider lifecycle; it is not
  three complete panels just because three glass shaders are available.
* Axion SDK `60fa902f7ef2debd9c13cd21515951208c4c7390`:
  [native media sizes](https://github.com/AxionAOSP/android_axion_sdk/blob/60fa902f7ef2debd9c13cd21515951208c4c7390/ax_systemui/src/com/android/systemui/qs/ax/ui/media/AxQsMediaGridLayout.kt).
  Use measured span constraints. Do not import its redesigned player; retain
  the One UI player and Samsung's exact `resizeConstraints` result.
* [Android View interoperability](https://developer.android.com/develop/ui/compose/migrate/interoperability-apis/views-in-compose):
  `AndroidView` factory/update/release own the edit overlay. A Compose root is
  not a legacy ViewGroup to reparent, and a ViewOverlay is not a touch host.

The native scene now supplies composition lifecycle and user-scoped appearance
selection. Any later mounting of `NativeGridEditor` must still supply actual
scrolling/RTL coordinates and the measured grid bounds. Separate orientation/
style metadata must not overwrite the native One UI layout. The new Hub choice
describes control formats; it does not advertise completed full-panel parity.

## Installed scene binding

The installer checks 23 exact donor class contracts and pins the bodies of the
two modified methods. It redirects only the outer main call in
`SecQuickSettingScene$$ExternalSyntheticLambda7`, leaving the native main,
its restart lambda and `MediaPlayerKt` byte-identical. The second hook replaces
only a local frame value in the native grid's content lambda; it does not
mutate a captured shape, replace controls or capture the media view model.

`ComposePanelRoot` provides one Compose-local selection through a native
`rememberComposableLambda` slot. Its remembered session follows the native QS
user context. A `DisposableEffect` registers a Secure-setting observer after
composition commits, re-reads after registration, and unregisters on disposal
or user changes. No polling timer, service, sensor, duplicate tile host or
SystemUI restart is introduced. Unknown values and unavailable observation use
the native appearance. Runtime ABI preflight falls back before emitting any
composition; native content failures propagate once, without retrying a partly
emitted scene.

The Settings writer verifies the provider readback and attempts to recover its
previous value on failure. Its preference has no independent SharedPreferences
writer. It remains disabled unless the matching scene installer sets its build
capability property. Both adapters ship generated SDK37/D8 smali with source/
output integrity manifests, so ordinary ROM builds need no additional SDK.

Exact-donor dry runs, DEX assembly and controlled host lifecycle tests cover
these source contracts. They do not establish physical rendering, fluidity,
cold-load persistence or the visual identity of the completed panel.
