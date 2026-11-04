.class public final Lcom/gmhub/monitor/ThermalPanel;
.super Landroid/widget/LinearLayout;
.source "ThermalPanel.java"


# static fields
.field private static final TAG:Ljava/lang/String; = "gmhub_thermal_panel"


# instance fields
.field private active:Z

.field private attached:Z

.field private generation:I

.field private identities:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private final main:Landroid/os/Handler;

.field private final readings:Landroid/widget/LinearLayout;

.field private final status:Landroid/widget/TextView;

.field private final values:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Landroid/widget/TextView;",
            ">;"
        }
    .end annotation
.end field

.field private visible:Z

.field private worker:Ljava/util/concurrent/ScheduledExecutorService;


# direct methods
.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 4

    invoke-direct {p0, p1, p2}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    new-instance p2, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v0

    invoke-direct {p2, v0}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    iput-object p2, p0, Lcom/gmhub/monitor/ThermalPanel;->main:Landroid/os/Handler;

    new-instance p2, Ljava/util/LinkedHashMap;

    invoke-direct {p2}, Ljava/util/LinkedHashMap;-><init>()V

    iput-object p2, p0, Lcom/gmhub/monitor/ThermalPanel;->values:Ljava/util/Map;

    new-instance p2, Ljava/util/ArrayList;

    invoke-direct {p2}, Ljava/util/ArrayList;-><init>()V

    iput-object p2, p0, Lcom/gmhub/monitor/ThermalPanel;->identities:Ljava/util/List;

    const/4 p2, 0x1

    iput-boolean p2, p0, Lcom/gmhub/monitor/ThermalPanel;->active:Z

    const-string v0, "gmhub_thermal_panel"

    invoke-virtual {p0, v0}, Lcom/gmhub/monitor/ThermalPanel;->setTag(Ljava/lang/Object;)V

    invoke-virtual {p0, p2}, Lcom/gmhub/monitor/ThermalPanel;->setOrientation(I)V

    const/16 v0, 0x10

    invoke-direct {p0, v0}, Lcom/gmhub/monitor/ThermalPanel;->dp(I)I

    move-result v0

    const/16 v1, 0x8

    invoke-direct {p0, v1}, Lcom/gmhub/monitor/ThermalPanel;->dp(I)I

    move-result v2

    invoke-direct {p0, v1}, Lcom/gmhub/monitor/ThermalPanel;->dp(I)I

    move-result v3

    invoke-virtual {p0, v0, v2, v0, v3}, Lcom/gmhub/monitor/ThermalPanel;->setPadding(IIII)V

    new-instance v0, Landroid/widget/TextView;

    invoke-direct {v0, p1}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/gmhub/monitor/ThermalPanel;->status:Landroid/widget/TextView;

    const v2, 0x10301b3

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setTextAppearance(I)V

    const-string v2, "gm_thermal_loading"

    const-string v3, "Reading sensors\u2026"

    invoke-direct {p0, v2, v3}, Lcom/gmhub/monitor/ThermalPanel;->text(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    invoke-direct {p0, v1}, Lcom/gmhub/monitor/ThermalPanel;->dp(I)I

    move-result v2

    invoke-direct {p0, v1}, Lcom/gmhub/monitor/ThermalPanel;->dp(I)I

    move-result v1

    const/4 v3, 0x0

    invoke-virtual {v0, v3, v2, v3, v1}, Landroid/widget/TextView;->setPadding(IIII)V

    new-instance v1, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v2, -0x1

    const/4 v3, -0x2

    invoke-direct {v1, v2, v3}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {p0, v0, v1}, Lcom/gmhub/monitor/ThermalPanel;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    new-instance v0, Landroid/widget/LinearLayout;

    invoke-direct {v0, p1}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/gmhub/monitor/ThermalPanel;->readings:Landroid/widget/LinearLayout;

    invoke-virtual {v0, p2}, Landroid/widget/LinearLayout;->setOrientation(I)V

    new-instance p1, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {p1, v2, v3}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {p0, v0, p1}, Lcom/gmhub/monitor/ThermalPanel;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    return-void
.end method

.method private dp(I)I
    .locals 0

    int-to-float p1, p1

    invoke-virtual {p0}, Lcom/gmhub/monitor/ThermalPanel;->getResources()Landroid/content/res/Resources;

    move-result-object p0

    invoke-virtual {p0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object p0

    iget p0, p0, Landroid/util/DisplayMetrics;->density:F

    mul-float/2addr p1, p0

    invoke-static {p1}, Ljava/lang/Math;->round(F)I

    move-result p0

    return p0
.end method

.method static synthetic lambda$refreshLifecycle$0(Ljava/lang/Runnable;)Ljava/lang/Thread;
    .locals 2

    new-instance v0, Ljava/lang/Thread;

    const-string v1, "GMHubThermal"

    invoke-direct {v0, p0, v1}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;Ljava/lang/String;)V

    const/4 p0, 0x1

    invoke-virtual {v0, p0}, Ljava/lang/Thread;->setDaemon(Z)V

    return-object v0
.end method

.method private refreshLifecycle()V
    .locals 9

    invoke-static {}, Landroid/os/Looper;->myLooper()Landroid/os/Looper;

    move-result-object v0

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    if-ne v0, v1, :cond_3

    iget-boolean v0, p0, Lcom/gmhub/monitor/ThermalPanel;->attached:Z

    const/4 v1, 0x1

    if-eqz v0, :cond_0

    iget-boolean v0, p0, Lcom/gmhub/monitor/ThermalPanel;->visible:Z

    if-eqz v0, :cond_0

    iget-boolean v0, p0, Lcom/gmhub/monitor/ThermalPanel;->active:Z

    if-eqz v0, :cond_0

    move v0, v1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    if-eqz v0, :cond_1

    iget-object v2, p0, Lcom/gmhub/monitor/ThermalPanel;->worker:Ljava/util/concurrent/ScheduledExecutorService;

    if-nez v2, :cond_1

    iget v0, p0, Lcom/gmhub/monitor/ThermalPanel;->generation:I

    add-int/2addr v0, v1

    iput v0, p0, Lcom/gmhub/monitor/ThermalPanel;->generation:I

    new-instance v1, Lcom/gmhub/monitor/ThermalPanel$$ExternalSyntheticLambda0;

    invoke-direct {v1}, Lcom/gmhub/monitor/ThermalPanel$$ExternalSyntheticLambda0;-><init>()V

    invoke-static {v1}, Ljava/util/concurrent/Executors;->newSingleThreadScheduledExecutor(Ljava/util/concurrent/ThreadFactory;)Ljava/util/concurrent/ScheduledExecutorService;

    move-result-object v2

    iput-object v2, p0, Lcom/gmhub/monitor/ThermalPanel;->worker:Ljava/util/concurrent/ScheduledExecutorService;

    new-instance v3, Lcom/gmhub/monitor/ThermalPanel$$ExternalSyntheticLambda1;

    invoke-direct {v3, p0, v0}, Lcom/gmhub/monitor/ThermalPanel$$ExternalSyntheticLambda1;-><init>(Lcom/gmhub/monitor/ThermalPanel;I)V

    const-wide/16 v6, 0x2

    sget-object v8, Ljava/util/concurrent/TimeUnit;->SECONDS:Ljava/util/concurrent/TimeUnit;

    const-wide/16 v4, 0x0

    invoke-interface/range {v2 .. v8}, Ljava/util/concurrent/ScheduledExecutorService;->scheduleWithFixedDelay(Ljava/lang/Runnable;JJLjava/util/concurrent/TimeUnit;)Ljava/util/concurrent/ScheduledFuture;

    return-void

    :cond_1
    if-nez v0, :cond_2

    iget-object v0, p0, Lcom/gmhub/monitor/ThermalPanel;->worker:Ljava/util/concurrent/ScheduledExecutorService;

    if-eqz v0, :cond_2

    iget v2, p0, Lcom/gmhub/monitor/ThermalPanel;->generation:I

    add-int/2addr v2, v1

    iput v2, p0, Lcom/gmhub/monitor/ThermalPanel;->generation:I

    invoke-interface {v0}, Ljava/util/concurrent/ScheduledExecutorService;->shutdownNow()Ljava/util/List;

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/gmhub/monitor/ThermalPanel;->worker:Ljava/util/concurrent/ScheduledExecutorService;

    iget-object p0, p0, Lcom/gmhub/monitor/ThermalPanel;->main:Landroid/os/Handler;

    invoke-virtual {p0, v0}, Landroid/os/Handler;->removeCallbacksAndMessages(Ljava/lang/Object;)V

    :cond_2
    return-void

    :cond_3
    new-instance p0, Ljava/lang/IllegalStateException;

    const-string v0, "Settings UI thread required"

    invoke-direct {p0, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p0
.end method

.method private render(Ljava/util/List;)V
    .locals 7
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lcom/gmhub/monitor/ThermalReader$Reading;",
            ">;)V"
        }
    .end annotation

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/gmhub/monitor/ThermalReader$Reading;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v4, v2, Lcom/gmhub/monitor/ThermalReader$Reading;->zone:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v4, ":"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v2, v2, Lcom/gmhub/monitor/ThermalReader$Reading;->sensor:Ljava/lang/String;

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-interface {v0, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    :cond_0
    iget-object v1, p0, Lcom/gmhub/monitor/ThermalPanel;->identities:Ljava/util/List;

    invoke-interface {v0, v1}, Ljava/util/List;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_1

    iget-object v1, p0, Lcom/gmhub/monitor/ThermalPanel;->readings:Landroid/widget/LinearLayout;

    invoke-virtual {v1}, Landroid/widget/LinearLayout;->removeAllViews()V

    iget-object v1, p0, Lcom/gmhub/monitor/ThermalPanel;->values:Ljava/util/Map;

    invoke-interface {v1}, Ljava/util/Map;->clear()V

    iput-object v0, p0, Lcom/gmhub/monitor/ThermalPanel;->identities:Ljava/util/List;

    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_1
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/gmhub/monitor/ThermalReader$Reading;

    new-instance v2, Landroid/widget/TextView;

    invoke-virtual {p0}, Lcom/gmhub/monitor/ThermalPanel;->getContext()Landroid/content/Context;

    move-result-object v3

    invoke-direct {v2, v3}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    const v3, 0x10301b1

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setTextAppearance(I)V

    const/16 v3, 0xc

    invoke-direct {p0, v3}, Lcom/gmhub/monitor/ThermalPanel;->dp(I)I

    move-result v4

    invoke-direct {p0, v3}, Lcom/gmhub/monitor/ThermalPanel;->dp(I)I

    move-result v3

    const/4 v5, 0x0

    invoke-virtual {v2, v5, v4, v5, v3}, Landroid/widget/TextView;->setPadding(IIII)V

    invoke-virtual {v2, v5}, Landroid/widget/TextView;->setAccessibilityLiveRegion(I)V

    iget-object v3, p0, Lcom/gmhub/monitor/ThermalPanel;->readings:Landroid/widget/LinearLayout;

    new-instance v4, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v5, -0x1

    const/4 v6, -0x2

    invoke-direct {v4, v5, v6}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v3, v2, v4}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    iget-object v3, p0, Lcom/gmhub/monitor/ThermalPanel;->values:Ljava/util/Map;

    iget-object v1, v1, Lcom/gmhub/monitor/ThermalReader$Reading;->zone:Ljava/lang/String;

    invoke-interface {v3, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_1

    :cond_1
    const-string v0, "gm_thermal_unavailable"

    const-string v1, "Unavailable"

    invoke-direct {p0, v0, v1}, Lcom/gmhub/monitor/ThermalPanel;->text(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-interface {p1}, Ljava/util/List;->isEmpty()Z

    move-result v1

    if-eqz v1, :cond_2

    const-string v1, "gm_thermal_empty"

    goto :goto_2

    :cond_2
    const-string v1, "gm_thermal_read_only"

    :goto_2
    invoke-interface {p1}, Ljava/util/List;->isEmpty()Z

    move-result v2

    if-eqz v2, :cond_3

    const-string v2, "No readable thermal sensors."

    goto :goto_3

    :cond_3
    const-string v2, "Read-only sensor temperatures."

    :goto_3
    invoke-direct {p0, v1, v2}, Lcom/gmhub/monitor/ThermalPanel;->text(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lcom/gmhub/monitor/ThermalPanel;->status:Landroid/widget/TextView;

    invoke-virtual {v2}, Landroid/widget/TextView;->getText()Ljava/lang/CharSequence;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/String;->contentEquals(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_4

    iget-object v2, p0, Lcom/gmhub/monitor/ThermalPanel;->status:Landroid/widget/TextView;

    invoke-virtual {v2, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    :cond_4
    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :cond_5
    :goto_4
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_6

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/gmhub/monitor/ThermalReader$Reading;

    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v2

    invoke-virtual {v1, v2, v0}, Lcom/gmhub/monitor/ThermalReader$Reading;->temperature(Ljava/util/Locale;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iget-object v3, p0, Lcom/gmhub/monitor/ThermalPanel;->values:Ljava/util/Map;

    iget-object v4, v1, Lcom/gmhub/monitor/ThermalReader$Reading;->zone:Ljava/lang/String;

    invoke-interface {v3, v4}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Landroid/widget/TextView;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, v1, Lcom/gmhub/monitor/ThermalReader$Reading;->sensor:Ljava/lang/String;

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "\n"

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v3}, Landroid/widget/TextView;->getText()Ljava/lang/CharSequence;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/String;->contentEquals(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_5

    invoke-virtual {v3, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_4

    :cond_6
    return-void
.end method

.method public static setActive(Landroid/view/View;Z)V
    .locals 1

    if-nez p0, :cond_0

    goto :goto_0

    :cond_0
    const-string v0, "gmhub_thermal_panel"

    invoke-virtual {p0, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object p0

    instance-of v0, p0, Lcom/gmhub/monitor/ThermalPanel;

    if-eqz v0, :cond_1

    check-cast p0, Lcom/gmhub/monitor/ThermalPanel;

    iput-boolean p1, p0, Lcom/gmhub/monitor/ThermalPanel;->active:Z

    invoke-direct {p0}, Lcom/gmhub/monitor/ThermalPanel;->refreshLifecycle()V

    :cond_1
    :goto_0
    return-void
.end method

.method private text(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 3

    invoke-virtual {p0}, Lcom/gmhub/monitor/ThermalPanel;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {p0}, Lcom/gmhub/monitor/ThermalPanel;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v1

    const-string v2, "string"

    invoke-virtual {v0, p1, v2, v1}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result p1

    if-nez p1, :cond_0

    return-object p2

    :cond_0
    invoke-virtual {p0}, Lcom/gmhub/monitor/ThermalPanel;->getResources()Landroid/content/res/Resources;

    move-result-object p0

    invoke-virtual {p0, p1}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method


# virtual methods
.method synthetic lambda$refreshLifecycle$1$com-gmhub-monitor-ThermalPanel(I)V
    .locals 3

    new-instance v0, Ljava/io/File;

    const-string v1, "/sys/class/thermal"

    invoke-direct {v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-static {v0}, Lcom/gmhub/monitor/ThermalReader;->read(Ljava/io/File;)Ljava/util/List;

    move-result-object v0

    iget-object v1, p0, Lcom/gmhub/monitor/ThermalPanel;->main:Landroid/os/Handler;

    new-instance v2, Lcom/gmhub/monitor/ThermalPanel$$ExternalSyntheticLambda2;

    invoke-direct {v2, p0, p1, v0}, Lcom/gmhub/monitor/ThermalPanel$$ExternalSyntheticLambda2;-><init>(Lcom/gmhub/monitor/ThermalPanel;ILjava/util/List;)V

    invoke-virtual {v1, v2}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method synthetic lambda$refreshLifecycle$2$com-gmhub-monitor-ThermalPanel(ILjava/util/List;)V
    .locals 1

    iget-object v0, p0, Lcom/gmhub/monitor/ThermalPanel;->worker:Ljava/util/concurrent/ScheduledExecutorService;

    if-eqz v0, :cond_0

    iget v0, p0, Lcom/gmhub/monitor/ThermalPanel;->generation:I

    if-ne v0, p1, :cond_0

    invoke-direct {p0, p2}, Lcom/gmhub/monitor/ThermalPanel;->render(Ljava/util/List;)V

    :cond_0
    return-void
.end method

.method protected onAttachedToWindow()V
    .locals 1

    invoke-super {p0}, Landroid/widget/LinearLayout;->onAttachedToWindow()V

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/gmhub/monitor/ThermalPanel;->attached:Z

    invoke-virtual {p0}, Lcom/gmhub/monitor/ThermalPanel;->isShown()Z

    move-result v0

    iput-boolean v0, p0, Lcom/gmhub/monitor/ThermalPanel;->visible:Z

    invoke-direct {p0}, Lcom/gmhub/monitor/ThermalPanel;->refreshLifecycle()V

    return-void
.end method

.method protected onDetachedFromWindow()V
    .locals 1

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/gmhub/monitor/ThermalPanel;->attached:Z

    invoke-direct {p0}, Lcom/gmhub/monitor/ThermalPanel;->refreshLifecycle()V

    invoke-super {p0}, Landroid/widget/LinearLayout;->onDetachedFromWindow()V

    return-void
.end method

.method public onVisibilityAggregated(Z)V
    .locals 0

    invoke-super {p0, p1}, Landroid/widget/LinearLayout;->onVisibilityAggregated(Z)V

    iput-boolean p1, p0, Lcom/gmhub/monitor/ThermalPanel;->visible:Z

    invoke-direct {p0}, Lcom/gmhub/monitor/ThermalPanel;->refreshLifecycle()V

    return-void
.end method
