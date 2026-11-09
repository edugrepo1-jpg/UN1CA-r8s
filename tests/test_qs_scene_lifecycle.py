"""Execute the real adapter with a controlled host Compose/provider contract.

These are host doubles, not Android emulation or proof of device rendering.
The separate installer audit checks these names/descriptors on the real donor.
"""
from pathlib import Path
import os
import shutil
import subprocess
import tempfile
import unittest

ROOT = Path(__file__).resolve().parents[1]
R = 'androidx/compose/runtime/'
S = 'com/android/systemui/samsung/quicksetting/ui/'

FIXTURES = {
    'android/content/res/Configuration.java': 'package android.content.res; public class Configuration {}',
    'com/gmhub/qs/IosHeader.java': 'package com.gmhub.qs; public class IosHeader {public static void content(Object m,Object f,Object c,int flags){}}',
    'android/net/Uri.java': 'package android.net; public class Uri {public final String key; public Uri(String key){this.key=key;}}',
    'android/os/Looper.java': 'package android.os; public class Looper {public static Looper getMainLooper(){return new Looper();}}',
    'android/os/Handler.java': 'package android.os; public class Handler {public Handler(Looper looper){}}',
    'android/os/Build.java': 'package android.os; public class Build {public static class VERSION {public static int SDK_INT=37;}}',
    'android/os/SystemProperties.java': 'package android.os; public class SystemProperties {public static int installed=1; public static int getInt(String key,int def){return installed;}}',
    'android/database/ContentObserver.java': 'package android.database; public class ContentObserver {public ContentObserver(android.os.Handler h){} public void onChange(boolean self){}}',
    'android/content/res/Resources.java': '''package android.content.res; public class Resources {
 public static boolean missingIcons=true;
 public Configuration getConfiguration(){return new Configuration();}
 public int getIdentifier(String name,String kind,String pkg){
  if(name.equals("gmhub_qs_remove"))return missingIcons?0:42;
  if(name.equals("gmhub_qs_resize"))return missingIcons?0:43;
  return 1;
 }}''',
    'android/content/ContentResolver.java': '''package android.content;
public class ContentResolver {
 public java.util.Map<String,Integer> values=new java.util.HashMap<>();
 public java.util.List<android.database.ContentObserver> observers=new java.util.ArrayList<>();
 public boolean failRegister,ignoreWrite;public int writes;public Runnable onRegister;
 public void registerContentObserver(android.net.Uri uri,boolean descendants,android.database.ContentObserver observer){
  if(failRegister)throw new SecurityException("denied");observers.add(observer);
  if(onRegister!=null){Runnable pending=onRegister;onRegister=null;pending.run();}
 }
 public void unregisterContentObserver(android.database.ContentObserver observer){observers.remove(observer);}
 public void notifyChange(){for(android.database.ContentObserver o:new java.util.ArrayList<>(observers))o.onChange(false);}
}''',
    'android/content/Context.java': '''package android.content; public class Context {
 public final ContentResolver resolver=new ContentResolver();
 public ContentResolver getContentResolver(){return resolver;}
 public android.content.res.Resources getResources(){return new android.content.res.Resources();}
 public String getPackageName(){return "com.android.settings";}
}''',
    'android/provider/Settings.java': '''package android.provider; public class Settings { public static class Secure {
 public static int getInt(android.content.ContentResolver r,String k,int d){return r.values.containsKey(k)?r.values.get(k):d;}
 public static boolean putInt(android.content.ContentResolver r,String k,int v){r.writes++;if(!r.ignoreWrite)r.values.put(k,v);r.notifyChange();return true;}
 public static android.net.Uri getUriFor(String key){return new android.net.Uri(key);}
}}''',
    'android/util/Log.java': 'package android.util; public class Log {public static int e(String t,String s,Throwable e){return 0;} public static int e(String t,String s){return 0;} public static int w(String t,String s,Throwable e){return 0;}}',
    'android/widget/Toast.java': 'package android.widget; public class Toast {public static int shown; public static int LENGTH_LONG=1; public static Toast makeText(android.content.Context c,int id,int length){return new Toast();}public void show(){shown++;}}',
    'kotlin/Unit.java': 'package kotlin; public class Unit {public static final Unit INSTANCE=new Unit();}',
    'kotlin/jvm/functions/Function0.java': 'package kotlin.jvm.functions; public interface Function0 {Object invoke();}',
    'kotlin/jvm/functions/Function1.java': 'package kotlin.jvm.functions; public interface Function1 {Object invoke(Object a);}',
    'kotlin/jvm/functions/Function2.java': 'package kotlin.jvm.functions; public interface Function2 {Object invoke(Object a,Object b);}',
    R + 'Composer.java': '''package androidx.compose.runtime; public interface Composer {
 Companion Companion=new Companion(); class Companion {static final Object EMPTY=new Object();public Object getEmpty(){return EMPTY;}}
 Composer startRestartGroup(int key);ScopeUpdateScope endRestartGroup();void startReplaceGroup(int key);void endReplaceGroup();
 boolean changedInstance(Object o);boolean changed(int i);Object rememberedValue();void updateRememberedValue(Object o);
 Object consume(CompositionLocal local);
}''',
    R + 'ScopeUpdateScope.java': 'package androidx.compose.runtime; public interface ScopeUpdateScope {void updateScope(kotlin.jvm.functions.Function2 function);}',
    R + 'State.java': 'package androidx.compose.runtime; public interface State {Object getValue();}',
    R + 'MutableState.java': 'package androidx.compose.runtime; public interface MutableState extends State {void setValue(Object o);}',
    R + 'SnapshotStateKt.java': '''package androidx.compose.runtime; public class SnapshotStateKt {
 public static class Value implements MutableState {Object value;Value(Object v){value=v;}public Object getValue(){return value;}public void setValue(Object v){value=v;}}
 public static MutableState mutableStateOf$default(Object v){return new Value(v);}
}''',
    R + 'CompositionLocal.java': 'package androidx.compose.runtime; public class CompositionLocal {public final kotlin.jvm.functions.Function0 factory;public CompositionLocal(kotlin.jvm.functions.Function0 f){factory=f;}}',
    R + 'ProvidedValue.java': 'package androidx.compose.runtime; public class ProvidedValue {public final CompositionLocal local;public final Object value;ProvidedValue(CompositionLocal l,Object v){local=l;value=v;}}',
    R + 'ProvidableCompositionLocal.java': 'package androidx.compose.runtime; public class ProvidableCompositionLocal extends CompositionLocal {public ProvidableCompositionLocal(kotlin.jvm.functions.Function0 f){super(f);}public ProvidedValue provides(Object value){return new ProvidedValue(this,value);}}',
    R + 'DynamicProvidableCompositionLocal.java': 'package androidx.compose.runtime; public class DynamicProvidableCompositionLocal extends ProvidableCompositionLocal {public DynamicProvidableCompositionLocal(kotlin.jvm.functions.Function0 f){super(f);}}',
    R + 'CompositionLocalKt.java': '''package androidx.compose.runtime; public class CompositionLocalKt {
 public static DynamicProvidableCompositionLocal compositionLocalOf$default(kotlin.jvm.functions.Function0 f){return new DynamicProvidableCompositionLocal(f);}
 public static void CompositionLocalProvider(ProvidedValue value,kotlin.jvm.functions.Function2 slot,Composer c,int changed){
  if(!(slot instanceof androidx.compose.runtime.internal.ComposableLambda))throw new AssertionError("unwrapped slot");
  gmhubtest.Support.C composer=(gmhubtest.Support.C)c;Object old=composer.locals.put(value.local,value.value);
  try {slot.invoke(c,0);}finally {if(old==null)composer.locals.remove(value.local);else composer.locals.put(value.local,old);}
 }
}''',
    R + 'DisposableEffectResult.java': 'package androidx.compose.runtime; public interface DisposableEffectResult {void dispose();}',
    R + 'EffectsKt.java': '''package androidx.compose.runtime; public class EffectsKt {
 static class Effect {Object key;DisposableEffectResult result;Effect(Object key,DisposableEffectResult result){this.key=key;this.result=result;}}
 static java.util.Map<Composer,Effect> effects=new java.util.IdentityHashMap<>();
 public static void DisposableEffect(Object key,kotlin.jvm.functions.Function1 function,Composer c){
  Effect previous=effects.get(c);if(previous!=null && previous.key==key)return;
  if(previous!=null)previous.result.dispose();effects.put(c,new Effect(key,(DisposableEffectResult)function.invoke(new Object())));
 }
 public static void dispose(Composer c){Effect e=effects.remove(c);if(e!=null)e.result.dispose();}
}''',
    R + 'internal/ComposableLambda.java': 'package androidx.compose.runtime.internal; public interface ComposableLambda extends kotlin.jvm.functions.Function2 {}',
    R + 'internal/ComposableLambdaKt.java': '''package androidx.compose.runtime.internal; public class ComposableLambdaKt {
 public static ComposableLambda rememberComposableLambda(int key,boolean tracked,Object block,androidx.compose.runtime.Composer c,int changed){
  kotlin.jvm.functions.Function2 f=(kotlin.jvm.functions.Function2)block;return (a,b)->f.invoke(a,b);
 }
}''',
    'androidx/compose/ui/Modifier.java': 'package androidx.compose.ui; public interface Modifier {}',
    'com/android/compose/animation/scene/ContentScope.java': 'package com.android.compose.animation.scene; public interface ContentScope {}',
    'com/android/systemui/qs/QSHost.java': 'package com.android.systemui.qs; public interface QSHost {int getUserId();android.content.Context getUserContext();}',
    S + 'panel/QuickSettingSceneViewModel.java': '''package com.android.systemui.samsung.quicksetting.ui.panel; public class QuickSettingSceneViewModel {
 public com.android.systemui.qs.QSHost qsHost;public boolean portrait=true,tablet,popover;
 public QuickSettingSceneViewModel(com.android.systemui.qs.QSHost host){qsHost=host;}
 public boolean isPortraitPanel(android.content.res.Configuration c){return portrait;}
 public boolean isTablet(){return tablet;}public boolean isPopOverEnabled(){return popover;}
}''',
    S + 'panel/QuickTileBoxViewModel.java': 'package com.android.systemui.samsung.quicksetting.ui.panel; public class QuickTileBoxViewModel {}',
    S + 'SecQuickSettingSceneKt.java': '''package com.android.systemui.samsung.quicksetting.ui; public class SecQuickSettingSceneKt {
 public static final androidx.compose.runtime.DynamicProvidableCompositionLocal LocalViewModel=new androidx.compose.runtime.DynamicProvidableCompositionLocal(()->null);
 public static void SecQuickSettingSceneMain(com.android.compose.animation.scene.ContentScope scope,androidx.compose.ui.Modifier modifier,
  java.util.List items,com.android.systemui.samsung.quicksetting.ui.panel.QuickTileBoxViewModel tilebox,androidx.compose.runtime.Composer c,int flags){gmhubtest.Support.nativeContent(items,c);}
}''',
    S + 'base/spannablegrid/SpannableGridTileScopeImpl.java': 'package com.android.systemui.samsung.quicksetting.ui.base.spannablegrid; public class SpannableGridTileScopeImpl {public long spanSize;public boolean inAvailableGrid,expanded;}',
    S + 'base/spannablegrid/SpannableGridTileKt$$ExternalSyntheticLambda6.java': 'package com.android.systemui.samsung.quicksetting.ui.base.spannablegrid; public class SpannableGridTileKt$$ExternalSyntheticLambda6 {public Object f$1;public SpannableGridTileScopeImpl f$22=new SpannableGridTileScopeImpl();}',
    'com/android/systemui/samsung/quicksetting/domain/model/items/MediaPlayer.java': 'package com.android.systemui.samsung.quicksetting.domain.model.items; public class MediaPlayer {}',
    'com/android/systemui/samsung/quicksetting/domain/model/items/LegacyMediaPlayer.java': 'package com.android.systemui.samsung.quicksetting.domain.model.items; public class LegacyMediaPlayer {}',
    'androidx/compose/foundation/shape/RoundedCornerShapeKt.java': '''package androidx.compose.foundation.shape; public class RoundedCornerShapeKt {
 public static Object RoundedCornerShape(int p){return "percent/"+p;}
 public static Object RoundedCornerShape_0680j_4(float dp){return "dp/"+dp;}
}''',
}

