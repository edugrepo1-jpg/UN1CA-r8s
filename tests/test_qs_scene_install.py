"""Composition entry installation must be atomic, narrow and reproducible."""
from pathlib import Path
import copy
import hashlib
import importlib.util
import json
import re
import shutil
import tempfile
import unittest
import xml.etree.ElementTree as ET

ROOT = Path(__file__).resolve().parents[1]
MODULE = ROOT / 'unica/mods/qs_apple_scene'
SETTINGS = ROOT / 'unica/mods/settings'
spec = importlib.util.spec_from_file_location('qs_scene_install', MODULE / 'install.py')
installer = importlib.util.module_from_spec(spec)
spec.loader.exec_module(installer)
A = '{http://schemas.android.com/apk/res/android}'


def fixture(decoded, module):
    contract = json.loads((module / 'native-contracts.json').read_text(encoding='utf-8'))
    for cls, members in contract['classes'].items():
        path = decoded / 'smali_classes3' / (cls + '.smali')
        path.parent.mkdir(parents=True, exist_ok=True)
        text = '.class public final L' + cls + ';\n'
        text += ''.join('.field public ' + field + '\n' for field in members['fields'])
        text += ''.join('.method public ' + method + '\n.end method\n' for method in members['methods'])
        path.write_text(text, encoding='utf-8')
    for hook in contract['hooks']:
        if hook['kind'] == 'entry':
            body = (hook['signature'] + '\n    .locals 16\n'
                    '    invoke-static/range {v10 .. v15}, ' + installer.NATIVE_MAIN
                    + '\n    return-object v0\n.end method')
        elif hook['kind'] == 'shape':
            body = (hook['signature'] + '\n    .locals 50\n' + installer.COMPOSER_ANCHOR
                    + '\n' + installer.REMOVE_ANCHOR
                    + '\n    return-object v0\n.end method')
        elif hook['kind'] == 'resize_icon':
            body = (hook['signature'] + '\n    .locals 30\n' + installer.RESIZE_ANCHOR
                    + '\n    return-object v0\n.end method')
        elif hook['kind'] == 'cell_aspect':
            body = (hook['signature'] + '\n    .locals 35\n' + installer.GRID_ANCHOR
                    + 'native-descriptor)V\n    return-object v0\n.end method')
        else:
            body = (hook['signature'] + '\n    .locals 16\n'
                    '    invoke-static {v1, v0, v12, v13}, ' + installer.NATIVE_HEADER
                    + '\n    return-object v0\n.end method')
        hook['method_sha256'] = hashlib.sha256(body.encode()).hexdigest()
        path = decoded / 'smali_classes3' / (hook['class'] + '.smali')
        if not path.exists():
            path.parent.mkdir(parents=True, exist_ok=True)
            path.write_text('.class public final L' + hook['class'] + ';\n', encoding='utf-8')
        path.write_text(path.read_text(encoding='utf-8') + body + '\n', encoding='utf-8')
    for check in contract.get('support_methods', []):
        path = decoded / 'smali_classes3' / (check['class'] + '.smali')
        if not path.exists():
            path.parent.mkdir(parents=True, exist_ok=True)
            path.write_text('.class public final L' + check['class'] + ';\n', encoding='utf-8')
        text = path.read_text(encoding='utf-8')
        signature = check['signature'].split()[-1]
        text = re.sub(r'(?ms)^\.method [^\n]*' + re.escape(signature) + r'\n.*?^\.end method\n?', '', text)
        body = check['signature'] + '\n    .locals 1\n    return-void\n.end method'
        check['method_sha256'] = hashlib.sha256(body.encode()).hexdigest()
        path.write_text(text + body + '\n', encoding='utf-8')
    (module / 'native-contracts.json').write_text(json.dumps(contract), encoding='utf-8')
    return contract


def snapshot(root):
    return {p.relative_to(root).as_posix(): p.read_bytes() for p in root.rglob('*') if p.is_file()}


