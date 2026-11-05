package com.gmhub.glass;

import android.app.ActivityManager;
import android.content.Context;
import android.content.res.Configuration;
import android.graphics.Bitmap;
import android.graphics.BitmapShader;
import android.graphics.Canvas;
import android.graphics.ColorFilter;
import android.graphics.Paint;
import android.graphics.Rect;
import android.graphics.RuntimeShader;
import android.graphics.Shader;
import android.graphics.drawable.BitmapDrawable;
import android.os.Build;
import android.os.PowerManager;
import android.os.SystemClock;
import android.provider.Settings;
import android.util.Log;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;

/** Samsung keeps ownership of screenshot selection, security and fallback blur.
 * Only the captured QUICK_PANEL background is replaced; never the keyguard PIN,
 * authentication mask, media controls, live-window blur or arbitrary app content.
 * This adapter ports the three upstream AGSL engines, not their demo applications.
 */
public final class GlassDrawable extends BitmapDrawable {
    public static final String ENGINE_KEY = "gmhub_liquid_glass_engine";
    public static final String PURE_BLACK_KEY = "gmhub_pure_black";
    private static final String TAG = "GMHubGlass";
    private static final int MAX_SHADER_BYTES = 128 * 1024;
    private static final int MAX_PIXELS = 4 * 1024 * 1024;
    private static final String[] SOURCES = new String[4];
    private static final Health HEALTH = new Health();
    private static final String MAPPER = "uniform shader bitmap; uniform float2 captureSize; "
        + "uniform float2 viewSize; half4 main(float2 p) { "
        + "return bitmap.eval(clamp(p / viewSize * captureSize, float2(0.5), captureSize - 0.5)); }";
    private final Context context;
    private final BitmapDrawable fallback;
    private final Bitmap raw;
    private final int engine;
    private final RuntimeShader lens;
    private final RuntimeShader mapper;
    private final Paint glass = new Paint(Paint.ANTI_ALIAS_FLAG);
    private final Paint veil = new Paint(Paint.ANTI_ALIAS_FLAG);
    private final Paint black = new Paint();
    private final float density;
    private int width, height;
    private long nextPolicyCheck;
    private boolean allowed, failed;

    /** Transient capture/memory failures belong to that capture. Incompatible
     * programs remain disabled; a later healthy capture may retry after OOM.
     * No timer, shared mutable RuntimeShader or background shader pool. */
    static final class Health {
        private static final long RETRY_DELAY_MS=15000;
        private final boolean[] incompatible=new boolean[4],logged=new boolean[4];
        private final long[] retryAt=new long[4];
        synchronized boolean available(int engine,long now) {
            return engine>=1 && engine<=3 && now>=0 && !incompatible[engine] && now>=retryAt[engine];
        }
        synchronized boolean record(int engine,long now,boolean permanent) {
            if(engine<1 || engine>3)throw new IllegalArgumentException("Invalid glass engine");
            incompatible[engine]|=permanent;
            long start=Math.max(0,now);
            retryAt[engine]=start>Long.MAX_VALUE-RETRY_DELAY_MS?Long.MAX_VALUE:start+RETRY_DELAY_MS;
            boolean first=!logged[engine];logged[engine]=true;return first;
        }
    }

    /** Failure returns the original already-blurred drawable, never a raw frame. */
    public static BitmapDrawable wrap(Context c, Bitmap raw, BitmapDrawable original, String scene) {
        if (!"QUICK_PANEL".equals(scene) || original == null || Build.VERSION.SDK_INT < 33)
            return original;
        // Solid black needs no shader, extra capture or bitmap allocation.
        if (pureBlack(c)) {
            try { return new GlassDrawable(c, raw, original, 0); }
            catch (RuntimeException | LinkageError | OutOfMemoryError ex) { return original; }
        }
        // Check capture dimensions before creating a shader/texture, not just
        // the output view in draw(). A small view can reference a huge capture.
        // Keeping Samsung's existing blurred drawable needs no new allocation.
        if (!usable(raw) || !usable(original.getBitmap())) return original;
        int e = selected(c);
        if (!HEALTH.available(e,SystemClock.uptimeMillis()) || !policyAllows(c)) return original;
        try {
            return new GlassDrawable(c, raw, original, e);
        } catch (RuntimeException | LinkageError | OutOfMemoryError ex) {
            fail(e, ex);
            return original;
        }
    }

    private static boolean usable(Bitmap bitmap) {
        return bitmap != null && !bitmap.isRecycled() && bitmap.getWidth() >= 4
            && bitmap.getHeight() >= 4 && (long) bitmap.getWidth() * bitmap.getHeight() <= MAX_PIXELS;
    }

    private static int selected(Context c) {
        try {
            int e = Settings.Global.getInt(c.getContentResolver(), ENGINE_KEY, 0);
            return e >= 1 && e <= 3 ? e : 0;
        } catch (RuntimeException ex) { return 0; }
    }