HARNESS = r'''package gmhubtest;
import java.util.*;
import android.content.*;
import androidx.compose.runtime.*;
import com.gmhub.qs.ComposePanelRoot;
import com.gmhub.panelstyle.PanelStyleControl;
import com.android.systemui.samsung.quicksetting.ui.SecQuickSettingSceneKt;
import com.android.systemui.samsung.quicksetting.ui.panel.*;
import com.android.systemui.samsung.quicksetting.ui.base.spannablegrid.*;
public class Support {
 static int checks,nativeCalls,lastRemove,lastResize;static boolean failNative;static Object lastShape;
 static float lastAspect;
 static final Object nativeShape=new Object(),player=new Object();
 static final List<Object> items=Arrays.asList(player);
 static final SpannableGridTileKt$$ExternalSyntheticLambda6 holder=new SpannableGridTileKt$$ExternalSyntheticLambda6();
 static final QuickTileBoxViewModel box=new QuickTileBoxViewModel();
 static final String KEY="gmhub_qs_style";
 static void check(boolean value){checks++;if(!value)throw new AssertionError("check "+checks);}
 public static void nativeContent(List supplied,Composer c){
  nativeCalls++;check(supplied==items && supplied.get(0)==player);
  if(failNative)throw new IllegalStateException("native marker");
  lastShape=ComposePanelRoot.shape(holder,nativeShape,c);
  lastAspect=ComposePanelRoot.cellAspect(0.83f,c);
  check(Float.isNaN(ComposePanelRoot.cellAspect(Float.NaN,c)));
  check(ComposePanelRoot.cellAspect(0f,c)==0f);
  check(ComposePanelRoot.cellAspect(-1f,c)==-1f);
  check(ComposePanelRoot.cellAspect(Float.POSITIVE_INFINITY,c)==Float.POSITIVE_INFINITY);
  lastRemove=ComposePanelRoot.editResource(0x7e080fe4,c,0);
  lastResize=ComposePanelRoot.editResource(0x7e080820,c,1);
  check(ComposePanelRoot.editResource(0x7e080bda,c,1)==0x7e080bda);
  check(ComposePanelRoot.editResource(0x7e080988,c,1)==0x7e080988);
  check(ComposePanelRoot.editResource(123,c,0)==123);
 }
 public static final class Host implements com.android.systemui.qs.QSHost {
  final int id;final Context context;Host(int id,Context context){this.id=id;this.context=context;}
  public int getUserId(){return id;}public Context getUserContext(){return context;}
 }
 static final class Cursor {final List<Object> data;int index,last;Cursor(List<Object> data){this.data=data;}}
 public static final class C implements Composer {
  final Map<Integer,List<Object>> groups=new HashMap<>();final Deque<Cursor> cursors=new ArrayDeque<>();
  public final Map<CompositionLocal,Object> locals=new IdentityHashMap<>();
  public Object model;public kotlin.jvm.functions.Function2 restart;
  C(Object model){this.model=model;}
  void push(int key){cursors.push(new Cursor(groups.computeIfAbsent(key,k->new ArrayList<>())));}
  Object next(){Cursor s=cursors.peek();s.last=s.index++;if(s.data.size()<=s.last)s.data.add(Composer.Companion.getEmpty());return s.data.get(s.last);}
  void write(Object value){Cursor s=cursors.peek();s.data.set(s.last,value);}
  public Composer startRestartGroup(int key){cursors.clear();push(key);return this;}
  public ScopeUpdateScope endRestartGroup(){cursors.pop();return f->restart=f;}
  public void startReplaceGroup(int key){push(key);}public void endReplaceGroup(){cursors.pop();}
  public boolean changedInstance(Object o){Object old=next();write(o);return old!=o;}
  public boolean changed(int value){Object old=next();write(value);return !Integer.valueOf(value).equals(old);}
  public Object rememberedValue(){return next();}public void updateRememberedValue(Object o){write(o);}
  public Object consume(CompositionLocal local){return local==SecQuickSettingSceneKt.LocalViewModel?model:locals.containsKey(local)?locals.get(local):local.factory.invoke();}
 }
 public static class Preference {
  public String value;public boolean enabled,persistent;public int summary;
  public void setValue(String v){value=v;}public void setPersistent(boolean v){persistent=v;}
  public void setEnabled(boolean v){enabled=v;}public void setSummary(int id){summary=id;}
 }
 static void render(C c){ComposePanelRoot.content(null,null,items,box,c,0);}
 static void span(int w,int h){holder.f$22.spanSize=((long)w<<32)|(h&0xffffffffL);}
 public static void main(String[] args){
  Context zero=new Context(),ten=new Context();Host h0=new Host(0,zero),h10=new Host(10,ten);
  C c=new C(new QuickSettingSceneViewModel(h0));span(1,1);holder.f$1=new Object();
  render(c);check(lastShape==nativeShape && lastAspect==0.83f);check(zero.resolver.observers.size()==1);
  check(lastRemove==0x7e080fe4 && lastResize==0x7e080820);
  android.provider.Settings.Secure.putInt(zero.resolver,KEY,1);render(c);
  check("percent/50".equals(lastShape) && lastAspect==1f);check(zero.resolver.observers.size()==1);
  QuickSettingSceneViewModel model=(QuickSettingSceneViewModel)c.model;
  model.portrait=false;render(c);check(lastAspect==0.83f);model.portrait=true;
  model.tablet=true;render(c);check(lastAspect==0.83f);model.tablet=false;
  model.popover=true;render(c);check(lastAspect==0.83f);model.popover=false;
  render(c);check(lastAspect==1f);
  check(lastRemove==0x7e080fe4 && lastResize==0x7e080820);
  android.content.res.Resources.missingIcons=false;render(c);
  check(lastRemove==42 && lastResize==43);
  c.restart.invoke(c,1);check("percent/50".equals(lastShape));check(zero.resolver.observers.size()==1);
  span(2,2);render(c);check("dp/32.0".equals(lastShape));
  holder.f$1=new com.android.systemui.samsung.quicksetting.domain.model.items.MediaPlayer();render(c);check(lastShape==nativeShape);
  holder.f$1=new com.android.systemui.samsung.quicksetting.domain.model.items.LegacyMediaPlayer();render(c);check(lastShape==nativeShape);
  holder.f$1=new Object();holder.f$22.inAvailableGrid=true;render(c);check("percent/16".equals(lastShape));
  span(1,1);render(c);check("percent/50".equals(lastShape));
  holder.f$1=new com.android.systemui.samsung.quicksetting.domain.model.items.MediaPlayer();render(c);check(lastShape==nativeShape);
  holder.f$1=new Object();span(2,2);
  holder.f$22.inAvailableGrid=false;holder.f$22.expanded=true;render(c);check(lastShape==nativeShape);holder.f$22.expanded=false;
  android.provider.Settings.Secure.putInt(zero.resolver,KEY,0);render(c);check(lastShape==nativeShape && lastAspect==0.83f);
  check(lastRemove==0x7e080fe4 && lastResize==0x7e080820);
  c.model=new QuickSettingSceneViewModel(h10);render(c);
  check(zero.resolver.observers.isEmpty());check(ten.resolver.observers.size()==1);check(lastShape==nativeShape);
  android.provider.Settings.Secure.putInt(zero.resolver,KEY,1);render(c);check(lastShape==nativeShape);
  android.provider.Settings.Secure.putInt(ten.resolver,KEY,1);render(c);check("dp/32.0".equals(lastShape));
  android.database.ContentObserver late=ten.resolver.observers.get(0);EffectsKt.dispose(c);EffectsKt.dispose(c);
  check(ten.resolver.observers.isEmpty());late.onChange(false);check(ten.resolver.observers.isEmpty());
  // The observer re-reads after registering, closing a provider change in the
  // initial-read/registration interval; invalid values always select native.
  Context race=new Context();race.resolver.onRegister=()->race.resolver.values.put(KEY,1);
  C rc=new C(new QuickSettingSceneViewModel(new Host(20,race)));render(rc);check("dp/32.0".equals(lastShape));EffectsKt.dispose(rc);
  Context denied=new Context();denied.resolver.values.put(KEY,1);denied.resolver.failRegister=true;
  C dc=new C(new QuickSettingSceneViewModel(new Host(21,denied)));render(dc);check(lastShape==nativeShape);check(denied.resolver.observers.isEmpty());EffectsKt.dispose(dc);
  // A native content error must propagate exactly once, never call the
  // original again after half the composition has already been emitted.
  C bad=new C(new QuickSettingSceneViewModel(h0));int before=nativeCalls;failNative=true;
  try{render(bad);throw new AssertionError("missing native error");}catch(IllegalStateException expected){check("native marker".equals(expected.getMessage()));}
  finally{failNative=false;EffectsKt.dispose(bad);}check(nativeCalls==before+1);
  Preference pref=new Preference();PanelStyleControl.sync(ten,pref);check(pref.enabled && !pref.persistent && "1".equals(pref.value));
  int writes=ten.resolver.writes;PanelStyleControl.change(ten,pref,"7");check(ten.resolver.writes==writes);
  PanelStyleControl.change(ten,pref,"0");check("0".equals(pref.value));check(ten.resolver.values.get(KEY)==0);
  ten.resolver.ignoreWrite=true;PanelStyleControl.change(ten,pref,"1");check("0".equals(pref.value));check(android.widget.Toast.shown==1);
  ten.resolver.ignoreWrite=false;android.os.SystemProperties.installed=0;PanelStyleControl.sync(ten,pref);check(!pref.enabled);
  writes=ten.resolver.writes;PanelStyleControl.change(ten,pref,"1");check(writes==ten.resolver.writes);
  check(zero.resolver.observers.isEmpty() && ten.resolver.observers.isEmpty());
  System.out.println(checks+" scene lifecycle, media identity and preference checks passed");
 }
}'''


