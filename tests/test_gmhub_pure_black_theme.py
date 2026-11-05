"""System theme policy, exact callback shape and durable transaction contracts."""
from pathlib import Path
import importlib.util
import os
import shutil
import subprocess
import tempfile
import unittest

ROOT=Path(__file__).resolve().parents[1]
MODULE=ROOT/'unica/mods/settings/pureblack'
spec=importlib.util.spec_from_file_location('theme_install',MODULE/'install.py')
installer=importlib.util.module_from_spec(spec);spec.loader.exec_module(installer)

STUBS={
'android/content/ContentResolver.java':'package android.content;public class ContentResolver{}',
'android/content/Context.java':'package android.content;public class Context{public ContentResolver getContentResolver(){return new ContentResolver();}}',
'android/content/res/Resources.java':'''package android.content.res;import java.util.*;public class Resources{public Set<String> names=new HashSet<>();public int getIdentifier(String n,String t,String p){return names.contains(n)?1:0;}}''',
'android/util/Log.java':'package android.util;public class Log{public static int w(String a,String b,Throwable c){return 0;}}',
'android/provider/Settings.java':'''package android.provider;import android.content.ContentResolver;public class Settings{public static class Secure{public static java.util.Map<Integer,Integer> values=new java.util.HashMap<>();public static int getIntForUser(ContentResolver r,String k,int fallback,int user){return values.getOrDefault(user,fallback);}}}''',
'android/app/AppGlobals.java':'package android.app;public class AppGlobals{public static android.content.Context getInitialApplication(){return new android.content.Context();}}',
'android/os/UserHandle.java':'package android.os;public class UserHandle{public int id;private UserHandle(int u){id=u;}public static UserHandle of(int u){return new UserHandle(u);}}',
'android/content/om/OverlayIdentifier.java':'package android.content.om;public class OverlayIdentifier{public String owner,name;public OverlayIdentifier(String o,String n){owner=o;name=n;}}'
}
CONTRACT=r'''import com.gmhub.theme.PureBlackPolicy;import com.gmhub.profiles.ProfileEngine;import java.util.*;
public class ThemeContract{
 static int checks;static void check(boolean v){checks++;if(!v)throw new AssertionError("check "+checks);}
 public static class Info{public boolean isEnabled(){return true;}}
 public static class Manager{public Object getOverlayInfo(android.content.om.OverlayIdentifier id,android.os.UserHandle user)throws Exception{
  check(id.owner.equals("com.android.settings"));check(id.name.equals(PureBlackPolicy.name("android",user.id)));return new Info();}}
 public static class Builder{int writes,user;boolean enabled;public Builder setEnabled(android.content.om.OverlayIdentifier id,boolean on,int uid){writes++;user=uid;enabled=on;return this;}}
 static class State implements ProfileEngine.Store{ProfileEngine.State value=ProfileEngine.State.empty();int writes;public ProfileEngine.State load(){return value;}public void save(ProfileEngine.State v){writes++;value=v;}}
 static class Access implements ProfileEngine.Access{State journal;Map<String,String> values=new LinkedHashMap<>();String reject,ignore;int writes;
  public String read(String k){return values.get(k);}public void write(String k,String v){check(journal.value.pending);writes++;if(k.equals(reject))throw new IllegalStateException("denied");if(!k.equals(ignore))values.put(k,v);}}
 static LinkedHashMap<String,String> plan(){LinkedHashMap<String,String> map=new LinkedHashMap<>();map.put("overlay:android","1");map.put("overlay:com.android.settings","1");map.put("overlay:com.android.systemui","1");map.put("night","2");map.put("enabled","1");return map;}
 public static void main(String[]args)throws Exception{
  android.content.res.Resources r=new android.content.res.Resources();r.names.add("system_surface_dark");r.names.add("basic_token_sys_surface_container_dark");
  r.names.add("system_on_surface_dark");r.names.add("basic_token_sys_surface_fixed_dark");r.names.add("basic_token_gray_100");r.names.add("system_error_dark");
  check(PureBlackPolicy.roles(r,"android").equals(Arrays.asList("system_surface_dark","basic_token_sys_surface_container_dark")));
  Set<String> roles=new HashSet<>();for(String role:PureBlackPolicy.ROLES){check(roles.add(role));check(!role.contains("fixed"));check(!role.contains("on_surface"));check(!role.contains("on_background"));check(!role.contains("accent"));}
  check(PureBlackPolicy.name("com.test",0).matches("[a-zA-Z0-9_.]+"));check(!PureBlackPolicy.name("com.test",0).equals(PureBlackPolicy.name("com.test",10)));
  check(!PureBlackPolicy.name("com.a_b",0).equals(PureBlackPolicy.name("com.a.b",0)));
  Builder b=new Builder();android.provider.Settings.Secure.values.put(10,1);PureBlackPolicy.append(new Manager(),b,0);check(b.writes==0);
  PureBlackPolicy.append(new Manager(),b,10);check(b.writes==1&&b.user==10&&b.enabled);
  android.provider.Settings.Secure.values.put(10,0);PureBlackPolicy.append(new Manager(),b,10);check(b.writes==1);
  for(String fault:plan().keySet())for(boolean ignored:new boolean[]{false,true}){
   State saved=new State();Access access=new Access();access.journal=saved;access.values.put("night","0");
   Map<String,String> before=new HashMap<>();for(String key:plan().keySet())before.put(key,access.read(key));
   if(ignored)access.ignore=fault;else access.reject=fault;
   ProfileEngine engine=new ProfileEngine(access,saved);boolean failed=false;
   try{engine.apply("pure_black",plan());}catch(Exception expected){failed=true;}
   check(failed);for(String key:before.keySet())check(Objects.equals(before.get(key),access.read(key)));
   check(engine.status().equals("stock"));
  }
  State saved=new State();Access access=new Access();access.journal=saved;access.values.put("night","3");ProfileEngine engine=new ProfileEngine(access,saved);
  engine.apply("pure_black",plan());check(engine.status().equals("pure_black"));check(access.read("night").equals("2"));
  access.values.put("night","1"); // A separate user change must survive restore.
  ProfileEngine.RestoreResult restored=engine.restore();check(restored.conflicts==1);check(access.read("night").equals("1"));check(access.read("enabled")==null);check(engine.status().equals("stock"));
  System.out.println(checks+" real system-theme policy/transaction checks passed");
 }
}'''

