.class final Lcom/gmhub/qs/IosGridPanel$RailView;
.super Landroid/widget/ScrollView;
.source "IosGridPanel.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/gmhub/qs/IosGridPanel;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "RailView"
.end annotation


# instance fields
.field final buttons:Landroid/widget/LinearLayout;

.field count:I

.field density:I

.field session:Lcom/gmhub/qs/IosGridPanel$Session;


# direct methods
.method constructor <init>(Landroid/content/Context;)V
    .locals 3

    invoke-direct {p0, p1}, Landroid/widget/ScrollView;-><init>(Landroid/content/Context;)V

    const/4 v0, -0x1

    iput v0, p0, Lcom/gmhub/qs/IosGridPanel$RailView;->count:I

    const/4 v1, 0x0

    invoke-virtual {p0, v1}, Lcom/gmhub/qs/IosGridPanel$RailView;->setFillViewport(Z)V

    invoke-virtual {p0, v1}, Lcom/gmhub/qs/IosGridPanel$RailView;->setVerticalScrollBarEnabled(Z)V

    const/4 v1, 0x2

    invoke-virtual {p0, v1}, Lcom/gmhub/qs/IosGridPanel$RailView;->setOverScrollMode(I)V

    new-instance v1, Landroid/widget/LinearLayout;

    invoke-direct {v1, p1}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    iput-object v1, p0, Lcom/gmhub/qs/IosGridPanel$RailView;->buttons:Landroid/widget/LinearLayout;

    const/4 p1, 0x1

    invoke-virtual {v1, p1}, Landroid/widget/LinearLayout;->setOrientation(I)V

    new-instance p1, Landroid/widget/FrameLayout$LayoutParams;

    const/4 v2, -0x2

    invoke-direct {p1, v0, v2}, Landroid/widget/FrameLayout$LayoutParams;-><init>(II)V

    invoke-virtual {p0, v1, p1}, Lcom/gmhub/qs/IosGridPanel$RailView;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    return-void
.end method


