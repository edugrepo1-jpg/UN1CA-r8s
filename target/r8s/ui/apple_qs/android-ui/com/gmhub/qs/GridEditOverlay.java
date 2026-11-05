package com.gmhub.qs;

import android.content.Context;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;
import android.graphics.Path;
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
        boolean canResize(String key);
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
    private final Path emptySlots=new Path();
    private final Paint emptyPaint=new Paint(Paint.ANTI_ALIAS_FLAG);
    private final float density,slop,halo;
    private QsLayout.Snapshot snapshot;
    private float originX,originY,cellWidth,cellHeight,gap;
    private int page;
    private Handle active;
    private Handle touchTarget;
    private boolean closed;

    public GridEditOverlay(Context context,Commands commands,Labels labels) {
        super(context); this.commands=Objects.requireNonNull(commands);this.labels=Objects.requireNonNull(labels);
        density=context.getResources().getDisplayMetrics().density;
        halo=Ios26Design.HALO_DP*density;
        slop=ViewConfiguration.get(context).getScaledTouchSlop();
        setClipChildren(false);setClipToPadding(false);
        setWillNotDraw(false);emptyPaint.setColor(0x14ffffff);
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
                ||!Float.isFinite(gap)||cellWidth<=gap||cellHeight<=gap
                ||gap<0||gap>=Math.min(cellWidth,cellHeight)||page<0)
            throw new IllegalArgumentException("Invalid measured native QS grid");
        if(this.originX!=left||this.originY!=top||this.cellWidth!=cellWidth||this.cellHeight!=cellHeight||this.gap!=gap||this.page!=page)
            cancelGesture();
        this.originX=left;this.originY=top;this.cellWidth=cellWidth;this.cellHeight=cellHeight;this.gap=gap;this.page=page;
        emptySlots.reset();
        requestLayout();
    }
    public void render(QsLayout.Snapshot state) {
        ui();if(closed)return;
        snapshot=Objects.requireNonNull(state);
        emptySlots.reset();
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
                if(touchTarget==entry.getValue())touchTarget=null;
                removeView(entry.getValue());it.remove();
            }
        }
        requestLayout();
    }
    @Override protected void onMeasure(int width,int height) {
        setMeasuredDimension(MeasureSpec.getSize(width),MeasureSpec.getSize(height));
        for(Handle h:handles.values())h.measure(
            MeasureSpec.makeMeasureSpec(Math.max(0,(int)Math.ceil(h.card.width*cellWidth-gap+2*halo)),MeasureSpec.EXACTLY),
            MeasureSpec.makeMeasureSpec(Math.max(0,(int)Math.ceil(h.card.height*cellHeight-gap+2*halo)),MeasureSpec.EXACTLY));
    }
    @Override protected void onLayout(boolean changed,int l,int t,int r,int b) {
        for(Handle h:handles.values()) {
            int x=Math.round(originX+h.card.x*cellWidth+gap/2-halo),y=Math.round(originY+h.card.y*cellHeight+gap/2-halo);
            h.layout(x,y,x+h.getMeasuredWidth(),y+h.getMeasuredHeight());
            h.measuredChrome();
        }
        rebuildEmptySlots();
    }
    private void rebuildEmptySlots() {
        emptySlots.reset();
        if(snapshot==null||cellWidth<=gap||cellHeight<=gap)return;
        int[] occupied=new int[snapshot.board.rows];
        for(QsLayout.Card c:snapshot.cards)if(c.page==page) {
            int mask=((1<<c.width)-1)<<c.x;
            for(int row=c.y;row<c.y+c.height;row++)occupied[row]|=mask;
        }
        float radius=(Math.min(cellWidth,cellHeight)-gap)/2f;
        for(int row=0;row<snapshot.board.rows;row++) {
            float y=originY+(row+.5f)*cellHeight;
            if(y-radius>getHeight())break;
            if(y+radius<0)continue;
            for(int col=0;col<snapshot.board.columns;col++)if((occupied[row]&(1<<col))==0) {
                float x=originX+(col+.5f)*cellWidth;
                if(x+radius>=0&&x-radius<=getWidth())emptySlots.addCircle(x,y,radius,Path.Direction.CW);
            }
        }
        // Faint circular free slots match the reference. The path is built only
        // on layout/state changes; draw does not scan the grid or allocate.
    }
    @Override protected void onDraw(Canvas canvas) {
        canvas.drawPath(emptySlots,emptyPaint);
    }
    /** Expanded hit areas can overlap a neighboring card. Choose the nearest
     * actual corner, not whichever child happened to be added last. Header,
     * gallery and page-rail regions with no control remain outside this owner.
     */
    private Handle targetAt(float x,float y) {
        Handle body=null,corner=null;double nearest=Double.POSITIVE_INFINITY;
        for(Handle h:handles.values())if(h.chrome!=null) {
            float px=x-h.getLeft()-halo,py=y-h.getTop()-halo;
            int role=h.chrome.hit(px,py,commands.canRemove(h.card.key),commands.canResize(h.card.key));
            if(role==Ios26Design.MOVE)body=h;
            else if(role!=Ios26Design.NONE) {
                double d=h.chrome.hitDistance(role,px,py);
                if(d<nearest){nearest=d;corner=h;}
            }
        }
        return corner!=null?corner:body;
    }
    @Override public boolean dispatchTouchEvent(MotionEvent event) {
        if(closed)return false;
        int action=event.getActionMasked();
        if(action==MotionEvent.ACTION_DOWN)touchTarget=targetAt(event.getX(),event.getY());
        Handle h=touchTarget;
        if(h==null)return false;
        MotionEvent child=MotionEvent.obtain(event);
        child.offsetLocation(-h.getLeft(),-h.getTop());
        try {
            boolean accepted=h.dispatchTouchEvent(child);
            if(!accepted&&action==MotionEvent.ACTION_DOWN)touchTarget=null;
            return accepted;
        }
        finally {
            child.recycle();
            if(action==MotionEvent.ACTION_UP||action==MotionEvent.ACTION_CANCEL)touchTarget=null;
        }
    }
    private void cancelGesture() {
        if(active==null)return;
        Handle h=active;active=null;h.pointer.cancel();h.original=null;
        h.removeCallbacks(h.longPress);
        boolean begun=h.begun;h.begun=false;
        getParentDisallow(false);
        // A tap, rejected begin or a second pointer before touch slop has no
        // transaction to cancel. Do not close an unrelated accepted edit.
        if(begun)commands.end(true);
    }
    private void getParentDisallow(boolean disallow) {
        if(getParent()!=null)getParent().requestDisallowInterceptTouchEvent(disallow);
    }
    @Override protected void onDetachedFromWindow() { cancelGesture();touchTarget=null;super.onDetachedFromWindow(); }
    @Override public void close() {
        ui();if(closed)return;cancelGesture();touchTarget=null;closed=true;removeAllViews();handles.clear();snapshot=null;emptySlots.reset();
    }
    private static int add(int a,int b) {return (int)Math.max(Integer.MIN_VALUE,Math.min(Integer.MAX_VALUE,(long)a+b));}

    private final class Handle extends View {
        QsLayout.Card card,original;
        final EditPointer pointer=new EditPointer();
        final Paint paint=new Paint(Paint.ANTI_ALIAS_FLAG);
        final RectF rect=new RectF();
        final Path grip=new Path();
        Ios26Design.Chrome chrome;
        int role,lastX,lastY;
        boolean begun;
        final Runnable longPress=()->{
            if(active==this&&!pointer.dragging()&&role==Ios26Design.MOVE) {
                pointer.hold();performLongClick();
            }
        };
        Handle(Context context,QsLayout.Card card) {
            super(context);this.card=card;setFocusable(true);setClickable(true);
            setImportantForAccessibility(IMPORTANT_FOR_ACCESSIBILITY_YES);
            setOnLongClickListener(v->{cancelGesture();return performClick();});
        }
        private void measuredChrome() {
            float w=getWidth()-2*halo,h=getHeight()-2*halo;
            // No temporary geometry is accepted before native measurements exist.
            chrome=w>=48*density&&h>=48*density?
                new Ios26Design.Chrome(w,h,density,card.width,card.height):null;
            grip.reset();
            if(chrome!=null) {
                float right=halo+chrome.width,bottom=halo+chrome.height;
                grip.moveTo(right-24*density,bottom);
                grip.cubicTo(right-10*density,bottom,right,bottom-10*density,right,bottom-24*density);
            }
        }
        @Override protected void onDraw(Canvas c) {
            if(chrome==null)return;
            paint.setStrokeCap(Paint.Cap.ROUND);paint.setStrokeJoin(Paint.Join.ROUND);
            // The native media player retains its original surface and artwork.
            if(card.kind!=QsLayout.Kind.MEDIA) {
                paint.setColor(Color.WHITE);paint.setAlpha(70);paint.setStrokeWidth(.8f*density);paint.setStyle(Paint.Style.STROKE);
                rect.set(halo,halo,halo+chrome.width,halo+chrome.height);
                c.drawRoundRect(rect,chrome.radius,chrome.radius,paint);
            }
            if(commands.canRemove(card.key)) {
                float x=halo+chrome.removeX,y=halo+chrome.removeY;
                paint.setStyle(Paint.Style.FILL);paint.setColor(0xff566873);paint.setAlpha(165);
                c.drawCircle(x,y,12*density,paint);
                paint.setStyle(Paint.Style.STROKE);paint.setColor(Color.WHITE);paint.setAlpha(135);paint.setStrokeWidth(.7f*density);
                c.drawCircle(x,y,12*density,paint);
                paint.setAlpha(255);paint.setStrokeWidth(1.7f*density);
                c.drawLine(x-4.5f*density,y,x+4.5f*density,y,paint);
            }
            if(commands.canResize(card.key)) {
                // Curved lower-right glass grip, not an L or a diagonal arrow.
                paint.setStyle(Paint.Style.STROKE);paint.setColor(Color.WHITE);paint.setAlpha(155);paint.setStrokeWidth(10*density);
                c.drawPath(grip,paint);
                paint.setColor(0xff7d919b);paint.setAlpha(185);paint.setStrokeWidth(8*density);
                c.drawPath(grip,paint);
            }
        }
        private void menuAction(int id) {
            if(closed||original!=null||active!=null)return;
            if(id==8){if(commands.canRemove(card.key))commands.remove(card.key);return;}
            if(id>=4&&id<=7&&!commands.canResize(card.key))return;
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
            for(int i=0;i<names.length;i++)if((i!=8||commands.canRemove(card.key))
                    &&(i<4||i>7||commands.canResize(card.key)))menu.getMenu().add(0,i,i,names[i]);
            menu.setOnMenuItemClickListener(item->{menuAction(item.getItemId());return true;});menu.show();return true;
        }
        @Override public boolean onTouchEvent(MotionEvent event) {
            if(closed||chrome==null||cellWidth<=0||cellHeight<=0)return false;
            int action=event.getActionMasked(),index=event.getActionIndex(),id=event.getPointerId(index);
            float rawX=event.getRawX(index),rawY=event.getRawY(index);
            if(action==MotionEvent.ACTION_DOWN) {
                cancelGesture();active=this;original=card;begun=false;lastX=lastY=0;
                role=chrome.hit(event.getX()-halo,event.getY()-halo,commands.canRemove(card.key),commands.canResize(card.key));
                if(role==Ios26Design.NONE){active=null;original=null;return false;}
                if(!pointer.begin(id,rawX,rawY,slop)){cancelGesture();return false;}
                postDelayed(longPress,ViewConfiguration.getLongPressTimeout());
                return true;
            }
            if(active!=this)return false;
            if(action==MotionEvent.ACTION_POINTER_DOWN||action==MotionEvent.ACTION_POINTER_UP||action==MotionEvent.ACTION_CANCEL) {
                cancelGesture();return true;
            }
            if(event.getPointerCount()!=1){cancelGesture();return true;}
            if(action==MotionEvent.ACTION_MOVE||action==MotionEvent.ACTION_UP) {
                if(pointer.move(id,rawX,rawY))removeCallbacks(longPress);
                if(pointer.dragging()&&role!=Ios26Design.REMOVE) {
                    if(!begun) {
                        boolean accepted=commands.begin(card.key);
                        // Native calls can synchronously lock/change user or
                        // remove a control. Do not dereference a cancelled edit.
                        if(closed||active!=this||original==null) {
                            if(accepted)commands.end(true);
                            return true;
                        }
                        begun=accepted;
                        if(!begun){cancelGesture();return true;}
                        getParentDisallow(true);
                    }
                    int dx=EditPointer.cells(pointer.deltaX(),cellWidth),dy=EditPointer.cells(pointer.deltaY(),cellHeight);
                    if(dx!=lastX||dy!=lastY) {
                        commands.preview(card.key,role==0?add(original.x,dx):original.x,
                            role==0?add(original.y,dy):original.y,
                            role==1?add(original.width,dx):original.width,role==1?add(original.height,dy):original.height);
                        lastX=dx;lastY=dy;
                    }
                }
                if(closed||active!=this||original==null)return true;
                if(action==MotionEvent.ACTION_UP) {
                    removeCallbacks(longPress);
                    EditPointer.End end=pointer.end(id,rawX,rawY,false);
                    active=null;original=null;getParentDisallow(false);
                    if(begun){begun=false;commands.end(end!=EditPointer.End.DRAG);}
                    else if(end==EditPointer.End.TAP) {
                        if(role==Ios26Design.REMOVE){if(commands.canRemove(card.key))commands.remove(card.key);}
                        else super.performClick();
                    }
                }
            }
            return true;
        }
    }
}
