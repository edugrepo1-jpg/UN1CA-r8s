"""Run the app-state engine itself, including native-error and restore isolation cases."""
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
import com.gmhub.apps.AppStateEngine;
public class AppStateContract {
 static int checks;
 static void check(boolean value){checks++;if(!value)throw new AssertionError("check "+checks);}
 interface Action{void run()throws Exception;}
 static void fails(Action action)throws Exception{
  try{action.run();throw new AssertionError("Expected failure");}catch(AssertionError e){throw e;}catch(Exception expected){checks++;}
 }
 static class Native implements AppStateEngine.Access{
  Map<String,Integer> states=new HashMap<>(); boolean allowed=true,ignore,throwBefore,throwAfter,unreadable;
  Saved saved; int writes;
  public int read(String p)throws Exception{if(unreadable)throw new Exception("unreadable");return states.get(p);}
  public boolean canDisable(String p){return allowed;}
  public void write(String p,int value)throws Exception{
   check(saved.entries.containsKey(p)); // Durable intent must exist BEFORE native mutation.
   writes++; if(throwBefore)throw new Exception("Permission denied");
   if(!ignore)states.put(p,value);
   if(throwAfter)throw new Exception("Binder failed after mutation");
  }
 }
 static class Saved implements AppStateEngine.Journal{
  Map<String,AppStateEngine.Record> entries=new TreeMap<>();boolean failPut;
  public AppStateEngine.Record get(String p){return entries.get(p);}
  public void put(String p,AppStateEngine.Record r)throws Exception{if(failPut)throw new Exception("Disk full");entries.put(p,r);}
  public void remove(String p){entries.remove(p);}
  public Set<String> keys(){return new TreeSet<>(entries.keySet());}
 }
 static class Pair{
  Native os=new Native();Saved saved=new Saved();AppStateEngine engine=new AppStateEngine(os,saved);
  Pair(int state){os.saved=saved;os.states.put("com.example.app",state);}
 }
 public static void main(String[] args)throws Exception{
  String pkg="com.example.app";
  for(int initial=0;initial<=4;initial++)for(boolean enabled:new boolean[]{false,true}){
   Pair p=new Pair(initial);int target=enabled?1:3;
   check(p.engine.change(pkg,enabled)==(initial!=target));
   check(p.os.states.get(pkg)==target);
   if(initial==target){check(p.saved.keys().isEmpty());check(p.os.writes==0);}
   else{check(p.saved.get(pkg).original==initial);check(p.engine.restore(pkg));check(p.os.states.get(pkg)==initial);check(p.saved.keys().isEmpty());}
  }
  Pair p=new Pair(0);
  p.engine.change(pkg,false);p.engine.change(pkg,true);
  check(p.saved.get(pkg).original==0);p.engine.restore(pkg);check(p.os.states.get(pkg)==0);
  // Never enable unrelated apps which were already disabled before opening the Hub.
  p.os.states.put("com.other.disabled",3);check(!p.engine.restore("com.other.disabled"));
  check(p.os.states.get("com.other.disabled")==3);
  Pair denied=new Pair(0);denied.os.allowed=false;
  fails(()->denied.engine.change(pkg,false));check(denied.os.writes==0);check(denied.saved.keys().isEmpty());
  // Protected app may be explicitly enabled, but cannot be disabled by restore.
  Pair protectedRestore=new Pair(3);protectedRestore.engine.change(pkg,true);protectedRestore.os.allowed=false;
  fails(()->protectedRestore.engine.restore(pkg));check(protectedRestore.os.states.get(pkg)==1);
  Pair disk=new Pair(0);disk.saved.failPut=true;
  fails(()->disk.engine.change(pkg,false));check(disk.os.writes==0);check(disk.os.states.get(pkg)==0);
  Pair binder=new Pair(0);binder.os.throwBefore=true;
  fails(()->binder.engine.change(pkg,false));check(binder.saved.keys().isEmpty());check(binder.os.states.get(pkg)==0);
  Pair silent=new Pair(0);silent.os.ignore=true;
  fails(()->silent.engine.change(pkg,false));check(silent.saved.keys().isEmpty());check(silent.os.states.get(pkg)==0);
  Pair after=new Pair(0);after.os.throwAfter=true;
  check(after.engine.change(pkg,false));check(after.os.states.get(pkg)==3);check(after.saved.get(pkg).original==0);
  Pair external=new Pair(0);external.engine.change(pkg,false);external.os.states.put(pkg,2);
  fails(()->external.engine.restore(pkg));check(external.os.states.get(pkg)==2);check(external.saved.get(pkg)!=null);
  external.engine.change(pkg,true);check(external.saved.get(pkg).original==2);
  external.engine.restore(pkg);check(external.os.states.get(pkg)==2);
  // Crash after journaling but before native mutation is safe to restore.
  Pair pending=new Pair(0);pending.saved.put(pkg,new AppStateEngine.Record(0,3));
  check(!pending.engine.restore(pkg));check(pending.os.writes==0);check(pending.saved.keys().isEmpty());
  Pair old=new Pair(0);old.engine.change(pkg,false);old.os.throwBefore=true;
  fails(()->old.engine.change(pkg,true));check(old.saved.get(pkg).encode().equals("0:3"));
  old.os.throwBefore=false;old.engine.restore(pkg);check(old.os.states.get(pkg)==0);
  Pair unconfirmed=new Pair(0);unconfirmed.engine.change(pkg,false);unconfirmed.os.ignore=true;
  fails(()->unconfirmed.engine.restore(pkg));check(unconfirmed.saved.get(pkg)!=null);
  // Two user-scoped journals cannot restore each other's app states.
  Pair userA=new Pair(0),userB=new Pair(3);userA.engine.change(pkg,false);
  check(!userB.engine.restore(pkg));check(userB.os.states.get(pkg)==3);
  for(int a=0;a<=4;a++)for(int b=0;b<=4;b++){
   var r=AppStateEngine.Record.decode(new AppStateEngine.Record(a,b).encode());check(r.original==a&&r.applied==b);
  }
  for(String bad:new String[]{"", "0", "-1:3", "5:3", "0:5", "0:3:1", "00:3"})fails(()->AppStateEngine.Record.decode(bad));
  for(String bad:new String[]{"", "com.app;reboot", "com.app x", "../x", "com..app", "0app", "com.app\n"})fails(()->AppStateEngine.packageName(bad));
  System.out.println(checks+" native-state and restore-isolation checks passed");
 }
}'''


class AppManagerTests(unittest.TestCase):
    def test_actual_state_engine_failures_readback_and_restore_isolation(self):
        suffix = '.exe' if os.name == 'nt' else ''
        home = os.environ.get('JAVA_HOME')
        javac = str(Path(home) / ('bin/javac' + suffix)) if home else shutil.which('javac')
        java = str(Path(home) / ('bin/java' + suffix)) if home else shutil.which('java')
        if not java or not javac:
            self.skipTest('A complete JDK is required')
        with tempfile.TemporaryDirectory() as directory:
            out = Path(directory)
            contract = out / 'AppStateContract.java'
            contract.write_text(CONTRACT, encoding='utf-8')
            source = SETTINGS / 'apps/src/com/gmhub/apps/AppStateEngine.java'
            compiled = subprocess.run([javac, '-encoding', 'UTF-8', '-d', str(out), str(source), str(contract)], capture_output=True, text=True, timeout=45)
            self.assertEqual(compiled.returncode, 0, compiled.stderr)
            result = subprocess.run([java, '-Xverify:all', '-cp', str(out), 'AppStateContract'], capture_output=True, text=True, timeout=30)
            self.assertEqual(result.returncode, 0, result.stdout + result.stderr)

    def test_shipped_code_manifest_navigation_and_translations(self):
        spec = importlib.util.spec_from_file_location('apps_verify', SETTINGS / 'apps/verify.py')
        verifier = importlib.util.module_from_spec(spec)
        spec.loader.exec_module(verifier)
        verifier.verify(SETTINGS)
        android = '{http://schemas.android.com/apk/res/android}'
        screen = ET.parse(SETTINGS / 'SecSettings.apk/res/xml/unica_top_settings.xml')
        self.assertEqual(len([n for n in screen.getroot().iter() if n.get(android + 'fragment') == 'com.paradox.hub.ParadoxAppManagerFragment']), 1)
        resources = []
        for folder in ['values', 'values-pt-rBR']:
            tree = ET.parse(SETTINGS / f'SecSettings.apk/res/{folder}/gm_apps_strings.xml')
            resources.append({n.get('name') for n in tree.getroot()})
        self.assertEqual(resources[0], resources[1])
        bridge = (SETTINGS / 'SecSettings.apk/smali_classes4/com/paradox/hub/ParadoxAppManagerFragment.smali').read_text()
        self.assertNotIn('Ljava/lang/Runtime;', bridge)
        self.assertFalse(list((SETTINGS / 'SecSettings.apk/smali_classes4/com/paradox/hub').glob('ParadoxAppManagerFragment$*.smali')))
        self.assertIn('python3 "$MODPATH/apps/verify.py" || return 1', (SETTINGS / 'customize.sh').read_text())
