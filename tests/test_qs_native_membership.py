"""Exercise the actual membership adapter against a faulting native boundary.

The JVM fixtures expose the donor's Kotlin-mangled method names. This validates
factory flags, identity protection, stale selections and failure handling; the
read-only exact-donor check separately validates Samsung's actual signatures.
Neither check proves physical QS/renderer operation.
"""
from pathlib import Path
import os
import shutil
import struct
import subprocess
import tempfile
import unittest

ROOT = Path(__file__).resolve().parents[1]
SOURCE = ROOT / 'target/r8s/ui/apple_qs/src/com/gmhub/qs/NativePanelActions.java'

HARNESS = r'''package com.gmhub.qs;
import java.util.*;
import com.android.systemui.samsung.quicksetting.domain.model.*;
import com.android.systemui.samsung.quicksetting.domain.model.items.GridTileItem;
import androidx.compose.ui.unit.IntOffset;

public class MembershipContract {
    static int checks;
    static void check(boolean value){checks++;if(!value)throw new AssertionError("check "+checks);}
    public static class Item implements GridTileItem {
        final String id,key;final boolean functional;
        Item(String id,String key,boolean functional){this.id=id;this.key=key;this.functional=functional;}
    }
    public static class Repo {
        boolean safeMode;
        public boolean isGridPrefsWriteSafeModeActive(){return safeMode;}
    }
    public static class Save {public final Repo gridTileRepository=new Repo();}
    public static class Model {
        public final Save saveEventCoordinator=new Save();
        public final Panel quickPanelViewModel;
        Runnable duringPlacement;
        Model(SamsungScene scene){quickPanelViewModel=new Panel(scene);}
        public long canPlaceTopLeft(Spannable slot) {
            if(duringPlacement!=null)duringPlacement.run();return 0L;
        }
    }
    public static class Panel {
        final SamsungScene scene;
        int adds,removes;boolean lastDrag,lastBox,ignoreAdd,rejectAdd,throwAfterAdd,replacePlayer,ignoreRemove,loseOwner;
        Panel(SamsungScene scene){this.scene=scene;}
        public boolean commitAddTile(GridTileItem preview,long offset,long size,IntOffset translation,boolean dnd,boolean box) {
            adds++;lastDrag=dnd;lastBox=box;
            if(rejectAdd)return false;
            if(!ignoreAdd){
                Item p=(Item)preview;
                Item live=new Item(p.id+"-live",p.key,true);
                scene.active.add(slot(live));
            }
            if(replacePlayer)scene.active.set(0,slot(new Item("player","MediaPlayer",true)));
            if(loseOwner)scene.current=false;
            if(throwAfterAdd)throw new IllegalStateException("factory after publication");
            return true;
        }
        public void eliminateEmptyLines(List<Object> remaining) {
            removes++;
            if(ignoreRemove)return;
            scene.active.removeIf(entry->!remaining.contains(entry.nativeSlot));
        }
    }
    static SamsungScene.Slot slot(Item item) {
        return new SamsungScene.Slot(new QSPanelItem(),item,item.key,item.id,true);
    }
    static class Fixture {
        final SamsungScene scene=new SamsungScene();
        final Item player=new Item("player","MediaPlayer",true);
        final Model model=new Model(scene);
        final Panel panel=model.quickPanelViewModel;
        final SamsungScene.Slot selected=slot(new Item("wifi-preview","Internet",false));
        final NativePanelActions actions;
        Fixture()throws Exception{
            scene.model=model;scene.active.add(slot(player));scene.palette.add(selected);
            actions=new NativePanelActions(scene);
        }
        void playerUntouched(){check(scene.active.get(0).nativeItem==player);}
    }
    public static void main(String[] args)throws Exception{
        Fixture f=new Fixture();check(f.actions.add(f.selected));check(f.panel.adds==1);
        check(!f.panel.lastDrag&&!f.panel.lastBox);f.playerUntouched();
        check(((Item)f.scene.active.get(1).nativeItem).functional);
        check(f.scene.active.get(1).nativeItem!=f.selected.nativeItem);
        check(!f.actions.add(f.selected));check(f.panel.adds==1);
        check(f.actions.remove("Internet"));check(f.panel.removes==1);f.playerUntouched();
        check(!f.actions.remove("Internet"));check(f.panel.removes==1);
        // Protect native policy, write-safe mode, active gestures and ownership.
        f=new Fixture();SamsungScene.Slot protectedSlot=new SamsungScene.Slot(new QSPanelItem(),new Item("sim","MultiSIMPreferred",true),"MultiSIMPreferred","sim",false);
        f.scene.active.add(protectedSlot);check(!f.actions.remove("MultiSIMPreferred"));check(f.panel.removes==0);
        f.model.saveEventCoordinator.gridTileRepository.safeMode=true;
        check(!f.actions.add(f.selected));check(f.panel.adds==0);
        f.model.saveEventCoordinator.gridTileRepository.safeMode=false;
        f.scene.gesture=true;check(!f.actions.remove("MediaPlayer"));check(!f.actions.add(f.selected));
        f.scene.gesture=false;f.scene.editable=false;check(!f.actions.add(f.selected));
        f.scene.editable=true;f.scene.current=false;check(!f.actions.add(f.selected));
        // Matching text/IDs cannot substitute a rebuilt or another user's preview.
        f=new Fixture();SamsungScene.Slot stale=slot(new Item("wifi-preview","Internet",false));
        check(!f.actions.add(stale));check(f.panel.adds==0);
        // The factory is not called when placement observed stale state.
        f=new Fixture();final Fixture safe=f;
        f.model.duringPlacement=()->safe.model.saveEventCoordinator.gridTileRepository.safeMode=true;
        check(!f.actions.add(f.selected));check(f.panel.adds==0);
        f=new Fixture();final Fixture moved=f;
        f.model.duringPlacement=()->moved.scene.active.set(0,slot(moved.player));
        check(!f.actions.add(f.selected));check(f.panel.adds==0);f.playerUntouched();
        // A normal factory rejection keeps the binding available for another choice.
        f=new Fixture();f.panel.rejectAdd=true;check(!f.actions.add(f.selected));check(f.actions.usable());
        check(f.scene.active.size()==1);f.playerUntouched();
        // Ignored or partially dispatched writes are never reported as success,
        // automatically retried or rolled back over Samsung's own service work.
        for(int mode=0;mode<4;mode++){
            f=new Fixture();f.panel.ignoreAdd=mode==0;f.panel.throwAfterAdd=mode==1;
            f.panel.replacePlayer=mode==2;f.panel.loseOwner=mode==3;
            try{f.actions.add(f.selected);throw new AssertionError("bad add accepted "+mode);}
            catch(Exception expected){check(!f.actions.usable());}
            check(!f.actions.add(f.selected));check(f.panel.adds==1);
            if(mode!=2)f.playerUntouched();
        }
        f=new Fixture();check(f.actions.add(f.selected));f.panel.ignoreRemove=true;
        try{f.actions.remove("Internet");throw new AssertionError("ignored removal accepted");}
        catch(Exception expected){check(!f.actions.usable());}
        check(!f.actions.remove("Internet"));check(f.panel.removes==1);f.playerUntouched();
        f=new Fixture();final Fixture ui=f;final Throwable[] failure={null};
        Thread thread=new Thread(()->{try{ui.actions.add(ui.selected);}catch(Throwable e){failure[0]=e;}});
        thread.start();thread.join();check(failure[0] instanceof IllegalStateException);check(f.panel.adds==0);
        System.out.println(checks+" native gallery membership checks passed");
    }
}'''

