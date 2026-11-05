"""Run the real profile engine against faulting native settings and journal stores."""
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
CONTRACT = r'''import java.util.*;
import com.gmhub.profiles.ProfileEngine;
public class ProfileContract {
 static int checks;
 static void check(boolean value){checks++;if(!value)throw new AssertionError("check "+checks);}
 interface Action{void run()throws Exception;}
 static void fails(Action action)throws Exception{
  try{action.run();throw new AssertionError("Expected failure");}catch(AssertionError e){throw e;}catch(Exception expected){checks++;}
 }
 static class Saved implements ProfileEngine.Store{
  ProfileEngine.State state=ProfileEngine.State.empty(); int failSave=-1,saves;
  public ProfileEngine.State load(){return state;}
  public void save(ProfileEngine.State value)throws Exception{
   if(++saves==failSave)throw new Exception("Disk full");state=value;
  }
 }
 static class Native implements ProfileEngine.Access{
  Map<String,String> data=new LinkedHashMap<>();Saved saved;String failKey,ignoreKey;
  boolean failRollback,throwAfter;int writes;
  public String read(String key){return data.get(key);}
  public void write(String key,String value)throws Exception{
   check(saved.state.pending);check(saved.state.entries.containsKey(key));writes++;
   if(key.equals(failKey))throw new Exception("Native service refused");
   if(failRollback&&"a".equals(key)&&"base-a".equals(value))throw new Exception("Rollback refused");
   if(!key.equals(ignoreKey))data.put(key,value);
   if(throwAfter)throw new Exception("Binder died after mutation");
  }
 }
 static class Pair{
  Saved saved=new Saved();Native os=new Native();ProfileEngine engine=new ProfileEngine(os,saved);
  Pair(){os.saved=saved;os.data.put("a","base-a");os.data.put("b",null);os.data.put("c","base-c");}
 }
 static Map<String,String> plan(String...pairs){Map<String,String> result=new LinkedHashMap<>();for(int i=0;i<pairs.length;i+=2)result.put(pairs[i],pairs[i+1]);return result;}
 public static void main(String[] args)throws Exception{
  Pair clean=new Pair();check(clean.engine.status().equals("stock"));check(clean.os.writes==0);check(clean.saved.saves==0);
  clean.engine.apply("smooth",plan("a","new-a","b","new-b"));
  check(clean.engine.status().equals("smooth"));check(!clean.saved.state.pending);
  check(clean.saved.state.entries.get("b").original==null);
  var result=clean.engine.restore();check(result.changed==2&&result.conflicts==0);
  check(clean.os.data.get("a").equals("base-a"));check(clean.os.data.get("b")==null);check(clean.engine.status().equals("stock"));
  // Failure at every position must undo earlier confirmed settings and preserve the baseline.
  for(String fail:new String[]{"a","b","c"}){
   Pair p=new Pair();p.os.failKey=fail;
   fails(()->p.engine.apply("gaming",plan("a","new-a","b","new-b","c","new-c")));
   check(p.os.data.get("a").equals("base-a"));check(p.os.data.get("b")==null);
   check(p.os.data.get("c").equals("base-c"));check(p.engine.status().equals("stock"));
  }
  Pair disk=new Pair();disk.saved.failSave=1;
  fails(()->disk.engine.apply("smooth",plan("a","new-a")));check(disk.os.writes==0);
  Pair finalDisk=new Pair();finalDisk.saved.failSave=2;
  fails(()->finalDisk.engine.apply("smooth",plan("a","new-a")));
  check(finalDisk.os.data.get("a").equals("base-a"));check(finalDisk.engine.status().equals("stock"));
  Pair ignored=new Pair();ignored.os.ignoreKey="b";
  fails(()->ignored.engine.apply("smooth",plan("a","new-a","b","new-b")));
  check(ignored.os.data.get("a").equals("base-a"));check(ignored.engine.status().equals("stock"));
  Pair after=new Pair();after.os.throwAfter=true;
  after.engine.apply("smooth",plan("a","new-a"));check(after.engine.status().equals("smooth"));
  // Recover a partial transaction; no new profile may overwrite its recovery record.
  Pair pending=new Pair();pending.os.failKey="b";pending.os.failRollback=true;
  fails(()->pending.engine.apply("gaming",plan("a","new-a","b","new-b")));
  check(pending.engine.status().equals("pending"));
  fails(()->pending.engine.apply("battery",plan("c","new-c")));
  pending.os.failKey=null;pending.os.failRollback=false;
  check(pending.engine.restore().conflicts==0);check(pending.os.data.get("a").equals("base-a"));
  // Simulated process death immediately after the durable intent, before native writes.
  Pair crash=new Pair();Map<String,ProfileEngine.Entry> recovery=new LinkedHashMap<>();
  recovery.put("a",new ProfileEngine.Entry("base-a","new-a",Arrays.asList("base-a","new-a")));
  crash.saved.state=new ProfileEngine.State("smooth",true,recovery);
  check(crash.engine.restore().changed==0);check(crash.os.writes==0);check(crash.engine.status().equals("stock"));
  // Switching from Battery must restore AOD/timeout-like fields omitted by Gaming.
  Pair switched=new Pair();switched.engine.apply("battery",plan("a","battery-a","b","battery-b"));
  switched.engine.apply("gaming",plan("a","gaming-a","c","gaming-c"));
  check(switched.os.data.get("b")==null);check(!switched.saved.state.entries.containsKey("b"));
  check(switched.saved.state.entries.get("a").original.equals("base-a"));
  check(switched.engine.restore().conflicts==0);check(switched.os.data.get("a").equals("base-a"));
  Pair outside=new Pair();outside.engine.apply("smooth",plan("a","new-a","b","new-b"));
  outside.os.data.put("a","user-choice");check(outside.engine.status().equals("custom"));
  result=outside.engine.restore();check(result.conflicts==1);check(outside.os.data.get("a").equals("user-choice"));
  check(outside.os.data.get("b")==null);check(outside.saved.state.entries.isEmpty());check(!outside.saved.state.pending);
  check(result.failed==0);outside.engine.apply("gaming",plan("a","gaming-a"));
  check(outside.saved.state.entries.get("a").original.equals("user-choice"));
  Pair failedRestore=new Pair();failedRestore.engine.apply("smooth",plan("a","new-a"));failedRestore.os.failRollback=true;
  result=failedRestore.engine.restore();check(result.failed==1);check(failedRestore.saved.state.pending);
  check(failedRestore.saved.state.entries.containsKey("a"));
  // A fresh explicit selection can establish a new baseline for a manually changed field.
  Pair reselected=new Pair();reselected.engine.apply("smooth",plan("a","new-a","b","new-b"));
  reselected.os.data.put("a","user-choice");reselected.os.data.put("b","external-b");
  reselected.engine.apply("gaming",plan("a","gaming-a"));
  check(reselected.os.data.get("b").equals("external-b"));check(!reselected.saved.state.entries.containsKey("b"));
  reselected.engine.restore();check(reselected.os.data.get("a").equals("user-choice"));
  // Immutable snapshots cannot be accidentally edited after saving intent.
  Pair immutable=new Pair();immutable.engine.apply("smooth",plan("a","new-a"));
  try{immutable.saved.state.entries.clear();throw new AssertionError();}catch(UnsupportedOperationException expected){checks++;}
  try{immutable.saved.state.entries.get("a").owned.clear();throw new AssertionError();}catch(UnsupportedOperationException expected){checks++;}
  fails(()->immutable.engine.apply("bogus",plan("b","x")));
  System.out.println(checks+" transaction, rollback and ownership checks passed");
 }
}'''


