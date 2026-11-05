"""Exercise the shipped display transaction against narrow Binder/provider fixtures."""
from pathlib import Path
import importlib.util
import os
import shutil
import subprocess
import tempfile
import unittest

ROOT=Path(__file__).resolve().parents[1]
spec=importlib.util.spec_from_file_location("refresh_contract",Path(__file__).with_name("test_gmhub_refresh.py"))
refresh=importlib.util.module_from_spec(spec);spec.loader.exec_module(refresh)
STUBS=dict(refresh.STUBS)
STUBS.update({
"android/graphics/Point.java":"package android.graphics;public class Point{public int x,y;}",
"android/os/UserHandle.java":"package android.os;public class UserHandle{public static int myUserId(){return 0;}}",
"android/app/ActivityManager.java":"package android.app;public class ActivityManager{public static int current;public static int getCurrentUser(){return current;}}",
"android/view/IWindowManager.java": """package android.view;import android.graphics.Point;
public interface IWindowManager{
 void getInitialDisplaySize(int display,Point out);void getBaseDisplaySize(int display,Point out);
 int getBaseDisplayDensity(int display);void setForcedDisplaySize(int display,int w,int h);
 void clearForcedDisplaySize(int display);void setForcedDisplayDensityForUser(int display,int dpi,int user);
 void clearForcedDisplayDensityForUser(int display,int user);
}""",
"android/view/WindowManagerGlobal.java":"""package android.view;
public class WindowManagerGlobal{public static IWindowManager service;public static IWindowManager getWindowManagerService(){return service;}}""",
"android/provider/Settings.java":"""package android.provider;import android.content.ContentResolver;
public class Settings{public static String size,density;
 public static class Global{public static String getString(ContentResolver r,String k){return size;}}
 public static class Secure{public static String getString(ContentResolver r,String k){return density;}}
}"""
})
CONTRACT=r'''package com.gmhub.refresh;
import android.content.Context;import android.provider.Settings;
public class DisplayScaleContract{
 static int checks;static void check(boolean v){checks++;if(!v)throw new AssertionError("check "+checks);}
 static class Port implements DisplayScale.Port {
  int w=1080,h=2400,dpi=480,calls,failAt,ignoreAt,throwAfterAt,switchAt;boolean user=true;
  String size,den;public DisplayScale.State read(){return new DisplayScale.State(w,h,dpi,size,den);}
  public boolean sameUser(){return user;}
  boolean start(){calls++;if(calls==failAt)throw new IllegalStateException("rejected");return calls!=ignoreAt;}
  void end(){if(calls==switchAt)user=false;if(calls==throwAfterAt)throw new IllegalStateException("late");}
  public void size(int width,int height,boolean clear){if(!start())return;w=clear?1080:width;h=clear?2400:height;size=clear?null:w+","+h;end();}
  public void density(int value,boolean clear){if(!start())return;dpi=clear?480:value;den=clear?null:Integer.toString(dpi);end();}
  boolean original(){return w==1080&&h==2400&&dpi==480&&size==null&&den==null;}
 }
 static class WM implements android.view.IWindowManager {
  int width=1080,height=2400,dpi=480;
  public void getInitialDisplaySize(int d,android.graphics.Point p){p.x=1080;p.y=2400;}
  public void getBaseDisplaySize(int d,android.graphics.Point p){p.x=width;p.y=height;}
  public int getBaseDisplayDensity(int d){return dpi;}
  public void setForcedDisplaySize(int d,int w,int h){width=w;height=h;Settings.size=w+","+h;}
  public void clearForcedDisplaySize(int d){width=1080;height=2400;Settings.size=null;}
  public void setForcedDisplayDensityForUser(int d,int density,int u){check(u==0);dpi=density;Settings.density=""+density;}
  public void clearForcedDisplayDensityForUser(int d,int u){dpi=480;Settings.density=null;}
 }
 public static void main(String[] args){
  Port p=new Port();check(DisplayScale.apply(p,"720x1600"));check(p.w==720&&p.h==1600&&p.dpi==320);
  check(DisplayScale.apply(p,"1080x2400"));check(p.w==1080&&p.h==2400&&p.dpi==480);
  int previous=p.calls;check(DisplayScale.apply(p,"1080x2400"));check(p.calls==previous);
  p=new Port();p.dpi=420;p.den="420";check(DisplayScale.apply(p,"720x1600"));check(p.dpi==280);
  p=new Port();p.w=720;p.h=1600;p.dpi=320;p.size="720,1600";p.den="320";
  p.failAt=2;check(!DisplayScale.apply(p,"1080x2400"));check(p.w==720&&p.h==1600&&p.dpi==320&&p.size.equals("720,1600")&&p.den.equals("320"));
  for(int pos=1;pos<=2;pos++)for(int kind=0;kind<3;kind++){
   p=new Port();if(kind==0)p.failAt=pos;else if(kind==1)p.ignoreAt=pos;else p.throwAfterAt=pos;
   check(!DisplayScale.apply(p,"720x1600"));check(p.original());
  }
  for(String bad:new String[]{null,"","1440x3200","0x0","720x1600;reboot","-720x1600","1080x1600"}){
   p=new Port();check(!DisplayScale.apply(p,bad));check(p.calls==0);
  }
  p=new Port();p.user=false;check(!DisplayScale.apply(p,"720x1600"));check(p.calls==0);
  p=new Port();p.switchAt=1;check(!DisplayScale.apply(p,"720x1600"));check(p.calls==1); // Never touch the new user.
  p=new Port();p.size="1440,3200";check(!DisplayScale.apply(p,"720x1600"));check(p.calls==0); // Incoherent provider/native state.
  WM wm=new WM();android.view.WindowManagerGlobal.service=wm;Context c=new Context();
  check(DisplayScale.value(c).equals("1080x2400"));check(DisplayScale.apply(c,"720x1600"));check(wm.dpi==320);
  check(DisplayScale.value(c).equals("720x1600"));
  android.app.ActivityManager.current=10;check(!DisplayScale.apply(c,"1080x2400"));check(wm.width==720);
  java.lang.System.out.println(checks+" display transaction and native adapter checks passed");
 }
}'''

