.class public final Lcom/gmhub/theme/PureBlackControl;
.super Ljava/lang/Object;
.source "PureBlackControl.java"


# static fields
.field private static final CONTROLS:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/lang/ref/WeakReference<",
            "Ljava/lang/Object;",
            ">;>;"
        }
    .end annotation
.end field

.field private static final MAIN:Landroid/os/Handler;

.field private static final WORK:Ljava/util/concurrent/ThreadPoolExecutor;

.field private static busy:Z


# direct methods
.method static constructor <clinit>()V
    .locals 9

    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    sput-object v0, Lcom/gmhub/theme/PureBlackControl;->MAIN:Landroid/os/Handler;

    new-instance v2, Ljava/util/concurrent/ThreadPoolExecutor;

    sget-object v7, Ljava/util/concurrent/TimeUnit;->SECONDS:Ljava/util/concurrent/TimeUnit;

    new-instance v8, Ljava/util/concurrent/LinkedBlockingQueue;

    invoke-direct {v8}, Ljava/util/concurrent/LinkedBlockingQueue;-><init>()V

    const/4 v3, 0x0

    const/4 v4, 0x1

    const-wide/16 v5, 0xf

    invoke-direct/range {v2 .. v8}, Ljava/util/concurrent/ThreadPoolExecutor;-><init>(IIJLjava/util/concurrent/TimeUnit;Ljava/util/concurrent/BlockingQueue;)V

    sput-object v2, Lcom/gmhub/theme/PureBlackControl;->WORK:Ljava/util/concurrent/ThreadPoolExecutor;

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    sput-object v0, Lcom/gmhub/theme/PureBlackControl;->CONTROLS:Ljava/util/List;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static change(Landroid/content/Context;Ljava/lang/Object;Z)V
    .locals 2

    invoke-static {}, Landroid/os/Looper;->myLooper()Landroid/os/Looper;

    move-result-object v0

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    if-ne v0, v1, :cond_1

    invoke-static {p1}, Lcom/gmhub/theme/PureBlackControl;->watch(Ljava/lang/Object;)V

    sget-boolean p1, Lcom/gmhub/theme/PureBlackControl;->busy:Z

    if-nez p1, :cond_0

    invoke-static {p2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object p1

    invoke-static {p0, p1}, Lcom/gmhub/theme/PureBlackControl;->submit(Landroid/content/Context;Ljava/lang/Boolean;)V

    :cond_0
    return-void

    :cond_1
    new-instance p0, Ljava/lang/IllegalStateException;

    const-string p1, "Main thread required"

    invoke-direct {p0, p1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p0
.end method

.method private static control(Ljava/lang/Object;ZZ)V
    .locals 2

    :try_start_0
    const-string v0, "setChecked"

    sget-object v1, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    filled-new-array {v1}, [Ljava/lang/Class;

    move-result-object v1

    invoke-static {p1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object p1

    filled-new-array {p1}, [Ljava/lang/Object;

    move-result-object p1

    invoke-static {p0, v0, v1, p1}, Lcom/gmhub/theme/PureBlackPolicy;->call(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Class;[Ljava/lang/Object;)Ljava/lang/Object;

    const-string p1, "setEnabled"

    sget-object v0, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    filled-new-array {v0}, [Ljava/lang/Class;

    move-result-object v0

    invoke-static {p2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object p2

    filled-new-array {p2}, [Ljava/lang/Object;

    move-result-object p2

    invoke-static {p0, p1, v0, p2}, Lcom/gmhub/theme/PureBlackPolicy;->call(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Class;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p0

    const-string p1, "GMHubBlack"

    const-string p2, "Preference no longer available"

    invoke-static {p1, p2, p0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    return-void
.end method

.method static synthetic lambda$submit$0(Landroid/content/Context;Ljava/lang/Boolean;)V
    .locals 11

    const/4 v1, 0x0

    :try_start_0
    new-instance v0, Lcom/gmhub/theme/PureBlackBackend;

    invoke-direct {v0, p0}, Lcom/gmhub/theme/PureBlackBackend;-><init>(Landroid/content/Context;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1

    const/4 v2, 0x1

    if-eqz p1, :cond_1

    :try_start_1
    invoke-virtual {p1}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v3

    if-eqz v3, :cond_0

    invoke-virtual {v0}, Lcom/gmhub/theme/PureBlackBackend;->enable()V

    goto :goto_0

    :cond_0
    invoke-virtual {v0}, Lcom/gmhub/theme/PureBlackBackend;->disable()V

    :cond_1
    :goto_0
    invoke-virtual {v0}, Lcom/gmhub/theme/PureBlackBackend;->enabled()Z

    move-result v1
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    const/4 v0, 0x0

    goto :goto_2

    :catch_0
    move-exception v0

    goto :goto_1

    :catch_1
    move-exception v0

    move v2, v1

    :goto_1
    const-string v3, "GMHubBlack"

    const-string v4, "Theme operation not confirmed"

    invoke-static {v3, v4, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    :goto_2
    move-object v9, v0

    move v6, v1

    move v7, v2

    sget-object v0, Lcom/gmhub/theme/PureBlackControl;->MAIN:Landroid/os/Handler;

    new-instance v5, Lcom/gmhub/theme/PureBlackControl$$ExternalSyntheticLambda0;

    move-object v10, p0

    move-object v8, p1

    invoke-direct/range {v5 .. v10}, Lcom/gmhub/theme/PureBlackControl$$ExternalSyntheticLambda0;-><init>(ZZLjava/lang/Boolean;Ljava/lang/Exception;Landroid/content/Context;)V

    invoke-virtual {v0, v5}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method static synthetic lambda$submit$1(ZZLjava/lang/Boolean;Ljava/lang/Exception;Landroid/content/Context;)V
    .locals 4

    const/4 v0, 0x0

    sput-boolean v0, Lcom/gmhub/theme/PureBlackControl;->busy:Z

    sget-object v1, Lcom/gmhub/theme/PureBlackControl;->CONTROLS:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    const/4 v3, 0x1

    if-eqz v2, :cond_3

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/ref/WeakReference;

    invoke-virtual {v2}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v2

    if-nez v2, :cond_0

    invoke-interface {v1}, Ljava/util/Iterator;->remove()V

    goto :goto_0

    :cond_0
    if-nez p1, :cond_2

    if-eqz p2, :cond_1

    goto :goto_1

    :cond_1
    move v3, v0

    :cond_2
    :goto_1
    invoke-static {v2, p0, v3}, Lcom/gmhub/theme/PureBlackControl;->control(Ljava/lang/Object;ZZ)V

    goto :goto_0

    :cond_3
    if-eqz p3, :cond_5

    if-eqz p2, :cond_5

    invoke-virtual {p4}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object p0

    const-string p1, "string"

    invoke-virtual {p4}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object p2

    const-string p3, "gm_pure_black_failed"

    invoke-virtual {p0, p3, p1, p2}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result p0

    if-nez p0, :cond_4

    const-string p0, "Pure Black could not be confirmed; reopen to check recovery."

    goto :goto_2

    :cond_4
    invoke-virtual {p4, p0}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p0

    :goto_2
    invoke-static {p4, p0, v3}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object p0

    invoke-virtual {p0}, Landroid/widget/Toast;->show()V

    :cond_5
    return-void
.end method

.method private static submit(Landroid/content/Context;Ljava/lang/Boolean;)V
    .locals 5

    const/4 v0, 0x1

    sput-boolean v0, Lcom/gmhub/theme/PureBlackControl;->busy:Z

    sget-object v0, Lcom/gmhub/theme/PureBlackControl;->CONTROLS:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :catch_0
    :cond_0
    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/ref/WeakReference;

    invoke-virtual {v1}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v1

    if-eqz v1, :cond_0

    :try_start_0
    const-string v2, "setEnabled"

    sget-object v3, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    filled-new-array {v3}, [Ljava/lang/Class;

    move-result-object v3

    const/4 v4, 0x0

    invoke-static {v4}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v4

    filled-new-array {v4}, [Ljava/lang/Object;

    move-result-object v4

    invoke-static {v1, v2, v3, v4}, Lcom/gmhub/theme/PureBlackPolicy;->call(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Class;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :cond_1
    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object p0

    sget-object v0, Lcom/gmhub/theme/PureBlackControl;->WORK:Ljava/util/concurrent/ThreadPoolExecutor;

    new-instance v1, Lcom/gmhub/theme/PureBlackControl$$ExternalSyntheticLambda1;

    invoke-direct {v1, p0, p1}, Lcom/gmhub/theme/PureBlackControl$$ExternalSyntheticLambda1;-><init>(Landroid/content/Context;Ljava/lang/Boolean;)V

    invoke-virtual {v0, v1}, Ljava/util/concurrent/ThreadPoolExecutor;->execute(Ljava/lang/Runnable;)V

    return-void
.end method

.method public static sync(Landroid/content/Context;Ljava/lang/Object;)V
    .locals 2

    invoke-static {}, Landroid/os/Looper;->myLooper()Landroid/os/Looper;

    move-result-object v0

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    if-ne v0, v1, :cond_1

    invoke-static {p1}, Lcom/gmhub/theme/PureBlackControl;->watch(Ljava/lang/Object;)V

    sget-boolean v0, Lcom/gmhub/theme/PureBlackControl;->busy:Z

    if-eqz v0, :cond_0

    const/4 p0, 0x0

    invoke-static {p1, p0, p0}, Lcom/gmhub/theme/PureBlackControl;->control(Ljava/lang/Object;ZZ)V

    return-void

    :cond_0
    const/4 p1, 0x0

    invoke-static {p0, p1}, Lcom/gmhub/theme/PureBlackControl;->submit(Landroid/content/Context;Ljava/lang/Boolean;)V

    return-void

    :cond_1
    new-instance p0, Ljava/lang/IllegalStateException;

    const-string p1, "Main thread required"

    invoke-direct {p0, p1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p0
.end method

.method private static watch(Ljava/lang/Object;)V
    .locals 2

    sget-object v0, Lcom/gmhub/theme/PureBlackControl;->CONTROLS:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_0
    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_2

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/ref/WeakReference;

    invoke-virtual {v1}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v1

    if-nez v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->remove()V

    goto :goto_0

    :cond_1
    if-ne v1, p0, :cond_0

    return-void

    :cond_2
    sget-object v0, Lcom/gmhub/theme/PureBlackControl;->CONTROLS:Ljava/util/List;

    new-instance v1, Ljava/lang/ref/WeakReference;

    invoke-direct {v1, p0}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    return-void
.end method
