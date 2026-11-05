package com.gmhub.qs;

import android.content.Context;
import android.os.Looper;
import android.util.Log;
import android.view.View;
import android.widget.FrameLayout;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Objects;
import java.util.concurrent.Executor;

/** Concrete edit-chrome/controller binding over the original Compose content.
 * The scene host supplies its measured native grid and lifecycle events. This
 * view draws handles only; media, sliders, artwork and native tile contents are
 * never copied, reparented or rendered by this controller. It does not install
 * itself in a window or change the native layout before a real editor gesture.
 */
public final class NativeGridEditor extends FrameLayout implements GridEditOverlay.Commands,AutoCloseable {
    public interface Listener {
        void changed(QsLayout.Snapshot state);
        void failed(Throwable error);
        void finished(Throwable error);
    }
    private final SamsungScene scene;
    private final NativePanelActions actions;
    private final NativeEditorSave saves;
    private final GridEditOverlay overlay;
    private final Listener listener;
    private final Map<String,SamsungScene.Slot> slots=new LinkedHashMap<>();
    private int columns,rows;
    private boolean screenFlag,deviceFlag,closed,finishing,refreshing;
    private NativeGeometry gesture;
    private QsLayout.Snapshot baseline;
    private QsLayout.SizePolicy sizes;

    public NativeGridEditor(Context context,SamsungScene scene,GridEditOverlay.Labels labels,
                            Executor main,Listener listener) throws Exception {
        super(context);this.scene=Objects.requireNonNull(scene);this.listener=Objects.requireNonNull(listener);
        ui();actions=new NativePanelActions(scene);saves=new NativeEditorSave(scene,main);
        overlay=new GridEditOverlay(context,this,labels);
        setClipChildren(false);setClipToPadding(false);
        addView(overlay,new FrameLayout.LayoutParams(LayoutParams.MATCH_PARENT,LayoutParams.MATCH_PARENT));
    }
    private void ui() {
        if(Looper.myLooper()!=Looper.getMainLooper())throw new IllegalStateException("QS UI thread required");
    }
    private void notifyFailure(Throwable error) {
        try{listener.failed(error);}catch(RuntimeException observer){Log.e("GMHubQs","Editor error observer failed",observer);}
    }
    private void fail(Throwable error) { if(!closed){close();notifyFailure(error);} }
    /** Values are supplied by the original native grid, not screen-size guesses.
     * Configuration changes cancel an active pointer before changing metrics. */
    public boolean bindMeasuredGrid(int columns,int rows,boolean screenFlag,boolean deviceFlag,
                                    float left,float top,float cellWidth,float cellHeight,float gap) {
        ui();if(closed || finishing)return false;
        try {
            if(columns<1 || columns>16 || rows<1 || rows>64)throw new IllegalArgumentException("Invalid native grid");
            if(this.columns!=columns || this.rows!=rows || this.screenFlag!=screenFlag || this.deviceFlag!=deviceFlag)
                overlay.cancelInteraction();
            this.columns=columns;this.rows=rows;this.screenFlag=screenFlag;this.deviceFlag=deviceFlag;
            overlay.metrics(left,top,cellWidth,cellHeight,gap,0);
            return refresh();
        } catch(Exception error){fail(error);return false;}
    }
    /** Called from native state/configuration changes, not a polling timer. */
    public boolean refresh() {
        ui();if(closed || finishing || columns==0)return false;
        if(refreshing)return true;
        refreshing=true;
        try {
            if(gesture!=null) {
                if(gesture.isCurrent())return true;
                overlay.cancelInteraction();
                if(gesture!=null)end(true);
                if(closed || finishing)return false;
            }
            try(NativeGeometry capture=scene.beginGeometry(columns,rows,screenFlag,deviceFlag)) {
                QsLayout.Snapshot actual=capture.initialLayout();
                if(actual==null)throw new IllegalStateException("Native grid requires its original editor");
                slots.clear();for(SamsungScene.Slot slot:scene.slots())slots.put(slot.key,slot);
                overlay.render(actual);listener.changed(actual);
            }
            return !closed;
        } catch(Exception error){fail(error);return false;}
        finally {refreshing=false;}
    }
    @Override public boolean begin(String key) {
        ui();if(closed || finishing || gesture!=null || !slots.containsKey(key))return false;
        try {
            gesture=scene.beginGeometry(columns,rows,screenFlag,deviceFlag);
            baseline=gesture.initialLayout();sizes=gesture.sizePolicy();
            if(baseline==null || baseline.find(key)==null){end(true);return false;}
            scene.dragging(true);return true;
        } catch(Exception error){fail(error);return false;}
    }
    @Override public boolean preview(String key,int x,int y,int width,int height) {
        ui();if(closed || finishing || gesture==null)return false;
        try {
            // Always derive from the gesture baseline, so neighbors do not walk
            // farther away each time the same pointer passes over a grid cell.
            QsLayout.Snapshot next=QsLayout.place(baseline,key,x,y,width,height,0,sizes);
            if(next==null)return false;
            if(!gesture.preview(next)) {overlay.cancelInteraction();if(gesture!=null)end(true);return false;}
            overlay.render(next);listener.changed(next);return !closed;
        } catch(Exception error){fail(error);return false;}
    }
    @Override public void end(boolean cancelled) {
        ui();NativeGeometry active=gesture;gesture=null;baseline=null;sizes=null;
        if(active==null)return;
        try {
            if(cancelled)active.close();else active.commit();
            scene.dragging(false);
            if(!closed && !finishing && !refreshing)refresh();
        } catch(Exception error){active.close();if(!closed)fail(error);}
    }
    @Override public boolean canRemove(String key) {
        ui();
        SamsungScene.Slot slot=slots.get(key);return !closed && !finishing && slot!=null && slot.removable;
    }
    @Override public boolean canResize(String key) {
        ui();
        SamsungScene.Slot slot=slots.get(key);return !closed && !finishing && slot!=null && slot.resizable;
    }
    @Override public void remove(String key) {
        ui();if(closed || finishing || gesture!=null)return;
        try{if(actions.remove(key))refresh();}catch(Exception error){fail(error);}
    }
    public boolean addFromPalette(SamsungScene.Slot selected) {
        ui();if(closed || finishing || gesture!=null)return false;
        try{
            if(!actions.add(selected))return false;
            refresh();return true;
        }catch(Exception error){fail(error);return false;}
    }
    /** Hooked by the scene's editor completion action, once per edit session. */
    public boolean finish() {
        ui();if(closed || finishing)return false;
        finishing=true;overlay.cancelInteraction();
        if(gesture!=null)end(true);
        if(closed)return false;
        overlay.setVisibility(View.INVISIBLE);
        try {
            boolean launched=saves.finish(error->{
                if(closed)return;
                if(error!=null && saves.status()==NativeEditorSave.Status.IDLE) {
                    finishing=false;overlay.setVisibility(View.VISIBLE);notifyFailure(error);return;
                }
                close();
                try{listener.finished(error);}catch(RuntimeException observer){Log.e("GMHubQs","Editor completion observer failed",observer);}
            });
            if(!launched && !closed){finishing=false;overlay.setVisibility(View.VISIBLE);}
            return launched;
        } catch(Exception error){fail(error);return false;}
    }
    @Override protected void onDetachedFromWindow(){
        // AndroidView may detach temporarily while Compose moves/deactivates
        // content. Cancel the pointer now; permanent disposal belongs to its
        // onRelease/scene owner, which must call close().
        boolean wasRefreshing=refreshing;refreshing=true;
        try{overlay.cancelInteraction();if(gesture!=null)end(true);}
        finally{refreshing=wasRefreshing;}
        super.onDetachedFromWindow();
    }
    @Override protected void onAttachedToWindow(){
        super.onAttachedToWindow();if(!closed && !finishing && columns>0)refresh();
    }
    @Override public void close() {
        ui();if(closed)return;closed=true;
        overlay.close();
        if(gesture!=null){gesture.close();gesture=null;}
        try{scene.dragging(false);}catch(Exception unavailable){Log.d("GMHubQs","Native drag owner was disposed");}
        saves.close();slots.clear();baseline=null;sizes=null;removeAllViews();
    }
}