def callback():
 return ('.class public final '+installer.OWNER+'\n.super Ljava/lang/Object;\n'
         +'.method public final run()V\n    .locals 13\n'+installer.USER+'\n'
         +'    iget-object v2, v0, Lcom/android/systemui/theme/ThemeOverlayApplier;->mOverlayManager:Landroid/content/om/OverlayManager;\n'
         +installer.BUILD+'\n    return-void\n.end method\n')

class ThemeTests(unittest.TestCase):
 def test_exact_theme_callback_is_idempotent_and_preserves_native_commit(self):
  patched=installer.patch(callback());self.assertEqual(installer.patch(patched),patched)
  self.assertEqual(patched.count(installer.HOOK),1);self.assertIn('move v13, v4',patched)
  self.assertLess(patched.index(installer.HOOK),patched.index(installer.BUILD))
  for bad in [callback().replace('.locals 13','.locals 14'),callback().replace('f$3:I','f$3:J'),callback().replace(installer.BUILD,'return-void')]:
   with self.assertRaises((ValueError,IndexError)):installer.patch(bad)
 def test_compiled_theme_matches_sources_and_transaction_dependency(self):
  spec=importlib.util.spec_from_file_location('theme_verify',MODULE/'verify.py');m=importlib.util.module_from_spec(spec);spec.loader.exec_module(m);m.verify(MODULE.parent)
 def test_actual_policy_and_transaction_engine(self):
  suffix='.exe' if os.name=='nt' else '';home=os.environ.get('JAVA_HOME')
  javac=str(Path(home)/('bin/javac'+suffix)) if home else shutil.which('javac');java=str(Path(home)/('bin/java'+suffix)) if home else shutil.which('java')
  if not javac or not java:self.skipTest('A complete JDK is required')
  with tempfile.TemporaryDirectory() as directory:
   out=Path(directory);sources=[]
   for relative,content in STUBS.items():
    path=out/relative;path.parent.mkdir(parents=True,exist_ok=True);path.write_text(content,encoding='utf8');sources.append(path)
   path=out/'ThemeContract.java';path.write_text(CONTRACT,encoding='utf8');sources.append(path)
   sources.extend([MODULE/'src/com/gmhub/theme/PureBlackPolicy.java',MODULE.parent/'profiles/src/com/gmhub/profiles/ProfileEngine.java'])
   result=subprocess.run([javac,'-encoding','UTF-8','-d',str(out/'classes'),*map(str,sources)],capture_output=True,text=True,timeout=45);self.assertEqual(result.returncode,0,result.stderr)
   result=subprocess.run([java,'-Xverify:all','-cp',str(out/'classes'),'ThemeContract'],capture_output=True,text=True,timeout=30);self.assertEqual(result.returncode,0,result.stdout+result.stderr)
   self.assertIn('system-theme policy/transaction checks passed',result.stdout)

if __name__=='__main__':unittest.main()