class DisplayTests(unittest.TestCase):
 def test_actual_display_writer_handles_rejection_rollback_and_user_switch(self):
  suffix=".exe" if os.name=="nt" else ""
  home=os.environ.get("JAVA_HOME")
  javac=str(Path(home)/("bin/javac"+suffix)) if home else shutil.which("javac")
  java=str(Path(home)/("bin/java"+suffix)) if home else shutil.which("java")
  if not javac or not java:self.skipTest("A complete JDK is required")
  with tempfile.TemporaryDirectory() as directory:
   out=Path(directory);sources=[]
   for relative,content in STUBS.items():
    path=out/relative;path.parent.mkdir(parents=True,exist_ok=True);path.write_text(content,encoding="utf8");sources.append(path)
   path=out/"DisplayScaleContract.java";path.write_text(CONTRACT,encoding="utf8");sources.append(path)
   sources.append(ROOT/"unica/mods/settings/refresh/src/com/gmhub/refresh/DisplayScale.java")
   compiled=subprocess.run([javac,"-encoding","UTF-8","-d",str(out/"classes"),*map(str,sources)],capture_output=True,text=True,timeout=45)
   self.assertEqual(compiled.returncode,0,compiled.stderr)
   result=subprocess.run([java,"-Xverify:all","-cp",str(out/"classes"),"com.gmhub.refresh.DisplayScaleContract"],capture_output=True,text=True,timeout=30)
   self.assertEqual(result.returncode,0,result.stdout+result.stderr)
   self.assertIn("native adapter checks passed",result.stdout)

if __name__=="__main__":unittest.main()