    private static boolean policyAllows(Context c) {
        try {
            ActivityManager am = c.getSystemService(ActivityManager.class);
            PowerManager pm = c.getSystemService(PowerManager.class);
            return am != null && !am.isLowRamDevice() && pm != null
                && !pm.isPowerSaveMode() && pm.getCurrentThermalStatus() < 2
                && Settings.Secure.getInt(c.getContentResolver(), "accessibility_reduce_transparency", 0) == 0
                && Settings.Secure.getInt(c.getContentResolver(), "high_text_contrast_enabled", 0) == 0;
        } catch (RuntimeException ex) { return false; }
    }

    private static boolean pureBlack(Context c) {
        try {
            return (c.getResources().getConfiguration().uiMode & Configuration.UI_MODE_NIGHT_MASK)
                    == Configuration.UI_MODE_NIGHT_YES
                && Settings.Secure.getInt(c.getContentResolver(), PURE_BLACK_KEY, 0) == 1;
        } catch (RuntimeException ex) { return false; }
    }

    private static synchronized String source(Context c, int engine) {
        if (SOURCES[engine] != null) return SOURCES[engine];
        String[] names = {"", "qwea", "kyant", "color"};
        try (InputStream in = c.getAssets().open("gmhub/liquid_glass/" + names[engine] + ".agsl");
             ByteArrayOutputStream out = new ByteArrayOutputStream()) {
            byte[] buffer = new byte[4096];
            int n;
            while ((n = in.read(buffer)) != -1) {
                if (out.size() + n > MAX_SHADER_BYTES) throw new IllegalArgumentException("Shader exceeds size limit");
                out.write(buffer, 0, n);
            }
            String result = new String(out.toByteArray(), StandardCharsets.UTF_8);
            if (result.isEmpty()) throw new IllegalArgumentException("Empty shader");
            return SOURCES[engine] = result;
        } catch (java.io.IOException ex) { throw new IllegalArgumentException("Missing glass asset", ex); }
    }

    private GlassDrawable(Context c, Bitmap raw, BitmapDrawable original, int e) {
        // Preserve the SDK-facing BitmapDrawable contract (getBitmap, intrinsic
        // size, density) because Samsung's binder expects a BitmapDrawable.
        super(c.getResources(), original.getBitmap());
        context = c;
        fallback = original;
        this.raw = raw;
        engine = e;
        density = c.getResources().getDisplayMetrics().density;
        black.setColor(0xff000000);
        veil.setColor(0x33000000);
        // Respect the native fade/filter even when wrapping a drawable which
        // was already configured by its binder before the capture completed.
        setAlpha(original.getAlpha());setColorFilter(original.getColorFilter());
        if (e == 0) {
            lens = null;
            mapper = null;
            return;
        }
        lens = new RuntimeShader(source(c, e));
        mapper = e == 3 ? null : new RuntimeShader(MAPPER);
        Bitmap chosen = e == 3 ? raw : original.getBitmap();
        if (chosen == null || chosen.isRecycled()) throw new IllegalStateException("Missing captured backdrop");
        BitmapShader input = new BitmapShader(chosen, Shader.TileMode.CLAMP, Shader.TileMode.CLAMP);
        input.setFilterMode(BitmapShader.FILTER_MODE_LINEAR);
        if (mapper != null) {
            mapper.setInputShader("bitmap", input);
            mapper.setFloatUniform("captureSize", chosen.getWidth(), chosen.getHeight());
            lens.setInputShader("content", mapper);
        } else {
            lens.setInputShader("uSource", input);
            lens.setInputShader("uSourceLowRes", input);
        }
        glass.setShader(lens);
        // Retain separation from white foreground labels; no foreground shader.
    }

