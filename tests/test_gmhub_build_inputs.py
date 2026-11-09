"""Catch incomplete input delivery before slow firmware preparation."""
from pathlib import Path
import importlib.util
import shutil
import tempfile
import unittest

ROOT = Path(__file__).resolve().parents[1]
spec = importlib.util.spec_from_file_location('gmhub_input_check', ROOT / 'scripts/internal/verify_gmhub_inputs.py')
checker = importlib.util.module_from_spec(spec)
spec.loader.exec_module(checker)


class BuildInputTests(unittest.TestCase):
    def test_shipped_inputs_are_complete_and_current(self):
        self.assertEqual(len(checker.verify(ROOT)), 9)

    def test_missing_or_empty_scene_metadata_is_rejected(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            module = root / 'unica/mods/qs_apple_scene'
            module.mkdir(parents=True)
            with self.assertRaisesRegex(ValueError, 'Missing required build module metadata'):
                checker.verify(root)
            (module / 'module.prop').write_text('name=QS\nauthor=\n', encoding='utf-8')
            with self.assertRaisesRegex(ValueError, 'Incomplete name/author'):
                checker.verify(root)

    def test_changed_generated_scene_is_rejected(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            shutil.copytree(ROOT / 'unica/mods', root / 'unica/mods')
            shutil.copytree(ROOT / 'target/r8s/ui/apple_qs', root / 'target/r8s/ui/apple_qs')
            target = root / 'unica/mods/qs_apple_scene/smali/com/gmhub/qs/ComposePanelRoot.smali'
            target.write_text(target.read_text(encoding='utf-8') + '\n# stale code\n', encoding='utf-8')
            with self.assertRaisesRegex(ValueError, 'out of sync'):
                checker.verify(root)


if __name__ == '__main__':
    unittest.main()
