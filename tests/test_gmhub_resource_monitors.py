"""Real parser/conversion contracts; no device, Android emulator or guessed sysfs units."""
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
CONTRACT = r'''import java.io.*;
import java.nio.file.*;
import java.nio.charset.StandardCharsets;
import java.util.*;
import com.gmhub.monitor.MemoryReader;
import com.gmhub.monitor.BatteryUnits;
public class ResourcesContract {
 static int checks;
 static void check(boolean value){checks++;if(!value)throw new AssertionError("check "+checks);}
 static void write(Path path,String text)throws Exception{Files.createDirectories(path.getParent());Files.write(path,text.getBytes(StandardCharsets.US_ASCII));}
 public static void main(String[] args)throws Exception{
  Path root=Paths.get(args[0]), mem=root.resolve("meminfo"), block=root.resolve("block");
  var absent=MemoryReader.read(mem.toFile(),block.toFile());
  check(absent.totalBytes==null&&absent.usedBytes==null&&absent.zramLogicalBytes==null);
  String original="MemTotal: 8388608 kB\nMemAvailable: 3145728 kB\nActive: 1048576 kB\nCached: 2097152 kB\nSwapTotal: 8388608 kB\nSwapFree: 6291456 kB\nHugePages_Total: 0\n";
  write(mem,original);
  write(block.resolve("zram0/disksize"),"4294967296\n");
  write(block.resolve("zram0/mm_stat"),"1073741824 200000000 268435456 0 0 0 0 0\n");
  write(block.resolve("zram1/disksize"),"0\n");
  var sample=MemoryReader.read(mem.toFile(),block.toFile());
  check(sample.totalBytes==8589934592L);check(sample.usedBytes==5368709120L);
  check(sample.activeBytes==1073741824L);check(sample.cachedBytes==2147483648L);
  check(sample.swapTotalBytes==8589934592L);check(sample.swapUsedBytes==2147483648L);
  check(sample.zramCapacityBytes==4294967296L);check(sample.zramLogicalBytes==1073741824L);
  check(sample.zramRamBytes==268435456L);check(!sample.swapUsedBytes.equals(sample.zramLogicalBytes));
  check(new String(Files.readAllBytes(mem),StandardCharsets.US_ASCII).equals(original));
  // Exact field names, explicit kB units, bounds and duplicate rejection.
  write(mem,"MemTotal: 10 kB\nMemAvailable: 11 kB\nActive(anon): 2 kB\nCached: 3 MB\nSwapTotal: 0 kB\nSwapFree: 0 kB\n");
  sample=MemoryReader.read(mem.toFile(),block.toFile());
  check(sample.usedBytes==null&&sample.activeBytes==null&&sample.cachedBytes==null);
  check(sample.swapUsedBytes==0L&&sample.swapTotalBytes==0L);
  write(mem,"MemTotal: 10 kB\nMemTotal: 11 kB\nMemAvailable: -1 kB\nCached: 9999999999999999999 kB\nActive: 999999999999999999 kB\n");
  sample=MemoryReader.read(mem.toFile(),block.toFile());
  check(sample.totalBytes==null&&sample.usedBytes==null&&sample.cachedBytes==null&&sample.activeBytes==null);
  write(mem,"MemTotal: bad kB\nMemTotal: 100 kB\n");
  check(MemoryReader.read(mem.toFile(),block.toFile()).totalBytes==null);
  write(mem,new String(new char[65537]).replace('\0','x'));
  check(MemoryReader.read(mem.toFile(),block.toFile()).totalBytes==null);
  // Never label aggregate SwapTotal as ZRAM or invent unavailable compression data.
  write(block.resolve("zram0/mm_stat"),"9999999999 2 3\n");
  check(MemoryReader.read(mem.toFile(),block.toFile()).zramLogicalBytes==null);
  Files.delete(block.resolve("zram0/mm_stat"));
  check(MemoryReader.read(mem.toFile(),block.toFile()).zramCapacityBytes==null);
  write(block.resolve("zram0/mm_stat"),"1024 512 4096\n");
  write(block.resolve("zram1/disksize"),"1048576\n");write(block.resolve("zram1/mm_stat"),"2048 512 4096\n");
  sample=MemoryReader.read(mem.toFile(),block.toFile());
  check(sample.zramLogicalBytes==3072L);check(sample.zramRamBytes==8192L);check(sample.zramCapacityBytes==4296015872L);
  check(BatteryUnits.current(1500000,Locale.US,"N/A").equals("1500.0 mA"));
  check(BatteryUnits.current(-250000,Locale.US,"N/A").equals("-250.0 mA"));
  check(BatteryUnits.current(0,Locale.US,"N/A").equals("0.0 mA"));
  check(BatteryUnits.current(Integer.MIN_VALUE,Locale.US,"N/A").equals("N/A"));
  check(BatteryUnits.current(Integer.MAX_VALUE,Locale.US,"N/A").equals("N/A"));
  check(BatteryUnits.charge(2500000,Locale.US,"N/A").equals("2500.0 mAh"));
  check(BatteryUnits.charge(-1,Locale.US,"N/A").equals("N/A"));
  check(BatteryUnits.charge(Integer.MIN_VALUE,Locale.US,"N/A").equals("N/A"));
  check(BatteryUnits.charge(Integer.MAX_VALUE,Locale.US,"N/A").equals("N/A"));
  System.out.println(checks+" memory, ZRAM and battery-unit checks passed");
 }
}'''


