from pathlib import Path
import importlib.util
import unittest
import xml.etree.ElementTree as ET
ROOT=Path(__file__).resolve().parents[1]
s=importlib.util.spec_from_file_location('thermal',ROOT/'target/r8s/adapt_thermal_policy.py')
m=importlib.util.module_from_spec(s);s.loader.exec_module(m)


class ThermalPolicyTests(unittest.TestCase):
    def test_modern_schema_retains_refresh_trip_and_other_limits(self):
        text=(ROOT/'target/r8s/dvfs/siop_model.xml').read_text(encoding='utf-8')
        supported={'LTB','LCD','GDM','GDMLTB','SS','EMR'}
        changed=m.adapt(text,supported);root=ET.fromstring(changed)
        self.assertNotIn('DEX',[x.tag for x in root.findall('./overheatcontrol/complex/*')])
        self.assertNotIn('FPS',[x.tag for x in root.findall('./overheatcontrol/complex/*')])
        self.assertEqual(root.find('./components/component[@name="DISPLAY"]/limiter[@name="LimitHrr"]').get('temp'),'430')
        self.assertEqual(m.adapt(changed,supported),changed)

    def test_older_supported_dex_stays_present(self):
        text=(ROOT/'target/r8s/dvfs/siop_model.xml').read_text(encoding='utf-8')
        changed=m.adapt(text,{'LTB','LCD','GDM','GDMLTB','SS','EMR','DEX'})
        self.assertIsNotNone(ET.fromstring(changed).find('./overheatcontrol/complex/DEX'))

    def test_unknown_trigger_and_formula_are_rejected(self):
        text=(ROOT/'target/r8s/dvfs/siop_model.xml').read_text(encoding='utf-8')
        supported={'LTB','LCD','GDM','GDMLTB','SS','EMR'}
        with self.assertRaisesRegex(ValueError,'Unrecognized'):
            m.adapt(text.replace('<DEX ', '<OTHER '),supported)
        with self.assertRaisesRegex(ValueError,'Unexpected legacy'):
            m.adapt(text.replace('<DEX    formula="LRP"','<DEX    formula="BAT"'),supported)

    def test_enum_names_come_from_donor_not_obfuscated_fields(self):
        self.assertEqual(m.supported_types('\n'.join(f'const-string v0, "{n}"' for n in ('LTB','LCD','GDM','GDMLTB','SS','EMR'))),
                         {'LTB','LCD','GDM','GDMLTB','SS','EMR'})