class ProfileTests(unittest.TestCase):
    def test_real_engine_transaction_failures_and_restore_ownership(self):
        suffix = '.exe' if os.name == 'nt' else ''
        home = os.environ.get('JAVA_HOME')
        javac = str(Path(home) / ('bin/javac' + suffix)) if home else shutil.which('javac')
        java = str(Path(home) / ('bin/java' + suffix)) if home else shutil.which('java')
        if not java or not javac:
            self.skipTest('A complete JDK is required')
        with tempfile.TemporaryDirectory() as directory:
            out = Path(directory)
            contract = out / 'ProfileContract.java'
            contract.write_text(CONTRACT, encoding='utf-8')
            compiled = subprocess.run([javac, '-encoding', 'UTF-8', '-d', str(out), str(SETTINGS / 'profiles/src/com/gmhub/profiles/ProfileEngine.java'), str(contract)], capture_output=True, text=True, timeout=45)
            self.assertEqual(compiled.returncode, 0, compiled.stderr)
            result = subprocess.run([java, '-Xverify:all', '-cp', str(out), 'ProfileContract'], capture_output=True, text=True, timeout=30)
            self.assertEqual(result.returncode, 0, result.stdout + result.stderr)

    def test_shipped_code_and_native_preferences_are_consistent(self):
        spec = importlib.util.spec_from_file_location('profiles_verify', SETTINGS / 'profiles/verify.py')
        verifier = importlib.util.module_from_spec(spec)
        spec.loader.exec_module(verifier)
        verifier.verify(SETTINGS)
        for folder in ['values', 'values-pt-rBR']:
            ET.parse(SETTINGS / f'SecSettings.apk/res/{folder}/gm_profiles_strings.xml')
        fragment = (SETTINGS / 'SecSettings.apk/smali_classes4/com/paradox/hub/ParadoxCoreModesFragment.smali').read_text()
        self.assertNotIn('->putGlobal(', fragment)
        self.assertIn('ProfileController;->select', fragment)
        self.assertIn('ProfileController;->close', fragment)
        self.assertIn('.method public static getModeLabel(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;', fragment)
        self.assertIn('python3 "$MODPATH/profiles/verify.py" || return 1', (SETTINGS / 'customize.sh').read_text())
