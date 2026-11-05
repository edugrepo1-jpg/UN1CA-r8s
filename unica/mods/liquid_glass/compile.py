#!/usr/bin/env python3
"""Rebuild the source-owned DEX adapter with a real SDK; no stubs are shipped.

Pre-generated smali is included so a ROM build does not download another SDK.
Changing Java without regenerating it is rejected by install.py.
"""
from pathlib import Path
import argparse
import hashlib
import json
import os
import shutil
import subprocess
import sys
import tempfile

sys.path.insert(0, str(Path(__file__).resolve().parents[3] / 'scripts/internal'))
from sdk_smali import disassemble


def compile_adapter(module, sdk, java_home, apktool, build_tools='36.0.0'):
    exe = '.exe' if os.name == 'nt' else ''
    java = java_home / 'bin' / ('java' + exe)
    javac = java_home / 'bin' / ('javac' + exe)
    android = sdk / 'platforms/android-37.0/android.jar'
    if not android.exists():
        android = sdk / 'platforms/android-37/android.jar'
    for f in (java, javac, android, apktool, sdk / 'build-tools' / build_tools / 'lib/d8.jar'):
        if not f.is_file():
            raise FileNotFoundError(f)
    source = module / 'src/com/gmhub/glass/GlassDrawable.java'
    with tempfile.TemporaryDirectory(prefix='gmhub-glass-compile-') as directory:
        tmp = Path(directory)
        classes = tmp / 'classes'
        classes.mkdir()
        subprocess.run([str(javac), '--release', '8', '-Xlint:-options', '-cp', str(android),
                        '-d', str(classes), str(source)], check=True)
        files = [str(f) for f in classes.rglob('*.class')]
        subprocess.run([str(java), '-cp', str(sdk / 'build-tools' / build_tools / 'lib/d8.jar'),
                        'com.android.tools.r8.D8', '--release', '--min-api', '33', '--lib', str(android),
                        '--output', str(tmp), *files], check=True)
        smali = tmp / 'smali'
        disassemble(java, apktool, tmp / 'classes.dex', smali)
        compiled = list(smali.rglob('*.smali'))
        expected={'com/gmhub/glass/GlassDrawable.smali','com/gmhub/glass/GlassDrawable$Health.smali'}
        if {f.relative_to(smali).as_posix() for f in compiled} != expected:
            raise ValueError('Unexpected generated adapter classes')
        shutil.copytree(smali, module / 'smali', dirs_exist_ok=True)
        # Git checks out text as LF on the Linux builder. Hash the same bytes
        # there and on Windows, regardless of baksmali's platform line endings.
        for generated in (module / 'smali').rglob('*.smali'):
            generated.write_text(generated.read_text(encoding='utf-8'), encoding='utf-8', newline='\n')
    digest = lambda p: hashlib.sha256(p.read_bytes()).hexdigest()
    result = {'java_sha256': digest(source),
              'smali_sha256': digest(module / 'smali/com/gmhub/glass/GlassDrawable.smali'),
              'smali_files': {p.relative_to(module/'smali').as_posix():digest(p)
                              for p in sorted((module/'smali').rglob('*.smali'))},
              'min_api': 33, 'sdk_api': 37}
    (module / 'compiled.json').write_text(json.dumps(result, indent=2) + '\n', encoding='utf-8')
    print('Compiled and disassembled native SDK adapter; no compiler stubs packaged')


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--sdk', type=Path, required=True)
    parser.add_argument('--java-home', type=Path, required=True)
    parser.add_argument('--apktool', type=Path, required=True)
    parser.add_argument('--build-tools', default='36.0.0')
    args = parser.parse_args()
    compile_adapter(Path(__file__).resolve().parent, args.sdk, args.java_home, args.apktool, args.build_tools)
