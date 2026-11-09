.class final Lcom/gmhub/qs/IosHeader$HeaderView;
.super Landroid/widget/LinearLayout;
.source "IosHeader.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/gmhub/qs/IosHeader;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "HeaderView"
.end annotation


# instance fields
.field private actions:Lcom/gmhub/qs/NativeHeaderActions;

.field private final add:Landroid/widget/ImageButton;

.field private final addText:I

.field private densityDpi:I

.field private final done:Landroid/widget/Button;

.field private final doneText:I

.field private final editText:I

.field private final errorText:I

.field private fontScale:F

.field private final power:Landroid/widget/ImageButton;

.field private final powerText:I


# direct methods
.method constructor <init>(Landroid/content/Context;)V
    .locals 8

    invoke-direct {p0, p1}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Lcom/gmhub/qs/IosHeader$HeaderView;->setOrientation(I)V

    const/16 v1, 0x10

    invoke-virtual {p0, v1}, Lcom/gmhub/qs/IosHeader$HeaderView;->setGravity(I)V

    const-string v1, "gmhub_qs_edit"

    const-string v2, "string"

    invoke-static {p1, v1, v2}, Lcom/gmhub/qs/IosHeader;->access$500(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    iput v1, p0, Lcom/gmhub/qs/IosHeader$HeaderView;->editText:I

    const-string v1, "gmhub_qs_add"

    invoke-static {p1, v1, v2}, Lcom/gmhub/qs/IosHeader;->access$500(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    iput v1, p0, Lcom/gmhub/qs/IosHeader$HeaderView;->addText:I

    const-string v1, "gmhub_qs_done"

    invoke-static {p1, v1, v2}, Lcom/gmhub/qs/IosHeader;->access$500(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    iput v1, p0, Lcom/gmhub/qs/IosHeader$HeaderView;->doneText:I

    const-string v1, "gmhub_qs_power"

    invoke-static {p1, v1, v2}, Lcom/gmhub/qs/IosHeader;->access$500(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v3

    iput v3, p0, Lcom/gmhub/qs/IosHeader$HeaderView;->powerText:I

    const-string v3, "gmhub_qs_action_failed"

    invoke-static {p1, v3, v2}, Lcom/gmhub/qs/IosHeader;->access$500(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v2

    iput v2, p0, Lcom/gmhub/qs/IosHeader$HeaderView;->errorText:I

    const/high16 v2, 0x41000000    # 8.0f

    invoke-direct {p0, v2}, Lcom/gmhub/qs/IosHeader$HeaderView;->dp(F)I

    move-result v3

    invoke-direct {p0, v2}, Lcom/gmhub/qs/IosHeader$HeaderView;->dp(F)I

    move-result v4

    invoke-virtual {p0, v3, v0, v4, v0}, Lcom/gmhub/qs/IosHeader$HeaderView;->setPaddingRelative(IIII)V

    const/high16 v3, 0x42600000    # 56.0f

    invoke-direct {p0, v3}, Lcom/gmhub/qs/IosHeader$HeaderView;->dp(F)I

    move-result v3

    invoke-virtual {p0, v3}, Lcom/gmhub/qs/IosHeader$HeaderView;->setMinimumHeight(I)V

    const-string v3, "gmhub_qs_plus"

    invoke-direct {p0, v3}, Lcom/gmhub/qs/IosHeader$HeaderView;->icon(Ljava/lang/String;)Landroid/widget/ImageButton;

    move-result-object v3

    iput-object v3, p0, Lcom/gmhub/qs/IosHeader$HeaderView;->add:Landroid/widget/ImageButton;

    invoke-direct {p0, v1}, Lcom/gmhub/qs/IosHeader$HeaderView;->icon(Ljava/lang/String;)Landroid/widget/ImageButton;

    move-result-object v1

    iput-object v1, p0, Lcom/gmhub/qs/IosHeader$HeaderView;->power:Landroid/widget/ImageButton;

    new-instance v4, Landroid/widget/Button;

    invoke-direct {v4, p1}, Landroid/widget/Button;-><init>(Landroid/content/Context;)V

    iput-object v4, p0, Lcom/gmhub/qs/IosHeader$HeaderView;->done:Landroid/widget/Button;

    invoke-virtual {v4, v0}, Landroid/widget/Button;->setAllCaps(Z)V

    const/high16 p1, 0x41a00000    # 20.0f

    invoke-virtual {v4, p1}, Landroid/widget/Button;->setTextSize(F)V

    const/4 p1, -0x1

    invoke-virtual {v4, p1}, Landroid/widget/Button;->setTextColor(I)V

    const/4 v5, 0x1

    invoke-virtual {v4, v5}, Landroid/widget/Button;->setSingleLine(Z)V

    sget-object v5, Landroid/text/TextUtils$TruncateAt;->END:Landroid/text/TextUtils$TruncateAt;

    invoke-virtual {v4, v5}, Landroid/widget/Button;->setEllipsize(Landroid/text/TextUtils$TruncateAt;)V

    const/high16 v5, 0x42400000    # 48.0f

    invoke-direct {p0, v5}, Lcom/gmhub/qs/IosHeader$HeaderView;->dp(F)I

    move-result v6

    invoke-virtual {v4, v6}, Landroid/widget/Button;->setMinWidth(I)V

    invoke-direct {p0, v5}, Lcom/gmhub/qs/IosHeader$HeaderView;->dp(F)I

    move-result v6

    invoke-virtual {v4, v6}, Landroid/widget/Button;->setMinHeight(I)V

    invoke-direct {p0, v2}, Lcom/gmhub/qs/IosHeader$HeaderView;->dp(F)I

    move-result v6

    invoke-direct {p0, v2}, Lcom/gmhub/qs/IosHeader$HeaderView;->dp(F)I

    move-result v2

    invoke-virtual {v4, v6, v0, v2, v0}, Landroid/widget/Button;->setPadding(IIII)V

    invoke-direct {p0, v4}, Lcom/gmhub/qs/IosHeader$HeaderView;->ripple(Landroid/view/View;)V

    new-instance v2, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {p0, v5}, Lcom/gmhub/qs/IosHeader$HeaderView;->dp(F)I

    move-result v6

    invoke-direct {p0, v5}, Lcom/gmhub/qs/IosHeader$HeaderView;->dp(F)I

    move-result v7

    invoke-direct {v2, v6, v7}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {p0, v3, v2}, Lcom/gmhub/qs/IosHeader$HeaderView;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    invoke-direct {p0}, Lcom/gmhub/qs/IosHeader$HeaderView;->gap()V

    new-instance v2, Landroid/widget/LinearLayout$LayoutParams;

    const/high16 v6, 0x3f800000    # 1.0f

    invoke-direct {v2, v0, p1, v6}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {p0, v4, v2}, Lcom/gmhub/qs/IosHeader$HeaderView;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    invoke-direct {p0}, Lcom/gmhub/qs/IosHeader$HeaderView;->gap()V

    new-instance p1, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {p0, v5}, Lcom/gmhub/qs/IosHeader$HeaderView;->dp(F)I

    move-result v0

    invoke-direct {p0, v5}, Lcom/gmhub/qs/IosHeader$HeaderView;->dp(F)I

    move-result v2

    invoke-direct {p1, v0, v2}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {p0, v1, p1}, Lcom/gmhub/qs/IosHeader$HeaderView;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    new-instance p1, Lcom/gmhub/qs/IosHeader$HeaderView$$ExternalSyntheticLambda0;

    invoke-direct {p1, p0}, Lcom/gmhub/qs/IosHeader$HeaderView$$ExternalSyntheticLambda0;-><init>(Lcom/gmhub/qs/IosHeader$HeaderView;)V

    invoke-virtual {v3, p1}, Landroid/widget/ImageButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    new-instance p1, Lcom/gmhub/qs/IosHeader$HeaderView$$ExternalSyntheticLambda1;

    invoke-direct {p1, p0}, Lcom/gmhub/qs/IosHeader$HeaderView$$ExternalSyntheticLambda1;-><init>(Lcom/gmhub/qs/IosHeader$HeaderView;)V

    invoke-virtual {v4, p1}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    new-instance p1, Lcom/gmhub/qs/IosHeader$HeaderView$$ExternalSyntheticLambda2;

    invoke-direct {p1, p0}, Lcom/gmhub/qs/IosHeader$HeaderView$$ExternalSyntheticLambda2;-><init>(Lcom/gmhub/qs/IosHeader$HeaderView;)V

    invoke-virtual {v1, p1}, Landroid/widget/ImageButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    return-void
.end method

.method private dp(F)I
    .locals 0

    invoke-virtual {p0}, Lcom/gmhub/qs/IosHeader$HeaderView;->getResources()Landroid/content/res/Resources;

    move-result-object p0

    invoke-virtual {p0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object p0

    iget p0, p0, Landroid/util/DisplayMetrics;->density:F

    mul-float/2addr p1, p0

    invoke-static {p1}, Ljava/lang/Math;->round(F)I

    move-result p0

    return p0
.end method

.method private gap()V
    .locals 4

    new-instance v0, Landroid/widget/Space;

    invoke-virtual {p0}, Lcom/gmhub/qs/IosHeader$HeaderView;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/widget/Space;-><init>(Landroid/content/Context;)V

    new-instance v1, Landroid/widget/LinearLayout$LayoutParams;

    const/high16 v2, 0x41000000    # 8.0f

    invoke-direct {p0, v2}, Lcom/gmhub/qs/IosHeader$HeaderView;->dp(F)I

    move-result v2

    const/4 v3, 0x1

    invoke-direct {v1, v2, v3}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {p0, v0, v1}, Lcom/gmhub/qs/IosHeader$HeaderView;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    return-void
.end method

.method private icon(Ljava/lang/String;)Landroid/widget/ImageButton;
    .locals 4

    new-instance v0, Landroid/widget/ImageButton;

    invoke-virtual {p0}, Lcom/gmhub/qs/IosHeader$HeaderView;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/widget/ImageButton;-><init>(Landroid/content/Context;)V

    invoke-virtual {p0}, Lcom/gmhub/qs/IosHeader$HeaderView;->getContext()Landroid/content/Context;

    move-result-object v1

    const-string v2, "drawable"

    invoke-static {v1, p1, v2}, Lcom/gmhub/qs/IosHeader;->access$500(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result p1

    invoke-virtual {v0, p1}, Landroid/widget/ImageButton;->setImageResource(I)V

    sget-object p1, Landroid/widget/ImageView$ScaleType;->CENTER_INSIDE:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {v0, p1}, Landroid/widget/ImageButton;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    const/high16 p1, 0x41400000    # 12.0f

    invoke-direct {p0, p1}, Lcom/gmhub/qs/IosHeader$HeaderView;->dp(F)I

    move-result v1

    invoke-direct {p0, p1}, Lcom/gmhub/qs/IosHeader$HeaderView;->dp(F)I

    move-result v2

    invoke-direct {p0, p1}, Lcom/gmhub/qs/IosHeader$HeaderView;->dp(F)I

    move-result v3

    invoke-direct {p0, p1}, Lcom/gmhub/qs/IosHeader$HeaderView;->dp(F)I

    move-result p1

    invoke-virtual {v0, v1, v2, v3, p1}, Landroid/widget/ImageButton;->setPadding(IIII)V

    const/high16 p1, 0x42400000    # 48.0f

    invoke-direct {p0, p1}, Lcom/gmhub/qs/IosHeader$HeaderView;->dp(F)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/widget/ImageButton;->setMinimumWidth(I)V

    invoke-direct {p0, p1}, Lcom/gmhub/qs/IosHeader$HeaderView;->dp(F)I

    move-result p1

    invoke-virtual {v0, p1}, Landroid/widget/ImageButton;->setMinimumHeight(I)V

    invoke-direct {p0, v0}, Lcom/gmhub/qs/IosHeader$HeaderView;->ripple(Landroid/view/View;)V

    return-object v0
.end method

.method private ripple(Landroid/view/View;)V
    .locals 3

    new-instance v0, Landroid/util/TypedValue;

    invoke-direct {v0}, Landroid/util/TypedValue;-><init>()V

    invoke-virtual {p0}, Lcom/gmhub/qs/IosHeader$HeaderView;->getContext()Landroid/content/Context;

    move-result-object p0

    invoke-virtual {p0}, Landroid/content/Context;->getTheme()Landroid/content/res/Resources$Theme;

    move-result-object p0

    const v1, 0x101045c

    const/4 v2, 0x1

    invoke-virtual {p0, v1, v0, v2}, Landroid/content/res/Resources$Theme;->resolveAttribute(ILandroid/util/TypedValue;Z)Z

    move-result p0

    if-eqz p0, :cond_0

    iget p0, v0, Landroid/util/TypedValue;->resourceId:I

    if-eqz p0, :cond_0

    iget p0, v0, Landroid/util/TypedValue;->resourceId:I

    invoke-virtual {p1, p0}, Landroid/view/View;->setBackgroundResource(I)V

    :cond_0
    return-void
.end method

.method private run(I)V
    .locals 3

    iget-object v0, p0, Lcom/gmhub/qs/IosHeader$HeaderView;->actions:Lcom/gmhub/qs/NativeHeaderActions;

    if-nez v0, :cond_0

    goto :goto_2

    :cond_0
    const/4 v1, 0x1

    if-nez p1, :cond_2

    :try_start_0
    invoke-virtual {v0}, Lcom/gmhub/qs/NativeHeaderActions;->state()Lcom/gmhub/qs/NativeHeaderActions$State;

    move-result-object p1

    iget-boolean p1, p1, Lcom/gmhub/qs/NativeHeaderActions$State;->editing:Z

    if-eqz p1, :cond_1

    invoke-virtual {v0}, Lcom/gmhub/qs/NativeHeaderActions;->gallery()Z

    goto :goto_0

    :cond_1
    invoke-virtual {v0}, Lcom/gmhub/qs/NativeHeaderActions;->edit()Z

    goto :goto_0

    :catch_0
    move-exception p1

    goto :goto_1

    :cond_2
    if-ne p1, v1, :cond_3

    invoke-virtual {v0}, Lcom/gmhub/qs/NativeHeaderActions;->done()Z

    goto :goto_0

    :cond_3
    invoke-virtual {v0}, Lcom/gmhub/qs/NativeHeaderActions;->power()Z

    :goto_0
    invoke-virtual {p0, v0}, Lcom/gmhub/qs/IosHeader$HeaderView;->bind(Lcom/gmhub/qs/NativeHeaderActions;)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :goto_1
    const-string v0, "GMHubQs"

    const-string v2, "Native header action failed"

    invoke-static {v0, v2, p1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    invoke-virtual {p0}, Lcom/gmhub/qs/IosHeader$HeaderView;->getContext()Landroid/content/Context;

    move-result-object p1

    iget p0, p0, Lcom/gmhub/qs/IosHeader$HeaderView;->errorText:I

    invoke-static {p1, p0, v1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;II)Landroid/widget/Toast;

    move-result-object p0

    invoke-virtual {p0}, Landroid/widget/Toast;->show()V

    :goto_2
    return-void
.end method

.method private updateMetrics()V
    .locals 13

    invoke-virtual {p0}, Lcom/gmhub/qs/IosHeader$HeaderView;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    iget v0, v0, Landroid/util/DisplayMetrics;->densityDpi:I

    invoke-virtual {p0}, Lcom/gmhub/qs/IosHeader$HeaderView;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v1

    iget v1, v1, Landroid/content/res/Configuration;->fontScale:F

    iget v2, p0, Lcom/gmhub/qs/IosHeader$HeaderView;->densityDpi:I

    const/4 v3, 0x2

    const/4 v4, 0x1

    const/4 v5, 0x0

    if-eq v2, v0, :cond_1

    iput v0, p0, Lcom/gmhub/qs/IosHeader$HeaderView;->densityDpi:I

    const/high16 v0, 0x41000000    # 8.0f

    invoke-direct {p0, v0}, Lcom/gmhub/qs/IosHeader$HeaderView;->dp(F)I

    move-result v2

    invoke-direct {p0, v0}, Lcom/gmhub/qs/IosHeader$HeaderView;->dp(F)I

    move-result v6

    invoke-virtual {p0, v2, v5, v6, v5}, Lcom/gmhub/qs/IosHeader$HeaderView;->setPaddingRelative(IIII)V

    const/high16 v2, 0x42600000    # 56.0f

    invoke-direct {p0, v2}, Lcom/gmhub/qs/IosHeader$HeaderView;->dp(F)I

    move-result v2

    invoke-virtual {p0, v2}, Lcom/gmhub/qs/IosHeader$HeaderView;->setMinimumHeight(I)V

    iget-object v2, p0, Lcom/gmhub/qs/IosHeader$HeaderView;->add:Landroid/widget/ImageButton;

    iget-object v6, p0, Lcom/gmhub/qs/IosHeader$HeaderView;->power:Landroid/widget/ImageButton;

    filled-new-array {v2, v6}, [Landroid/widget/ImageButton;

    move-result-object v2

    move v6, v5

    :goto_0
    const/high16 v7, 0x42400000    # 48.0f

    if-ge v6, v3, :cond_0

    aget-object v8, v2, v6

    new-instance v9, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {p0, v7}, Lcom/gmhub/qs/IosHeader$HeaderView;->dp(F)I

    move-result v10

    invoke-direct {p0, v7}, Lcom/gmhub/qs/IosHeader$HeaderView;->dp(F)I

    move-result v11

    invoke-direct {v9, v10, v11}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v8, v9}, Landroid/widget/ImageButton;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    const/high16 v9, 0x41400000    # 12.0f

    invoke-direct {p0, v9}, Lcom/gmhub/qs/IosHeader$HeaderView;->dp(F)I

    move-result v10

    invoke-direct {p0, v9}, Lcom/gmhub/qs/IosHeader$HeaderView;->dp(F)I

    move-result v11

    invoke-direct {p0, v9}, Lcom/gmhub/qs/IosHeader$HeaderView;->dp(F)I

    move-result v12

    invoke-direct {p0, v9}, Lcom/gmhub/qs/IosHeader$HeaderView;->dp(F)I

    move-result v9

    invoke-virtual {v8, v10, v11, v12, v9}, Landroid/widget/ImageButton;->setPadding(IIII)V

    invoke-direct {p0, v7}, Lcom/gmhub/qs/IosHeader$HeaderView;->dp(F)I

    move-result v9

    invoke-virtual {v8, v9}, Landroid/widget/ImageButton;->setMinimumWidth(I)V

    invoke-direct {p0, v7}, Lcom/gmhub/qs/IosHeader$HeaderView;->dp(F)I

    move-result v7

    invoke-virtual {v8, v7}, Landroid/widget/ImageButton;->setMinimumHeight(I)V

    add-int/lit8 v6, v6, 0x1

    goto :goto_0

    :cond_0
    invoke-virtual {p0, v4}, Lcom/gmhub/qs/IosHeader$HeaderView;->getChildAt(I)Landroid/view/View;

    move-result-object v2

    new-instance v6, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {p0, v0}, Lcom/gmhub/qs/IosHeader$HeaderView;->dp(F)I

    move-result v8

    invoke-direct {v6, v8, v4}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v2, v6}, Landroid/view/View;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    const/4 v2, 0x3

    invoke-virtual {p0, v2}, Lcom/gmhub/qs/IosHeader$HeaderView;->getChildAt(I)Landroid/view/View;

    move-result-object v2

    new-instance v6, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {p0, v0}, Lcom/gmhub/qs/IosHeader$HeaderView;->dp(F)I

    move-result v8

    invoke-direct {v6, v8, v4}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v2, v6}, Landroid/view/View;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    iget-object v2, p0, Lcom/gmhub/qs/IosHeader$HeaderView;->done:Landroid/widget/Button;

    invoke-direct {p0, v7}, Lcom/gmhub/qs/IosHeader$HeaderView;->dp(F)I

    move-result v6

    invoke-virtual {v2, v6}, Landroid/widget/Button;->setMinWidth(I)V

    iget-object v2, p0, Lcom/gmhub/qs/IosHeader$HeaderView;->done:Landroid/widget/Button;

    invoke-direct {p0, v7}, Lcom/gmhub/qs/IosHeader$HeaderView;->dp(F)I

    move-result v6

    invoke-virtual {v2, v6}, Landroid/widget/Button;->setMinHeight(I)V

    iget-object v2, p0, Lcom/gmhub/qs/IosHeader$HeaderView;->done:Landroid/widget/Button;

    invoke-direct {p0, v0}, Lcom/gmhub/qs/IosHeader$HeaderView;->dp(F)I

    move-result v6

    invoke-direct {p0, v0}, Lcom/gmhub/qs/IosHeader$HeaderView;->dp(F)I

    move-result v0

    invoke-virtual {v2, v6, v5, v0, v5}, Landroid/widget/Button;->setPadding(IIII)V

    :cond_1
    iget v0, p0, Lcom/gmhub/qs/IosHeader$HeaderView;->fontScale:F

    cmpl-float v0, v0, v1

    if-eqz v0, :cond_4

    iput v1, p0, Lcom/gmhub/qs/IosHeader$HeaderView;->fontScale:F

    iget-object v0, p0, Lcom/gmhub/qs/IosHeader$HeaderView;->done:Landroid/widget/Button;

    const/high16 v2, 0x41a00000    # 20.0f

    invoke-virtual {v0, v2}, Landroid/widget/Button;->setTextSize(F)V

    iget-object v0, p0, Lcom/gmhub/qs/IosHeader$HeaderView;->done:Landroid/widget/Button;

    const/high16 v2, 0x3fc00000    # 1.5f

    cmpg-float v6, v1, v2

    if-gtz v6, :cond_2

    move v5, v4

    :cond_2
    invoke-virtual {v0, v5}, Landroid/widget/Button;->setSingleLine(Z)V

    iget-object p0, p0, Lcom/gmhub/qs/IosHeader$HeaderView;->done:Landroid/widget/Button;

    cmpl-float v0, v1, v2

    if-lez v0, :cond_3

    goto :goto_1

    :cond_3
    move v3, v4

    :goto_1
    invoke-virtual {p0, v3}, Landroid/widget/Button;->setMaxLines(I)V

    :cond_4
    return-void
.end method


# virtual methods
.method bind(Lcom/gmhub/qs/NativeHeaderActions;)V
    .locals 5

    iget-object v0, p0, Lcom/gmhub/qs/IosHeader$HeaderView;->actions:Lcom/gmhub/qs/NativeHeaderActions;

    if-eqz v0, :cond_0

    if-eq v0, p1, :cond_0

    invoke-virtual {v0}, Lcom/gmhub/qs/NativeHeaderActions;->close()V

    :cond_0
    iput-object p1, p0, Lcom/gmhub/qs/IosHeader$HeaderView;->actions:Lcom/gmhub/qs/NativeHeaderActions;

    invoke-virtual {p1}, Lcom/gmhub/qs/NativeHeaderActions;->state()Lcom/gmhub/qs/NativeHeaderActions$State;

    move-result-object p1

    invoke-virtual {p0}, Lcom/gmhub/qs/IosHeader$HeaderView;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-direct {p0}, Lcom/gmhub/qs/IosHeader$HeaderView;->updateMetrics()V

    iget-boolean v1, p1, Lcom/gmhub/qs/NativeHeaderActions$State;->editing:Z

    if-eqz v1, :cond_1

    iget v1, p0, Lcom/gmhub/qs/IosHeader$HeaderView;->addText:I

    goto :goto_0

    :cond_1
    iget v1, p0, Lcom/gmhub/qs/IosHeader$HeaderView;->editText:I

    :goto_0
    invoke-virtual {v0, v1}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lcom/gmhub/qs/IosHeader$HeaderView;->add:Landroid/widget/ImageButton;

    invoke-virtual {v2}, Landroid/widget/ImageButton;->getContentDescription()Ljava/lang/CharSequence;

    move-result-object v2

    invoke-static {v2, v1}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_2

    iget-object v2, p0, Lcom/gmhub/qs/IosHeader$HeaderView;->add:Landroid/widget/ImageButton;

    invoke-virtual {v2, v1}, Landroid/widget/ImageButton;->setContentDescription(Ljava/lang/CharSequence;)V

    :cond_2
    iget-boolean v1, p1, Lcom/gmhub/qs/NativeHeaderActions$State;->editing:Z

    if-eqz v1, :cond_3

    iget v1, p0, Lcom/gmhub/qs/IosHeader$HeaderView;->doneText:I

    invoke-virtual {v0, v1}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v1

    goto :goto_1

    :cond_3
    const-string v1, ""

    :goto_1
    iget-object v2, p0, Lcom/gmhub/qs/IosHeader$HeaderView;->done:Landroid/widget/Button;

    invoke-virtual {v2}, Landroid/widget/Button;->getText()Ljava/lang/CharSequence;

    move-result-object v2

    invoke-static {v2, v1}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_4

    iget-object v2, p0, Lcom/gmhub/qs/IosHeader$HeaderView;->done:Landroid/widget/Button;

    invoke-virtual {v2, v1}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V

    :cond_4
    iget-object v2, p0, Lcom/gmhub/qs/IosHeader$HeaderView;->done:Landroid/widget/Button;

    invoke-virtual {v2, v1}, Landroid/widget/Button;->setContentDescription(Ljava/lang/CharSequence;)V

    iget-object v1, p0, Lcom/gmhub/qs/IosHeader$HeaderView;->done:Landroid/widget/Button;

    iget-boolean v2, p1, Lcom/gmhub/qs/NativeHeaderActions$State;->current:Z

    const/4 v3, 0x0

    const/4 v4, 0x1

    if-eqz v2, :cond_5

    iget-boolean v2, p1, Lcom/gmhub/qs/NativeHeaderActions$State;->canFinish:Z

    if-eqz v2, :cond_5

    move v2, v4

    goto :goto_2

    :cond_5
    move v2, v3

    :goto_2
    invoke-virtual {v1, v2}, Landroid/widget/Button;->setEnabled(Z)V

    iget-object v1, p0, Lcom/gmhub/qs/IosHeader$HeaderView;->done:Landroid/widget/Button;

    iget-boolean v2, p1, Lcom/gmhub/qs/NativeHeaderActions$State;->editing:Z

    if-eqz v2, :cond_6

    move v2, v4

    goto :goto_3

    :cond_6
    const/4 v2, 0x2

    :goto_3
    invoke-virtual {v1, v2}, Landroid/widget/Button;->setImportantForAccessibility(I)V

    iget-object v1, p0, Lcom/gmhub/qs/IosHeader$HeaderView;->done:Landroid/widget/Button;

    iget-boolean v2, p1, Lcom/gmhub/qs/NativeHeaderActions$State;->editing:Z

    invoke-virtual {v1, v2}, Landroid/widget/Button;->setClickable(Z)V

    iget-object v1, p0, Lcom/gmhub/qs/IosHeader$HeaderView;->power:Landroid/widget/ImageButton;

    iget v2, p0, Lcom/gmhub/qs/IosHeader$HeaderView;->powerText:I

    invoke-virtual {v0, v2}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Landroid/widget/ImageButton;->setContentDescription(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lcom/gmhub/qs/IosHeader$HeaderView;->add:Landroid/widget/ImageButton;

    iget-boolean v1, p1, Lcom/gmhub/qs/NativeHeaderActions$State;->current:Z

    if-eqz v1, :cond_8

    iget-boolean v1, p1, Lcom/gmhub/qs/NativeHeaderActions$State;->unlocked:Z

    if-eqz v1, :cond_8

    iget-boolean v1, p1, Lcom/gmhub/qs/NativeHeaderActions$State;->editing:Z

    if-eqz v1, :cond_7

    iget-boolean v1, p1, Lcom/gmhub/qs/NativeHeaderActions$State;->canAdd:Z

    if-eqz v1, :cond_8

    :cond_7
    move v3, v4

    :cond_8
    invoke-virtual {v0, v3}, Landroid/widget/ImageButton;->setEnabled(Z)V

    iget-object p0, p0, Lcom/gmhub/qs/IosHeader$HeaderView;->power:Landroid/widget/ImageButton;

    iget-boolean p1, p1, Lcom/gmhub/qs/NativeHeaderActions$State;->current:Z

    invoke-virtual {p0, p1}, Landroid/widget/ImageButton;->setEnabled(Z)V

    return-void
.end method

.method synthetic lambda$new$0$com-gmhub-qs-IosHeader$HeaderView(Landroid/view/View;)V
    .locals 0

    const/4 p1, 0x0

    invoke-direct {p0, p1}, Lcom/gmhub/qs/IosHeader$HeaderView;->run(I)V

    return-void
.end method

.method synthetic lambda$new$1$com-gmhub-qs-IosHeader$HeaderView(Landroid/view/View;)V
    .locals 0

    const/4 p1, 0x1

    invoke-direct {p0, p1}, Lcom/gmhub/qs/IosHeader$HeaderView;->run(I)V

    return-void
.end method

.method synthetic lambda$new$2$com-gmhub-qs-IosHeader$HeaderView(Landroid/view/View;)V
    .locals 0

    const/4 p1, 0x2

    invoke-direct {p0, p1}, Lcom/gmhub/qs/IosHeader$HeaderView;->run(I)V

    return-void
.end method

.method release()V
    .locals 2

    iget-object v0, p0, Lcom/gmhub/qs/IosHeader$HeaderView;->actions:Lcom/gmhub/qs/NativeHeaderActions;

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/gmhub/qs/NativeHeaderActions;->close()V

    iput-object v1, p0, Lcom/gmhub/qs/IosHeader$HeaderView;->actions:Lcom/gmhub/qs/NativeHeaderActions;

    :cond_0
    iget-object v0, p0, Lcom/gmhub/qs/IosHeader$HeaderView;->add:Landroid/widget/ImageButton;

    invoke-virtual {v0, v1}, Landroid/widget/ImageButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lcom/gmhub/qs/IosHeader$HeaderView;->done:Landroid/widget/Button;

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object p0, p0, Lcom/gmhub/qs/IosHeader$HeaderView;->power:Landroid/widget/ImageButton;

    invoke-virtual {p0, v1}, Landroid/widget/ImageButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    return-void
.end method
