"""Execute actual native viewport controller with narrow host boundary doubles."""
from pathlib import Path
import os,shutil,subprocess,tempfile,unittest
ROOT=Path(__file__).resolve().parents[1]
FILES={
'kotlin/coroutines/Continuation.java':'package kotlin.coroutines; public interface Continuation {}',
'androidx/compose/foundation/ScrollState.java':'''package androidx.compose.foundation;
public class ScrollState {
 public int value,max,calls,target,valueReads;public Object supplied;
 public final IntState viewportSize$delegate=new IntState();
 public static final Object SUSPENDED=new Object();
 public int getValue(){valueReads++;return value;}public int getMaxValue(){return max;}
 public static class IntState {public int value;public int getIntValue(){return value;}}
 public static Object animateScrollTo$default(ScrollState s,int target,kotlin.coroutines.Continuation continuation){
  s.calls++;s.target=target;s.supplied=continuation;return SUSPENDED;
 }
}''',
'pages/Check.java':'''package pages;
import com.gmhub.qs.NativePageNavigation;
import androidx.compose.foundation.ScrollState;
public class Check {
 static int checks;static void check(boolean v){checks++;if(!v)throw new AssertionError("check "+checks);}
 public static class Host {public int user;public int getUserId(){return user;}}
 public static class Model {public final Host qsHost=new Host();}
 public static class Grid {public boolean dragging;public boolean isDragging(){return dragging;}}
 public static void main(String[] ignored)throws Exception{
  Model model=new Model();Grid grid=new Grid();ScrollState scroll=new ScrollState();
  NativePageNavigation n=new NativePageNavigation(model,grid,scroll);
  check(n.pages().count==0 && n.request(0)==null);
  scroll.viewportSize$delegate.value=200;scroll.max=450;
  NativePageNavigation.Pages p=n.pages();check(p.count==4 && p.selected==0);
  check(p.target(0)==0 && p.target(1)==200 && p.target(2)==400 && p.target(3)==450);
  scroll.value=10;check(p.equals(n.pages()) && p.hashCode()==n.pages().hashCode());
  scroll.value=440;check(n.pages().selected==3);
  scroll.value=205;check(n.pages().selected==1);
  NativePageNavigation.Request request=n.request(3);int reads=scroll.valueReads;check(n.accepts(request) && reads==scroll.valueReads);
  kotlin.coroutines.Continuation continuation=new kotlin.coroutines.Continuation(){};Object unit=new Object();
  check(n.animate(request,continuation,unit)==ScrollState.SUSPENDED);
  check(scroll.target==450 && scroll.supplied==continuation && scroll.calls==1);
  grid.dragging=true;check(n.request(1)==null && !n.accepts(request));
  check(n.animate(request,continuation,unit)==unit && scroll.calls==1);grid.dragging=false;
  check(!n.accepts(request));
  NativePageNavigation.Request resized=n.request(1);
  scroll.viewportSize$delegate.value=201;check(!n.accepts(resized));
  scroll.viewportSize$delegate.value=200;check(!n.accepts(resized));
  scroll.max=449;check(!n.accepts(request));scroll.max=450;
  scroll.viewportSize$delegate.value=201;check(!n.accepts(request));scroll.viewportSize$delegate.value=200;
  model.qsHost.user=10;check(!n.current() && n.pages().count==0 && n.request(0)==null && !n.accepts(request));model.qsHost.user=0;
  NativePageNavigation other=new NativePageNavigation(model,grid,scroll);check(!other.accepts(request));other.close();
  check(n.request(-1)==null && n.request(4)==null);
  scroll.max=0;check(n.pages().count==1 && n.pages().target(0)==0);
  scroll.max=Integer.MAX_VALUE;check(n.pages().count==0);
  scroll.max=1000000;scroll.viewportSize$delegate.value=1;check(n.pages().count==0);
  scroll.max=200;scroll.viewportSize$delegate.value=200;check(n.pages().count==2);
  scroll.max=-1;check(n.pages().count==0);scroll.max=200;
  scroll.viewportSize$delegate.value=-1;check(n.pages().count==0);
  boolean[] rejected={false};Thread t=new Thread(()->{try{n.pages();}catch(IllegalStateException expected){rejected[0]=true;}});t.start();t.join();check(rejected[0]);
  n.close();check(!n.current() && n.pages().count==0 && n.animate(request,continuation,unit)==unit);
  System.out.println(checks+" native viewport checks passed");
 }
}'''}
class PageNavigationTests(unittest.TestCase):
 def test_actual_controller_cancellation_boundaries_and_measured_pages(self):
  home=os.environ.get('JAVA_HOME');suffix='.exe' if os.name=='nt' else ''
  java=str(Path(home)/('bin/java'+suffix)) if home else shutil.which('java')
  javac=str(Path(home)/('bin/javac'+suffix)) if home else shutil.which('javac')
  if not java or not javac:self.skipTest('Host JDK required')
  with tempfile.TemporaryDirectory() as directory:
   out=Path(directory);files=[]
   for name,text in FILES.items():
    p=out/name;p.parent.mkdir(parents=True,exist_ok=True);p.write_text(text,encoding='utf-8');files.append(str(p))
   files.append(str(ROOT/'target/r8s/ui/apple_qs/android-scene/com/gmhub/qs/NativePageNavigation.java'))
   r=subprocess.run([javac,'--release','8','-d',str(out),*files],capture_output=True,text=True,timeout=45)
   self.assertEqual(r.returncode,0,r.stderr)
   r=subprocess.run([java,'-Xverify:all','-cp',str(out),'pages.Check'],capture_output=True,text=True,timeout=30)
   self.assertEqual(r.returncode,0,r.stdout+r.stderr)
   self.assertIn('native viewport checks passed',r.stdout)
