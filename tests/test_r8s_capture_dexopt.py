"""ART policy installation must preserve donor callbacks and explicit filters."""
from pathlib import Path
import hashlib
import importlib.util
import tempfile
import unittest

ROOT = Path(__file__).resolve().parents[1]
spec = importlib.util.spec_from_file_location('capture_policy', ROOT / 'target/r8s/optimize_biometric_dexopt.py')
policy = importlib.util.module_from_spec(spec)
spec.loader.exec_module(policy)

DONOR = '''.class public Lcom/android/server/pm/DexOptHelper;
.super Ljava/lang/Object;
.method public static initializeArtManagerLocal(Landroid/content/Context;Lcom/android/server/pm/PackageManagerService;)V
    .locals 5
    invoke-virtual {v0, v1, v2}, Lcom/android/server/art/ArtManagerLocal;->setBatchDexoptStartCallback(Ljava/util/concurrent/Executor;Lcom/android/server/art/ArtManagerLocal$BatchDexoptStartCallback;)V
    const-class p1, Lcom/android/server/art/ArtManagerLocal;
    return-void
.end method
'''


class CapturePolicyTests(unittest.TestCase):
    def prepare(self, root):
        path = root / 'smali_classes2/com/android/server/pm/DexOptHelper.smali'
        path.parent.mkdir(parents=True)
        path.write_text(DONOR, encoding='utf-8')
        return path

    def test_native_initialization_and_other_callbacks_are_preserved(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            path = self.prepare(root)
            policy.patch(root)
            self.assertEqual(path.read_text().replace(policy.INSERT, '', 1), DONOR)
            first = {p.name: p.read_bytes() for p in path.parent.iterdir()}
            policy.patch(root)
            self.assertEqual(first, {p.name: p.read_bytes() for p in path.parent.iterdir()})

    def test_exact_previous_biometric_policy_can_upgrade_without_duplicate_registration(self):
        # The previous emitted callback is frozen by its whole-text digest.
        previous = policy.CALLBACK.replace('    if-nez v0, :automatic_reason\n'
            '    const-string v0, "com.samsung.android.app.smartcapture"\n'
            '    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z\n'
            '    move-result v0\n', '').replace('    :automatic_reason\n', '')
        self.assertEqual(hashlib.sha256(previous.encode()).hexdigest(), policy.PREVIOUS_CALLBACK_SHA256)
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            path = self.prepare(root)
            path.write_text(DONOR.replace(policy.ANCHOR, policy.INSERT + policy.ANCHOR), encoding='utf-8')
            callback = path.with_name(policy.NAME + '.smali')
            callback.write_text(previous, encoding='utf-8')
            before = path.read_bytes()
            policy.patch(root)
            self.assertEqual(path.read_bytes(), before)
            self.assertEqual(callback.read_text(), policy.CALLBACK)

    def test_foreign_callback_or_changed_layout_leaves_inputs_untouched(self):
        for changed in [DONOR.replace('    .locals 5', '    .locals 6'),
                        DONOR.replace(policy.ANCHOR, '    # ->setAdjustCompilerFilterCallback(\n' + policy.ANCHOR)]:
            with self.subTest(changed=changed), tempfile.TemporaryDirectory() as directory:
                root = Path(directory)
                path = self.prepare(root)
                path.write_text(changed, encoding='utf-8')
                before = path.read_bytes()
                with self.assertRaises(ValueError):
                    policy.patch(root)
                self.assertEqual(before, path.read_bytes())
                self.assertFalse(path.with_name(policy.NAME + '.smali').exists())

    def test_modified_installed_callback_is_not_replaced(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            path = self.prepare(root)
            policy.patch(root)
            callback = path.with_name(policy.NAME + '.smali')
            callback.write_text(policy.CALLBACK + '\n# foreign change\n', encoding='utf-8')
            before = callback.read_bytes()
            with self.assertRaises(ValueError):
                policy.patch(root)
            self.assertEqual(before, callback.read_bytes())


if __name__ == '__main__':
    unittest.main()