class ResourceTests(unittest.TestCase):
    def test_real_memory_reader_zram_separation_and_battery_units(self):
        suffix = '.exe' if os.name == 'nt' else ''
        home = os.environ.get('JAVA_HOME')
        javac = str(Path(home) / ('bin/javac' + suffix)) if home else shutil.which('javac')
        java = str(Path(home) / ('bin/java' + suffix)) if home else shutil.which('java')
        if not java or not javac:
            self.skipTest('A complete JDK is required')
        with tempfile.TemporaryDirectory() as directory:
            out = Path(directory)
            contract = out / 'ResourcesContract.java'
            contract.write_text(CONTRACT, encoding='utf-8')
            base = SETTINGS / 'monitor/src/com/gmhub/monitor'
            compiled = subprocess.run([javac, '-encoding', 'UTF-8', '-d', str(out), str(base / 'MemoryReader.java'), str(base / 'BatteryUnits.java'), str(contract)], capture_output=True, text=True, timeout=45)
            self.assertEqual(compiled.returncode, 0, compiled.stderr)
            result = subprocess.run([java, '-Xverify:all', '-cp', str(out), 'ResourcesContract', str(out / 'fixtures')], capture_output=True, text=True, timeout=30)
            self.assertEqual(result.returncode, 0, result.stdout + result.stderr)

    def test_native_pages_generated_code_and_translations(self):
        spec = importlib.util.spec_from_file_location('monitor_verify', SETTINGS / 'monitor/verify.py')
        verifier = importlib.util.module_from_spec(spec)
        spec.loader.exec_module(verifier)
        verifier.verify(SETTINGS)
        a = '{http://schemas.android.com/apk/res/android}'
        for name, xml, keys in [('Memory', 'paradox_memory_preferences', {'ram_monitor','active_monitor','cached_monitor','zram_monitor','gm_swap_monitor'}),
                                ('Battery', 'paradox_battery_preferences', {'bat_current','bat_capacity','bat_cycles','bat_health'})]:
            fragment = SETTINGS / f'SecSettings.apk/smali_classes4/com/paradox/hub/Paradox{name}Fragment.smali'
            text = fragment.read_text()
            self.assertNotIn('->postDelayed(', text)
            self.assertIn('ResourceController;->close', text)
            self.assertFalse(fragment.with_name(f'Paradox{name}Fragment$UpdateTask.smali').exists())
            nodes = list(ET.parse(SETTINGS / f'SecSettings.apk/res/xml/{xml}.xml').getroot())
            self.assertEqual({n.get(a+'key') for n in nodes}, keys)
            self.assertTrue(all(n.get(a+'selectable') == 'false' for n in nodes))
        translated = []
        for folder in ['values','values-pt-rBR']:
            translated.append({n.get('name') for n in ET.parse(SETTINGS / f'SecSettings.apk/res/{folder}/gm_resource_strings.xml').getroot()})
        self.assertEqual(translated[0], translated[1])
