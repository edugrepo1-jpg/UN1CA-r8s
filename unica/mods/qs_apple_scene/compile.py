"""Generate source-owned scene code with SDK37; compiler stubs are not shipped."""
from pathlib import Path
import argparse
import hashlib
import json
import os
import shutil
import subprocess
import sys
import tempfile

MODULE = Path(__file__).resolve().parent
SOURCE = MODULE.parents[2] / 'target/r8s/ui/apple_qs/android-scene'
sys.path.insert(0, str(MODULE.parents[2] / 'scripts/internal'))
from sdk_smali import disassemble


def compile_adapter(sdk, java_home, apktool, build_tools='36.0.0'):
    exe = '.exe' if os.name == 'nt' else ''
    java, javac = [java_home / 'bin' / (name + exe) for name in ['java', 'javac']]
    android = sdk / 'platforms/android-37.0/android.jar'
    if not android.exists():
        android = sdk / 'platforms/android-37/android.jar'
    d8 = sdk / 'build-tools' / build_tools / 'lib/d8.jar'
    for file in [java, javac, apktool, android, d8]:
        if not file.is_file():
            raise FileNotFoundError(file)
    with tempfile.TemporaryDirectory(prefix='gmhub-qs-scene-') as directory:
        tmp = Path(directory)
        classes = tmp / 'classes'
        classes.mkdir()
        subprocess.run([str(javac), '--release', '8', '-encoding', 'UTF-8', '-Xlint:-options',
                        '-cp', str(android), '-d', str(classes),
                        *map(str, sorted(SOURCE.rglob('*.java')))], check=True)
        subprocess.run([str(java), '-cp', str(d8), 'com.android.tools.r8.D8', '--release',
                        '--min-api', '33', '--lib', str(android), '--output', str(tmp),
                        *map(str, sorted(classes.rglob('*.class')))], check=True)
        smali = tmp / 'smali'
        disassemble(java, apktool, tmp / 'classes.dex', smali)
        # Remove stale classes only in this tool's checked, owned directory.
        destination = (MODULE / 'smali').resolve()
        if destination.parent != MODULE.resolve():
            raise ValueError('Unsafe generated source destination')
        if destination.exists():
            shutil.rmtree(destination)
        shutil.copytree(smali, destination)
        for p in destination.rglob('*.smali'):
            p.write_text(p.read_text(encoding='utf-8'), encoding='utf-8', newline='\n')
    digest = lambda p: hashlib.sha256(p.read_bytes()).hexdigest()
    result = {'sources': {p.relative_to(SOURCE).as_posix(): digest(p) for p in sorted(SOURCE.rglob('*.java'))},
              'smali': {p.relative_to(destination).as_posix(): digest(p) for p in sorted(destination.rglob('*.smali'))},
              'resources': {p.relative_to(MODULE / 'res').as_posix(): digest(p) for p in sorted((MODULE / 'res').rglob('*.xml'))},
              'sdk_api': 37, 'min_api': 33}
    (MODULE / 'compiled.json').write_text(json.dumps(result, indent=2) + '\n', encoding='utf-8')
    print('Generated QS scene adapter from SDK37 source')


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    for name in ['sdk', 'java-home', 'apktool']:
        parser.add_argument('--' + name, type=Path, required=True)
    args = parser.parse_args()
    compile_adapter(args.sdk, args.java_home, args.apktool)