    private void configure(int w, int h) {
        float r = Math.min(28 * density, Math.min(w, h) / 2f);
        float bevel = Math.max(1, Math.min(18 * density, Math.min(w, h) / 4f));
        if (mapper != null) mapper.setFloatUniform("viewSize", w, h);
        if (engine == 1) {
            f("margin", 0); f("viewSize", w, h);
            f("shape1", w/2f, h/2f, w/2f, h/2f);
            f("shape1L", w/2f, h/2f, w/2f, h/2f);
            f("radii1", r, r, r, r); f("shape2", 0, 0, 0, 0);
            f("radius2", 0); f("blendK", 0); f("rimSoft", 0);
            f("bevel", bevel); f("refractPx", Math.min(24*density, bevel));
            f("falloff", 2); f("refractDir", -1);
            f("sampleLo", 0.5f, 0.5f); f("sampleHi", w-0.5f, h-0.5f);
            f("dispersion", 0.12f); f("lightDir", 0.866f, 0.5f);
            f("specStrength", 0.35f); f("rimBandMax", 2*density);
            f("tintColor", 1, 1, 1, 0.04f); f("adaptiveTint", 1);
            f("glassTint", 0, 0, 0, 0); f("dimAmount", 0.08f); f("satFactor", 1.15f);
            f("press", 0); f("touchPos", w/2f, h/2f); f("touchAmp", 0);
        } else if (engine == 2) {
            f("size", w, h); f("offset", 0, 0); f("cornerRadii", r, r, r, r);
            f("refractionHeight", bevel); f("refractionAmount", -bevel);
            f("depthEffect", 1); f("chromaticAberration", 0.12f);
        } else {
            f("uSourceRect", 0, 0, raw.getWidth(), raw.getHeight());
            f("uSourceLowResRect", 0, 0, raw.getWidth(), raw.getHeight());
            f("uSourceSize", raw.getWidth(), raw.getHeight()); f("uViewport", w, h);
            f("uCornerRadius", r); f("uCornerIsConic", 0); f("uCornerWeight", 1.3968f);
            f("uCornerConicBlend", 0); f("uBlurRadius", 0);
            f("uRefractionHeight", bevel); f("uRefractionAmount", bevel); f("uDepth", 1);
            f("uDispersion", 0.12f); f("uHighlight", 0.35f);
            f("uHighlightWidth", 2*density); f("uHighlightFalloff", 2);
            f("uHighlightFloor", 0.4f); f("uHighlightInnerAtt", 0); f("uInnerGlow", 0);
            f("uVibrancy", 1.15f); f("uLightAngle", 0.7853982f); f("uParallax", 0, 0);
            f("uDebugCoord", 0); f("uDebugHighlight", 0);
            f("uMaskRect", 0, 0, w, h); f("uMaskCornerRadius", 0);
            f("uMaskWeight", 1.3968f); f("uMaskOffset", 0, 0);
            f("uMaskAlpha", 0); f("uMaskColor", 0, 0, 0, 1);
            // Keep metaball and tilt effects disabled for the native QS backdrop.
            f("uMetaballEnable", 0); f("uBodyRect", 0, 0, 0, 0);
            f("uBall1", 0, 0, 0, 0); f("uBall2", 0, 0, 0, 0); f("uBall3", 0, 0, 0, 0);
            f("uMetaballParam", 0, 0, 0, 0); f("uTilt", 0, 0, 0, 0);
        }
        width = w; height = h;
    }

    private void f(String name, float... values) { lens.setFloatUniform(name, values); }

    private static void fail(int e, Throwable ex) {
        boolean permanent=ex instanceof IllegalArgumentException || ex instanceof LinkageError;
        if (HEALTH.record(e,SystemClock.uptimeMillis(),permanent))
            Log.w(TAG,"Glass engine "+e+" unavailable; retaining Samsung blur",ex);
    }

    @Override public void draw(Canvas canvas) {
        Rect b = getBounds();
        if (b.isEmpty() || getAlpha() == 0) return;
        Bitmap blurred=fallback.getBitmap();
        // Native capture disposal may race the last display-list draw. Do not
        // upload a recycled bitmap, retry a dead capture or substitute raw data.
        fallback.setBounds(b);
        if (engine == 0) {
            if (pureBlack(context)) {
                black.setAlpha(getAlpha());
                canvas.drawRect(b, black);
            } else if(blurred!=null && !blurred.isRecycled()) {
                fallback.draw(canvas);
            }
            return;
        }
        if(blurred==null || blurred.isRecycled())return;
        long now = SystemClock.uptimeMillis();
        // At most once per second WHILE drawn; no timer, observer or idle work.
        if (now >= nextPolicyCheck) {
            allowed = selected(context) == engine && policyAllows(context);
            nextPolicyCheck = now + 1000;
        }
        if (!allowed || failed || !HEALTH.available(engine,now) || !canvas.isHardwareAccelerated()
                || b.width() < 4 || b.height() < 4
                || (long)b.width()*b.height() > MAX_PIXELS || raw.isRecycled()) {
            fallback.draw(canvas); return;
        }
        int save = canvas.save();
        try {
            if (width != b.width() || height != b.height()) configure(b.width(), b.height());
            canvas.translate(b.left, b.top);
            canvas.drawRect(0, 0, width, height, glass);
            float r = Math.min(28*density, Math.min(width, height)/2f);
            canvas.drawRoundRect(0, 0, width, height, r, r, veil);
        } catch (RuntimeException | LinkageError | OutOfMemoryError ex) {
            failed=true;
            fail(engine, ex);
        } finally { canvas.restoreToCount(save); }
        if (failed) fallback.draw(canvas);
    }

    @Override public void setAlpha(int alpha) {
        super.setAlpha(alpha);
        if (fallback != null) fallback.setAlpha(alpha);
        if (glass != null) glass.setAlpha(alpha);
        if (veil != null) veil.setAlpha(Math.round(alpha*0.2f));
        invalidateSelf();
    }
    @Override public void setColorFilter(ColorFilter filter) {
        super.setColorFilter(filter);
        if (fallback != null) fallback.setColorFilter(filter);
        if (glass != null) glass.setColorFilter(filter);
        invalidateSelf();
    }
    @Override public int getOpacity() { return android.graphics.PixelFormat.TRANSLUCENT; }
}
