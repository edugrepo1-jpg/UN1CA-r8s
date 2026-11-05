"""Exercise real editor adapters across lock/user/rotation lifecycle changes.

The Java host substitutes only Samsung's reflection boundary. It does not
claim Android UI, graphics, player or physical-device compatibility.
"""
from pathlib import Path
import os
import shutil
import subprocess
import tempfile
import unittest

ROOT = Path(__file__).resolve().parents[1]
SOURCE = ROOT / 'target/r8s/ui/apple_qs/src/com/gmhub/qs'

HARNESS = r'''package com.gmhub.qs;
import java.util.*;
import kotlin.jvm.internal.DefaultConstructorMarker;
import androidx.compose.ui.unit.IntOffset;
import androidx.compose.ui.unit.IntRect;

public final class NativeGeometryContract {
    static int checks;
    static void check(boolean value) { checks++; if(!value)throw new AssertionError("check "+checks); }
    public static class Flow {
        public Object value;
        public Flow(Object value) { this.value=value; }
        public Object getValue() { return value; }
    }
    public static class Item {
        public String getUniqueKey() { return "media"; }
        public String getType() { return "MediaPlayer"; }
        public boolean isResizeEnabled() { return true; }
        public Constraints resizeConstraints(int columns,int rows,boolean screen,boolean device) {
            return new Constraints();
        }
    }
    public static class Constraints {
        public long min=(1L<<32)|1, max=(8L<<32)|8;
    }
    public static class Slot {
        public final Item gridTileItem;
        public final float extraHeight,expandedHeight;
        public final int expandedSpanHeight;
        public final boolean expanded;
        public final IntOffset translationSpanOffset,translationOffset;
        public final IntRect resizeSpanRect;
        public final boolean isTarget,isDropOnItem,isNew;
        public final int spanWidth,spanHeight;public final long spanOffset;
        final int width,height; final long offset;
        public Slot(Item item,int w,int h,long xy,float extra,float expandedHeight,int expandedSpan,
                    IntOffset a,IntOffset b,IntRect c,boolean d,boolean e,boolean f,boolean expanded,
                    DefaultConstructorMarker marker) {
            gridTileItem=item;width=w;height=h;offset=xy;extraHeight=extra;
            spanWidth=w;spanHeight=h;spanOffset=xy;
            this.expandedHeight=expandedHeight;expandedSpanHeight=expandedSpan;this.expanded=expanded;
            translationSpanOffset=a;translationOffset=b;resizeSpanRect=c;
            isTarget=d;isDropOnItem=e;isNew=f;
        }
        public int getSpanX(){return (int)(offset>>32);} public int getSpanY(){return (int)offset;}
        public int getSpanWidth(){return width;} public int getSpanHeight(){return height;}
        @Override public boolean equals(Object other){
            if(!(other instanceof Slot))return false;Slot b=(Slot)other;
            return gridTileItem==b.gridTileItem&&width==b.width&&height==b.height&&offset==b.offset
                &&extraHeight==b.extraHeight&&expandedHeight==b.expandedHeight&&expandedSpanHeight==b.expandedSpanHeight
                &&translationSpanOffset==b.translationSpanOffset&&translationOffset==b.translationOffset
                &&resizeSpanRect==b.resizeSpanRect&&isTarget==b.isTarget&&isDropOnItem==b.isDropOnItem
                &&isNew==b.isNew&&expanded==b.expanded;
        }
        @Override public int hashCode(){return System.identityHashCode(gridTileItem);}
    }
    public static class Store {
        public final Flow currentScreenType=new Flow(new Object());
        public final Flow _qsPanelItems=new Flow(new Flow(new ArrayList<>()));
        public final Flow qsPanelItems=new Flow(null) {
            @Override public Object getValue(){return ((Flow)_qsPanelItems.value).value;}
        };
        int updates;boolean ignoreNext,throwAfterNext;
        public void updateQsPanelItems(List<Object> items){
            updates++;if(ignoreNext){ignoreNext=false;return;}
            Flow flow=(Flow)_qsPanelItems.value;
            if(!Objects.equals(flow.value,items))flow.value=items;
            if(throwAfterNext){throwAfterNext=false;throw new IllegalStateException("after publish");}
        }
        @SuppressWarnings("unchecked") public List<Object> items(){return (List<Object>)qsPanelItems.getValue();}
    }
    public static class Host { int user; public int getUserId(){return user;} }
    public static class Available { public final Flow allTiles=new Flow(Collections.emptyList()); }
    public static class Keyguard {
        boolean unlocked=true,visible;
        public boolean isUnlocked(){return unlocked;} public boolean isVisible(){return visible;}
    }
    public static class Grid { public final Flow currentGridSize=new Flow(42L); }
    public static class Model {
        public final Grid $$delegate_1=new Grid();
        public final Host qsHost=new Host();
        public final Store $$delegate_2=new Store();
        public final Available $$delegate_3=new Available();
        public final Keyguard keyguardStateController=new Keyguard();
        public void collapse(){} public void launchEditMode(){} public void launchPowerMenu(){}
        public void launchSettings(){} public void setOtherComponentDragging(boolean dragging){}
    }
    public static class Scene {
        public final Model viewModel=new Model(); public final Object qsAdapter=new Object();
    }
    static class Fixture {
        final Scene nativeScene=new Scene(); final Store store=nativeScene.viewModel.$$delegate_2;
        final Item player=new Item(); final Slot original=new Slot(player,2,2,0L,5f,7f,2,
            new IntOffset(),new IntOffset(),new IntRect(),true,true,true,false,null);
        final SamsungScene scene;
        final QsLayout.Board board=new QsLayout.Board(4,4,1);
        Fixture() throws Exception {
            store.updateQsPanelItems(Collections.singletonList(original));
            scene=new SamsungScene(nativeScene,new SamsungTiles());
        }
        NativeGeometry edit() throws Exception {return scene.beginGeometry(4,4,false,false);}
        QsLayout.Snapshot moved() {
            return QsLayout.restore(board,Collections.singletonList(
                new QsLayout.Card("media","media",QsLayout.Kind.MEDIA,1,0,2,2,0)),(card,board)->true);
        }
        QsLayout.Snapshot unchanged(){return QsLayout.restore(board,Collections.singletonList(
            new QsLayout.Card("media","media",QsLayout.Kind.MEDIA,0,0,2,2,0)),(card,board)->true);}
        void lock(){nativeScene.viewModel.keyguardStateController.unlocked=false;nativeScene.viewModel.keyguardStateController.visible=true;}
    }
    public static void main(String[] args) throws Exception {
        // Closing the scene on lock restores only its uncommitted geometry.
        Fixture f=new Fixture(); NativeGeometry edit=f.edit();
        check(edit.preview(f.moved())); check(f.store.items().get(0)!=f.original);
        check(((Slot)f.store.items().get(0)).gridTileItem==f.player);
        Slot copied=(Slot)f.store.items().get(0);
        check(copied.translationSpanOffset==f.original.translationSpanOffset);
        check(copied.translationOffset==f.original.translationOffset);
        check(copied.resizeSpanRect==f.original.resizeSpanRect);
        check(copied.isTarget&&copied.isDropOnItem&&copied.isNew);
        check(copied.extraHeight==5f&&copied.expandedHeight==7f);
        f.lock(); f.scene.close(); check(f.store.items().get(0)==f.original);check(!edit.isOpen());
        // A late pointer event/finish cannot commit after keyguard becomes visible.
        for(boolean commit:new boolean[]{false,true}) {
            f=new Fixture();edit=f.edit();check(edit.preview(f.moved()));f.lock();
            check(!(commit?edit.commit():edit.preview(f.moved())));
            check(f.store.items().get(0)==f.original);check(!edit.isOpen());
        }
        // Rotation/replacement and a new user must never be overwritten by rollback.
        f=new Fixture();edit=f.edit();check(edit.preview(f.moved()));
        List<Object> rotated=new ArrayList<>(Collections.singletonList(new Object()));
        f.store.currentScreenType.value=new Object();f.store._qsPanelItems.value=new Flow(rotated);
        edit.close();check(f.store.items()==rotated);
        f=new Fixture();edit=f.edit();check(edit.preview(f.moved()));
        Object current=f.store.items().get(0);f.nativeScene.viewModel.qsHost.user=10;
        edit.close();check(f.store.items().get(0)==current);
        // Same-screen grid measurements can change without rotating or replacing
        // the active flow (density, font scale or window resize).
        for(boolean commit:new boolean[]{false,true}) {
            f=new Fixture();edit=f.edit();check(edit.preview(f.moved()));
            f.nativeScene.viewModel.$$delegate_1.currentGridSize.value=99L;
            check(!(commit?edit.commit():edit.preview(f.moved())));
            check(!edit.isOpen());check(f.store.items().get(0)==f.original);
        }
        // The immutable layout and native geometry adapter share the same 16-column bound.
        QsLayout.Board wide=new QsLayout.Board(16,4,1);
        QsLayout.Snapshot wideLayout=QsLayout.restore(wide,Arrays.asList(
            new QsLayout.Card("left","wifi",QsLayout.Kind.TILE,0,0,8,1,0),
            new QsLayout.Card("right","bt",QsLayout.Kind.TILE,8,0,8,1,0)),(card,board)->true);
        check(wideLayout!=null);check(wideLayout.find("right").x==8);
        // Accepted edits retain the original player/model identity after close.
        f=new Fixture();edit=f.edit();check(edit.preview(f.moved()));check(edit.commit());
        Object accepted=f.store.items().get(0);f.scene.close();check(f.store.items().get(0)==accepted);
        check(((Slot)accepted).gridTileItem==f.player);
        // Kotlin StateFlow's equality suppression must not lose ownership.
        f=new Fixture();edit=f.edit();check(edit.preview(f.unchanged()));
        check(f.store.items().get(0)==f.original);check(edit.preview(f.moved()));
        accepted=f.store.items().get(0);check(edit.preview(f.moved()));
        check(f.store.items().get(0)==accepted);check(edit.commit());
        // A silently ignored write must report failure and remain recoverable.
        f=new Fixture();edit=f.edit();f.store.ignoreNext=true;
        try{edit.preview(f.moved());throw new AssertionError("ignored write accepted");}
        catch(IllegalStateException expected){check(f.store.items().get(0)==f.original);}
        check(edit.preview(f.moved()));edit.close();check(f.store.items().get(0)==f.original);
        // A failure after publication restores only this editor's own objects.
        f=new Fixture();edit=f.edit();f.store.throwAfterNext=true;
        try{edit.preview(f.moved());throw new AssertionError("late failure accepted");}
        catch(java.lang.reflect.InvocationTargetException expected){check(f.store.items().get(0)==f.original);}
        check(edit.preview(f.moved()));edit.close();check(f.store.items().get(0)==f.original);
        System.out.println(checks+" editor lifecycle checks passed");
    }
}'''


