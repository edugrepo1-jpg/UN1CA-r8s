"""Exercise the renderer's real health policy, without Android rendering/emulation."""
from pathlib import Path
import os
import shutil
import subprocess
import tempfile
import unittest

ROOT=Path(__file__).resolve().parents[1]
SOURCE=ROOT/'unica/mods/liquid_glass/src/com/gmhub/glass/GlassDrawable.java'
HARNESS='''package com.gmhub.glass;
public final class HealthContract {
    static void check(boolean value){if(!value)throw new AssertionError();}
    public static void main(String[] args){
        GlassDrawable.Health health=new GlassDrawable.Health();
        check(!health.available(0,0)&&!health.available(4,0)&&!health.available(1,-1));
        check(health.available(1,0)&&health.available(2,0)&&health.available(3,0));
        check(health.record(1,100,false));
        check(!health.available(1,100)&&!health.available(1,15099));
        check(health.available(1,15100));
        check(health.available(2,100)&&health.available(3,100));
        check(!health.record(1,15200,false));check(!health.available(1,15100));
        check(health.available(1,30200));
        check(health.record(2,100,true));check(!health.available(2,Long.MAX_VALUE));
        check(!health.record(2,100000,false));check(!health.available(2,Long.MAX_VALUE));
        check(health.available(3,100000));
        try{health.record(0,0,false);throw new AssertionError();}catch(IllegalArgumentException expected){}
        System.out.println("Transient capture recovery and permanent shader isolation passed");
    }
}'''

class GlassHealthTests(unittest.TestCase):
    def test_real_policy_keeps_transient_oom_local_and_incompatible_program_disabled(self):
        suffix='.exe' if os.name=='nt' else ''
        home=os.environ.get('JAVA_HOME')
        javac=str(Path(home)/('bin/javac'+suffix)) if home else shutil.which('javac')
        java=str(Path(home)/('bin/java'+suffix)) if home else shutil.which('java')
        sdk=os.environ.get('ANDROID_SDK_ROOT') or os.environ.get('ANDROID_HOME')
        if not sdk and os.name=='nt':sdk=str(Path.home()/'AppData/Local/Android/Sdk')
        if not sdk or not javac or not java:self.skipTest('Host JDK and SDK37 required')
        android=Path(sdk)/'platforms/android-37.0/android.jar'
        if not android.is_file():android=Path(sdk)/'platforms/android-37/android.jar'
        if not android.is_file():self.skipTest('SDK37 not installed on this test host')
        with tempfile.TemporaryDirectory() as directory:
            out=Path(directory);test=out/'HealthContract.java';test.write_text(HARNESS,encoding='utf-8')
            result=subprocess.run([javac,'--release','8','-Xlint:-options','-cp',str(android),
                                   '-d',str(out),str(SOURCE),str(test)],capture_output=True,text=True,timeout=40)
            self.assertEqual(result.returncode,0,result.stdout+result.stderr)
            result=subprocess.run([java,'-Xverify:all','-cp',os.pathsep.join([str(out),str(android)]),
                                   'com.gmhub.glass.HealthContract'],capture_output=True,text=True,timeout=20)
            self.assertEqual(result.returncode,0,result.stdout+result.stderr)
            self.assertIn('Transient capture recovery',result.stdout)
