"""Execute header actions against native-boundary doubles; no Android VM."""
from pathlib import Path
import os
import shutil
import subprocess
import tempfile
import unittest

ROOT=Path(__file__).resolve().parents[1]
P='com/android/systemui/samsung/quicksetting/ui/panel/'
FILES={
P+'AvailableTilesSource.java': '''package com.android.systemui.samsung.quicksetting.ui.panel;
public enum AvailableTilesSource {QUICK_PANEL,TILE_BOX,OTHER}''',
P+'SecQuickSettingHeaderKt$$ExternalSyntheticLambda35.java': '''package com.android.systemui.samsung.quicksetting.ui.panel;
public class SecQuickSettingHeaderKt$$ExternalSyntheticLambda35 {
 public Object f$0;public SecQuickSettingHeaderKt$$ExternalSyntheticLambda35(int id){if(id!=0)throw new AssertionError("wrong native action");}
 public Object invoke(){headercheck.Contract.Model m=(headercheck.Contract.Model)f$0;m.done++;
 if(m.failDone)throw new IllegalStateException("native save launch failed");m.$$delegate_0.editMode.value=false;return null;}
}''',
'headercheck/Contract.java': '''package headercheck;
import com.gmhub.qs.NativeHeaderActions;
import com.android.systemui.samsung.quicksetting.ui.panel.AvailableTilesSource;
public class Contract {
 static int checks;static void check(boolean v){checks++;if(!v)throw new AssertionError("check "+checks);}
 public static class Flow {
  public Object value;public boolean ignore,throwAfter;public int writes;public Runnable onWrite;
  Flow(Object v){value=v;}
  public Object getValue(){return value;}
  public void setValue(Object v){writes++;if(!ignore)value=v;if(onWrite!=null)onWrite.run();
   if(throwAfter){throwAfter=false;throw new IllegalStateException("provider failed after write");}}
 }
 public static class Host {public int user;public int getUserId(){return user;}}
 public static class Keyguard {public boolean unlocked=true,visible;public boolean isUnlocked(){return unlocked;}public boolean isVisible(){return visible;}}
 public static class Edit {public Flow editMode=new Flow(false);}
 public static class Available {
  public Flow hasAvailableTiles=new Flow(true),_availableTilesSource=new Flow(AvailableTilesSource.TILE_BOX),_showAvailableTiles=new Flow(false);
 }
 public static class Model {
  public Host qsHost=new Host();public Keyguard keyguardStateController=new Keyguard();
  public Edit $$delegate_0=new Edit();public Available $$delegate_3=new Available();
  public int edit,power,done;public boolean rejectEdit,failDone;
  public void launchEditMode(){edit++;if(!rejectEdit)$$delegate_0.editMode.value=true;}
  public void launchPowerMenu(){power++;}
 }
 static Model editing(){Model m=new Model();m.$$delegate_0.editMode.value=true;return m;}
 public static void main(String[] args)throws Exception {
  Model m=new Model();NativeHeaderActions a=new NativeHeaderActions(m);
  check(a.state().current && !a.state().editing && !a.state().canFinish);
  check(!a.gallery() && !a.done());check(a.edit() && m.edit==1 && a.state().editing);
  check(a.gallery());check(m.$$delegate_3._availableTilesSource.value==AvailableTilesSource.QUICK_PANEL);
  check(m.$$delegate_3._showAvailableTiles.value==Boolean.TRUE);
  int srcWrites=m.$$delegate_3._availableTilesSource.writes;
  check(a.gallery() && m.$$delegate_3._availableTilesSource.writes==srcWrites);
  check(a.done() && m.done==1 && !a.state().editing);check(!a.done() && m.done==1);
  check(a.power() && m.power==1);a.close();check(!a.power() && !a.edit() && !a.gallery() && !a.done() && !a.state().current);
  Model policy=new Model();policy.rejectEdit=true;NativeHeaderActions p=new NativeHeaderActions(policy);
  check(p.edit() && policy.edit==1 && !p.state().editing);check(!p.gallery());p.close();
  for(boolean showing:new boolean[]{true,false}){
   Model locked=editing();locked.keyguardStateController.visible=showing;locked.keyguardStateController.unlocked=showing;
   NativeHeaderActions l=new NativeHeaderActions(locked);check(!l.edit() && !l.gallery() && !l.done());
   check(l.power() && locked.power==1);l.close();
  }
  Model stale=editing();NativeHeaderActions s=new NativeHeaderActions(stale);stale.qsHost.user=10;
  check(!s.state().current && !s.edit() && !s.done() && !s.gallery() && !s.power());
  check(stale.$$delegate_3._availableTilesSource.writes==0 && stale.done==0);s.close();
  Model absent=editing();absent.$$delegate_3.hasAvailableTiles.value=false;NativeHeaderActions n=new NativeHeaderActions(absent);
  check(!n.state().canAdd && !n.gallery());check(absent.$$delegate_3._availableTilesSource.writes==0);n.close();
  Model ignored=editing();ignored.$$delegate_3._showAvailableTiles.ignore=true;NativeHeaderActions i=new NativeHeaderActions(ignored);
  check(!i.gallery());check(ignored.$$delegate_3._availableTilesSource.value==AvailableTilesSource.TILE_BOX);i.close();
  Model ignoredSource=editing();ignoredSource.$$delegate_3._availableTilesSource.ignore=true;
  NativeHeaderActions is=new NativeHeaderActions(ignoredSource);check(!is.gallery() && ignoredSource.$$delegate_3._showAvailableTiles.writes==0);is.close();
  Model lockedDuring=editing();lockedDuring.$$delegate_3._availableTilesSource.onWrite=()->lockedDuring.keyguardStateController.visible=true;
  NativeHeaderActions ld=new NativeHeaderActions(lockedDuring);check(!ld.gallery());
  check(lockedDuring.$$delegate_3._availableTilesSource.value==AvailableTilesSource.TILE_BOX);ld.close();
  Model switched=editing();switched.$$delegate_3._availableTilesSource.onWrite=()->switched.qsHost.user=11;
  NativeHeaderActions sw=new NativeHeaderActions(switched);check(!sw.gallery());
  check(switched.$$delegate_3._availableTilesSource.writes==1 && switched.$$delegate_3._showAvailableTiles.writes==0);sw.close();
  Model failSource=editing();failSource.$$delegate_3._availableTilesSource.throwAfter=true;
  NativeHeaderActions fs=new NativeHeaderActions(failSource);try{fs.gallery();throw new AssertionError("missing error");}catch(IllegalStateException expected){}
  check(failSource.$$delegate_3._availableTilesSource.value==AvailableTilesSource.TILE_BOX);fs.close();
  Model dispatched=editing();dispatched.$$delegate_3._showAvailableTiles.throwAfter=true;
  NativeHeaderActions dp=new NativeHeaderActions(dispatched);try{dp.gallery();throw new AssertionError("missing error");}catch(IllegalStateException expected){}
  check(dispatched.$$delegate_3._availableTilesSource.value==AvailableTilesSource.QUICK_PANEL && dispatched.$$delegate_3._showAvailableTiles.value==Boolean.TRUE);dp.close();
  Model changed=editing();changed.$$delegate_3._showAvailableTiles.onWrite=()->changed.$$delegate_3._availableTilesSource.value=AvailableTilesSource.OTHER;
  NativeHeaderActions ch=new NativeHeaderActions(changed);check(!ch.gallery());check(changed.$$delegate_3._availableTilesSource.value==AvailableTilesSource.OTHER);ch.close();
  Model saveFailure=editing();saveFailure.failDone=true;NativeHeaderActions sf=new NativeHeaderActions(saveFailure);
  try{sf.done();throw new AssertionError("missing native error");}catch(IllegalStateException expected){}
  check(!sf.done() && !sf.state().canFinish && saveFailure.done==1);
  saveFailure.$$delegate_0.editMode.value=false;check(!sf.state().editing);
  saveFailure.$$delegate_0.editMode.value=true;saveFailure.failDone=false;
  check(sf.state().canFinish && sf.done() && saveFailure.done==2);sf.close();
  Model threaded=new Model();NativeHeaderActions t=new NativeHeaderActions(threaded);boolean[] rejected={false};
  Thread other=new Thread(()->{try{t.power();}catch(IllegalStateException expected){rejected[0]=true;}});other.start();other.join();
  check(rejected[0] && threaded.power==0);t.close();
  System.out.println(checks+" native header action checks passed");
 }
}'''
}


