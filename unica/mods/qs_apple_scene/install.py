"""Install a user-scoped appearance provider at the exact Samsung Compose entry.

The native main, its restart function, player and controls are never replaced.
All method/member/generated-code checks precede changes to the decoded APK.
"""
from pathlib import Path
import hashlib
import importlib.util
import json
import re
import shutil
import sys

MODULE = Path(__file__).resolve().parent
SOURCE = MODULE.parents[2] / 'target/r8s/ui/apple_qs'
ROOT = 'Lcom/gmhub/qs/ComposePanelRoot;'
NATIVE_MAIN = ('Lcom/android/systemui/samsung/quicksetting/ui/SecQuickSettingSceneKt;'
               '->SecQuickSettingSceneMain(Lcom/android/compose/animation/scene/ContentScope;'
               'Landroidx/compose/ui/Modifier;Ljava/util/List;'
               'Lcom/android/systemui/samsung/quicksetting/ui/panel/QuickTileBoxViewModel;'
               'Landroidx/compose/runtime/Composer;I)V')
BRIDGE = ROOT + '->content(Ljava/lang/Object;Ljava/lang/Object;Ljava/util/List;Ljava/lang/Object;Ljava/lang/Object;I)V'
COMPOSER_ANCHOR = '    check-cast v13, Landroidx/compose/runtime/Composer;'
SHAPE_CODE = '''

    move-object/from16 v50, p0

    move-object/from16 v51, v21

    move-object/from16 v52, v13

    invoke-static/range {v50 .. v52}, Lcom/gmhub/qs/ComposePanelRoot;->shape(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v21

    check-cast v21, Landroidx/compose/foundation/shape/RoundedCornerShape;'''


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def method_body(text, signature):
    if text.splitlines().count(signature) != 1:
        raise ValueError('Changed QS method declaration: ' + signature)
    start = text.index(signature)
    end = text.index('.end method', start) + len('.end method')
    return start, end, text[start:end]


def patch(text, hook):
    start, end, body = method_body(text, hook['signature'])
    if hook['kind'] == 'entry':
        original = body.replace(BRIDGE, NATIVE_MAIN)
        if original.count(NATIVE_MAIN) != 1 or original.count('    .locals 16') != 1:
            raise ValueError('Changed native QS scene entry allocation')
        changed = original.replace(NATIVE_MAIN, BRIDGE)
    elif hook['kind'] == 'shape':
        original = body
        if ROOT + '->shape(' in original:
            if original.count(SHAPE_CODE) != 1:
                raise ValueError('Partially installed QS shape hook')
            original = original.replace(SHAPE_CODE, '').replace('    .locals 53', '    .locals 50', 1)
        if original.count('    .locals 50') != 1 or original.count(COMPOSER_ANCHOR) != 1:
            raise ValueError('Changed native QS frame allocation')
        # New scratch registers must never alias an explicitly numbered native
        # parameter. p0/p1/p2 are adjusted by the assembler after locals grows.
        if re.search(r'\bv(?:5[0-9]|[6-9][0-9]|[1-9][0-9]{2,})\b', original):
            raise ValueError('Native QS frame uses the reserved scratch registers')
        changed = original.replace('    .locals 50', '    .locals 53', 1)
        changed = changed.replace(COMPOSER_ANCHOR, COMPOSER_ANCHOR + SHAPE_CODE, 1)
    else:
        raise ValueError('Unknown QS hook kind')
    if hashlib.sha256(original.encode('utf-8')).hexdigest() != hook['method_sha256']:
        raise ValueError('QS method differs from the verified Samsung firmware: ' + hook['kind'])
    return text[:start] + changed + text[end:]


def verify_generated(module=MODULE, source=SOURCE):
    compiled = json.loads((module / 'compiled.json').read_text(encoding='utf-8'))
    sources = {p.relative_to(source / 'android-scene').as_posix(): digest(p)
               for p in sorted((source / 'android-scene').rglob('*.java'))}
    generated = {p.relative_to(module / 'smali').as_posix(): digest(p)
                 for p in sorted((module / 'smali').rglob('*.smali'))}
    if not sources or sources != compiled['sources'] or not generated or generated != compiled['smali']:
        raise ValueError('QS scene source and generated DEX are out of sync')
    if set(generated) - {p for p in generated if p.startswith('com/gmhub/qs/ComposePanelRoot')}:
        raise ValueError('Unexpected classes in QS scene adapter')


def install(decoded, module=MODULE, source=SOURCE):
    verify_generated(module, source)
    spec = importlib.util.spec_from_file_location('qs_contract', source / 'verify_contract.py')
    checker = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(checker)
    contract = json.loads((module / 'native-contracts.json').read_text(encoding='utf-8'))
    checker.verify(decoded, contract)
    changes = []
    for hook in contract['hooks']:
        files = list(decoded.glob('smali*/' + hook['class'] + '.smali'))
        if len(files) != 1:
            raise ValueError('Expected one QS hook owner: ' + hook['class'])
        path = files[0]
        changes.append((path, patch(path.read_text(encoding='utf-8'), hook)))
    existing = list(decoded.glob('smali*/com/gmhub/qs/ComposePanelRoot.smali'))
    if len(existing) > 1:
        raise ValueError('Duplicate QS scene definitions')
    generated = list((module / 'smali').rglob('*.smali'))
    for candidate in generated:
        definitions = list(decoded.glob('smali*/' + candidate.relative_to(module / 'smali').as_posix()))
        if len(definitions) > 1:
            raise ValueError('Duplicate generated QS class: ' + candidate.name)
        if definitions and (not existing or definitions[0].parents[3] != existing[0].parents[3]):
            raise ValueError('QS adapter classes split across DEX directories')
    if existing:
        dest = existing[0].parents[3]
    else:
        indices = [int(p.name[13:]) if p.name.startswith('smali_classes') else 1 for p in decoded.iterdir()
                   if p.is_dir() and re.fullmatch(r'smali(?:_classes\d+)?', p.name)]
        dest = decoded / ('smali_classes' + str(max(indices, default=1) + 1))
    shutil.copytree(module / 'smali', dest, dirs_exist_ok=True)
    for path, text in changes:
        path.write_text(text, encoding='utf-8', newline='\n')
    print('Connected native Samsung QS scene and per-user appearance; original player/editor retained')


if __name__ == '__main__':
    install(Path(sys.argv[1]))
