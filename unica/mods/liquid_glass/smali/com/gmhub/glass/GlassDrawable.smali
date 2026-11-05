.class public final Lcom/gmhub/glass/GlassDrawable;
.super Landroid/graphics/drawable/BitmapDrawable;
.source "GlassDrawable.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/gmhub/glass/GlassDrawable$Health;
    }
.end annotation


# static fields
.field public static final ENGINE_KEY:Ljava/lang/String; = "gmhub_liquid_glass_engine"

.field private static final HEALTH:Lcom/gmhub/glass/GlassDrawable$Health;

.field private static final MAPPER:Ljava/lang/String; = "uniform shader bitmap; uniform float2 captureSize; uniform float2 viewSize; half4 main(float2 p) { return bitmap.eval(clamp(p / viewSize * captureSize, float2(0.5), captureSize - 0.5)); }"

.field private static final MAX_PIXELS:I = 0x400000

.field private static final MAX_SHADER_BYTES:I = 0x20000

.field public static final PURE_BLACK_KEY:Ljava/lang/String; = "gmhub_pure_black"

.field private static final SOURCES:[Ljava/lang/String;

.field private static final TAG:Ljava/lang/String; = "GMHubGlass"


# instance fields
.field private allowed:Z

.field private final black:Landroid/graphics/Paint;

.field private final context:Landroid/content/Context;

.field private final density:F

.field private final engine:I

.field private failed:Z

.field private final fallback:Landroid/graphics/drawable/BitmapDrawable;

.field private final glass:Landroid/graphics/Paint;

.field private height:I

.field private final lens:Landroid/graphics/RuntimeShader;

.field private final mapper:Landroid/graphics/RuntimeShader;

.field private nextPolicyCheck:J

.field private final raw:Landroid/graphics/Bitmap;

.field private final veil:Landroid/graphics/Paint;

.field private width:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const/4 v0, 0x4

    new-array v0, v0, [Ljava/lang/String;

    sput-object v0, Lcom/gmhub/glass/GlassDrawable;->SOURCES:[Ljava/lang/String;

    new-instance v0, Lcom/gmhub/glass/GlassDrawable$Health;

    invoke-direct {v0}, Lcom/gmhub/glass/GlassDrawable$Health;-><init>()V

    sput-object v0, Lcom/gmhub/glass/GlassDrawable;->HEALTH:Lcom/gmhub/glass/GlassDrawable$Health;

    return-void
.end method

.method private constructor <init>(Landroid/content/Context;Landroid/graphics/Bitmap;Landroid/graphics/drawable/BitmapDrawable;I)V
    .locals 4

    invoke-virtual {p1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {p3}, Landroid/graphics/drawable/BitmapDrawable;->getBitmap()Landroid/graphics/Bitmap;

    move-result-object v1

    invoke-direct {p0, v0, v1}, Landroid/graphics/drawable/BitmapDrawable;-><init>(Landroid/content/res/Resources;Landroid/graphics/Bitmap;)V

    new-instance v0, Landroid/graphics/Paint;

    const/4 v1, 0x1

    invoke-direct {v0, v1}, Landroid/graphics/Paint;-><init>(I)V

    iput-object v0, p0, Lcom/gmhub/glass/GlassDrawable;->glass:Landroid/graphics/Paint;

    new-instance v2, Landroid/graphics/Paint;

    invoke-direct {v2, v1}, Landroid/graphics/Paint;-><init>(I)V

    iput-object v2, p0, Lcom/gmhub/glass/GlassDrawable;->veil:Landroid/graphics/Paint;

    new-instance v1, Landroid/graphics/Paint;

    invoke-direct {v1}, Landroid/graphics/Paint;-><init>()V

    iput-object v1, p0, Lcom/gmhub/glass/GlassDrawable;->black:Landroid/graphics/Paint;

    iput-object p1, p0, Lcom/gmhub/glass/GlassDrawable;->context:Landroid/content/Context;

    iput-object p3, p0, Lcom/gmhub/glass/GlassDrawable;->fallback:Landroid/graphics/drawable/BitmapDrawable;

    iput-object p2, p0, Lcom/gmhub/glass/GlassDrawable;->raw:Landroid/graphics/Bitmap;

    iput p4, p0, Lcom/gmhub/glass/GlassDrawable;->engine:I

    invoke-virtual {p1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v3

    invoke-virtual {v3}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v3

    iget v3, v3, Landroid/util/DisplayMetrics;->density:F

    iput v3, p0, Lcom/gmhub/glass/GlassDrawable;->density:F

    const/high16 v3, -0x1000000

    invoke-virtual {v1, v3}, Landroid/graphics/Paint;->setColor(I)V

    const/high16 v1, 0x33000000

    invoke-virtual {v2, v1}, Landroid/graphics/Paint;->setColor(I)V

    invoke-virtual {p3}, Landroid/graphics/drawable/BitmapDrawable;->getAlpha()I

    move-result v1

    invoke-virtual {p0, v1}, Lcom/gmhub/glass/GlassDrawable;->setAlpha(I)V

    invoke-virtual {p3}, Landroid/graphics/drawable/BitmapDrawable;->getColorFilter()Landroid/graphics/ColorFilter;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/gmhub/glass/GlassDrawable;->setColorFilter(Landroid/graphics/ColorFilter;)V

    const/4 v1, 0x0

    if-nez p4, :cond_0

    iput-object v1, p0, Lcom/gmhub/glass/GlassDrawable;->lens:Landroid/graphics/RuntimeShader;

    iput-object v1, p0, Lcom/gmhub/glass/GlassDrawable;->mapper:Landroid/graphics/RuntimeShader;

    return-void

    :cond_0
    new-instance v2, Landroid/graphics/RuntimeShader;

    invoke-static {p1, p4}, Lcom/gmhub/glass/GlassDrawable;->source(Landroid/content/Context;I)Ljava/lang/String;

    move-result-object p1

    invoke-direct {v2, p1}, Landroid/graphics/RuntimeShader;-><init>(Ljava/lang/String;)V

    iput-object v2, p0, Lcom/gmhub/glass/GlassDrawable;->lens:Landroid/graphics/RuntimeShader;

    const/4 p1, 0x3

    if-ne p4, p1, :cond_1

    goto :goto_0

    :cond_1
    new-instance v1, Landroid/graphics/RuntimeShader;

    const-string v3, "uniform shader bitmap; uniform float2 captureSize; uniform float2 viewSize; half4 main(float2 p) { return bitmap.eval(clamp(p / viewSize * captureSize, float2(0.5), captureSize - 0.5)); }"

    invoke-direct {v1, v3}, Landroid/graphics/RuntimeShader;-><init>(Ljava/lang/String;)V

    :goto_0
    iput-object v1, p0, Lcom/gmhub/glass/GlassDrawable;->mapper:Landroid/graphics/RuntimeShader;

    if-ne p4, p1, :cond_2

    goto :goto_1

    :cond_2
    invoke-virtual {p3}, Landroid/graphics/drawable/BitmapDrawable;->getBitmap()Landroid/graphics/Bitmap;

    move-result-object p2

    :goto_1
    if-eqz p2, :cond_4

    invoke-virtual {p2}, Landroid/graphics/Bitmap;->isRecycled()Z

    move-result p0

    if-nez p0, :cond_4

    new-instance p0, Landroid/graphics/BitmapShader;

    sget-object p1, Landroid/graphics/Shader$TileMode;->CLAMP:Landroid/graphics/Shader$TileMode;

    sget-object p3, Landroid/graphics/Shader$TileMode;->CLAMP:Landroid/graphics/Shader$TileMode;

    invoke-direct {p0, p2, p1, p3}, Landroid/graphics/BitmapShader;-><init>(Landroid/graphics/Bitmap;Landroid/graphics/Shader$TileMode;Landroid/graphics/Shader$TileMode;)V

    const/4 p1, 0x2

    invoke-virtual {p0, p1}, Landroid/graphics/BitmapShader;->setFilterMode(I)V

    if-eqz v1, :cond_3

    const-string p1, "bitmap"

    invoke-virtual {v1, p1, p0}, Landroid/graphics/RuntimeShader;->setInputShader(Ljava/lang/String;Landroid/graphics/Shader;)V

    invoke-virtual {p2}, Landroid/graphics/Bitmap;->getWidth()I

    move-result p0

    int-to-float p0, p0

    invoke-virtual {p2}, Landroid/graphics/Bitmap;->getHeight()I

    move-result p1

    int-to-float p1, p1

    const-string p2, "captureSize"

    invoke-virtual {v1, p2, p0, p1}, Landroid/graphics/RuntimeShader;->setFloatUniform(Ljava/lang/String;FF)V

    const-string p0, "content"

    invoke-virtual {v2, p0, v1}, Landroid/graphics/RuntimeShader;->setInputShader(Ljava/lang/String;Landroid/graphics/Shader;)V

    goto :goto_2

    :cond_3
    const-string p1, "uSource"

    invoke-virtual {v2, p1, p0}, Landroid/graphics/RuntimeShader;->setInputShader(Ljava/lang/String;Landroid/graphics/Shader;)V

    const-string p1, "uSourceLowRes"

    invoke-virtual {v2, p1, p0}, Landroid/graphics/RuntimeShader;->setInputShader(Ljava/lang/String;Landroid/graphics/Shader;)V

    :goto_2
    invoke-virtual {v0, v2}, Landroid/graphics/Paint;->setShader(Landroid/graphics/Shader;)Landroid/graphics/Shader;

    return-void

    :cond_4
    new-instance p0, Ljava/lang/IllegalStateException;

    const-string p1, "Missing captured backdrop"

    invoke-direct {p0, p1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p0
.end method

.method private configure(II)V
    .locals 22

    move-object/from16 v0, p0

    move/from16 v1, p1

    move/from16 v2, p2

    const/high16 v3, 0x41e00000    # 28.0f

    iget v4, v0, Lcom/gmhub/glass/GlassDrawable;->density:F

    mul-float/2addr v4, v3

    invoke-static/range {p1 .. p2}, Ljava/lang/Math;->min(II)I

    move-result v3

    int-to-float v3, v3

    const/high16 v5, 0x40000000    # 2.0f

    div-float/2addr v3, v5

    invoke-static {v4, v3}, Ljava/lang/Math;->min(FF)F

    move-result v3

    const/high16 v4, 0x41900000    # 18.0f

    iget v6, v0, Lcom/gmhub/glass/GlassDrawable;->density:F

    mul-float/2addr v6, v4

    invoke-static/range {p1 .. p2}, Ljava/lang/Math;->min(II)I

    move-result v4

    int-to-float v4, v4

    const/high16 v7, 0x40800000    # 4.0f

    div-float/2addr v4, v7

    invoke-static {v6, v4}, Ljava/lang/Math;->min(FF)F

    move-result v4

    const/high16 v6, 0x3f800000    # 1.0f

    invoke-static {v6, v4}, Ljava/lang/Math;->max(FF)F

    move-result v4

    iget-object v7, v0, Lcom/gmhub/glass/GlassDrawable;->mapper:Landroid/graphics/RuntimeShader;

    const-string v8, "viewSize"

    if-eqz v7, :cond_0

    int-to-float v9, v1

    int-to-float v10, v2

    invoke-virtual {v7, v8, v9, v10}, Landroid/graphics/RuntimeShader;->setFloatUniform(Ljava/lang/String;FF)V

    :cond_0
    iget v7, v0, Lcom/gmhub/glass/GlassDrawable;->engine:I

    const/4 v12, 0x3

    const/4 v13, 0x4

    const/4 v14, 0x2

    const/4 v15, 0x0

    move/from16 v16, v5

    const/4 v5, 0x1

    const/16 v17, 0x0

    if-ne v7, v5, :cond_1

    new-array v7, v5, [F

    aput v17, v7, v15

    move/from16 v18, v6

    const-string v6, "margin"

    invoke-direct {v0, v6, v7}, Lcom/gmhub/glass/GlassDrawable;->f(Ljava/lang/String;[F)V

    int-to-float v6, v1

    int-to-float v7, v2

    const v19, 0x3f933333    # 1.15f

    new-array v9, v14, [F

    aput v6, v9, v15

    aput v7, v9, v5

    invoke-direct {v0, v8, v9}, Lcom/gmhub/glass/GlassDrawable;->f(Ljava/lang/String;[F)V

    div-float v8, v6, v16

    div-float v9, v7, v16

    const v20, 0x3eb33333    # 0.35f

    new-array v10, v13, [F

    aput v8, v10, v15

    aput v9, v10, v5

    aput v8, v10, v14

    aput v9, v10, v12

    const v21, 0x3df5c28f    # 0.12f

    const-string v11, "shape1"

    invoke-direct {v0, v11, v10}, Lcom/gmhub/glass/GlassDrawable;->f(Ljava/lang/String;[F)V

    new-array v10, v13, [F

    aput v8, v10, v15

    aput v9, v10, v5

    aput v8, v10, v14

    aput v9, v10, v12

    const-string v11, "shape1L"

    invoke-direct {v0, v11, v10}, Lcom/gmhub/glass/GlassDrawable;->f(Ljava/lang/String;[F)V

    new-array v10, v13, [F

    aput v3, v10, v15

    aput v3, v10, v5

    aput v3, v10, v14

    aput v3, v10, v12

    const-string v3, "radii1"

    invoke-direct {v0, v3, v10}, Lcom/gmhub/glass/GlassDrawable;->f(Ljava/lang/String;[F)V

    new-array v3, v13, [F

    fill-array-data v3, :array_0

    const-string v10, "shape2"

    invoke-direct {v0, v10, v3}, Lcom/gmhub/glass/GlassDrawable;->f(Ljava/lang/String;[F)V

    new-array v3, v5, [F

    aput v17, v3, v15

    const-string v10, "radius2"

    invoke-direct {v0, v10, v3}, Lcom/gmhub/glass/GlassDrawable;->f(Ljava/lang/String;[F)V

    new-array v3, v5, [F

    aput v17, v3, v15

    const-string v10, "blendK"

    invoke-direct {v0, v10, v3}, Lcom/gmhub/glass/GlassDrawable;->f(Ljava/lang/String;[F)V

    new-array v3, v5, [F

    aput v17, v3, v15

    const-string v10, "rimSoft"

    invoke-direct {v0, v10, v3}, Lcom/gmhub/glass/GlassDrawable;->f(Ljava/lang/String;[F)V

    new-array v3, v5, [F

    aput v4, v3, v15

    const-string v10, "bevel"

    invoke-direct {v0, v10, v3}, Lcom/gmhub/glass/GlassDrawable;->f(Ljava/lang/String;[F)V

    const/high16 v3, 0x41c00000    # 24.0f

    iget v10, v0, Lcom/gmhub/glass/GlassDrawable;->density:F

    mul-float/2addr v10, v3

    invoke-static {v10, v4}, Ljava/lang/Math;->min(FF)F

    move-result v3

    new-array v4, v5, [F

    aput v3, v4, v15

    const-string v3, "refractPx"

    invoke-direct {v0, v3, v4}, Lcom/gmhub/glass/GlassDrawable;->f(Ljava/lang/String;[F)V

    new-array v3, v5, [F

    aput v16, v3, v15

    const-string v4, "falloff"

    invoke-direct {v0, v4, v3}, Lcom/gmhub/glass/GlassDrawable;->f(Ljava/lang/String;[F)V

    new-array v3, v5, [F

    const/high16 v4, -0x40800000    # -1.0f

    aput v4, v3, v15

    const-string v4, "refractDir"

    invoke-direct {v0, v4, v3}, Lcom/gmhub/glass/GlassDrawable;->f(Ljava/lang/String;[F)V

    new-array v3, v14, [F

    fill-array-data v3, :array_1

    const-string v4, "sampleLo"

    invoke-direct {v0, v4, v3}, Lcom/gmhub/glass/GlassDrawable;->f(Ljava/lang/String;[F)V

    const/high16 v3, 0x3f000000    # 0.5f

    sub-float/2addr v6, v3

    sub-float/2addr v7, v3

    new-array v3, v14, [F

    aput v6, v3, v15

    aput v7, v3, v5

    const-string v4, "sampleHi"

    invoke-direct {v0, v4, v3}, Lcom/gmhub/glass/GlassDrawable;->f(Ljava/lang/String;[F)V

    new-array v3, v5, [F

    aput v21, v3, v15

    const-string v4, "dispersion"

    invoke-direct {v0, v4, v3}, Lcom/gmhub/glass/GlassDrawable;->f(Ljava/lang/String;[F)V

    new-array v3, v14, [F

    fill-array-data v3, :array_2

    const-string v4, "lightDir"

    invoke-direct {v0, v4, v3}, Lcom/gmhub/glass/GlassDrawable;->f(Ljava/lang/String;[F)V

    new-array v3, v5, [F

    aput v20, v3, v15

    const-string v4, "specStrength"

    invoke-direct {v0, v4, v3}, Lcom/gmhub/glass/GlassDrawable;->f(Ljava/lang/String;[F)V

    iget v3, v0, Lcom/gmhub/glass/GlassDrawable;->density:F

    mul-float v3, v3, v16

    new-array v4, v5, [F

    aput v3, v4, v15

    const-string v3, "rimBandMax"

    invoke-direct {v0, v3, v4}, Lcom/gmhub/glass/GlassDrawable;->f(Ljava/lang/String;[F)V

    new-array v3, v13, [F

    fill-array-data v3, :array_3

    const-string v4, "tintColor"

    invoke-direct {v0, v4, v3}, Lcom/gmhub/glass/GlassDrawable;->f(Ljava/lang/String;[F)V

    new-array v3, v5, [F

    aput v18, v3, v15

    const-string v4, "adaptiveTint"

    invoke-direct {v0, v4, v3}, Lcom/gmhub/glass/GlassDrawable;->f(Ljava/lang/String;[F)V

    new-array v3, v13, [F

    fill-array-data v3, :array_4

    const-string v4, "glassTint"

    invoke-direct {v0, v4, v3}, Lcom/gmhub/glass/GlassDrawable;->f(Ljava/lang/String;[F)V

    new-array v3, v5, [F

    const v4, 0x3da3d70a    # 0.08f

    aput v4, v3, v15

    const-string v4, "dimAmount"

    invoke-direct {v0, v4, v3}, Lcom/gmhub/glass/GlassDrawable;->f(Ljava/lang/String;[F)V

    new-array v3, v5, [F

    aput v19, v3, v15

    const-string v4, "satFactor"

    invoke-direct {v0, v4, v3}, Lcom/gmhub/glass/GlassDrawable;->f(Ljava/lang/String;[F)V

    new-array v3, v5, [F

    aput v17, v3, v15

    const-string v4, "press"

    invoke-direct {v0, v4, v3}, Lcom/gmhub/glass/GlassDrawable;->f(Ljava/lang/String;[F)V

    new-array v3, v14, [F

    aput v8, v3, v15

    aput v9, v3, v5

    const-string v4, "touchPos"

    invoke-direct {v0, v4, v3}, Lcom/gmhub/glass/GlassDrawable;->f(Ljava/lang/String;[F)V

    new-array v3, v5, [F

    aput v17, v3, v15

    const-string v4, "touchAmp"

    invoke-direct {v0, v4, v3}, Lcom/gmhub/glass/GlassDrawable;->f(Ljava/lang/String;[F)V

    goto/16 :goto_0

    :cond_1
    move/from16 v18, v6

    const v19, 0x3f933333    # 1.15f

    const v20, 0x3eb33333    # 0.35f

    const v21, 0x3df5c28f    # 0.12f

    if-ne v7, v14, :cond_2

    int-to-float v6, v1

    int-to-float v7, v2

    new-array v8, v14, [F

    aput v6, v8, v15

    aput v7, v8, v5

    const-string v6, "size"

    invoke-direct {v0, v6, v8}, Lcom/gmhub/glass/GlassDrawable;->f(Ljava/lang/String;[F)V

    new-array v6, v14, [F

    fill-array-data v6, :array_5

    const-string v7, "offset"

    invoke-direct {v0, v7, v6}, Lcom/gmhub/glass/GlassDrawable;->f(Ljava/lang/String;[F)V

    new-array v6, v13, [F

    aput v3, v6, v15

    aput v3, v6, v5

    aput v3, v6, v14

    aput v3, v6, v12

    const-string v3, "cornerRadii"

    invoke-direct {v0, v3, v6}, Lcom/gmhub/glass/GlassDrawable;->f(Ljava/lang/String;[F)V

    new-array v3, v5, [F

    aput v4, v3, v15

    const-string v6, "refractionHeight"

    invoke-direct {v0, v6, v3}, Lcom/gmhub/glass/GlassDrawable;->f(Ljava/lang/String;[F)V

    neg-float v3, v4

    new-array v4, v5, [F

    aput v3, v4, v15

    const-string v3, "refractionAmount"

    invoke-direct {v0, v3, v4}, Lcom/gmhub/glass/GlassDrawable;->f(Ljava/lang/String;[F)V

    new-array v3, v5, [F

    aput v18, v3, v15

    const-string v4, "depthEffect"

    invoke-direct {v0, v4, v3}, Lcom/gmhub/glass/GlassDrawable;->f(Ljava/lang/String;[F)V

    new-array v3, v5, [F

    aput v21, v3, v15

    const-string v4, "chromaticAberration"

    invoke-direct {v0, v4, v3}, Lcom/gmhub/glass/GlassDrawable;->f(Ljava/lang/String;[F)V

    goto/16 :goto_0

    :cond_2
    iget-object v6, v0, Lcom/gmhub/glass/GlassDrawable;->raw:Landroid/graphics/Bitmap;

    invoke-virtual {v6}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v6

    int-to-float v6, v6

    iget-object v7, v0, Lcom/gmhub/glass/GlassDrawable;->raw:Landroid/graphics/Bitmap;

    invoke-virtual {v7}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v7

    int-to-float v7, v7

    new-array v8, v13, [F

    aput v17, v8, v15

    aput v17, v8, v5

    aput v6, v8, v14

    aput v7, v8, v12

    const-string v6, "uSourceRect"

    invoke-direct {v0, v6, v8}, Lcom/gmhub/glass/GlassDrawable;->f(Ljava/lang/String;[F)V

    iget-object v6, v0, Lcom/gmhub/glass/GlassDrawable;->raw:Landroid/graphics/Bitmap;

    invoke-virtual {v6}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v6

    int-to-float v6, v6

    iget-object v7, v0, Lcom/gmhub/glass/GlassDrawable;->raw:Landroid/graphics/Bitmap;

    invoke-virtual {v7}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v7

    int-to-float v7, v7

    new-array v8, v13, [F

    aput v17, v8, v15

    aput v17, v8, v5

    aput v6, v8, v14

    aput v7, v8, v12

    const-string v6, "uSourceLowResRect"

    invoke-direct {v0, v6, v8}, Lcom/gmhub/glass/GlassDrawable;->f(Ljava/lang/String;[F)V

    iget-object v6, v0, Lcom/gmhub/glass/GlassDrawable;->raw:Landroid/graphics/Bitmap;

    invoke-virtual {v6}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v6

    int-to-float v6, v6

    iget-object v7, v0, Lcom/gmhub/glass/GlassDrawable;->raw:Landroid/graphics/Bitmap;

    invoke-virtual {v7}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v7

    int-to-float v7, v7

    new-array v8, v14, [F

    aput v6, v8, v15

    aput v7, v8, v5

    const-string v6, "uSourceSize"

    invoke-direct {v0, v6, v8}, Lcom/gmhub/glass/GlassDrawable;->f(Ljava/lang/String;[F)V

    int-to-float v6, v1

    int-to-float v7, v2

    new-array v8, v14, [F

    aput v6, v8, v15

    aput v7, v8, v5

    const-string v9, "uViewport"

    invoke-direct {v0, v9, v8}, Lcom/gmhub/glass/GlassDrawable;->f(Ljava/lang/String;[F)V

    new-array v8, v5, [F

    aput v3, v8, v15

    const-string v3, "uCornerRadius"

    invoke-direct {v0, v3, v8}, Lcom/gmhub/glass/GlassDrawable;->f(Ljava/lang/String;[F)V

    new-array v3, v5, [F

    aput v17, v3, v15

    const-string v8, "uCornerIsConic"

    invoke-direct {v0, v8, v3}, Lcom/gmhub/glass/GlassDrawable;->f(Ljava/lang/String;[F)V

    new-array v3, v5, [F

    const v8, 0x3fb2ca58    # 1.3968f

    aput v8, v3, v15

    const-string v9, "uCornerWeight"

    invoke-direct {v0, v9, v3}, Lcom/gmhub/glass/GlassDrawable;->f(Ljava/lang/String;[F)V

    new-array v3, v5, [F

    aput v17, v3, v15

    const-string v9, "uCornerConicBlend"

    invoke-direct {v0, v9, v3}, Lcom/gmhub/glass/GlassDrawable;->f(Ljava/lang/String;[F)V

    new-array v3, v5, [F

    aput v17, v3, v15

    const-string v9, "uBlurRadius"

    invoke-direct {v0, v9, v3}, Lcom/gmhub/glass/GlassDrawable;->f(Ljava/lang/String;[F)V

    new-array v3, v5, [F

    aput v4, v3, v15

    const-string v9, "uRefractionHeight"

    invoke-direct {v0, v9, v3}, Lcom/gmhub/glass/GlassDrawable;->f(Ljava/lang/String;[F)V

    new-array v3, v5, [F

    aput v4, v3, v15

    const-string v4, "uRefractionAmount"

    invoke-direct {v0, v4, v3}, Lcom/gmhub/glass/GlassDrawable;->f(Ljava/lang/String;[F)V

    new-array v3, v5, [F

    aput v18, v3, v15

    const-string v4, "uDepth"

    invoke-direct {v0, v4, v3}, Lcom/gmhub/glass/GlassDrawable;->f(Ljava/lang/String;[F)V

    new-array v3, v5, [F

    aput v21, v3, v15

    const-string v4, "uDispersion"

    invoke-direct {v0, v4, v3}, Lcom/gmhub/glass/GlassDrawable;->f(Ljava/lang/String;[F)V

    new-array v3, v5, [F

    aput v20, v3, v15

    const-string v4, "uHighlight"

    invoke-direct {v0, v4, v3}, Lcom/gmhub/glass/GlassDrawable;->f(Ljava/lang/String;[F)V

    iget v3, v0, Lcom/gmhub/glass/GlassDrawable;->density:F

    mul-float v3, v3, v16

    new-array v4, v5, [F

    aput v3, v4, v15

    const-string v3, "uHighlightWidth"

    invoke-direct {v0, v3, v4}, Lcom/gmhub/glass/GlassDrawable;->f(Ljava/lang/String;[F)V

    new-array v3, v5, [F

    aput v16, v3, v15

    const-string v4, "uHighlightFalloff"

    invoke-direct {v0, v4, v3}, Lcom/gmhub/glass/GlassDrawable;->f(Ljava/lang/String;[F)V

    new-array v3, v5, [F

    const v4, 0x3ecccccd    # 0.4f

    aput v4, v3, v15

    const-string v4, "uHighlightFloor"

    invoke-direct {v0, v4, v3}, Lcom/gmhub/glass/GlassDrawable;->f(Ljava/lang/String;[F)V

    new-array v3, v5, [F

    aput v17, v3, v15

    const-string v4, "uHighlightInnerAtt"

    invoke-direct {v0, v4, v3}, Lcom/gmhub/glass/GlassDrawable;->f(Ljava/lang/String;[F)V

    new-array v3, v5, [F

    aput v17, v3, v15

    const-string v4, "uInnerGlow"

    invoke-direct {v0, v4, v3}, Lcom/gmhub/glass/GlassDrawable;->f(Ljava/lang/String;[F)V

    new-array v3, v5, [F

    aput v19, v3, v15

    const-string v4, "uVibrancy"

    invoke-direct {v0, v4, v3}, Lcom/gmhub/glass/GlassDrawable;->f(Ljava/lang/String;[F)V

    new-array v3, v5, [F

    const v4, 0x3f490fdb

    aput v4, v3, v15

    const-string v4, "uLightAngle"

    invoke-direct {v0, v4, v3}, Lcom/gmhub/glass/GlassDrawable;->f(Ljava/lang/String;[F)V

    new-array v3, v14, [F

    fill-array-data v3, :array_6

    const-string v4, "uParallax"

    invoke-direct {v0, v4, v3}, Lcom/gmhub/glass/GlassDrawable;->f(Ljava/lang/String;[F)V

    new-array v3, v5, [F

    aput v17, v3, v15

    const-string v4, "uDebugCoord"

    invoke-direct {v0, v4, v3}, Lcom/gmhub/glass/GlassDrawable;->f(Ljava/lang/String;[F)V

    new-array v3, v5, [F

    aput v17, v3, v15

    const-string v4, "uDebugHighlight"

    invoke-direct {v0, v4, v3}, Lcom/gmhub/glass/GlassDrawable;->f(Ljava/lang/String;[F)V

    new-array v3, v13, [F

    aput v17, v3, v15

    aput v17, v3, v5

    aput v6, v3, v14

    aput v7, v3, v12

    const-string v4, "uMaskRect"

    invoke-direct {v0, v4, v3}, Lcom/gmhub/glass/GlassDrawable;->f(Ljava/lang/String;[F)V

    new-array v3, v5, [F

    aput v17, v3, v15

    const-string v4, "uMaskCornerRadius"

    invoke-direct {v0, v4, v3}, Lcom/gmhub/glass/GlassDrawable;->f(Ljava/lang/String;[F)V

    new-array v3, v5, [F

    aput v8, v3, v15

    const-string v4, "uMaskWeight"

    invoke-direct {v0, v4, v3}, Lcom/gmhub/glass/GlassDrawable;->f(Ljava/lang/String;[F)V

    new-array v3, v14, [F

    fill-array-data v3, :array_7

    const-string v4, "uMaskOffset"

    invoke-direct {v0, v4, v3}, Lcom/gmhub/glass/GlassDrawable;->f(Ljava/lang/String;[F)V

    new-array v3, v5, [F

    aput v17, v3, v15

    const-string v4, "uMaskAlpha"

    invoke-direct {v0, v4, v3}, Lcom/gmhub/glass/GlassDrawable;->f(Ljava/lang/String;[F)V

    new-array v3, v13, [F

    fill-array-data v3, :array_8

    const-string v4, "uMaskColor"

    invoke-direct {v0, v4, v3}, Lcom/gmhub/glass/GlassDrawable;->f(Ljava/lang/String;[F)V

    new-array v3, v5, [F

    aput v17, v3, v15

    const-string v4, "uMetaballEnable"

    invoke-direct {v0, v4, v3}, Lcom/gmhub/glass/GlassDrawable;->f(Ljava/lang/String;[F)V

    new-array v3, v13, [F

    fill-array-data v3, :array_9

    const-string v4, "uBodyRect"

    invoke-direct {v0, v4, v3}, Lcom/gmhub/glass/GlassDrawable;->f(Ljava/lang/String;[F)V

    new-array v3, v13, [F

    fill-array-data v3, :array_a

    const-string v4, "uBall1"

    invoke-direct {v0, v4, v3}, Lcom/gmhub/glass/GlassDrawable;->f(Ljava/lang/String;[F)V

    new-array v3, v13, [F

    fill-array-data v3, :array_b

    const-string v4, "uBall2"

    invoke-direct {v0, v4, v3}, Lcom/gmhub/glass/GlassDrawable;->f(Ljava/lang/String;[F)V

    new-array v3, v13, [F

    fill-array-data v3, :array_c

    const-string v4, "uBall3"

    invoke-direct {v0, v4, v3}, Lcom/gmhub/glass/GlassDrawable;->f(Ljava/lang/String;[F)V

    new-array v3, v13, [F

    fill-array-data v3, :array_d

    const-string v4, "uMetaballParam"

    invoke-direct {v0, v4, v3}, Lcom/gmhub/glass/GlassDrawable;->f(Ljava/lang/String;[F)V

    new-array v3, v13, [F

    fill-array-data v3, :array_e

    const-string v4, "uTilt"

    invoke-direct {v0, v4, v3}, Lcom/gmhub/glass/GlassDrawable;->f(Ljava/lang/String;[F)V

    :goto_0
    iput v1, v0, Lcom/gmhub/glass/GlassDrawable;->width:I

    iput v2, v0, Lcom/gmhub/glass/GlassDrawable;->height:I

    return-void

    nop

    :array_0
    .array-data 4
        0x0
        0x0
        0x0
        0x0
    .end array-data

    :array_1
    .array-data 4
        0x3f000000    # 0.5f
        0x3f000000    # 0.5f
    .end array-data

    :array_2
    .array-data 4
        0x3f5db22d    # 0.866f
        0x3f000000    # 0.5f
    .end array-data

    :array_3
    .array-data 4
        0x3f800000    # 1.0f
        0x3f800000    # 1.0f
        0x3f800000    # 1.0f
        0x3d23d70a    # 0.04f
    .end array-data

    :array_4
    .array-data 4
        0x0
        0x0
        0x0
        0x0
    .end array-data

    :array_5
    .array-data 4
        0x0
        0x0
    .end array-data

    :array_6
    .array-data 4
        0x0
        0x0
    .end array-data

    :array_7
    .array-data 4
        0x0
        0x0
    .end array-data

    :array_8
    .array-data 4
        0x0
        0x0
        0x0
        0x3f800000    # 1.0f
    .end array-data

    :array_9
    .array-data 4
        0x0
        0x0
        0x0
        0x0
    .end array-data

    :array_a
    .array-data 4
        0x0
        0x0
        0x0
        0x0
    .end array-data

    :array_b
    .array-data 4
        0x0
        0x0
        0x0
        0x0
    .end array-data

    :array_c
    .array-data 4
        0x0
        0x0
        0x0
        0x0
    .end array-data

    :array_d
    .array-data 4
        0x0
        0x0
        0x0
        0x0
    .end array-data

    :array_e
    .array-data 4
        0x0
        0x0
        0x0
        0x0
    .end array-data
.end method

.method private varargs f(Ljava/lang/String;[F)V
    .locals 0

    iget-object p0, p0, Lcom/gmhub/glass/GlassDrawable;->lens:Landroid/graphics/RuntimeShader;

    invoke-virtual {p0, p1, p2}, Landroid/graphics/RuntimeShader;->setFloatUniform(Ljava/lang/String;[F)V

    return-void
.end method

.method private static fail(ILjava/lang/Throwable;)V
    .locals 4

    instance-of v0, p1, Ljava/lang/IllegalArgumentException;

    if-nez v0, :cond_1

    instance-of v0, p1, Ljava/lang/LinkageError;

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    goto :goto_1

    :cond_1
    :goto_0
    const/4 v0, 0x1

    :goto_1
    sget-object v1, Lcom/gmhub/glass/GlassDrawable;->HEALTH:Lcom/gmhub/glass/GlassDrawable$Health;

    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v2

    invoke-virtual {v1, p0, v2, v3, v0}, Lcom/gmhub/glass/GlassDrawable$Health;->record(IJZ)Z

    move-result v0

    if-eqz v0, :cond_2

    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "Glass engine "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string p0, " unavailable; retaining Samsung blur"

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    const-string v0, "GMHubGlass"

    invoke-static {v0, p0, p1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    :cond_2
    return-void
.end method

.method private static policyAllows(Landroid/content/Context;)Z
    .locals 3

    const/4 v0, 0x0

    :try_start_0
    const-class v1, Landroid/app/ActivityManager;

    invoke-virtual {p0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/app/ActivityManager;

    const-class v2, Landroid/os/PowerManager;

    invoke-virtual {p0, v2}, Landroid/content/Context;->getSystemService(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/os/PowerManager;

    if-eqz v1, :cond_0

    invoke-virtual {v1}, Landroid/app/ActivityManager;->isLowRamDevice()Z

    move-result v1

    if-nez v1, :cond_0

    if-eqz v2, :cond_0

    invoke-virtual {v2}, Landroid/os/PowerManager;->isPowerSaveMode()Z

    move-result v1

    if-nez v1, :cond_0

    invoke-virtual {v2}, Landroid/os/PowerManager;->getCurrentThermalStatus()I

    move-result v1

    const/4 v2, 0x2

    if-ge v1, v2, :cond_0

    invoke-virtual {p0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    const-string v2, "accessibility_reduce_transparency"

    invoke-static {v1, v2, v0}, Landroid/provider/Settings$Secure;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v1

    if-nez v1, :cond_0

    invoke-virtual {p0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object p0

    const-string v1, "high_text_contrast_enabled"

    invoke-static {p0, v1, v0}, Landroid/provider/Settings$Secure;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result p0
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    if-nez p0, :cond_0

    const/4 p0, 0x1

    return p0

    :catch_0
    :cond_0
    return v0
.end method

.method private static pureBlack(Landroid/content/Context;)Z
    .locals 3

    const/4 v0, 0x0

    :try_start_0
    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v1

    iget v1, v1, Landroid/content/res/Configuration;->uiMode:I

    and-int/lit8 v1, v1, 0x30

    const/16 v2, 0x20

    if-ne v1, v2, :cond_0

    invoke-virtual {p0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object p0

    const-string v1, "gmhub_pure_black"

    invoke-static {p0, v1, v0}, Landroid/provider/Settings$Secure;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result p0
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    const/4 v1, 0x1

    if-ne p0, v1, :cond_0

    return v1

    :catch_0
    :cond_0
    return v0
.end method

.method private static selected(Landroid/content/Context;)I
    .locals 2

    const/4 v0, 0x0

    :try_start_0
    invoke-virtual {p0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object p0

    const-string v1, "gmhub_liquid_glass_engine"

    invoke-static {p0, v1, v0}, Landroid/provider/Settings$Global;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result p0
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    const/4 v1, 0x1

    if-lt p0, v1, :cond_0

    const/4 v1, 0x3

    if-gt p0, v1, :cond_0

    return p0

    :catch_0
    :cond_0
    return v0
.end method

.method private static declared-synchronized source(Landroid/content/Context;I)Ljava/lang/String;
    .locals 6

    const-string v0, "gmhub/liquid_glass/"

    const-class v1, Lcom/gmhub/glass/GlassDrawable;

    monitor-enter v1

    :try_start_0
    sget-object v2, Lcom/gmhub/glass/GlassDrawable;->SOURCES:[Ljava/lang/String;

    aget-object v2, v2, p1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_4

    if-eqz v2, :cond_0

    monitor-exit v1

    return-object v2

    :cond_0
    :try_start_1
    const-string v2, ""

    const-string v3, "qwea"

    const-string v4, "kyant"

    const-string v5, "color"

    filled-new-array {v2, v3, v4, v5}, [Ljava/lang/String;

    move-result-object v2
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_4

    :try_start_2
    invoke-virtual {p0}, Landroid/content/Context;->getAssets()Landroid/content/res/AssetManager;

    move-result-object p0

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    aget-object v0, v2, p1

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v0, ".agsl"

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Landroid/content/res/AssetManager;->open(Ljava/lang/String;)Ljava/io/InputStream;

    move-result-object p0
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_4

    :try_start_3
    new-instance v0, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v0}, Ljava/io/ByteArrayOutputStream;-><init>()V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_2

    const/16 v2, 0x1000

    :try_start_4
    new-array v2, v2, [B

    :goto_0
    invoke-virtual {p0, v2}, Ljava/io/InputStream;->read([B)I

    move-result v3

    const/4 v4, -0x1

    if-eq v3, v4, :cond_2

    invoke-virtual {v0}, Ljava/io/ByteArrayOutputStream;->size()I

    move-result v4

    add-int/2addr v4, v3

    const/high16 v5, 0x20000

    if-gt v4, v5, :cond_1

    const/4 v4, 0x0

    invoke-virtual {v0, v2, v4, v3}, Ljava/io/ByteArrayOutputStream;->write([BII)V

    goto :goto_0

    :cond_1
    new-instance p1, Ljava/lang/IllegalArgumentException;

    const-string v2, "Shader exceeds size limit"

    invoke-direct {p1, v2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p1

    :cond_2
    new-instance v2, Ljava/lang/String;

    invoke-virtual {v0}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v3

    sget-object v4, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-direct {v2, v3, v4}, Ljava/lang/String;-><init>([BLjava/nio/charset/Charset;)V

    invoke-virtual {v2}, Ljava/lang/String;->isEmpty()Z

    move-result v3

    if-nez v3, :cond_4

    sget-object v3, Lcom/gmhub/glass/GlassDrawable;->SOURCES:[Ljava/lang/String;

    aput-object v2, v3, p1
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    :try_start_5
    invoke-virtual {v0}, Ljava/io/ByteArrayOutputStream;->close()V
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_2

    if-eqz p0, :cond_3

    :try_start_6
    invoke-virtual {p0}, Ljava/io/InputStream;->close()V
    :try_end_6
    .catch Ljava/io/IOException; {:try_start_6 .. :try_end_6} :catch_0
    .catchall {:try_start_6 .. :try_end_6} :catchall_4

    :cond_3
    monitor-exit v1

    return-object v2

    :cond_4
    :try_start_7
    new-instance p1, Ljava/lang/IllegalArgumentException;

    const-string v2, "Empty shader"

    invoke-direct {p1, v2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p1
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_0

    :catchall_0
    move-exception p1

    :try_start_8
    invoke-virtual {v0}, Ljava/io/ByteArrayOutputStream;->close()V
    :try_end_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_1

    goto :goto_1

    :catchall_1
    move-exception v0

    :try_start_9
    invoke-virtual {p1, v0}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    :goto_1
    throw p1
    :try_end_9
    .catchall {:try_start_9 .. :try_end_9} :catchall_2

    :catchall_2
    move-exception p1

    if-eqz p0, :cond_5

    :try_start_a
    invoke-virtual {p0}, Ljava/io/InputStream;->close()V
    :try_end_a
    .catchall {:try_start_a .. :try_end_a} :catchall_3

    goto :goto_2

    :catchall_3
    move-exception p0

    :try_start_b
    invoke-virtual {p1, p0}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    :cond_5
    :goto_2
    throw p1
    :try_end_b
    .catch Ljava/io/IOException; {:try_start_b .. :try_end_b} :catch_0
    .catchall {:try_start_b .. :try_end_b} :catchall_4

    :catch_0
    move-exception p0

    :try_start_c
    new-instance p1, Ljava/lang/IllegalArgumentException;

    const-string v0, "Missing glass asset"

    invoke-direct {p1, v0, p0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw p1

    :catchall_4
    move-exception p0

    monitor-exit v1
    :try_end_c
    .catchall {:try_start_c .. :try_end_c} :catchall_4

    throw p0
.end method

.method private static usable(Landroid/graphics/Bitmap;)Z
    .locals 4

    if-eqz p0, :cond_0

    invoke-virtual {p0}, Landroid/graphics/Bitmap;->isRecycled()Z

    move-result v0

    if-nez v0, :cond_0

    invoke-virtual {p0}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v0

    const/4 v1, 0x4

    if-lt v0, v1, :cond_0

    invoke-virtual {p0}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v0

    if-lt v0, v1, :cond_0

    invoke-virtual {p0}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v0

    int-to-long v0, v0

    invoke-virtual {p0}, Landroid/graphics/Bitmap;->getHeight()I

    move-result p0

    int-to-long v2, p0

    mul-long/2addr v0, v2

    const-wide/32 v2, 0x400000

    cmp-long p0, v0, v2

    if-gtz p0, :cond_0

    const/4 p0, 0x1

    return p0

    :cond_0
    const/4 p0, 0x0

    return p0
.end method

.method public static wrap(Landroid/content/Context;Landroid/graphics/Bitmap;Landroid/graphics/drawable/BitmapDrawable;Ljava/lang/String;)Landroid/graphics/drawable/BitmapDrawable;
    .locals 3

    const-string v0, "QUICK_PANEL"

    invoke-virtual {v0, p3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p3

    if-eqz p3, :cond_3

    if-eqz p2, :cond_3

    invoke-static {p0}, Lcom/gmhub/glass/GlassDrawable;->pureBlack(Landroid/content/Context;)Z

    move-result p3

    if-eqz p3, :cond_0

    :try_start_0
    new-instance p3, Lcom/gmhub/glass/GlassDrawable;

    const/4 v0, 0x0

    invoke-direct {p3, p0, p1, p2, v0}, Lcom/gmhub/glass/GlassDrawable;-><init>(Landroid/content/Context;Landroid/graphics/Bitmap;Landroid/graphics/drawable/BitmapDrawable;I)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/LinkageError; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/OutOfMemoryError; {:try_start_0 .. :try_end_0} :catch_1

    return-object p3

    :cond_0
    invoke-static {p1}, Lcom/gmhub/glass/GlassDrawable;->usable(Landroid/graphics/Bitmap;)Z

    move-result p3

    if-eqz p3, :cond_3

    invoke-virtual {p2}, Landroid/graphics/drawable/BitmapDrawable;->getBitmap()Landroid/graphics/Bitmap;

    move-result-object p3

    invoke-static {p3}, Lcom/gmhub/glass/GlassDrawable;->usable(Landroid/graphics/Bitmap;)Z

    move-result p3

    if-nez p3, :cond_1

    goto :goto_0

    :cond_1
    invoke-static {p0}, Lcom/gmhub/glass/GlassDrawable;->selected(Landroid/content/Context;)I

    move-result p3

    sget-object v0, Lcom/gmhub/glass/GlassDrawable;->HEALTH:Lcom/gmhub/glass/GlassDrawable$Health;

    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v1

    invoke-virtual {v0, p3, v1, v2}, Lcom/gmhub/glass/GlassDrawable$Health;->available(IJ)Z

    move-result v0

    if-eqz v0, :cond_3

    invoke-static {p0}, Lcom/gmhub/glass/GlassDrawable;->policyAllows(Landroid/content/Context;)Z

    move-result v0

    if-nez v0, :cond_2

    goto :goto_0

    :cond_2
    :try_start_1
    new-instance v0, Lcom/gmhub/glass/GlassDrawable;

    invoke-direct {v0, p0, p1, p2, p3}, Lcom/gmhub/glass/GlassDrawable;-><init>(Landroid/content/Context;Landroid/graphics/Bitmap;Landroid/graphics/drawable/BitmapDrawable;I)V
    :try_end_1
    .catch Ljava/lang/RuntimeException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/lang/LinkageError; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/lang/OutOfMemoryError; {:try_start_1 .. :try_end_1} :catch_0

    return-object v0

    :catch_0
    move-exception p0

    invoke-static {p3, p0}, Lcom/gmhub/glass/GlassDrawable;->fail(ILjava/lang/Throwable;)V

    :catch_1
    :cond_3
    :goto_0
    return-object p2
.end method


# virtual methods
.method public draw(Landroid/graphics/Canvas;)V
    .locals 12

    invoke-virtual {p0}, Lcom/gmhub/glass/GlassDrawable;->getBounds()Landroid/graphics/Rect;

    move-result-object v0

    invoke-virtual {v0}, Landroid/graphics/Rect;->isEmpty()Z

    move-result v3

    if-nez v3, :cond_a

    invoke-virtual {p0}, Lcom/gmhub/glass/GlassDrawable;->getAlpha()I

    move-result v3

    if-nez v3, :cond_0

    goto/16 :goto_4

    :cond_0
    iget-object v3, p0, Lcom/gmhub/glass/GlassDrawable;->fallback:Landroid/graphics/drawable/BitmapDrawable;

    invoke-virtual {v3}, Landroid/graphics/drawable/BitmapDrawable;->getBitmap()Landroid/graphics/Bitmap;

    move-result-object v3

    iget-object v4, p0, Lcom/gmhub/glass/GlassDrawable;->fallback:Landroid/graphics/drawable/BitmapDrawable;

    invoke-virtual {v4, v0}, Landroid/graphics/drawable/BitmapDrawable;->setBounds(Landroid/graphics/Rect;)V

    iget v4, p0, Lcom/gmhub/glass/GlassDrawable;->engine:I

    if-nez v4, :cond_2

    iget-object v4, p0, Lcom/gmhub/glass/GlassDrawable;->context:Landroid/content/Context;

    invoke-static {v4}, Lcom/gmhub/glass/GlassDrawable;->pureBlack(Landroid/content/Context;)Z

    move-result v4

    if-eqz v4, :cond_1

    iget-object v3, p0, Lcom/gmhub/glass/GlassDrawable;->black:Landroid/graphics/Paint;

    invoke-virtual {p0}, Lcom/gmhub/glass/GlassDrawable;->getAlpha()I

    move-result v4

    invoke-virtual {v3, v4}, Landroid/graphics/Paint;->setAlpha(I)V

    iget-object v1, p0, Lcom/gmhub/glass/GlassDrawable;->black:Landroid/graphics/Paint;

    invoke-virtual {p1, v0, v1}, Landroid/graphics/Canvas;->drawRect(Landroid/graphics/Rect;Landroid/graphics/Paint;)V

    return-void

    :cond_1
    if-eqz v3, :cond_a

    invoke-virtual {v3}, Landroid/graphics/Bitmap;->isRecycled()Z

    move-result v0

    if-nez v0, :cond_a

    iget-object v0, p0, Lcom/gmhub/glass/GlassDrawable;->fallback:Landroid/graphics/drawable/BitmapDrawable;

    invoke-virtual {v0, p1}, Landroid/graphics/drawable/BitmapDrawable;->draw(Landroid/graphics/Canvas;)V

    return-void

    :cond_2
    if-eqz v3, :cond_a

    invoke-virtual {v3}, Landroid/graphics/Bitmap;->isRecycled()Z

    move-result v3

    if-eqz v3, :cond_3

    goto/16 :goto_4

    :cond_3
    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v3

    iget-wide v5, p0, Lcom/gmhub/glass/GlassDrawable;->nextPolicyCheck:J

    cmp-long v5, v3, v5

    const/4 v10, 0x1

    if-ltz v5, :cond_5

    iget-object v5, p0, Lcom/gmhub/glass/GlassDrawable;->context:Landroid/content/Context;

    invoke-static {v5}, Lcom/gmhub/glass/GlassDrawable;->selected(Landroid/content/Context;)I

    move-result v5

    iget v6, p0, Lcom/gmhub/glass/GlassDrawable;->engine:I

    if-ne v5, v6, :cond_4

    iget-object v5, p0, Lcom/gmhub/glass/GlassDrawable;->context:Landroid/content/Context;

    invoke-static {v5}, Lcom/gmhub/glass/GlassDrawable;->policyAllows(Landroid/content/Context;)Z

    move-result v5

    if-eqz v5, :cond_4

    move v5, v10

    goto :goto_0

    :cond_4
    const/4 v5, 0x0

    :goto_0
    iput-boolean v5, p0, Lcom/gmhub/glass/GlassDrawable;->allowed:Z

    const-wide/16 v5, 0x3e8

    add-long/2addr v5, v3

    iput-wide v5, p0, Lcom/gmhub/glass/GlassDrawable;->nextPolicyCheck:J

    :cond_5
    iget-boolean v5, p0, Lcom/gmhub/glass/GlassDrawable;->allowed:Z

    if-eqz v5, :cond_9

    iget-boolean v5, p0, Lcom/gmhub/glass/GlassDrawable;->failed:Z

    if-nez v5, :cond_9

    sget-object v5, Lcom/gmhub/glass/GlassDrawable;->HEALTH:Lcom/gmhub/glass/GlassDrawable$Health;

    iget v6, p0, Lcom/gmhub/glass/GlassDrawable;->engine:I

    invoke-virtual {v5, v6, v3, v4}, Lcom/gmhub/glass/GlassDrawable$Health;->available(IJ)Z

    move-result v3

    if-eqz v3, :cond_9

    invoke-virtual {p1}, Landroid/graphics/Canvas;->isHardwareAccelerated()Z

    move-result v3

    if-eqz v3, :cond_9

    invoke-virtual {v0}, Landroid/graphics/Rect;->width()I

    move-result v3

    const/4 v4, 0x4

    if-lt v3, v4, :cond_9

    invoke-virtual {v0}, Landroid/graphics/Rect;->height()I

    move-result v3

    if-lt v3, v4, :cond_9

    invoke-virtual {v0}, Landroid/graphics/Rect;->width()I

    move-result v3

    int-to-long v3, v3

    invoke-virtual {v0}, Landroid/graphics/Rect;->height()I

    move-result v5

    int-to-long v5, v5

    mul-long/2addr v3, v5

    const-wide/32 v5, 0x400000

    cmp-long v3, v3, v5

    if-gtz v3, :cond_9

    iget-object v3, p0, Lcom/gmhub/glass/GlassDrawable;->raw:Landroid/graphics/Bitmap;

    invoke-virtual {v3}, Landroid/graphics/Bitmap;->isRecycled()Z

    move-result v3

    if-eqz v3, :cond_6

    goto/16 :goto_3

    :cond_6
    invoke-virtual {p1}, Landroid/graphics/Canvas;->save()I

    move-result v11

    :try_start_0
    iget v3, p0, Lcom/gmhub/glass/GlassDrawable;->width:I

    invoke-virtual {v0}, Landroid/graphics/Rect;->width()I

    move-result v4

    if-ne v3, v4, :cond_7

    iget v3, p0, Lcom/gmhub/glass/GlassDrawable;->height:I

    invoke-virtual {v0}, Landroid/graphics/Rect;->height()I

    move-result v4

    if-eq v3, v4, :cond_8

    :cond_7
    invoke-virtual {v0}, Landroid/graphics/Rect;->width()I

    move-result v3

    invoke-virtual {v0}, Landroid/graphics/Rect;->height()I

    move-result v4

    invoke-direct {p0, v3, v4}, Lcom/gmhub/glass/GlassDrawable;->configure(II)V

    :cond_8
    iget v3, v0, Landroid/graphics/Rect;->left:I

    int-to-float v3, v3

    iget v0, v0, Landroid/graphics/Rect;->top:I

    int-to-float v0, v0

    invoke-virtual {p1, v3, v0}, Landroid/graphics/Canvas;->translate(FF)V

    iget v0, p0, Lcom/gmhub/glass/GlassDrawable;->width:I

    int-to-float v5, v0

    iget v0, p0, Lcom/gmhub/glass/GlassDrawable;->height:I

    int-to-float v6, v0

    iget-object v7, p0, Lcom/gmhub/glass/GlassDrawable;->glass:Landroid/graphics/Paint;

    const/4 v3, 0x0

    const/4 v4, 0x0

    move-object v2, p1

    invoke-virtual/range {v2 .. v7}, Landroid/graphics/Canvas;->drawRect(FFFFLandroid/graphics/Paint;)V

    iget v0, p0, Lcom/gmhub/glass/GlassDrawable;->density:F

    const/high16 v2, 0x41e00000    # 28.0f

    mul-float/2addr v0, v2

    iget v2, p0, Lcom/gmhub/glass/GlassDrawable;->width:I

    iget v3, p0, Lcom/gmhub/glass/GlassDrawable;->height:I

    invoke-static {v2, v3}, Ljava/lang/Math;->min(II)I

    move-result v2

    int-to-float v2, v2

    const/high16 v3, 0x40000000    # 2.0f

    div-float/2addr v2, v3

    invoke-static {v0, v2}, Ljava/lang/Math;->min(FF)F

    move-result v7

    iget v0, p0, Lcom/gmhub/glass/GlassDrawable;->width:I

    int-to-float v5, v0

    iget v0, p0, Lcom/gmhub/glass/GlassDrawable;->height:I

    int-to-float v6, v0

    iget-object v9, p0, Lcom/gmhub/glass/GlassDrawable;->veil:Landroid/graphics/Paint;

    const/4 v3, 0x0

    const/4 v4, 0x0

    move v8, v7

    move-object v2, p1

    invoke-virtual/range {v2 .. v9}, Landroid/graphics/Canvas;->drawRoundRect(FFFFFFLandroid/graphics/Paint;)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/LinkageError; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/OutOfMemoryError; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_1

    :catchall_0
    move-exception v0

    goto :goto_2

    :catch_0
    move-exception v0

    :try_start_1
    iput-boolean v10, p0, Lcom/gmhub/glass/GlassDrawable;->failed:Z

    iget v3, p0, Lcom/gmhub/glass/GlassDrawable;->engine:I

    invoke-static {v3, v0}, Lcom/gmhub/glass/GlassDrawable;->fail(ILjava/lang/Throwable;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :goto_1
    invoke-virtual {p1, v11}, Landroid/graphics/Canvas;->restoreToCount(I)V

    iget-boolean v0, p0, Lcom/gmhub/glass/GlassDrawable;->failed:Z

    if-eqz v0, :cond_a

    iget-object v0, p0, Lcom/gmhub/glass/GlassDrawable;->fallback:Landroid/graphics/drawable/BitmapDrawable;

    invoke-virtual {v0, p1}, Landroid/graphics/drawable/BitmapDrawable;->draw(Landroid/graphics/Canvas;)V

    goto :goto_4

    :goto_2
    invoke-virtual {p1, v11}, Landroid/graphics/Canvas;->restoreToCount(I)V

    throw v0

    :cond_9
    :goto_3
    iget-object v0, p0, Lcom/gmhub/glass/GlassDrawable;->fallback:Landroid/graphics/drawable/BitmapDrawable;

    invoke-virtual {v0, p1}, Landroid/graphics/drawable/BitmapDrawable;->draw(Landroid/graphics/Canvas;)V

    :cond_a
    :goto_4
    return-void
.end method

.method public getOpacity()I
    .locals 0

    const/4 p0, -0x3

    return p0
.end method

.method public setAlpha(I)V
    .locals 2

    invoke-super {p0, p1}, Landroid/graphics/drawable/BitmapDrawable;->setAlpha(I)V

    iget-object v0, p0, Lcom/gmhub/glass/GlassDrawable;->fallback:Landroid/graphics/drawable/BitmapDrawable;

    if-eqz v0, :cond_0

    invoke-virtual {v0, p1}, Landroid/graphics/drawable/BitmapDrawable;->setAlpha(I)V

    :cond_0
    iget-object v0, p0, Lcom/gmhub/glass/GlassDrawable;->glass:Landroid/graphics/Paint;

    if-eqz v0, :cond_1

    invoke-virtual {v0, p1}, Landroid/graphics/Paint;->setAlpha(I)V

    :cond_1
    iget-object v0, p0, Lcom/gmhub/glass/GlassDrawable;->veil:Landroid/graphics/Paint;

    if-eqz v0, :cond_2

    int-to-float p1, p1

    const v1, 0x3e4ccccd    # 0.2f

    mul-float/2addr p1, v1

    invoke-static {p1}, Ljava/lang/Math;->round(F)I

    move-result p1

    invoke-virtual {v0, p1}, Landroid/graphics/Paint;->setAlpha(I)V

    :cond_2
    invoke-virtual {p0}, Lcom/gmhub/glass/GlassDrawable;->invalidateSelf()V

    return-void
.end method

.method public setColorFilter(Landroid/graphics/ColorFilter;)V
    .locals 1

    invoke-super {p0, p1}, Landroid/graphics/drawable/BitmapDrawable;->setColorFilter(Landroid/graphics/ColorFilter;)V

    iget-object v0, p0, Lcom/gmhub/glass/GlassDrawable;->fallback:Landroid/graphics/drawable/BitmapDrawable;

    if-eqz v0, :cond_0

    invoke-virtual {v0, p1}, Landroid/graphics/drawable/BitmapDrawable;->setColorFilter(Landroid/graphics/ColorFilter;)V

    :cond_0
    iget-object v0, p0, Lcom/gmhub/glass/GlassDrawable;->glass:Landroid/graphics/Paint;

    if-eqz v0, :cond_1

    invoke-virtual {v0, p1}, Landroid/graphics/Paint;->setColorFilter(Landroid/graphics/ColorFilter;)Landroid/graphics/ColorFilter;

    :cond_1
    invoke-virtual {p0}, Lcom/gmhub/glass/GlassDrawable;->invalidateSelf()V

    return-void
.end method