class HeaderActionsTests(unittest.TestCase):
    def test_native_guards_readback_rollback_and_save_dispatch(self):
        suffix='.exe' if os.name=='nt' else ''
        home=os.environ.get('JAVA_HOME')
        java=str(Path(home)/('bin/java'+suffix)) if home else shutil.which('java')
        javac=str(Path(home)/('bin/javac'+suffix)) if home else shutil.which('javac')
        if not java or not javac:self.skipTest('Host JDK required')
        with tempfile.TemporaryDirectory() as directory:
            out=Path(directory);files=[]
            for name,text in FILES.items():
                path=out/name;path.parent.mkdir(parents=True,exist_ok=True);path.write_text(text,encoding='utf-8');files.append(str(path))
            files.append(str(ROOT/'target/r8s/ui/apple_qs/android-scene/com/gmhub/qs/NativeHeaderActions.java'))
            result=subprocess.run([javac,'-encoding','UTF-8','-d',str(out),*files],capture_output=True,text=True,timeout=45)
            self.assertEqual(result.returncode,0,result.stderr)
            result=subprocess.run([java,'-Xverify:all','-cp',str(out),'headercheck.Contract'],capture_output=True,text=True,timeout=30)
            self.assertEqual(result.returncode,0,result.stdout+result.stderr)
            self.assertIn('native header action checks passed',result.stdout)


if __name__=='__main__':unittest.main()
