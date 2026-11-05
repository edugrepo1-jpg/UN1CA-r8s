package com.gmhub.qs;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

/** Native gallery membership changes. Adding a preview directly to StateFlow
 * bypasses Samsung's real QSTile factory and produces a nonfunctional control.
 * Use the same factory/placement flags as the donor's ordinary gallery tap.
 * Removal uses its original empty-row reconciler, without destroying a player
 * or a QSTile service. The original editor save coroutine persists the result.
 */
public final class NativePanelActions {
    private static final String BASE="com.android.systemui.samsung.quicksetting.";
    private final Thread owner=Thread.currentThread();
    private final SamsungScene scene;
    private final Object model, panel, repository;
    private final Method place, add, eliminate, spanSize, writeSafeMode;
    private boolean invalidated;

    public NativePanelActions(SamsungScene scene) throws Exception {
        this.scene=Objects.requireNonNull(scene); model=scene.nativeModel();
        panel=field(model,"quickPanelViewModel");
        repository=field(field(model,"saveEventCoordinator"),"gridTileRepository");
        ClassLoader loader=model.getClass().getClassLoader();
        Class<?> item=Class.forName(BASE+"domain.model.items.GridTileItem",false,loader);
        Class<?> spannable=Class.forName(BASE+"domain.model.Spannable",false,loader);
        Class<?> offset=Class.forName("androidx.compose.ui.unit.IntOffset",false,loader);
        Class<?> slot=Class.forName(BASE+"domain.model.QSPanelItem",false,loader);
        place=method(model,"canPlaceTopLeft-Bjo55l4",spannable);
        add=method(panel,"commitAddTile-3UiIcl8",item,long.class,long.class,offset,boolean.class,boolean.class);
        eliminate=method(panel,"eliminateEmptyLines",List.class);
        spanSize=slot.getMethod("getSpanSize-YbymL2g"); spanSize.setAccessible(true);
        writeSafeMode=method(repository,"isGridPrefsWriteSafeModeActive");
    }
    private static Object field(Object target,String name) throws Exception {
        Field f=target.getClass().getField(name);f.setAccessible(true);return f.get(target);
    }
    private static Method method(Object target,String name,Class<?>... types) throws Exception {
        Method m=target.getClass().getMethod(name,types);m.setAccessible(true);return m;
    }
    private void ui() {
        if(Thread.currentThread()!=owner)throw new IllegalStateException("QS UI thread required");
    }
    public boolean usable() throws Exception {
        ui();return !invalidated && scene.geometryAllowed() && !scene.geometryInProgress()
            && Boolean.FALSE.equals(writeSafeMode.invoke(repository));
    }
    private static Map<String,SamsungScene.Slot> byId(List<SamsungScene.Slot> list) {
        Map<String,SamsungScene.Slot> result=new LinkedHashMap<>();
        Map<String,Boolean> keys=new LinkedHashMap<>();
        for(SamsungScene.Slot slot:list) {
            if(result.put(slot.elementId,slot)!=null || keys.put(slot.key,Boolean.TRUE)!=null)
                throw new IllegalStateException("Duplicate native control identity");
        }
        return result;
    }
    private List<SamsungScene.Slot> readBack() throws Exception {
        if(!scene.geometryOwned())throw new IllegalStateException("QS owner changed during membership edit");
        return scene.slots();
    }
    private static void preserve(Map<String,SamsungScene.Slot> before,
                                 Map<String,SamsungScene.Slot> after,String removed) {
        for(SamsungScene.Slot old:before.values()) {
            if(old.elementId.equals(removed))continue;
            SamsungScene.Slot now=after.get(old.elementId);
            if(now==null || now.nativeItem!=old.nativeItem || !old.key.equals(now.key))
                throw new IllegalStateException("Native action replaced an unrelated control or player");
        }
    }
    private boolean unchanged(List<SamsungScene.Slot> before) throws Exception {
        List<SamsungScene.Slot> now=readBack();
        if(before.size()!=now.size())return false;
        for(int i=0;i<before.size();i++)if(before.get(i).nativeSlot!=now.get(i).nativeSlot)return false;
        return true;
    }
    public boolean add(SamsungScene.Slot selected) throws Exception {
        if(!usable() || selected==null)return false;
        // A matching label/type is not enough: reject a stale gallery token or
        // a preview rebuilt for another user/orientation. Refresh the gallery.
        boolean found=false;
        for(SamsungScene.Slot candidate:scene.paletteSlots())
            if(candidate.nativeSlot==selected.nativeSlot && candidate.nativeItem==selected.nativeItem)found=true;
        if(!found)return false;
        List<SamsungScene.Slot> original=scene.slots();
        Map<String,SamsungScene.Slot> before=byId(original);
        for(SamsungScene.Slot slot:original)if(slot.key.equals(selected.key))return false;
        long offset=((Number)place.invoke(model,selected.nativeSlot)).longValue();
        long size=((Number)spanSize.invoke(selected.nativeSlot)).longValue();
        if(!usable() || !unchanged(original))return false;
        try {
            Object result=add.invoke(panel,selected.nativeItem,offset,size,null,false,false);
            if(!(result instanceof Boolean))throw new IllegalStateException("Changed native gallery result contract");
            Map<String,SamsungScene.Slot> after=byId(readBack());
            preserve(before,after,null);
            if(!(Boolean)result) {
                if(after.size()!=before.size())throw new IllegalStateException("Rejected native add changed membership");
                return false;
            }
            if(after.size()!=before.size()+1 || after.values().stream().filter(s->s.key.equals(selected.key)).count()!=1)
                throw new IllegalStateException("Native gallery add was not reflected in the active grid");
            return true;
        } catch(Exception error) {
            // The native factory/reconciler may already have published. Never
            // blindly retry, reverse a service mutation or overwrite its flow.
            invalidated=true;throw error;
        }
    }
    public boolean remove(String key) throws Exception {
        if(!usable() || key==null)return false;
        List<SamsungScene.Slot> original=scene.slots();
        Map<String,SamsungScene.Slot> before=byId(original);
        SamsungScene.Slot selected=null;
        List<Object> remaining=new ArrayList<>();
        for(SamsungScene.Slot slot:original) {
            if(slot.key.equals(key))selected=slot;
            else remaining.add(slot.nativeSlot);
        }
        if(selected==null || !selected.removable)return false;
        if(!usable() || !unchanged(original))return false;
        try {
            // Matches the donor minus-button callback, which filters the UUID
            // then calls eliminateEmptyLines. It does not call QSHost.removeTile.
            eliminate.invoke(panel,remaining);
            Map<String,SamsungScene.Slot> after=byId(readBack());
            preserve(before,after,selected.elementId);
            if(after.size()!=before.size()-1 || after.containsKey(selected.elementId))
                throw new IllegalStateException("Native removal was not reflected in the active grid");
            return true;
        } catch(Exception error) { invalidated=true;throw error; }
    }
}