STUB_SCENE = r'''package com.gmhub.qs;
import java.util.*;
public class SamsungScene {
  Object model;boolean current=true,editable=true,gesture;
  final List<Slot> active=new ArrayList<>(),palette=new ArrayList<>();
  public Object nativeModel(){return model;}
  boolean geometryOwned(){return current;}
  boolean geometryAllowed(){return current&&editable;}
  boolean geometryInProgress(){return gesture;}
  public List<Slot> slots(){return new ArrayList<>(active);}
  public List<Slot> paletteSlots(){return new ArrayList<>(palette);}
  public static class Slot {
    public final Object nativeSlot,nativeItem;public final String key,elementId;
    public final boolean removable;
    Slot(Object raw,Object item,String key,String id,boolean removable){
      nativeSlot=raw;nativeItem=item;this.key=key;elementId=id;this.removable=removable;
    }
  }
}'''


def mangle_fixture_methods(path):
    """Rename fixture ABI symbols in class files; Java cannot spell Kotlin '-'."""
    mapping = {
        b'canPlaceTopLeft': b'canPlaceTopLeft-Bjo55l4',
        b'commitAddTile': b'commitAddTile-3UiIcl8',
        b'getSpanSize': b'getSpanSize-YbymL2g',
    }
    data = path.read_bytes()
    count = struct.unpack_from('>H', data, 8)[0]
    cursor, index, entries = 10, 1, []
    sizes = {3: 4, 4: 4, 5: 8, 6: 8, 7: 2, 8: 2, 9: 4, 10: 4, 11: 4,
             12: 4, 15: 3, 16: 2, 17: 4, 18: 4, 19: 2, 20: 2}
    while index < count:
        start = cursor
        tag = data[cursor]
        cursor += 1
        if tag == 1:
            length = struct.unpack_from('>H', data, cursor)[0]
            value = data[cursor + 2:cursor + 2 + length]
            cursor += length + 2
            value = mapping.get(value, value)
            entries.append(bytes([tag]) + struct.pack('>H', len(value)) + value)
        else:
            cursor += sizes[tag]
            entries.append(data[start:cursor])
        index += 2 if tag in (5, 6) else 1
    path.write_bytes(data[:10] + b''.join(entries) + data[cursor:])


