"""Reject stale generated pureblack bytecode before modifying the firmware."""
from pathlib import Path
import hashlib
import json


def verify(root):
    manifest = json.loads((root / 'pureblack/compiled.json').read_text(encoding='utf-8'))
    sources = {p.relative_to(root).as_posix() for p in (root / 'pureblack/src').rglob('*.java')}
    if sources != set(manifest['sources']):
        raise ValueError('Missing or unexpected pureblack-writer sources')
    for kind in ['sources', 'generated', 'dependencies']:
        if not manifest[kind]:
            raise ValueError('Empty pureblack compilation manifest')
        for path, expected in manifest[kind].items():
            target = root / path
            if not target.is_file() or hashlib.sha256(target.read_bytes()).hexdigest() != expected:
                raise ValueError('Pure Black source/generated mismatch: ' + path)
    actual = {p.relative_to(root).as_posix() for p in (root / 'SecSettings.apk/smali_classes4/com/gmhub/theme').glob('*.smali')}
    if actual != set(manifest['generated']):
        raise ValueError('Unexpected generated pureblack classes')


if __name__ == '__main__':
    verify(Path(__file__).resolve().parents[1])