class SceneLifecycleTests(unittest.TestCase):
    def test_user_switch_disposal_native_errors_and_confirmed_preferences(self):
        home = os.environ.get('JAVA_HOME')
        suffix = '.exe' if os.name == 'nt' else ''
        javac = str(Path(home) / ('bin/javac' + suffix)) if home else shutil.which('javac')
        java = str(Path(home) / ('bin/java' + suffix)) if home else shutil.which('java')
        if not javac or not java:
            self.skipTest('A complete host JDK is required')
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            sources = []
            for name, text in {**FIXTURES, 'gmhubtest/Support.java': HARNESS}.items():
                path = root / name
                path.parent.mkdir(parents=True, exist_ok=True)
                path.write_text(text, encoding='utf-8')
                sources.append(path)
            sources += [ROOT / 'target/r8s/ui/apple_qs/android-scene/com/gmhub/qs/ComposePanelRoot.java',
                        ROOT / 'unica/mods/settings/panelstyle/src/com/gmhub/panelstyle/PanelStyleControl.java']
            classes = root / 'classes'
            classes.mkdir()
            result = subprocess.run([javac, '--release', '8', '-d', str(classes), *map(str, sources)],
                                    capture_output=True, text=True, timeout=45)
            self.assertEqual(result.returncode, 0, result.stderr)
            # Kotlin's inline-class name is legal in bytecode but not Java
            # syntax. Rename the host double's identical-length UTF8 entry.
            shape = classes / 'androidx/compose/foundation/shape/RoundedCornerShapeKt.class'
            data = shape.read_bytes()
            self.assertEqual(data.count(b'RoundedCornerShape_0680j_4'), 1)
            shape.write_bytes(data.replace(b'RoundedCornerShape_0680j_4', b'RoundedCornerShape-0680j_4'))
            result = subprocess.run([java, '-Xverify:all', '-cp', str(classes), 'gmhubtest.Support'],
                                    capture_output=True, text=True, timeout=30)
            self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
            self.assertIn('scene lifecycle, media identity and preference checks passed', result.stdout)


if __name__ == '__main__':
    unittest.main()
