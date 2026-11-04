"""Thermal readings use the real Java parser, not fixed donor zone indexes."""
from pathlib import Path
import importlib.util
import os
import shutil
import subprocess
import tempfile
import unittest
import xml.etree.ElementTree as ET

ROOT = Path(__file__).resolve().parents[1]
SETTINGS = ROOT / 'unica/mods/settings'
SOURCE = SETTINGS / 'monitor/src/com/gmhub/monitor/ThermalReader.java'

CONTRACT = r'''import java.io.*;
import java.nio.file.*;
import java.util.*;
import com.gmhub.monitor.ThermalReader;
public class ThermalContract {
 static int checks;
 static void check(boolean v){checks++;if(!v)throw new AssertionError("check "+checks);}
 static void zone(Path root,int index,String name,String value)throws Exception{
  Path zone=root.resolve("thermal_zone"+index);Files.createDirectories(zone);
  Files.write(zone.resolve("type"),name.getBytes(java.nio.charset.StandardCharsets.UTF_8));
  Files.write(zone.resolve("temp"),value.getBytes(java.nio.charset.StandardCharsets.UTF_8));
 }
 public static void main(String[] args)throws Exception{
  Path root=Paths.get(args[0]);
  check(ThermalReader.read(root.resolve("absent").toFile()).isEmpty());
  Files.createDirectories(root);
  // Zone order is deliberately different from the old hard-coded four reads.
  zone(root,10,"GPU\n","41250\n");zone(root,2,"CPUCL2\n","-1000\n");
  zone(root,0,"CPUCL0\n","44000\n");zone(root,1,"CPUCL1\n","-273000\n");
  zone(root,4,"ISP\n","not-a-temperature\n");zone(root,5,"\n","90000\n");
  zone(root,6,"LONG\n",new String(new char[161]).replace('\0','8'));
  var values=ThermalReader.read(root.toFile());check(values.size()==6);
  check(values.get(0).sensor.equals("CPUCL0"));check(values.get(0).milliCelsius==44000);
  check(values.get(1).milliCelsius==null);check(values.get(2).milliCelsius==-1000);
  check(values.get(5).sensor.equals("GPU"));check(values.get(5).milliCelsius==41250);
  check(values.get(3).temperature(Locale.US,"unavailable").equals("unavailable"));
  check(values.get(5).temperature(Locale.US,"unavailable").equals("41.3 °C"));
  try{values.clear();throw new AssertionError("Mutable snapshot");}catch(UnsupportedOperationException expected){checks++;}
  check(new String(Files.readAllBytes(root.resolve("thermal_zone1/temp"))).equals("-273000\n"));
  for(int i=11;i<145;i++)zone(root,i,"SENSOR\n","35000\n");
  check(ThermalReader.read(root.toFile()).size()<=128);
  System.out.println(checks+" read-only thermal checks passed");
 }
}'''


class ThermalTests(unittest.TestCase):
    def test_real_parser_uses_type_names_units_bounds_and_read_only_snapshots(self):
        suffix = '.exe' if os.name == 'nt' else ''
        home = os.environ.get('JAVA_HOME')
        javac = str(Path(home) / ('bin/javac' + suffix)) if home else shutil.which('javac')
        java = str(Path(home) / ('bin/java' + suffix)) if home else shutil.which('java')
        if not java or not javac:
            self.skipTest('A complete JDK is required')
        with tempfile.TemporaryDirectory() as directory:
            out = Path(directory)
            contract = out / 'ThermalContract.java'
            contract.write_text(CONTRACT, encoding='utf-8')
            compile_result = subprocess.run([javac, '-encoding', 'UTF-8', '-d', str(out), str(SOURCE), str(contract)], capture_output=True, text=True, timeout=45)
            self.assertEqual(compile_result.returncode, 0, compile_result.stderr)
            result = subprocess.run([java, '-Xverify:all', '-cp', str(out), 'ThermalContract', str(out / 'thermal')], capture_output=True, text=True, timeout=30)
            self.assertEqual(result.returncode, 0, result.stdout + result.stderr)

    def test_compiled_monitor_and_navigation_are_consistent(self):
        spec = importlib.util.spec_from_file_location('monitor_verify', SETTINGS / 'monitor/verify.py')
        verifier = importlib.util.module_from_spec(spec)
        spec.loader.exec_module(verifier)
        verifier.verify(SETTINGS)
        android = '{http://schemas.android.com/apk/res/android}'
        screen = ET.parse(SETTINGS / 'SecSettings.apk/res/xml/unica_top_settings.xml')
        targets = [n for n in screen.getroot().iter() if n.get(android + 'fragment') == 'com.paradox.hub.ParadoxThermalFragment']
        self.assertEqual(len(targets), 1)
        fragment = (SETTINGS / 'SecSettings.apk/smali_classes4/com/paradox/hub/ParadoxThermalFragment.smali').read_text()
        self.assertNotIn('mUpdateTask', fragment)
        self.assertIn('->setActive(Landroid/view/View;Z)V', fragment)
