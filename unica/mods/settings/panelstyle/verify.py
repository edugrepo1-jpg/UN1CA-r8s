"""Reject stale generated panelstyle bytecode before modifying the firmware."""
from pathlib import Path
import hashlib
import json


def verify(root):
    manifest = json.loads((root / 'panelstyle/compiled.json').read_text(encoding='utf-8'))
    sources = {p.relative_to(root).as_posix() for p in (root / 'panelstyle/src').rglob('*.java')}
    if sources != set(manifest['sources']):
        raise ValueError('Missing or unexpected panelstyle-writer sources')
    for kind in ['sources', 'generated']:
        if not manifest[kind]:
            raise ValueError('Empty panelstyle compilation manifest')
        for path, expected in manifest[kind].items():
            target = root / path
            if not target.is_file() or hashlib.sha256(target.read_bytes()).hexdigest() != expected:
                raise ValueError('Panel style source/generated mismatch: ' + path)
    actual = {p.relative_to(root).as_posix() for p in (root / 'SecSettings.apk/smali_classes4/com/gmhub/panelstyle').glob('*.smali')}
    if actual != set(manifest['generated']):
        raise ValueError('Unexpected generated panelstyle classes')


if __name__ == '__main__':
    verify(Path(__file__).resolve().parents[1])
