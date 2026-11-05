# GM Hub: three opt-in Liquid Glass shader ports

This module adapts the optical AGSL engines from QWEA Liquid-Glass-Android,
Kyant Backdrop and ColorOS16-LiquidGlass to the **captured QUICK_PANEL background**
in the audited API37 Samsung SystemUI. It does not install their demo control
centers, depend on Compose/OPPO/LSPosed, change the player or replace all system
blur. Live-window blur, notifications and authentication backgrounds retain the
Samsung renderer. Full-system integration and the separate editable Apple QS
layout remain outside this first adapter.

Settings > GM HUB > Liquid Glass provides one persistent engine selection:
original One UI, QWEA, Kyant or ColorOS. Default is original One UI. Only the
selected engine is instantiated on the next background capture. Installation
does not change a saved selection or force-restart SystemUI.

The hook uses Samsung's existing capture provider and leaves its native blur
calculation intact for an immediate fallback. QWEA and Kyant sample the blurred
backdrop; ColorOS samples the original authorized capture. Thus this initial
adapter does **not** claim to eliminate Samsung's original blur processing cost.
It adds no screen capture service, timer, sensor, bitmap readback or idle frame
loop. This is not a measured FPS/battery improvement.

The renderer uses original blur during power saving, moderate-or-higher thermal
status, high contrast, reduced transparency, low-RAM mode, software rendering,
oversized surfaces, recycled captures or a shader error. Failures are logged once
per engine. Incompatible programs/assets are suppressed for that SystemUI process;
a transient capture/OOM failure disables that drawable and permits a new capture
after a 15-second cooldown, with no timer or idle work. A recovered capture never
reactivates a dead drawable. The native alpha/filter is retained on wrapping.
The original blurred drawable is retained; failure must never expose a raw
capture. Original capture security and keyguard source selection are unchanged.

Pinned originals and licenses are in `upstream/` and `licenses/`. Packaged shader
and adapter digests are checked before modifying the decoded APK. `prepare_assets.py`
extracts actual shader programs rather than substituting three parameter presets.
The Kyant SDF interpolation is resolved from the same pinned source file. These
are native shader ports, not complete ports of the libraries' widgets, editors,
sensor lighting or platform-specific hooks. No arbitrary apps are injected.

Rebuild the adapter after Java changes with `compile.py --sdk SDK --java-home JDK
--apktool APKTOOL_JAR`, then rerun the integration and linkage checks. The committed
smali avoids adding SDK/Gradle downloads to the normal ROM pipeline.

Host compilation/linkage/render tests are separate from device validation.
No physical r8s rendering, battery or jank result is established by this module.

## Scope and lifecycle research

The newer ColorOS implementation was reviewed at
[`9082b2b8286f2e78df58f2206fb3a0bb8ecaeb57`](https://github.com/AYwlilwYA/ColorOS16-LiquidGlass/tree/9082b2b8286f2e78df58f2206fb3a0bb8ecaeb57).
Its per-surface shader isolation and capture policy are useful, but its OPPO/Xposed
hooks, resident shader pool and 30–120 Hz capture modes are not drop-in Samsung
implementations. Its `SceneFilter` still documents a no-op/TODO, so importing it
does not implement all-system scope selection. Our three pinned shader sources
remain unchanged; this review does not silently replace their rendering programs.

[Kyant LayerBackdrop](https://github.com/Kyant0/AndroidLiquidGlass/blob/65ab177e90e5c1d8c62e70cf7755841982da65f6/backdrop/src/commonMain/kotlin/com/kyant/backdrop/backdrops/LayerBackdrop.kt)
shares an existing Compose layer with coordinate mapping. It does not provide a
global cross-window capture source. Axion's window controller preserves/restores
surface state, but its native GlassBlurFilter depends on its rebuilt renderer.
[Android cross-window blur](https://source.android.com/docs/core/display/window-blurs)
is a different rendering path from a bitmap-backed AGSL effect. Therefore other
scopes need their actual owned background and lifecycle bindings; widening a
scene-name allowlist would not implement them and could sample the wrong source.
Authentication/PIN/UDFPS backgrounds remain native.
