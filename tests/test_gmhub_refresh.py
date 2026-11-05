"""Execute the actual writer against narrow native-service fixtures, not a display emulator."""
from pathlib import Path
import importlib.util
import os
import shutil
import subprocess
import tempfile
import unittest

ROOT = Path(__file__).resolve().parents[1]
SETTINGS = ROOT / 'unica/mods/settings'
STUBS = {
'android/content/ContentResolver.java': 'package android.content;public class ContentResolver {}',
'android/content/Context.java': '''package android.content;
public class Context {
 public final android.hardware.display.DisplayManager display=new android.hardware.display.DisplayManager();
 public <T>T getSystemService(Class<T> type){return type.cast(display);}
 public ContentResolver getContentResolver(){return new ContentResolver();}
 public android.content.res.Resources getResources(){return new android.content.res.Resources();}
 public String getPackageName(){return "com.android.settings";}
 public String getString(int id){return "message";}
}''',
'android/content/res/Resources.java': 'package android.content.res;public class Resources{public int getIdentifier(String a,String b,String c){return 0;}}',
'android/hardware/display/DisplayManager.java': '''package android.hardware.display;
public class DisplayManager{public android.view.Display display=new android.view.Display();public android.view.Display getDisplay(int id){return display;}}''',
'android/view/Display.java': '''package android.view;
public class Display {
 public static final int DEFAULT_DISPLAY=0;public Mode[] modes;public Mode current;
 public Mode getMode(){return current;}public Mode[] getSupportedModes(){return modes;}
 public static class Mode {int w,h;float r;public Mode(int w,int h,float r){this.w=w;this.h=h;this.r=r;}
  public int getPhysicalWidth(){return w;}public int getPhysicalHeight(){return h;}public float getRefreshRate(){return r;}}
}''',
'android/util/Log.java': 'package android.util;public class Log{public static int w(String a,String b,Throwable t){return 0;}}',
'android/widget/Toast.java': 'package android.widget;public class Toast{public static int LENGTH_LONG=1;public static Toast makeText(android.content.Context c,String v,int d){return new Toast();}public void show(){}}',
'android/provider/Settings.java': '''package android.provider;
import android.content.ContentResolver;import java.util.*;
public class Settings{
 public static Map<String,String> values=new LinkedHashMap<>();public static int writes,failAt,ignoreAt,throwAfterAt;
 static boolean put(String k,String v){writes++;if(writes==failAt)return false;if(writes==ignoreAt)return true;
  if(v==null)values.remove(k);else values.put(k,v);if(writes==throwAfterAt)throw new SecurityException("after write");return true;}
 public static class System{public static String getString(ContentResolver r,String k){return values.get("s:"+k);}public static boolean putString(ContentResolver r,String k,String v){return put("s:"+k,v);}}
 public static class Secure{public static String getString(ContentResolver r,String k){return values.get("c:"+k);}public static boolean putString(ContentResolver r,String k,String v){return put("c:"+k,v);}}
}'''
}
CONTRACT = r'''import android.content.Context;import android.view.Display;import android.provider.Settings;
import com.gmhub.refresh.RefreshSettings;import java.util.*;
public class RefreshContract{
 static int checks;static void check(boolean v){checks++;if(!v)throw new AssertionError("check "+checks);}
 static Context context(float...rates){Context c=new Context();c.display.display.current=new Display.Mode(1080,2400,60);
  c.display.display.modes=new Display.Mode[rates.length];for(int i=0;i<rates.length;i++)c.display.display.modes[i]=new Display.Mode(1080,2400,rates[i]);return c;}
 static void reset(){Settings.values.clear();Settings.writes=Settings.failAt=Settings.ignoreAt=Settings.throwAfterAt=0;}
 static String min(){return Settings.values.get("s:min_refresh_rate");}static String max(){return Settings.values.get("s:peak_refresh_rate");}
 public static void main(String[]args){
  Context c=context(60,95.999f,120);reset();
  check(RefreshSettings.value(c,true).equals("60"));check(RefreshSettings.value(c,false).equals("120"));check(Settings.writes==0);
  check(RefreshSettings.applySingle(c,"min_refresh_rate","96"));check(min().equals("96.0"));check(max().equals("120.0"));
  check(Settings.values.get("c:refresh_rate_mode").equals("1"));
  check(RefreshSettings.applySingle(c,"max_refresh_rate","60"));check(min().equals("60.0"));check(max().equals("60.0"));
  check(RefreshSettings.applySingle(c,"min_refresh_rate","96"));check(min().equals("96.0")&&max().equals("96.0"));
  check(RefreshSettings.reset(c));check(min().equals("60.0")&&max().equals("120.0"));
  Context other=context(60,120);reset();check(!RefreshSettings.applySingle(other,"min_refresh_rate","96"));check(Settings.writes==0);
  // Display changes since the menu was opened must invalidate a stale 96-Hz selection.
  c.display.display.modes=other.display.display.modes;check(!RefreshSettings.applySingle(c,"max_refresh_rate","96"));check(Settings.writes==0);
  c=context(60,96,120);c.display.display.modes=new Display.Mode[]{new Display.Mode(1080,2400,60),new Display.Mode(1080,2400,120),new Display.Mode(720,1600,96)};
  check(!RefreshSettings.applySingle(c,"max_refresh_rate","96"));check(Settings.writes==0);
  c=context(60,96,120);check(!RefreshSettings.applySingle(c,"arbitrary_key","96"));check(!RefreshSettings.applySingle(c,"min_refresh_rate","NaN"));
  check(!RefreshSettings.applySingle(c,"min_refresh_rate","Infinity"));check(!RefreshSettings.applySingle(c,"min_refresh_rate","-1"));check(Settings.writes==0);
  // Return-value and readback failures at every write position restore all original fields.
  for(int position=1;position<=3;position++)for(boolean ignored:new boolean[]{false,true}){
   reset();Settings.values.put("s:min_refresh_rate","60");Settings.values.put("s:peak_refresh_rate","120");Settings.values.put("c:refresh_rate_mode","0");
   Map<String,String> before=new LinkedHashMap<>(Settings.values);
   if(ignored)Settings.ignoreAt=position;else Settings.failAt=position;
   check(!RefreshSettings.applySingle(c,"max_refresh_rate","96"));check(Settings.values.equals(before));
  }
  reset();Settings.throwAfterAt=2;check(!RefreshSettings.applySingle(c,"max_refresh_rate","96"));check(Settings.values.isEmpty());
  reset();check(RefreshSettings.reset(context(60)));check(min().equals("60.0")&&max().equals("60.0"));
  reset();Context gone=context(60,120);gone.display.display=null;check(!RefreshSettings.reset(gone));check(Settings.writes==0);
  reset();Context invalid=context(Float.NaN,Float.POSITIVE_INFINITY);check(!RefreshSettings.reset(invalid));check(Settings.writes==0);
  java.lang.System.out.println(checks+" real writer mode-selection and rollback checks passed");
 }
}'''


