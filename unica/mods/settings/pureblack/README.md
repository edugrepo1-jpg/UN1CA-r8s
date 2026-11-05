# Native Pure Black system theme

GM Hub applies a reversible per-user theme through Android's native fabricated
overlays. The framework's dark background/surface roles and the corresponding
Samsung/basic-token/SESL roles are discovered in installed app resource tables.
This includes Settings and SystemUI instead of only the captured QS background.
Foreground/on-surface, fixed/inverse, accent, warning, image and media resources
are deliberately excluded. Applications painting private colors in their own
Canvas/WebView/game engine need their own supported theme; this code does not
pretend that a resource overlay can rewrite every drawn pixel.

The existing source-owned ProfileEngine supplies write-ahead recovery, readback,
rollback and selective restore. Its new pure_black mode uses an independent
journal. No Core Modes option changes. Overlays are user-specific and the secure
flag is per-user. Enabling also requests native night mode; disabling restores
the prior mode only while that value remains owned. A separate user change is
preserved. The overlay manager and native settings retain state across reboot;
there is no boot daemon, root command or per-frame recoloring.

Theme work runs on one expiring worker, with weak UI references. The exact
Samsung Monet callback gets an additional final transaction request for the
owned framework overlay so wallpaper/palette updates retain Pure Black priority.
Native palette registration/commit is preserved. Native original resources are
never permanently replaced, and disable affects only our own overlay IDs.

SDK37/D8 generation, full Settings DEX assembly, the exact native callback patch,
reflection signatures and host failure/recovery contracts are checked separately.
These checks do not confirm visual results or package overlay acceptance on a
physical device. No complete ROM build or device action was performed here.
