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
    private final Object store, screen, activeFlow, gridToken;
    private final int columns, rows;
    private final boolean screenFlag, deviceFlag;
    private final List<Object> original;
    private List<Object> published;
    private final Map<String, SamsungScene.Slot> slots = new LinkedHashMap<>();
    private final Map<String,Object[]> metadata = new HashMap<>();
    private final GeometryAccess access;
    private final QsLayout.SizePolicy sizePolicy;
    private boolean closed;

    /** Resolve the donor ABI once per transaction, not once per tile on every
     * pointer event. QSPanelItem's donor fields are immutable. Never cache a
     * player or its mutable state globally across scenes/users. */
    private static final class GeometryAccess {
        private static final String[] NAMES={"gridTileItem","spanWidth","spanHeight","spanOffset",
            "extraHeight","expandedHeight","expandedSpanHeight","translationSpanOffset",
            "translationOffset","resizeSpanRect","isTarget","isDropOnItem","isNew","expanded"};
        final Class<?> type;
        final Field[] fields=new Field[NAMES.length];
        final Constructor<?> constructor;
        GeometryAccess(Object sample,Object item) throws Exception {
            type=sample.getClass();
            for(int i=0;i<NAMES.length;i++) {
                fields[i]=type.getField(NAMES[i]);fields[i].setAccessible(true);
            }
            Constructor<?> found=null;
            for(Constructor<?> c:type.getConstructors()) {
                Class<?>[] p=c.getParameterTypes();
                if(p.length==15 && p[0].isInstance(item) && p[1]==int.class && p[2]==int.class
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
            constructor=found;constructor.setAccessible(true);
        }
        Object[] capture(Object slot) throws Exception {
            if(slot.getClass()!=type)throw new IllegalStateException("Mixed native geometry classes");
            Object[] result=new Object[15];
            for(int i=0;i<fields.length;i++)result[i]=fields[i].get(slot);
            return result;
        }
        boolean equal(Object a,Object b) throws Exception {
            if(a==b)return true;
            if(a==null || b==null || a.getClass()!=type || b.getClass()!=type
                    || fields[0].get(a)!=fields[0].get(b))return false;
            for(int i=1;i<fields.length;i++)if(!Objects.equals(fields[i].get(a),fields[i].get(b)))return false;
            return true;
        }
        boolean geometry(Object slot,QsLayout.Card card) throws Exception {
            long offset=((long)card.x<<32)|(card.y&0xffffffffL);
            return fields[1].getInt(slot)==card.width && fields[2].getInt(slot)==card.height
                && fields[3].getLong(slot)==offset;
        }
    }

    private static final class SizeRule {
        final SamsungScene.Bounds bounds;
        final int width, height;
        final boolean resizable, media;
        SizeRule(SamsungScene.Slot slot, SamsungScene.Bounds bounds) {
            this.bounds=bounds; width=slot.width; height=slot.height;
            resizable=slot.resizable; media="MediaPlayer".equals(slot.type);
        }
        boolean allows(QsLayout.Card card) {
            return (!media || card.kind==QsLayout.Kind.MEDIA)
                && (resizable ? bounds.allows(card.width,card.height)
                    : card.width==width && card.height==height);
        }
    }

    NativeGeometry(SamsungScene scene, Object store, int columns, int rows,
                   boolean screenFlag, boolean deviceFlag) throws Exception {
        if (columns < 1 || columns > 16 || rows < 1 || rows > 64)
            throw new IllegalArgumentException("Invalid native grid dimensions");
        this.scene=scene; this.store=store; this.columns=columns; this.rows=rows;
        this.screenFlag=screenFlag; this.deviceFlag=deviceFlag;
        screen=flow(field(store,"currentScreenType"));
        gridToken=scene.gridToken();
        activeFlow=flow(field(store,"_qsPanelItems"));
        original=items(); published=original;
        List< SamsungScene.Slot> visible=scene.slots();
        if (visible.size()!=original.size()) throw new IllegalStateException("Native grid is still changing");
        access=visible.isEmpty()?null:new GeometryAccess(visible.get(0).nativeSlot,visible.get(0).nativeItem);
        Map<String,SizeRule> rules=new HashMap<>();
        for(int i=0;i<visible.size();i++) {
            SamsungScene.Slot slot=visible.get(i);
            if(slot.nativeSlot!=original.get(i) || slots.put(slot.key,slot)!=null)
                throw new IllegalStateException("Unstable or duplicate native grid item");
            if(Boolean.TRUE.equals(field(slot.nativeSlot,"expanded")))
                throw new IllegalStateException("Close the expanded native control before editing");
            metadata.put(slot.key,access.capture(slot.nativeSlot));
            rules.put(slot.key,new SizeRule(slot,scene.bounds(slot,columns,rows,screenFlag,deviceFlag)));
        }
        // Freeze only primitive size rules. A background layout load may use
        // this policy without touching a Compose item, player or UI StateFlow.
        // Preview still rechecks the live native bounds before publication.
        Map<String,SizeRule> limits=Collections.unmodifiableMap(rules);
        sizePolicy=(card,board)->{
            if(card==null || board==null || board.columns!=columns || board.rows!=rows
                    || board.pages!=1 || card.page!=0)return false;
            SizeRule rule=limits.get(card.key);
            return rule!=null && rule.allows(card);
        };
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
    private boolean sameLayout(List<Object> expected,List<Object> actual) throws Exception {
        if(expected.size()!=actual.size())return false;
        for(int i=0;i<expected.size();i++)if(!access.equal(expected.get(i),actual.get(i)))return false;
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
    private Object copy(SamsungScene.Slot slot,QsLayout.Card card,Object current) throws Exception {
        if(access.geometry(current,card))return current;
        Object[] args=metadata.get(slot.key).clone();
        args[1]=card.width;args[2]=card.height;args[3]=((long)card.x<<32)|(card.y&0xffffffffL);
        return access.constructor.newInstance(args);
    }
    private void checkThread() {
        if(Thread.currentThread()!=owner)throw new IllegalStateException("QS UI thread required");
    }
    public boolean isOpen() { checkThread(); return !closed; }
    public boolean isCurrent() throws Exception {
        checkThread();return !closed && scene.geometryAllowed() && scene.sameGrid(gridToken) && owns();
    }
    /** Pass these native limits to QsLayout.restore/move/resize, rather than
     * assuming a generic media minimum. The donor permits a compact 2x1 player
     * in one screen mode and 2x2 in the other, with a 4x4 maximum in both.
     * This immutable policy contains no player/model references. */
    public QsLayout.SizePolicy sizePolicy() { checkThread(); return sizePolicy; }
    public QsLayout.Snapshot initialLayout() {
        checkThread();if(closed)throw new IllegalStateException("Native geometry is closed");
        List<QsLayout.Card> cards=new ArrayList<>();
        for(SamsungScene.Slot slot:slots.values())cards.add(new QsLayout.Card(slot.key,slot.key,
            "MediaPlayer".equals(slot.type)?QsLayout.Kind.MEDIA:QsLayout.Kind.TILE,
            slot.x,slot.y,slot.width,slot.height,0));
        return QsLayout.exact(new QsLayout.Board(columns,rows,1),cards,sizePolicy);
    }
    /** Moves/resizes the complete visible grid in ONE native StateFlow update.
     * Rejects duplicates, overlaps, hidden pages, unsupported native sizes and
     * stale state without publishing a partially edited grid. */
    public boolean preview(QsLayout.Snapshot snapshot) throws Exception {
        checkThread();
        if(closed)return false;
        if(!scene.geometryAllowed() || !scene.sameGrid(gridToken) || !owns()) { close(); return false; }
        if(snapshot==null || snapshot.board.columns!=columns || snapshot.board.rows!=rows || snapshot.board.pages!=1
                || snapshot.cards.size()!=original.size())return false;
        Set<String> keys=new HashSet<>(); boolean[][] occupied=new boolean[rows][columns];
        List<Object> replacements=new ArrayList<>();
        Map<Object,Object> current=new IdentityHashMap<>();
        for(Object wrapper:published)current.put(access.fields[0].get(wrapper),wrapper);
        for(QsLayout.Card card:snapshot.cards) {
            SamsungScene.Slot slot=slots.get(card.key);
            if(slot==null || !keys.add(card.key) || card.page!=0 || card.x<0 || card.y<0
                    || card.width<1 || card.height<1 || card.width>columns || card.height>rows
                    || card.x>columns-card.width || card.y>rows-card.height || !sizePolicy.allows(card,snapshot.board))return false;
            if(!slot.resizable && (card.width!=slot.width || card.height!=slot.height))return false;
            // A fixed native control keeps its existing dimensions. Generic
            // resize constraints must not invalidate an unresizable bar.
            if(slot.resizable && !scene.bounds(slot,columns,rows,screenFlag,deviceFlag).allows(card.width,card.height))return false;
            for(int y=card.y;y<card.y+card.height;y++)for(int x=card.x;x<card.x+card.width;x++) {
                if(occupied[y][x])return false; occupied[y][x]=true;
            }
            replacements.add(copy(slot,card,current.get(slot.nativeItem)));
        }
        boolean same=true;
        for(int i=0;i<published.size();i++)if(published.get(i)!=replacements.get(i)){same=false;break;}
        // Motion events within the same snapped cell must not enqueue another
        // StateFlow write/recomposition or allocate another media wrapper.
        if(same)return true;
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
        if(!scene.geometryAllowed() || !scene.sameGrid(gridToken) || !owns()) { close(); return false; }
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
            boolean changed=original.size()!=published.size();
            for(int i=0;!changed && i<original.size();i++)changed=original.get(i)!=published.get(i);
            if(changed && scene.geometryOwned() && owns())update(original);
        } catch(Exception ignored) {
            // Base remains owned by Samsung if it was already torn down.
        } finally { closed=true; }
    }
}