class RefreshTests(unittest.TestCase):
    def test_actual_writer_handles_native_modes_stale_choices_and_partial_writes(self):
        suffix = '.exe' if os.name == 'nt' else ''
        home = os.environ.get('JAVA_HOME')
        javac = str(Path(home) / ('bin/javac' + suffix)) if home else shutil.which('javac')
        java = str(Path(home) / ('bin/java' + suffix)) if home else shutil.which('java')
        if not java or not javac:
            self.skipTest('A complete JDK is required')
        with tempfile.TemporaryDirectory() as directory:
            out=Path(directory); sources=[]
            for relative, content in STUBS.items():
                path=out/relative;path.parent.mkdir(parents=True,exist_ok=True);path.write_text(content,encoding='utf-8');sources.append(path)
            path=out/'RefreshContract.java';path.write_text(CONTRACT,encoding='utf-8');sources.append(path)
            sources.append(SETTINGS/'refresh/src/com/gmhub/refresh/RefreshSettings.java')
            compiled=subprocess.run([javac,'-encoding','UTF-8','-d',str(out/'classes'),*map(str,sources)],capture_output=True,text=True,timeout=45)
            self.assertEqual(compiled.returncode,0,compiled.stderr)
            result=subprocess.run([java,'-Xverify:all','-cp',str(out/'classes'),'RefreshContract'],capture_output=True,text=True,timeout=30)
            self.assertEqual(result.returncode,0,result.stdout+result.stderr)

    def test_packaged_writer_and_existing_dynamic_native_lists_are_wired(self):
        spec=importlib.util.spec_from_file_location('refresh_verify',SETTINGS/'refresh/verify.py')
        verifier=importlib.util.module_from_spec(spec);spec.loader.exec_module(verifier);verifier.verify(SETTINGS)
        base=SETTINGS/'SecSettings.apk/smali_classes4/com/paradox/hub'
        modes=(base/'ParadoxRefreshModes.smali').read_text()
        center=(base/'ParadoxCenterFragment.smali').read_text()
        self.assertIn('Display;->getSupportedModes()',modes)
        self.assertIn('RefreshSettings;->applySingle',modes)
        self.assertIn('RefreshSettings;->reset',center)
        self.assertIn('->syncRefresh()V',center)
        self.assertIn('python3 "$MODPATH/refresh/verify.py" || return 1',(SETTINGS/'customize.sh').read_text())