class GeometryLifecycleTests(unittest.TestCase):
    def test_lock_cancellation_does_not_overwrite_new_user_or_rotated_grid(self):
        home = os.environ.get('JAVA_HOME')
        suffix = '.exe' if os.name == 'nt' else ''
        javac = str(Path(home) / ('bin/javac' + suffix)) if home else shutil.which('javac')
        java = str(Path(home) / ('bin/java' + suffix)) if home else shutil.which('java')
        if not javac or not java:
            self.skipTest('A complete host JDK is required')
        with tempfile.TemporaryDirectory() as directory:
            out = Path(directory)
            sources = {
                'com/gmhub/qs/NativeGeometryContract.java': HARNESS,
                'com/gmhub/qs/SamsungTiles.java': 'package com.gmhub.qs; public class SamsungTiles { public boolean bind(Object host){return true;} public void setListening(boolean active){} }',
                'kotlin/jvm/internal/DefaultConstructorMarker.java': 'package kotlin.jvm.internal; public class DefaultConstructorMarker {}',
                'androidx/compose/ui/unit/IntOffset.java': 'package androidx.compose.ui.unit; public class IntOffset {}',
                'androidx/compose/ui/unit/IntRect.java': 'package androidx.compose.ui.unit; public class IntRect {}',
            }
            files = []
            for name, content in sources.items():
                path = out / name
                path.parent.mkdir(parents=True, exist_ok=True)
                path.write_text(content, encoding='utf-8')
                files.append(str(path))
            for name in ['QsLayout', 'SamsungScene', 'NativeGeometry']:
                files.append(str(SOURCE / (name + '.java')))
            compile_result = subprocess.run([javac, '-encoding', 'UTF-8', '-d', str(out), *files], capture_output=True, text=True, timeout=45)
            self.assertEqual(compile_result.returncode, 0, compile_result.stderr)
            result = subprocess.run([java, '-Xverify:all', '-cp', str(out), 'com.gmhub.qs.NativeGeometryContract'], capture_output=True, text=True, timeout=30)
            self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
            self.assertIn('editor lifecycle checks passed', result.stdout)
