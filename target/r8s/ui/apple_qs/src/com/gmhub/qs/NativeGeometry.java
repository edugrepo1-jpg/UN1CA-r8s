package com.gmhub.qs;

import java.lang.reflect.Constructor;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.util.*;

/** Transactional geometry adapter for the original Samsung Compose grid.
 * Only QSPanelItem geometry wrappers are copied. The GridTileItem (including
 * MediaPlayer, sliders and their native models) is retained by identity.
 * Does not create a player, capture artwork or replace native controls.
 */
public final class NativeGeometry implements AutoCloseable {
    private final Thread owner=Thread.currentThread();
    private final SamsungScene scene;
    private final Object store, screen, activeFlow;
    private final int columns, rows;
    private final boolean screenFlag, deviceFlag;
    private final List<Object> original;
    private List<Object> published;
    private final Map<String, SamsungScene.Slot> slots = new LinkedHashMap<>();
    private boolean closed;

    NativeGeometry(SamsungScene scene, Object store, int columns, int rows,
                   boolean screenFlag, boolean deviceFlag) throws Exception {
        if (columns < 1 || columns > 16 || rows < 1 || rows > 64)
            throw new IllegalArgumentException("Invalid native grid dimensions");
        this.scene=scene; this.store=store; this.columns=columns; this.rows=rows;
        this.screenFlag=screenFlag; this.deviceFlag=deviceFlag;
        screen=flow(field(store,"currentScreenType"));
        activeFlow=flow(field(store,"_qsPanelItems"));
        original=items(); published=original;
        List< SamsungScene.Slot> visible=scene.slots();
        if (visible.size()!=original.size()) throw new IllegalStateException("Native grid is still changing");
        for(int i=0;i<visible.size();i++) {
            SamsungScene.Slot slot=visible.get(i);
            if(slot.nativeSlot!=original.get(i) || slots.put(slot.key,slot)!=null)
                throw new IllegalStateException("Unstable or duplicate native grid item");
            if(Boolean.TRUE.equals(field(slot.nativeSlot,"expanded")))
                throw new IllegalStateException("Close the expanded native control before editing");
        }
    }
    private static Object field(Object o,String name) throws Exception {
        Field f=o.getClass().getField(name); f.setAccessible(true); return f.get(o);
    }
    private static Object flow(Object flow) throws Exception {
        Method m=flow.getClass().getMethod("getValue"); m.setAccessible(true); return m.invoke(flow);
    }
    private List<Object> items() throws Exception {
        Object value=flow(activeFlow);
        if(!(value instanceof Collection)) throw new IllegalStateException("Native item flow changed");
        return new ArrayList<>((Collection<?>)value);
    }
    private boolean owns() throws Exception {
        if(flow(field(store,"currentScreenType"))!=screen || flow(field(store,"_qsPanelItems"))!=activeFlow)
            return false;
        List<Object> now=items();
        if(now.size()!=published.size())return false;
        for(int i=0;i<now.size();i++)if(now.get(i)!=published.get(i))return false;
        return true;
    }
    private static boolean sameLayout(List<Object> expected,List<Object> actual) throws Exception {
        if(expected.size()!=actual.size())return false;
        String[] fields={"spanWidth","spanHeight","spanOffset","extraHeight","expandedHeight",
            "expandedSpanHeight","translationSpanOffset","translationOffset","resizeSpanRect",
            "isTarget","isDropOnItem","isNew","expanded"};
        for(int i=0;i<expected.size();i++) {
            Object a=expected.get(i),b=actual.get(i);
            if(a==null || b==null || a.getClass()!=b.getClass()
                    || field(a,"gridTileItem")!=field(b,"gridTileItem"))return false;
            for(String name:fields)if(!Objects.equals(field(a,name),field(b,name)))return false;
        }
        return true;
    }
    private List<Object> update(List<Object> values) throws Exception {
        Method m=store.getClass().getMethod("updateQsPanelItems",List.class);
        m.setAccessible(true); m.invoke(store,new ArrayList<>(values));
        List<Object> actual=items();
        if(!sameLayout(values,actual))throw new IllegalStateException("Native QS grid did not accept the edit");
        // StateFlow suppresses equal values, retaining the previous wrappers.
        // Track the actual stored objects, not newly allocated equal copies.
        return actual;
    }
    private static Object copy(SamsungScene.Slot slot, QsLayout.Card card) throws Exception {
        Constructor<?> found=null;
        for(Constructor<?> c:slot.nativeSlot.getClass().getConstructors()) {
            Class<?>[] p=c.getParameterTypes();
            if(p.length==15 && p[0].isInstance(slot.nativeItem) && p[1]==int.class && p[2]==int.class
                    && p[3]==long.class && p[4]==float.class && p[5]==float.class && p[6]==int.class
                    && p[7].getName().equals("androidx.compose.ui.unit.IntOffset")
                    && p[8].getName().equals("androidx.compose.ui.unit.IntOffset")
                    && p[9].getName().equals("androidx.compose.ui.unit.IntRect")
                    && p[10]==boolean.class && p[11]==boolean.class && p[12]==boolean.class && p[13]==boolean.class
                    && p[14].getName().equals("kotlin.jvm.internal.DefaultConstructorMarker")) {
                if(found!=null)throw new IllegalStateException("Ambiguous native geometry constructor");
                found=c;
            }
        }
        if(found==null)throw new IllegalStateException("Changed Samsung grid geometry contract");
        long offset=((long)card.x<<32)|(card.y&0xffffffffL);
        found.setAccessible(true);
        return found.newInstance(slot.nativeItem,card.width,card.height,offset,
            field(slot.nativeSlot,"extraHeight"),field(slot.nativeSlot,"expandedHeight"),
            field(slot.nativeSlot,"expandedSpanHeight"),field(slot.nativeSlot,"translationSpanOffset"),
            field(slot.nativeSlot,"translationOffset"),field(slot.nativeSlot,"resizeSpanRect"),
            field(slot.nativeSlot,"isTarget"),field(slot.nativeSlot,"isDropOnItem"),
            field(slot.nativeSlot,"isNew"),field(slot.nativeSlot,"expanded"),null);
    }
    private void checkThread() {
        if(Thread.currentThread()!=owner)throw new IllegalStateException("QS UI thread required");
    }
    public boolean isOpen() { checkThread(); return !closed; }
    /** Moves/resizes the complete visible grid in ONE native StateFlow update.
     * Rejects duplicates, overlaps, hidden pages, unsupported native sizes and
     * stale state without publishing a partially edited grid. */
    public boolean preview(QsLayout.Snapshot snapshot) throws Exception {
        checkThread();
        if(closed)return false;
        if(!scene.geometryAllowed() || !owns()) { close(); return false; }
        if(snapshot==null || snapshot.board.columns!=columns || snapshot.board.rows!=rows
                || snapshot.cards.size()!=original.size())return false;
        Set<String> keys=new HashSet<>(); boolean[][] occupied=new boolean[rows][columns];
        List<Object> replacements=new ArrayList<>();
        for(QsLayout.Card card:snapshot.cards) {
            SamsungScene.Slot slot=slots.get(card.key);
            if(slot==null || !keys.add(card.key) || card.page!=0 || card.x<0 || card.y<0
                    || card.width<1 || card.height<1 || card.width>columns || card.height>rows
                    || card.x>columns-card.width || card.y>rows-card.height)return false;
            if(!slot.resizable && (card.width!=slot.width || card.height!=slot.height))return false;
            if(!scene.bounds(slot,columns,rows,screenFlag,deviceFlag).allows(card.width,card.height))return false;
            for(int y=card.y;y<card.y+card.height;y++)for(int x=card.x;x<card.x+card.width;x++) {
                if(occupied[y][x])return false; occupied[y][x]=true;
            }
            replacements.add(copy(slot,card));
        }
        List<Object> previous=published;
        try { published=update(replacements); return true; }
        catch(Exception failure) {
            // Defend even against a changed implementation throwing after it
            // published. Restore only the list that this edit still owns.
            published=replacements;
            try {
                if(owns()) published=update(previous);
                else {
                    // An ignored write leaves the previous list intact. A
                    // foreign update invalidates ownership instead of being
                    // overwritten by cancellation or a later pointer event.
                    published=previous;
                    if(!owns())closed=true;
                }
            }
            catch(Exception rollback) { failure.addSuppressed(rollback); }
            throw failure;
        }
    }
    public boolean commit() throws Exception {
        checkThread();
        if(closed)return false;
        if(!scene.geometryAllowed() || !owns()) { close(); return false; }
        closed=true; return true;
    }
    @Override public void close() {
        checkThread();
        if(closed)return;
        try {
            // A new orientation, user, controller or native gallery edit owns
            // its own grid; cancellation must never overwrite that state.
            // Locking prevents NEW edits, but must still cancel this user's
            // uncommitted preview. Ownership checks protect a new user/grid.
            if(scene.geometryOwned() && owns())update(original);
        } catch(Exception ignored) {
            // Base remains owned by Samsung if it was already torn down.
        } finally { closed=true; }
    }
}
