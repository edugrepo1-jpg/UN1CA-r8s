#!/usr/bin/env python3
"""Translate legacy r8s complex triggers to the real donor SDHMS schema.

API37 removed the DEX/FPS complex enum values. Passing them to Enum.valueOf
crashes SDHMS repeatedly. Keep DeX available and all AP/BAT/LCD/charging and
scenario policies. Preserve the old FPS trip through the supported LimitHrr
component rather than inventing an enum or skipping thermal service startup.
"""
from pathlib import Path
import argparse
import re
import xml.etree.ElementTree as ET


def supported_types(smali):
    names = set(re.findall(r'const-string(?:/jumbo)?\s+\w+,\s+"([A-Z][A-Z0-9_]*)"', smali))
    if not {'LTB', 'LCD', 'GDM', 'GDMLTB', 'SS'}.issubset(names):
        raise ValueError('Unknown SDHMS OverheatComplexType schema')
    return names


def adapt(text, supported):
    root = ET.fromstring(text)
    unsupported = [e for e in root.findall('./overheatcontrol/complex/*') if e.tag not in supported]
    if any(e.tag not in {'FPS', 'DEX'} for e in unsupported):
        raise ValueError('Unrecognized complex thermal trigger; inspect the donor instead of dropping it')
    result = text
    fps_temp = None
    for entry in unsupported:
        if entry.attrib.get('formula') != 'LRP' or not entry.attrib.get('temp', '').isdigit():
            raise ValueError(f'Unexpected legacy {entry.tag} formula')
        if entry.tag == 'FPS':
            fps_temp = int(entry.attrib['temp'])
        pattern = rf'(?m)^[ \t]*<{entry.tag}\s+formula="LRP"\s+temp="{entry.attrib["temp"]}"\s*/>[ \t]*\r?\n'
        result, count = re.subn(pattern, '', result)
        if count != 1:
            raise ValueError(f'Ambiguous {entry.tag} complex trigger')
    if fps_temp is not None:
        display = root.find('./components/component[@name="DISPLAY"]')
        limits = display.findall('limiter[@name="LimitHrr"]') if display is not None else []
        if len(limits) != 1 or display.get('tempType') != 'LRP':
            raise ValueError('Missing supported display refresh-rate limiter')
        current = limits[0].get('temp', '')
        if not current.isdigit():
            raise ValueError('Unexpected display refresh-rate trip')
        target = str(min(int(current), fps_temp))
        pattern = rf'(<limiter name="LimitHrr"\s+temp="){current}("\s+value="-1:1"\s*/>)'
        result, count = re.subn(pattern, lambda m: m[1]+target+m[2], result)
        if count != 1:
            raise ValueError('Ambiguous display refresh-rate limiter')
    after = ET.fromstring(result)
    if any(e.tag not in supported for e in after.findall('./overheatcontrol/complex/*')):
        raise ValueError('Unsupported thermal trigger remains')
    for component in root.findall('./components/component'):
        name = component.attrib['name']
        if name != 'DISPLAY':
            if ET.tostring(component) != ET.tostring(after.find(f'./components/component[@name="{name}"]')):
                raise ValueError(f'Thermal policy changed outside display compatibility: {name}')
    if ET.tostring(root.find('scenarios')) != ET.tostring(after.find('scenarios')):
        raise ValueError('Scenario policy changed')
    return result


def patch(package, policy):
    enums = list(package.glob('smali*/com/sec/android/sdhms/thermal/overheatcontrol/overheatcomplex/OverheatComplexType.smali'))
    if len(enums) != 1:
        raise ValueError('Expected the exact SDHMS enum class')
    original = policy.read_text(encoding='utf-8')
    changed = adapt(original, supported_types(enums[0].read_text(encoding='utf-8')))
    if changed != original:
        policy.write_text(changed, encoding='utf-8', newline='\n')


if __name__ == '__main__':
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('decoded_package', type=Path)
    p.add_argument('policy', type=Path)
    args = p.parse_args()
    patch(args.decoded_package, args.policy)
    print('SDHMS complex triggers match donor; CPU/GPU/charging and scenario limits retained')
