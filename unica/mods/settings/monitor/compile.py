"""Compile the source-owned Settings monitor; no SDK download in ROM builds."""
from pathlib import Path
import argparse
import hashlib
import json
import os
import subprocess
import sys
import tempfile

sys.path.insert(0, str(Path(__file__).resolve().parents[4] / 'scripts/internal'))
from sdk_smali import disassemble


def compile_sources(root, sdk, java_home, apktool):
    suffix = '.exe' if os.name == 'nt' else ''
    java = java_home / 'bin' / ('java' + suffix)
    javac = java_home / 'bin' / ('javac' + suffix)
    android = sdk / 'platforms/android-37.0/android.jar'
    if not android.is_file():
        android = sdk / 'platforms/android-37/android.jar'
    d8 = sdk / 'build-tools/36.0.0/lib/d8.jar'
    for path in [java, javac, android, d8, apktool]:
        if not path.is_file():
            raise FileNotFoundError(path)
    sources = sorted((root / 'src').rglob('*.java'))
    with tempfile.TemporaryDirectory(prefix='gmhub-monitor-') as directory:
        tmp = Path(directory)
        classes = tmp / 'classes'
        classes.mkdir()
        subprocess.run([str(javac), '--release', '8', '-encoding', 'UTF-8', '-Xlint:-options', '-cp', str(android), '-d', str(classes), *map(str, sources)], check=True)
        subprocess.run([str(java), '-cp', str(d8), 'com.android.tools.r8.D8', '--release', '--min-api', '33', '--lib', str(android), '--output', str(tmp), *map(str, classes.rglob('*.class'))], check=True)
        disassemble(java, apktool, tmp / 'classes.dex', tmp / 'smali')
        generated = sorted((tmp / 'smali').rglob('*.smali'))
        if not generated or any(not p.relative_to(tmp / 'smali').as_posix().startswith('com/gmhub/monitor/') for p in generated):
            raise ValueError('Unexpected generated monitor classes')
        manifest = {'sdk_api': 37, 'min_api': 33, 'sources': {}, 'generated': {}}
        for path in sources:
            manifest['sources'][path.relative_to(root.parent).as_posix()] = hashlib.sha256(path.read_bytes()).hexdigest()
        dest = root.parent / 'SecSettings.apk/smali_classes4'
        for path in generated:
            target = dest / path.relative_to(tmp / 'smali')
            target.parent.mkdir(parents=True, exist_ok=True)
            target.write_text(path.read_text(encoding='utf-8'), encoding='utf-8', newline='\n')
            manifest['generated'][target.relative_to(root.parent).as_posix()] = hashlib.sha256(target.read_bytes()).hexdigest()
        (root / 'compiled.json').write_text(json.dumps(manifest, indent=2) + '\n', encoding='utf-8', newline='\n')
    print('Settings monitor compiled with SDK37; no compiler stubs shipped')


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    for arg in ['sdk', 'java-home', 'apktool']:
        parser.add_argument('--' + arg, type=Path, required=True)
    args = parser.parse_args()
    compile_sources(Path(__file__).resolve().parent, args.sdk, args.java_home, args.apktool)
