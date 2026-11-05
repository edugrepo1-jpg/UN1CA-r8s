package com.gmhub.qs;

import android.content.Context;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;
import android.graphics.RectF;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewConfiguration;
import android.view.ViewGroup;
import android.widget.PopupMenu;
import java.util.*;

/** Transparent edit handles over the ORIGINAL Samsung Compose grid. This layer
 * never paints/reparents/recreates the player, sliders, artwork or tile content.
 * Native toolbar/gallery remain outside this overlay and keep their handlers.
 * All coordinates are native measured pixels; no status/header guess is used.
 */
public final class GridEditOverlay extends ViewGroup implements AutoCloseable {
    public interface Commands {
        boolean begin(String key);
        boolean preview(String key,int x,int y,int width,int height);
        void end(boolean cancelled);
        boolean canRemove(String key);
        void remove(String key);
    }
    public interface Labels {
        CharSequence control(String key);
        CharSequence moveLeft(); CharSequence moveRight(); CharSequence moveUp(); CharSequence moveDown();
        CharSequence wider(); CharSequence narrower(); CharSequence taller(); CharSequence shorter();
        CharSequence remove();
    }
    private final Commands commands;
    private final Labels labels;
    private final Map<String,Handle> handles=new LinkedHashMap<>();
    private final float density,slop;
    private QsLayout.Snapshot snapshot;
    private float originX,originY,cellWidth,cellHeight,gap;
    private int page;
    private Handle active;
    private boolean closed;

    public GridEditOverlay(Context context,Commands commands,Labels labels) {
        super(context); this.commands=Objects.requireNonNull(commands);this.labels=Objects.requireNonNull(labels);
        density=context.getResources().getDisplayMetrics().density;
        slop=ViewConfiguration.get(context).getScaledTouchSlop();
        setClipChildren(false);setClipToPadding(false);
        setImportantForAccessibility(IMPORTANT_FOR_ACCESSIBILITY_NO);
    }
    private void ui() {
        if(android.os.Looper.myLooper()!=android.os.Looper.getMainLooper())
            throw new IllegalStateException("QS UI thread required");
    }
    /** Native bounds must already be converted to this overlay's coordinates.
     * Configure/rotation invalidates a gesture before its dimensions change. */
    public void metrics(float left,float top,float cellWidth,float cellHeight,float gap,int page) {
        ui();
        if(!Float.isFinite(left)||!Float.isFinite(top)||!Float.isFinite(cellWidth)||!Float.isFinite(cellHeight)
                ||!Float.isFinite(gap)||cellWidth<48*density||cellHeight<48*density
                ||gap<0||gap>=Math.min(cellWidth,cellHeight)||page<0)
            throw new IllegalArgumentException("Invalid measured native QS grid");
        if(this.originX!=left||this.originY!=top||this.cellWidth!=cellWidth||this.cellHeight!=cellHeight||this.gap!=gap||this.page!=page)
            cancelGesture();
        this.originX=left;this.originY=top;this.cellWidth=cellWidth;this.cellHeight=cellHeight;this.gap=gap;this.page=page;
        requestLayout();
    }
    public void render(QsLayout.Snapshot state) {
        ui();if(closed)return;
        snapshot=Objects.requireNonNull(state);
        if(page>=state.board.pages)throw new IllegalArgumentException("QS page outside board");
        Set<String> visible=new HashSet<>();
        for(QsLayout.Card card:state.cards)if(card.page==page) {
            visible.add(card.key);Handle h=handles.get(card.key);
            if(h==null){h=new Handle(getContext(),card);handles.put(card.key,h);addView(h);}
            h.card=card;h.setContentDescription(labels.control(card.key));h.invalidate();
        }
        for(Iterator<Map.Entry<String,Handle>> it=handles.entrySet().iterator();it.hasNext();) {
            Map.Entry<String,Handle> entry=it.next();
            if(!visible.contains(entry.getKey())) {
                if(active==entry.getValue())cancelGesture();
                removeView(entry.getValue());it.remove();
            }
        }
        requestLayout();
    }
    @Override protected void onMeasure(int width,int height) {
        setMeasuredDimension(MeasureSpec.getSize(width),MeasureSpec.getSize(height));
        for(Handle h:handles.values())h.measure(
            MeasureSpec.makeMeasureSpec(Math.max(0,Math.round(h.card.width*cellWidth-gap)),MeasureSpec.EXACTLY),
            MeasureSpec.makeMeasureSpec(Math.max(0,Math.round(h.card.height*cellHeight-gap)),MeasureSpec.EXACTLY));
    }
    @Override protected void onLayout(boolean changed,int l,int t,int r,int b) {
        for(Handle h:handles.values()) {
            int x=Math.round(originX+h.card.x*cellWidth+gap/2),y=Math.round(originY+h.card.y*cellHeight+gap/2);
            h.layout(x,y,x+h.getMeasuredWidth(),y+h.getMeasuredHeight());
        }
    }
    private void cancelGesture() {
        if(active==null)return;
        Handle h=active;active=null;h.pointer.cancel();h.original=null;
        boolean begun=h.begun;h.begun=false;
        getParentDisallow(false);
        // A tap, rejected begin or a second pointer before touch slop has no
        // transaction to cancel. Do not close an unrelated accepted edit.
        if(begun)commands.end(true);
    }
    private void getParentDisallow(boolean disallow) {
        if(getParent()!=null)getParent().requestDisallowInterceptTouchEvent(disallow);
    }
    @Override protected void onDetachedFromWindow() { cancelGesture();super.onDetachedFromWindow(); }
    @Override public void close() {
        ui();if(closed)return;cancelGesture();closed=true;removeAllViews();handles.clear();snapshot=null;
    }
    private static int add(int a,int b) {return (int)Math.max(Integer.MIN_VALUE,Math.min(Integer.MAX_VALUE,(long)a+b));}