class NativeMembershipTests(unittest.TestCase):
    def test_native_factory_flags_identity_and_stale_operations(self):
        home = os.environ.get('JAVA_HOME')
        suffix = '.exe' if os.name == 'nt' else ''
        javac = str(Path(home) / ('bin/javac' + suffix)) if home else shutil.which('javac')
        java = str(Path(home) / ('bin/java' + suffix)) if home else shutil.which('java')
        if not javac or not java:
            self.skipTest('A complete host JDK is required')
        base = 'com/android/systemui/samsung/quicksetting/domain/model/'
        sources = {
            'com/gmhub/qs/MembershipContract.java': HARNESS,
            'com/gmhub/qs/SamsungScene.java': STUB_SCENE,
            base + 'items/GridTileItem.java': 'package com.android.systemui.samsung.quicksetting.domain.model.items;public interface GridTileItem {}',
            base + 'Spannable.java': 'package com.android.systemui.samsung.quicksetting.domain.model;public interface Spannable {}',
            base + 'QSPanelItem.java': 'package com.android.systemui.samsung.quicksetting.domain.model;public class QSPanelItem implements Spannable {public long getSpanSize(){return (2L<<32)|2;}}',
            'androidx/compose/ui/unit/IntOffset.java': 'package androidx.compose.ui.unit;public class IntOffset {}',
        }
        with tempfile.TemporaryDirectory() as directory:
            out = Path(directory)
            files = [str(SOURCE)]
            for name, content in sources.items():
                path = out / name
                path.parent.mkdir(parents=True, exist_ok=True)
                path.write_text(content, encoding='utf-8')
                files.append(str(path))
            compiled = subprocess.run([javac, '-encoding', 'UTF-8', '-d', str(out), *files], capture_output=True, text=True, timeout=45)
            self.assertEqual(compiled.returncode, 0, compiled.stderr)
            for path in out.rglob('*.class'):
                mangle_fixture_methods(path)
            result = subprocess.run([java, '-Xverify:all', '-cp', str(out), 'com.gmhub.qs.MembershipContract'], capture_output=True, text=True, timeout=30)
            self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
            self.assertIn('native gallery membership checks passed', result.stdout)