# virtual methods
.method bind(Lcom/gmhub/qs/IosGridPanel$Session;Lcom/gmhub/qs/NativePageNavigation$Pages;)V
    .locals 8

    iput-object p1, p0, Lcom/gmhub/qs/IosGridPanel$RailView;->session:Lcom/gmhub/qs/IosGridPanel$Session;

    invoke-virtual {p0}, Lcom/gmhub/qs/IosGridPanel$RailView;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    iget v0, v0, Landroid/util/DisplayMetrics;->densityDpi:I

    iget v1, p0, Lcom/gmhub/qs/IosGridPanel$RailView;->count:I

    iget v2, p2, Lcom/gmhub/qs/NativePageNavigation$Pages;->count:I

    const/4 v3, 0x0

    const/4 v4, 0x1

    if-ne v1, v2, :cond_0

    iget v1, p0, Lcom/gmhub/qs/IosGridPanel$RailView;->density:I

    if-eq v1, v0, :cond_3

    :cond_0
    iget v1, p2, Lcom/gmhub/qs/NativePageNavigation$Pages;->count:I

    iput v1, p0, Lcom/gmhub/qs/IosGridPanel$RailView;->count:I

    iput v0, p0, Lcom/gmhub/qs/IosGridPanel$RailView;->density:I

    iget-object v0, p0, Lcom/gmhub/qs/IosGridPanel$RailView;->buttons:Landroid/widget/LinearLayout;

    invoke-virtual {v0}, Landroid/widget/LinearLayout;->removeAllViews()V

    move v0, v3

    :goto_0
    iget v1, p0, Lcom/gmhub/qs/IosGridPanel$RailView;->count:I

    if-ge v0, v1, :cond_3

    new-instance v1, Landroid/widget/ImageButton;

    invoke-virtual {p0}, Lcom/gmhub/qs/IosGridPanel$RailView;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-direct {v1, v2}, Landroid/widget/ImageButton;-><init>(Landroid/content/Context;)V

    invoke-virtual {p0}, Lcom/gmhub/qs/IosGridPanel$RailView;->getContext()Landroid/content/Context;

    move-result-object v2

    if-nez v0, :cond_1

    const-string v5, "favorite"

    goto :goto_1

    :cond_1
    const-string v5, "page"

    :goto_1
    const-string v6, "gmhub_qs_"

    invoke-virtual {v6, v5}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    const-string v6, "drawable"

    invoke-static {v2, v5, v6}, Lcom/gmhub/qs/IosGridPanel;->access$500(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v2

    invoke-virtual {v1, v2}, Landroid/widget/ImageButton;->setImageResource(I)V

    const/16 v2, 0xe

    invoke-virtual {p0, v2}, Lcom/gmhub/qs/IosGridPanel$RailView;->dp(I)I

    move-result v5

    invoke-virtual {p0, v2}, Lcom/gmhub/qs/IosGridPanel$RailView;->dp(I)I

    move-result v6

    invoke-virtual {p0, v2}, Lcom/gmhub/qs/IosGridPanel$RailView;->dp(I)I

    move-result v7

    invoke-virtual {p0, v2}, Lcom/gmhub/qs/IosGridPanel$RailView;->dp(I)I

    move-result v2

    invoke-virtual {v1, v5, v6, v7, v2}, Landroid/widget/ImageButton;->setPadding(IIII)V

    new-instance v2, Landroid/util/TypedValue;

    invoke-direct {v2}, Landroid/util/TypedValue;-><init>()V

    invoke-virtual {p0}, Lcom/gmhub/qs/IosGridPanel$RailView;->getContext()Landroid/content/Context;

    move-result-object v5

    invoke-virtual {v5}, Landroid/content/Context;->getTheme()Landroid/content/res/Resources$Theme;

    move-result-object v5

    const v6, 0x101045c

    invoke-virtual {v5, v6, v2, v4}, Landroid/content/res/Resources$Theme;->resolveAttribute(ILandroid/util/TypedValue;Z)Z

    move-result v5

    if-eqz v5, :cond_2

    iget v5, v2, Landroid/util/TypedValue;->resourceId:I

    if-eqz v5, :cond_2

    iget v2, v2, Landroid/util/TypedValue;->resourceId:I

    invoke-virtual {v1, v2}, Landroid/widget/ImageButton;->setBackgroundResource(I)V

    :cond_2
    new-instance v2, Lcom/gmhub/qs/IosGridPanel$RailView$$ExternalSyntheticLambda0;

    invoke-direct {v2, p0, v0}, Lcom/gmhub/qs/IosGridPanel$RailView$$ExternalSyntheticLambda0;-><init>(Lcom/gmhub/qs/IosGridPanel$RailView;I)V

    invoke-virtual {v1, v2}, Landroid/widget/ImageButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v2, p0, Lcom/gmhub/qs/IosGridPanel$RailView;->buttons:Landroid/widget/LinearLayout;

    new-instance v5, Landroid/widget/LinearLayout$LayoutParams;

    const/16 v6, 0x30

    invoke-virtual {p0, v6}, Lcom/gmhub/qs/IosGridPanel$RailView;->dp(I)I

    move-result v7

    invoke-virtual {p0, v6}, Lcom/gmhub/qs/IosGridPanel$RailView;->dp(I)I

    move-result v6

    invoke-direct {v5, v7, v6}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v2, v1, v5}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_3
    move v0, v3

    :goto_2
    iget v1, p0, Lcom/gmhub/qs/IosGridPanel$RailView;->count:I

    if-ge v0, v1, :cond_6

    iget-object v1, p0, Lcom/gmhub/qs/IosGridPanel$RailView;->buttons:Landroid/widget/LinearLayout;

    invoke-virtual {v1, v0}, Landroid/widget/LinearLayout;->getChildAt(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/ImageButton;

    iget v2, p2, Lcom/gmhub/qs/NativePageNavigation$Pages;->selected:I

    if-ne v0, v2, :cond_4

    move v2, v4

    goto :goto_3

    :cond_4
    move v2, v3

    :goto_3
    if-eqz v2, :cond_5

    const/4 v5, -0x1

    goto :goto_4

    :cond_5
    const v5, -0x656566

    :goto_4
    invoke-static {v5}, Landroid/content/res/ColorStateList;->valueOf(I)Landroid/content/res/ColorStateList;

    move-result-object v5

    invoke-virtual {v1, v5}, Landroid/widget/ImageButton;->setImageTintList(Landroid/content/res/ColorStateList;)V

    invoke-virtual {v1, v2}, Landroid/widget/ImageButton;->setSelected(Z)V

    iget-object v2, p1, Lcom/gmhub/qs/IosGridPanel$Session;->navigation:Lcom/gmhub/qs/NativePageNavigation;

    invoke-virtual {v2}, Lcom/gmhub/qs/NativePageNavigation;->current()Z

    move-result v2

    invoke-virtual {v1, v2}, Landroid/widget/ImageButton;->setEnabled(Z)V

    invoke-virtual {p0}, Lcom/gmhub/qs/IosGridPanel$RailView;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-virtual {p0}, Lcom/gmhub/qs/IosGridPanel$RailView;->getContext()Landroid/content/Context;

    move-result-object v5

    const-string v6, "gmhub_qs_page_number"

    const-string v7, "string"

    invoke-static {v5, v6, v7}, Lcom/gmhub/qs/IosGridPanel;->access$500(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v5

    add-int/lit8 v0, v0, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    iget v7, p0, Lcom/gmhub/qs/IosGridPanel$RailView;->count:I

    invoke-static {v7}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v7

    filled-new-array {v6, v7}, [Ljava/lang/Object;

    move-result-object v6

    invoke-virtual {v2, v5, v6}, Landroid/content/Context;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/widget/ImageButton;->setContentDescription(Ljava/lang/CharSequence;)V

    goto :goto_2

    :cond_6
    return-void
.end method

.method dp(I)I
    .locals 0

    int-to-float p1, p1

    invoke-virtual {p0}, Lcom/gmhub/qs/IosGridPanel$RailView;->getResources()Landroid/content/res/Resources;

    move-result-object p0

    invoke-virtual {p0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object p0

    iget p0, p0, Landroid/util/DisplayMetrics;->density:F

    mul-float/2addr p1, p0

    invoke-static {p1}, Ljava/lang/Math;->round(F)I

    move-result p0

    return p0
.end method

.method synthetic lambda$bind$0$com-gmhub-qs-IosGridPanel$RailView(ILandroid/view/View;)V
    .locals 0

    iget-object p0, p0, Lcom/gmhub/qs/IosGridPanel$RailView;->session:Lcom/gmhub/qs/IosGridPanel$Session;

    if-eqz p0, :cond_0

    :try_start_0
    invoke-virtual {p0, p1}, Lcom/gmhub/qs/IosGridPanel$Session;->select(I)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p0

    const-string p1, "GMHubQs"

    const-string p2, "Native page navigation failed"

    invoke-static {p1, p2, p0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    :cond_0
    return-void
.end method

.method release()V
    .locals 3

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/gmhub/qs/IosGridPanel$RailView;->session:Lcom/gmhub/qs/IosGridPanel$Session;

    const/4 v1, 0x0

    :goto_0
    iget-object v2, p0, Lcom/gmhub/qs/IosGridPanel$RailView;->buttons:Landroid/widget/LinearLayout;

    invoke-virtual {v2}, Landroid/widget/LinearLayout;->getChildCount()I

    move-result v2

    if-ge v1, v2, :cond_0

    iget-object v2, p0, Lcom/gmhub/qs/IosGridPanel$RailView;->buttons:Landroid/widget/LinearLayout;

    invoke-virtual {v2, v1}, Landroid/widget/LinearLayout;->getChildAt(I)Landroid/view/View;

    move-result-object v2

    invoke-virtual {v2, v0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_0
    return-void
.end method
