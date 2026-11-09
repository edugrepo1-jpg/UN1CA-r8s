#!/usr/bin/env python3
"""Reject incomplete GM Hub inputs before downloading or modifying firmware."""
from pathlib import Path
import importlib.util
import sys


def load(path, name):
    spec = importlib.util.spec_from_file_location(name, path)
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


def verify(root):
    root = Path(root)
    mods = root / 'unica/mods'
    # apply_modules.sh requires module.prop for every top-level module, even
    # before it checks for a disable marker. Never silently skip missing input.
    for directory in sorted(p for p in mods.iterdir() if p.is_dir()):
        # The selected ESSI subdirectory owns metadata when present.
        selected = directory / 'essi' if (directory / 'essi').is_dir() else directory
        metadata = selected / 'module.prop'
        if not metadata.is_file():
            raise ValueError('Missing required build module metadata: ' + str(metadata.relative_to(root)))
        values = {}
        for line in metadata.read_text(encoding='utf-8').splitlines():
            if not line.strip() or line.lstrip().startswith('#'):
                continue
            key, separator, value = line.partition('=')
            if separator:
                if key in values:
                    raise ValueError('Duplicate module property: ' + str(metadata.relative_to(root)) + ': ' + key)
                values[key] = value.strip()
        if not values.get('name') or not values.get('author'):
            raise ValueError('Incomplete name/author: ' + str(metadata.relative_to(root)))

    settings = mods / 'settings'
    checked = []
    for name in ['apps', 'profiles', 'monitor', 'refresh', 'undervolt', 'pureblack', 'panelstyle']:
        load(settings / name / 'verify.py', 'gmhub_preflight_' + name).verify(settings)
        checked.append(name)
    scene = load(mods / 'qs_apple_scene/install.py', 'gmhub_preflight_scene')
    scene.verify_generated(mods / 'qs_apple_scene', root / 'target/r8s/ui/apple_qs')
    checked.append('qs_apple_scene')
    load(mods / 'liquid_glass/install.py', 'gmhub_preflight_glass').verify_generated(mods / 'liquid_glass')
    checked.append('liquid_glass')
    return checked


if __name__ == '__main__':
    try:
        checked = verify(Path(__file__).resolve().parents[2])
        print('GM Hub module metadata and source/generated integrity verified: ' + ', '.join(checked))
    except (OSError, ValueError, KeyError) as error:
        sys.exit(str(error))