    private final class Handle extends View {
        QsLayout.Card card,original;
        final EditPointer pointer=new EditPointer();
        final Paint paint=new Paint(Paint.ANTI_ALIAS_FLAG);
        final RectF rect=new RectF();
        int role,lastX,lastY;
        boolean begun;
        Handle(Context context,QsLayout.Card card) {
            super(context);this.card=card;setFocusable(true);setClickable(true);
            setImportantForAccessibility(IMPORTANT_FOR_ACCESSIBILITY_YES);
            setOnLongClickListener(v->{cancelGesture();return performClick();});
        }
        private boolean resizeVisible(){return getWidth()>=96*density&&getHeight()>=96*density;}
        @Override protected void onDraw(Canvas c) {
            paint.setColor(Color.WHITE);paint.setAlpha(205);paint.setStrokeWidth(1.5f*density);paint.setStyle(Paint.Style.STROKE);
            rect.set(density,density,getWidth()-density,getHeight()-density);
            c.drawRoundRect(rect,Math.min(28*density,getWidth()/2f),Math.min(28*density,getHeight()/2f),paint);
            if(commands.canRemove(card.key)) {
                paint.setStyle(Paint.Style.FILL);paint.setColor(0xffd0d3d4);paint.setAlpha(255);
                c.drawCircle(24*density,24*density,10*density,paint);
                paint.setColor(0xff303437);paint.setStrokeWidth(2.2f*density);
                c.drawLine(19*density,24*density,29*density,24*density,paint);
            }
            if(resizeVisible()) {
                paint.setStyle(Paint.Style.STROKE);paint.setColor(Color.WHITE);paint.setStrokeWidth(3*density);
                float x=getWidth()-24*density,y=getHeight()-24*density;
                c.drawLine(x-7*density,y+7*density,x+7*density,y+7*density,paint);
                c.drawLine(x+7*density,y+7*density,x+7*density,y-7*density,paint);
            }
        }
        private void menuAction(int id) {
            if(closed||original!=null||active!=null)return;
            if(id==8){if(commands.canRemove(card.key))commands.remove(card.key);return;}
            if(!commands.begin(card.key))return;
            int x=card.x,y=card.y,w=card.width,h=card.height;
            switch(id){case 0:x--;break;case 1:x++;break;case 2:y--;break;case 3:y++;break;
                case 4:w++;break;case 5:w--;break;case 6:h++;break;case 7:h--;break;default:commands.end(true);return;}
            boolean accepted=false;
            try { accepted=commands.preview(card.key,x,y,w,h); }
            finally { commands.end(!accepted); }
        }
        @Override public boolean performClick() {
            super.performClick();if(closed)return false;
            PopupMenu menu=new PopupMenu(getContext(),this);
            CharSequence[] names={labels.moveLeft(),labels.moveRight(),labels.moveUp(),labels.moveDown(),
                labels.wider(),labels.narrower(),labels.taller(),labels.shorter(),labels.remove()};
            for(int i=0;i<names.length;i++)if(i!=8||commands.canRemove(card.key))menu.getMenu().add(0,i,i,names[i]);
            menu.setOnMenuItemClickListener(item->{menuAction(item.getItemId());return true;});menu.show();return true;
        }
        @Override public boolean onTouchEvent(MotionEvent event) {
            if(closed||cellWidth<=0||cellHeight<=0)return false;
            int action=event.getActionMasked(),index=event.getActionIndex(),id=event.getPointerId(index);
            float rawX=event.getRawX(index),rawY=event.getRawY(index);
            if(action==MotionEvent.ACTION_DOWN) {
                cancelGesture();active=this;original=card;begun=false;lastX=lastY=0;
                role=commands.canRemove(card.key)&&event.getX()<48*density&&event.getY()<48*density?2:
                    resizeVisible()&&event.getX()>getWidth()-48*density&&event.getY()>getHeight()-48*density?1:0;
                return pointer.begin(id,rawX,rawY,slop);
            }
            if(active!=this)return false;
            if(action==MotionEvent.ACTION_POINTER_DOWN||action==MotionEvent.ACTION_POINTER_UP||action==MotionEvent.ACTION_CANCEL) {
                cancelGesture();return true;
            }
            if(event.getPointerCount()!=1){cancelGesture();return true;}
            if(action==MotionEvent.ACTION_MOVE||action==MotionEvent.ACTION_UP) {
                if(pointer.move(id,rawX,rawY)&&role!=2) {
                    if(!begun){begun=commands.begin(card.key);if(!begun){cancelGesture();return true;}getParentDisallow(true);}
                    int dx=EditPointer.cells(pointer.deltaX(),cellWidth),dy=EditPointer.cells(pointer.deltaY(),cellHeight);
                    if(dx!=lastX||dy!=lastY) {
                        commands.preview(card.key,role==0?add(original.x,dx):original.x,
                            role==0?add(original.y,dy):original.y,
                            role==1?add(original.width,dx):original.width,role==1?add(original.height,dy):original.height);
                        lastX=dx;lastY=dy;
                    }
                }
                if(action==MotionEvent.ACTION_UP) {
                    EditPointer.End end=pointer.end(id,rawX,rawY,false);
                    active=null;original=null;getParentDisallow(false);
                    if(begun){begun=false;commands.end(end!=EditPointer.End.DRAG);}
                    else if(end==EditPointer.End.TAP){if(role==2){if(commands.canRemove(card.key))commands.remove(card.key);}else performClick();}
                }
            }
            return true;
        }
    }
}