class SceneInstallTests(unittest.TestCase):
    def test_narrow_idempotent_entry_and_local_shape_hook(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            module = root / 'module'
            shutil.copytree(MODULE, module)
            decoded = root / 'decoded'
            contract = fixture(decoded, module)
            before = snapshot(decoded)
            installer.install(decoded, module)
            first = snapshot(decoded)
            installer.install(decoded, module)
            self.assertEqual(first, snapshot(decoded))
            changed = [name for name in before if before[name] != first[name]]
            self.assertEqual(len(changed), 5)
            self.assertTrue(all(any(h['class'] + '.smali' in name for h in contract['hooks']) for name in changed))
            for hook in contract['hooks']:
                text = (decoded / 'smali_classes3' / (hook['class'] + '.smali')).read_text()
                self.assertEqual(text.count(installer.ROOT + '->'), 2 if hook['kind'] == 'shape' else 1)
            # Re-installation must reuse one DEX directory, never duplicate the
            # root or the generated nested classes into a second class loader.
            self.assertEqual(len(list(decoded.glob('smali*/com/gmhub/qs/ComposePanelRoot.smali'))), 1)

    def test_changed_native_member_rejected_before_any_writes(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            module = root / 'module'
            shutil.copytree(MODULE, module)
            decoded = root / 'decoded'
            contract = fixture(decoded, module)
            cls = next(c for c in contract['classes'] if c.endswith('/QSHost'))
            path = decoded / 'smali_classes3' / (cls + '.smali')
            path.write_text(path.read_text().replace('getUserContext()', 'changedUserContext()'))
            before = snapshot(decoded)
            with self.assertRaisesRegex(ValueError, 'changed public method'):
                installer.install(decoded, module)
            self.assertEqual(before, snapshot(decoded))

    def test_changed_method_or_partial_hook_rejected(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            module = root / 'module'
            shutil.copytree(MODULE, module)
            decoded = root / 'decoded'
            contract = fixture(decoded, module)
            for hook in contract['hooks']:
                text = (decoded / 'smali_classes3' / (hook['class'] + '.smali')).read_text()
                changed = installer.patch(text, hook)
                for broken in [text.replace('return-object v0', 'return-object v1'),
                               changed.replace('return-object v0', 'return-object v1')]:
                    with self.assertRaisesRegex(ValueError, 'differs'):
                        installer.patch(broken, hook)
                if hook['kind'] == 'shape':
                    with self.assertRaises(ValueError):
                        installer.patch(changed.replace('move-object/from16 v51, v21', ''), hook)
                if hook['kind'] == 'cell_aspect':
                    with self.assertRaises(ValueError):
                        installer.patch(changed.replace('move-object/from16 v36, v23', ''), hook)

    def test_generated_code_has_no_stale_or_external_classes(self):
        installer.verify_generated()
        with tempfile.TemporaryDirectory() as directory:
            module = Path(directory) / 'module'
            shutil.copytree(MODULE, module)
            target = module / 'smali/com/gmhub/qs/ComposePanelRoot.smali'
            target.write_text(target.read_text() + '\n# stale\n')
            with self.assertRaisesRegex(ValueError, 'out of sync'):
                installer.verify_generated(module)

    def test_prior_shape_only_hook_upgrades_without_duplicate_calls(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            module = root / 'module'
            shutil.copytree(MODULE, module)
            decoded = root / 'decoded'
            contract = fixture(decoded, module)
            hook = next(h for h in contract['hooks'] if h['kind'] == 'shape')
            path = decoded / 'smali_classes3' / (hook['class'] + '.smali')
            original = path.read_text(encoding='utf-8')
            previous = original.replace('    .locals 50', '    .locals 53', 1).replace(
                installer.COMPOSER_ANCHOR, installer.COMPOSER_ANCHOR + installer.SHAPE_CODE, 1)
            self.assertEqual(installer.patch(previous, hook), installer.patch(original, hook))

    def test_conflicting_editor_icon_cannot_leave_partial_native_hooks(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            module = root / 'module'
            shutil.copytree(MODULE, module)
            decoded = root / 'decoded'
            fixture(decoded, module)
            icon = decoded / 'res/drawable/gmhub_qs_remove.xml'
            icon.parent.mkdir(parents=True)
            icon.write_text('<vector />', encoding='utf-8')
            before = snapshot(decoded)
            with self.assertRaisesRegex(ValueError, 'Conflicting owned QS icon'):
                installer.install(decoded, module)
            self.assertEqual(before, snapshot(decoded))

    def test_changed_native_done_semantics_are_rejected_before_writes(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            module = root / 'module'
            shutil.copytree(MODULE, module)
            decoded = root / 'decoded'
            contract = fixture(decoded, module)
            check = next(c for c in contract['support_methods'] if c['class'].endswith('ExternalSyntheticLambda35'))
            path = decoded / 'smali_classes3' / (check['class'] + '.smali')
            path.write_text(path.read_text(encoding='utf-8').replace('return-void', 'return-object v0'), encoding='utf-8')
            before = snapshot(decoded)
            with self.assertRaisesRegex(ValueError, 'action semantics changed'):
                installer.install(decoded, module)
            self.assertEqual(before, snapshot(decoded))

    def test_hub_choice_is_user_scoped_and_exposes_native_restore(self):
        xml = ET.parse(SETTINGS / 'SecSettings.apk/res/xml/gm_qs_preferences.xml').getroot()
        selector = xml.find('ListPreference')
        self.assertEqual(selector.get(A + 'persistent'), 'false')
        self.assertEqual(selector.get(A + 'key'), 'gmhub_qs_style')
        resources = ET.parse(SETTINGS / 'SecSettings.apk/res/values/gm_qs.xml').getroot()
        self.assertEqual([v.text for v in resources.find("./string-array[@name='gm_qs_style_values']")], ['0', '1'])
        source = (SETTINGS / 'panelstyle/src/com/gmhub/panelstyle/PanelStyleControl.java').read_text()
        self.assertIn('Settings.Secure.putInt', source)
        self.assertIn('Settings.Secure.getInt', source)
        self.assertNotIn('Settings.Global', source)
        self.assertNotIn('reboot', source)
        self.assertNotIn('force-stop', source)
        top = ET.parse(SETTINGS / 'SecSettings.apk/res/xml/unica_top_settings.xml').getroot()
        self.assertTrue(any(p.get(A + 'fragment') == 'com.paradox.hub.PanelStyleFragment' for p in top.iter()))


if __name__ == '__main__':
    unittest.main()
