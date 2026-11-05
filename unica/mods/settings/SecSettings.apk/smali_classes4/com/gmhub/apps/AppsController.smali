.class public final Lcom/gmhub/apps/AppsController;
.super Ljava/lang/Object;
.source "AppsController.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/gmhub/apps/AppsController$Host;,
        Lcom/gmhub/apps/AppsController$Row;
    }
.end annotation


# static fields
.field private static final OPTIONAL:[Ljava/lang/String;


# instance fields
.field private volatile active:Z

.field private backend:Lcom/gmhub/apps/AppBackend;

.field private busy:Z

.field private volatile closed:Z

.field private final context:Landroid/content/Context;

.field private dialog:Landroid/app/AlertDialog;

.field private generation:I

.field private final host:Lcom/gmhub/apps/AppsController$Host;

.field private final iconBindings:Ljava/util/WeakHashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/WeakHashMap<",
            "Landroid/widget/ImageView;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private final iconCache:Landroid/util/LruCache;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/util/LruCache<",
            "Ljava/lang/String;",
            "Landroid/graphics/drawable/Drawable$ConstantState;",
            ">;"
        }
    .end annotation
.end field

.field private final icons:Ljava/util/concurrent/ThreadPoolExecutor;

.field private inventory:Ljava/util/concurrent/Future;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/concurrent/Future<",
            "*>;"
        }
    .end annotation
.end field

.field private final main:Landroid/os/Handler;

.field private query:Ljava/lang/String;

.field private final search:Ljava/lang/Runnable;

.field private showSystem:Z

.field private final worker:Ljava/util/concurrent/ExecutorService;


# direct methods
.method static constructor <clinit>()V
    .locals 5

    const-string v0, "com.samsung.android.game.gametools"

    const-string v1, "com.samsung.android.kidsinstaller"

    const-string v2, "com.samsung.android.bixby.agent"

    const-string v3, "com.samsung.android.app.spage"

    const-string v4, "com.sec.android.app.sbrowser"

    filled-new-array {v2, v3, v4, v0, v1}, [Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/gmhub/apps/AppsController;->OPTIONAL:[Ljava/lang/String;

    return-void
.end method

.method public constructor <init>(Lcom/gmhub/apps/AppsController$Host;)V
    .locals 9

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    iput-object v0, p0, Lcom/gmhub/apps/AppsController;->main:Landroid/os/Handler;

    invoke-static {}, Ljava/util/concurrent/Executors;->newSingleThreadExecutor()Ljava/util/concurrent/ExecutorService;

    move-result-object v0

    iput-object v0, p0, Lcom/gmhub/apps/AppsController;->worker:Ljava/util/concurrent/ExecutorService;

    new-instance v1, Ljava/util/concurrent/ThreadPoolExecutor;

    sget-object v6, Ljava/util/concurrent/TimeUnit;->SECONDS:Ljava/util/concurrent/TimeUnit;

    new-instance v7, Ljava/util/concurrent/ArrayBlockingQueue;

    const/16 v0, 0x10

    invoke-direct {v7, v0}, Ljava/util/concurrent/ArrayBlockingQueue;-><init>(I)V

    new-instance v8, Ljava/util/concurrent/ThreadPoolExecutor$DiscardOldestPolicy;

    invoke-direct {v8}, Ljava/util/concurrent/ThreadPoolExecutor$DiscardOldestPolicy;-><init>()V

    const/4 v2, 0x1

    const/4 v3, 0x1

    const-wide/16 v4, 0x0

    invoke-direct/range {v1 .. v8}, Ljava/util/concurrent/ThreadPoolExecutor;-><init>(IIJLjava/util/concurrent/TimeUnit;Ljava/util/concurrent/BlockingQueue;Ljava/util/concurrent/RejectedExecutionHandler;)V

    iput-object v1, p0, Lcom/gmhub/apps/AppsController;->icons:Ljava/util/concurrent/ThreadPoolExecutor;

    new-instance v0, Landroid/util/LruCache;

    const/16 v1, 0xc

    invoke-direct {v0, v1}, Landroid/util/LruCache;-><init>(I)V

    iput-object v0, p0, Lcom/gmhub/apps/AppsController;->iconCache:Landroid/util/LruCache;

    new-instance v0, Ljava/util/WeakHashMap;

    invoke-direct {v0}, Ljava/util/WeakHashMap;-><init>()V

    iput-object v0, p0, Lcom/gmhub/apps/AppsController;->iconBindings:Ljava/util/WeakHashMap;

    const-string v0, ""

    iput-object v0, p0, Lcom/gmhub/apps/AppsController;->query:Ljava/lang/String;

    new-instance v0, Lcom/gmhub/apps/AppsController$$ExternalSyntheticLambda1;

    invoke-direct {v0, p0}, Lcom/gmhub/apps/AppsController$$ExternalSyntheticLambda1;-><init>(Lcom/gmhub/apps/AppsController;)V

    iput-object v0, p0, Lcom/gmhub/apps/AppsController;->search:Ljava/lang/Runnable;

    iput-object p1, p0, Lcom/gmhub/apps/AppsController;->host:Lcom/gmhub/apps/AppsController$Host;

    invoke-interface {p1}, Lcom/gmhub/apps/AppsController$Host;->context()Landroid/content/Context;

    move-result-object p1

    iput-object p1, p0, Lcom/gmhub/apps/AppsController;->context:Landroid/content/Context;

    return-void
.end method

.method private backend()Lcom/gmhub/apps/AppBackend;
    .locals 2

    iget-object v0, p0, Lcom/gmhub/apps/AppsController;->backend:Lcom/gmhub/apps/AppBackend;

    if-nez v0, :cond_0

    new-instance v0, Lcom/gmhub/apps/AppBackend;

    iget-object v1, p0, Lcom/gmhub/apps/AppsController;->context:Landroid/content/Context;

    invoke-direct {v0, v1}, Lcom/gmhub/apps/AppBackend;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/gmhub/apps/AppsController;->backend:Lcom/gmhub/apps/AppBackend;

    :cond_0
    iget-object p0, p0, Lcom/gmhub/apps/AppsController;->backend:Lcom/gmhub/apps/AppBackend;

    return-object p0
.end method

.method private chooseOptional(Z)V
    .locals 3

    iget v0, p0, Lcom/gmhub/apps/AppsController;->generation:I

    iget-object v1, p0, Lcom/gmhub/apps/AppsController;->worker:Ljava/util/concurrent/ExecutorService;

    new-instance v2, Lcom/gmhub/apps/AppsController$$ExternalSyntheticLambda12;

    invoke-direct {v2, p0, v0, p1}, Lcom/gmhub/apps/AppsController$$ExternalSyntheticLambda12;-><init>(Lcom/gmhub/apps/AppsController;IZ)V

    invoke-interface {v1, v2}, Ljava/util/concurrent/ExecutorService;->submit(Ljava/lang/Runnable;)Ljava/util/concurrent/Future;

    return-void
.end method

.method private current(I)Z
    .locals 1

    iget-boolean v0, p0, Lcom/gmhub/apps/AppsController;->active:Z

    if-eqz v0, :cond_0

    iget-boolean v0, p0, Lcom/gmhub/apps/AppsController;->closed:Z

    if-nez v0, :cond_0

    iget p0, p0, Lcom/gmhub/apps/AppsController;->generation:I

    if-ne p1, p0, :cond_0

    const/4 p0, 0x1

    return p0

    :cond_0
    const/4 p0, 0x0

    return p0
.end method

.method static synthetic lambda$chooseOptional$2([ZLandroid/content/DialogInterface;IZ)V
    .locals 0

    aput-boolean p3, p0, p2

    return-void
.end method

.method static synthetic lambda$reload$1(Ljava/text/Collator;Lcom/gmhub/apps/AppsController$Row;Lcom/gmhub/apps/AppsController$Row;)I
    .locals 2

    iget-object v0, p1, Lcom/gmhub/apps/AppsController$Row;->label:Ljava/lang/String;

    iget-object v1, p2, Lcom/gmhub/apps/AppsController$Row;->label:Ljava/lang/String;

    invoke-virtual {p0, v0, v1}, Ljava/text/Collator;->compare(Ljava/lang/String;Ljava/lang/String;)I

    move-result p0

    if-eqz p0, :cond_0

    return p0

    :cond_0
    iget-object p0, p1, Lcom/gmhub/apps/AppsController$Row;->pkg:Ljava/lang/String;

    iget-object p1, p2, Lcom/gmhub/apps/AppsController$Row;->pkg:Ljava/lang/String;

    invoke-virtual {p0, p1}, Ljava/lang/String;->compareTo(Ljava/lang/String;)I

    move-result p0

    return p0
.end method

.method private perform(Ljava/util/List;ZZ)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;ZZ)V"
        }
    .end annotation

    iget-boolean v0, p0, Lcom/gmhub/apps/AppsController;->active:Z

    if-eqz v0, :cond_2

    iget-boolean v0, p0, Lcom/gmhub/apps/AppsController;->busy:Z

    if-nez v0, :cond_2

    iget-boolean v0, p0, Lcom/gmhub/apps/AppsController;->closed:Z

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/gmhub/apps/AppsController;->busy:Z

    iget v1, p0, Lcom/gmhub/apps/AppsController;->generation:I

    add-int/2addr v1, v0

    iput v1, p0, Lcom/gmhub/apps/AppsController;->generation:I

    iget-object v1, p0, Lcom/gmhub/apps/AppsController;->inventory:Ljava/util/concurrent/Future;

    if-eqz v1, :cond_1

    invoke-interface {v1, v0}, Ljava/util/concurrent/Future;->cancel(Z)Z

    :cond_1
    iget-object v1, p0, Lcom/gmhub/apps/AppsController;->host:Lcom/gmhub/apps/AppsController$Host;

    invoke-interface {v1, v0}, Lcom/gmhub/apps/AppsController$Host;->busy(Z)V

    iget-object v0, p0, Lcom/gmhub/apps/AppsController;->worker:Ljava/util/concurrent/ExecutorService;

    new-instance v1, Lcom/gmhub/apps/AppsController$$ExternalSyntheticLambda0;

    invoke-direct {v1, p0, p3, p1, p2}, Lcom/gmhub/apps/AppsController$$ExternalSyntheticLambda0;-><init>(Lcom/gmhub/apps/AppsController;ZLjava/util/List;Z)V

    invoke-interface {v0, v1}, Ljava/util/concurrent/ExecutorService;->submit(Ljava/lang/Runnable;)Ljava/util/concurrent/Future;

    :cond_2
    :goto_0
    return-void
.end method

.method private reload()V
    .locals 5

    iget-boolean v0, p0, Lcom/gmhub/apps/AppsController;->active:Z

    if-eqz v0, :cond_2

    iget-boolean v0, p0, Lcom/gmhub/apps/AppsController;->closed:Z

    if-nez v0, :cond_2

    iget-boolean v0, p0, Lcom/gmhub/apps/AppsController;->busy:Z

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    iget v0, p0, Lcom/gmhub/apps/AppsController;->generation:I

    const/4 v1, 0x1

    add-int/2addr v0, v1

    iput v0, p0, Lcom/gmhub/apps/AppsController;->generation:I

    iget-object v2, p0, Lcom/gmhub/apps/AppsController;->inventory:Ljava/util/concurrent/Future;

    if-eqz v2, :cond_1

    invoke-interface {v2, v1}, Ljava/util/concurrent/Future;->cancel(Z)Z

    :cond_1
    iget-object v2, p0, Lcom/gmhub/apps/AppsController;->query:Ljava/lang/String;

    sget-object v3, Ljava/util/Locale;->ROOT:Ljava/util/Locale;

    invoke-virtual {v2, v3}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v2

    iget-boolean v3, p0, Lcom/gmhub/apps/AppsController;->showSystem:Z

    iget-object v4, p0, Lcom/gmhub/apps/AppsController;->host:Lcom/gmhub/apps/AppsController$Host;

    invoke-interface {v4, v1}, Lcom/gmhub/apps/AppsController$Host;->busy(Z)V

    iget-object v1, p0, Lcom/gmhub/apps/AppsController;->host:Lcom/gmhub/apps/AppsController$Host;

    const-string v4, "paradox_mgr_loading"

    invoke-direct {p0, v4}, Lcom/gmhub/apps/AppsController;->text(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-interface {v1, v4}, Lcom/gmhub/apps/AppsController$Host;->clear(Ljava/lang/String;)V

    iget-object v1, p0, Lcom/gmhub/apps/AppsController;->worker:Ljava/util/concurrent/ExecutorService;

    new-instance v4, Lcom/gmhub/apps/AppsController$$ExternalSyntheticLambda2;

    invoke-direct {v4, p0, v3, v2, v0}, Lcom/gmhub/apps/AppsController$$ExternalSyntheticLambda2;-><init>(Lcom/gmhub/apps/AppsController;ZLjava/lang/String;I)V

    invoke-interface {v1, v4}, Ljava/util/concurrent/ExecutorService;->submit(Ljava/lang/Runnable;)Ljava/util/concurrent/Future;

    move-result-object v0

    iput-object v0, p0, Lcom/gmhub/apps/AppsController;->inventory:Ljava/util/concurrent/Future;

    :cond_2
    :goto_0
    return-void
.end method

.method private render(Ljava/util/List;II)V
    .locals 10
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lcom/gmhub/apps/AppsController$Row;",
            ">;II)V"
        }
    .end annotation

    invoke-direct {p0, p3}, Lcom/gmhub/apps/AppsController;->current(I)Z

    move-result v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    const-string v0, ""

    if-nez p2, :cond_2

    iget-object v1, p0, Lcom/gmhub/apps/AppsController;->host:Lcom/gmhub/apps/AppsController$Host;

    invoke-interface {p1}, Ljava/util/List;->isEmpty()Z

    move-result v2

    if-eqz v2, :cond_1

    const-string v2, "gm_apps_empty"

    invoke-direct {p0, v2}, Lcom/gmhub/apps/AppsController;->text(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto :goto_0

    :cond_1
    move-object v2, v0

    :goto_0
    invoke-interface {v1, v2}, Lcom/gmhub/apps/AppsController$Host;->clear(Ljava/lang/String;)V

    :cond_2
    add-int/lit8 v1, p2, 0x8

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v2

    invoke-static {v1, v2}, Ljava/lang/Math;->min(II)I

    move-result v1

    :goto_1
    if-ge p2, v1, :cond_4

    invoke-interface {p1, p2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/gmhub/apps/AppsController$Row;

    iget-object v3, p0, Lcom/gmhub/apps/AppsController;->host:Lcom/gmhub/apps/AppsController$Host;

    iget-object v4, v2, Lcom/gmhub/apps/AppsController$Row;->pkg:Ljava/lang/String;

    iget-object v5, v2, Lcom/gmhub/apps/AppsController$Row;->label:Ljava/lang/String;

    iget-boolean v6, v2, Lcom/gmhub/apps/AppsController$Row;->enabled:Z

    iget-boolean v7, v2, Lcom/gmhub/apps/AppsController$Row;->editable:Z

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v9, v2, Lcom/gmhub/apps/AppsController$Row;->pkg:Ljava/lang/String;

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-boolean v2, v2, Lcom/gmhub/apps/AppsController$Row;->editable:Z

    if-eqz v2, :cond_3

    move-object v2, v0

    goto :goto_2

    :cond_3
    new-instance v2, Ljava/lang/StringBuilder;

    const-string v9, "\n"

    invoke-direct {v2, v9}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v9, "gm_apps_protected"

    invoke-direct {p0, v9}, Lcom/gmhub/apps/AppsController;->text(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v2, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    :goto_2
    invoke-virtual {v8, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-interface/range {v3 .. v8}, Lcom/gmhub/apps/AppsController$Host;->row(Ljava/lang/String;Ljava/lang/String;ZZLjava/lang/String;)V

    add-int/lit8 p2, p2, 0x1

    goto :goto_1

    :cond_4
    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result p2

    if-ge v1, p2, :cond_5

    iget-object p2, p0, Lcom/gmhub/apps/AppsController;->main:Landroid/os/Handler;

    new-instance v0, Lcom/gmhub/apps/AppsController$$ExternalSyntheticLambda14;

    invoke-direct {v0, p0, p1, v1, p3}, Lcom/gmhub/apps/AppsController$$ExternalSyntheticLambda14;-><init>(Lcom/gmhub/apps/AppsController;Ljava/util/List;II)V

    const-wide/16 p0, 0x10

    invoke-virtual {p2, v0, p0, p1}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    return-void

    :cond_5
    iget-object p0, p0, Lcom/gmhub/apps/AppsController;->host:Lcom/gmhub/apps/AppsController$Host;

    const/4 p1, 0x0

    invoke-interface {p0, p1}, Lcom/gmhub/apps/AppsController$Host;->busy(Z)V

    return-void
.end method

.method private text(Ljava/lang/String;)Ljava/lang/String;
    .locals 3

    iget-object v0, p0, Lcom/gmhub/apps/AppsController;->context:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    iget-object v1, p0, Lcom/gmhub/apps/AppsController;->context:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v1

    const-string v2, "string"

    invoke-virtual {v0, p1, v2, v1}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    if-nez v0, :cond_0

    return-object p1

    :cond_0
    iget-object p0, p0, Lcom/gmhub/apps/AppsController;->context:Landroid/content/Context;

    invoke-virtual {p0, v0}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method


# virtual methods
.method public bindIcon(Landroid/view/View;Ljava/lang/String;)V
    .locals 3

    const v0, 0x1020006

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/ImageView;

    if-eqz p1, :cond_2

    iget-boolean v0, p0, Lcom/gmhub/apps/AppsController;->active:Z

    if-eqz v0, :cond_2

    iget-boolean v0, p0, Lcom/gmhub/apps/AppsController;->closed:Z

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    const v0, 0x1080093

    invoke-virtual {p1, v0}, Landroid/widget/ImageView;->setImageResource(I)V

    iget-object v0, p0, Lcom/gmhub/apps/AppsController;->iconBindings:Ljava/util/WeakHashMap;

    invoke-virtual {v0, p1, p2}, Ljava/util/WeakHashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Lcom/gmhub/apps/AppsController;->iconCache:Landroid/util/LruCache;

    invoke-virtual {v0, p2}, Landroid/util/LruCache;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/graphics/drawable/Drawable$ConstantState;

    if-eqz v0, :cond_1

    iget-object p0, p0, Lcom/gmhub/apps/AppsController;->context:Landroid/content/Context;

    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object p0

    invoke-virtual {v0, p0}, Landroid/graphics/drawable/Drawable$ConstantState;->newDrawable(Landroid/content/res/Resources;)Landroid/graphics/drawable/Drawable;

    move-result-object p0

    invoke-virtual {p1, p0}, Landroid/widget/ImageView;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V

    return-void

    :cond_1
    iget v0, p0, Lcom/gmhub/apps/AppsController;->generation:I

    new-instance v1, Ljava/lang/ref/WeakReference;

    invoke-direct {v1, p1}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    iget-object p1, p0, Lcom/gmhub/apps/AppsController;->icons:Ljava/util/concurrent/ThreadPoolExecutor;

    new-instance v2, Lcom/gmhub/apps/AppsController$$ExternalSyntheticLambda13;

    invoke-direct {v2, p0, p2, v0, v1}, Lcom/gmhub/apps/AppsController$$ExternalSyntheticLambda13;-><init>(Lcom/gmhub/apps/AppsController;Ljava/lang/String;ILjava/lang/ref/WeakReference;)V

    invoke-virtual {p1, v2}, Ljava/util/concurrent/ThreadPoolExecutor;->execute(Ljava/lang/Runnable;)V

    :cond_2
    :goto_0
    return-void
.end method

.method public change(Ljava/lang/String;Z)Z
    .locals 2

    iget-boolean v0, p0, Lcom/gmhub/apps/AppsController;->active:Z

    const/4 v1, 0x0

    if-eqz v0, :cond_1

    iget-boolean v0, p0, Lcom/gmhub/apps/AppsController;->busy:Z

    if-nez v0, :cond_1

    iget-boolean v0, p0, Lcom/gmhub/apps/AppsController;->closed:Z

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    invoke-static {p1}, Ljava/util/Collections;->singletonList(Ljava/lang/Object;)Ljava/util/List;

    move-result-object p1

    invoke-direct {p0, p1, p2, v1}, Lcom/gmhub/apps/AppsController;->perform(Ljava/util/List;ZZ)V

    :cond_1
    :goto_0
    return v1
.end method

.method public close()V
    .locals 1

    invoke-virtual {p0}, Lcom/gmhub/apps/AppsController;->pause()V

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/gmhub/apps/AppsController;->closed:Z

    iget-object v0, p0, Lcom/gmhub/apps/AppsController;->worker:Ljava/util/concurrent/ExecutorService;

    invoke-interface {v0}, Ljava/util/concurrent/ExecutorService;->shutdown()V

    iget-object p0, p0, Lcom/gmhub/apps/AppsController;->icons:Ljava/util/concurrent/ThreadPoolExecutor;

    invoke-virtual {p0}, Ljava/util/concurrent/ThreadPoolExecutor;->shutdownNow()Ljava/util/List;

    return-void
.end method

.method public createMenu(Landroid/view/Menu;)V
    .locals 4

    const-string v0, "gm_apps_restore"

    invoke-direct {p0, v0}, Lcom/gmhub/apps/AppsController;->text(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    const/4 v2, 0x1

    invoke-interface {p1, v1, v2, v1, v0}, Landroid/view/Menu;->add(IIILjava/lang/CharSequence;)Landroid/view/MenuItem;

    const-string v0, "gm_apps_disable_selected"

    invoke-direct {p0, v0}, Lcom/gmhub/apps/AppsController;->text(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const/4 v3, 0x2

    invoke-interface {p1, v1, v3, v2, v0}, Landroid/view/Menu;->add(IIILjava/lang/CharSequence;)Landroid/view/MenuItem;

    const-string v0, "gm_apps_enable_selected"

    invoke-direct {p0, v0}, Lcom/gmhub/apps/AppsController;->text(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const/4 v2, 0x4

    invoke-interface {p1, v1, v2, v3, v0}, Landroid/view/Menu;->add(IIILjava/lang/CharSequence;)Landroid/view/MenuItem;

    const-string v0, "paradox_mgr_show_sys"

    invoke-direct {p0, v0}, Lcom/gmhub/apps/AppsController;->text(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    const/4 v0, 0x3

    invoke-interface {p1, v1, v0, v0, p0}, Landroid/view/Menu;->add(IIILjava/lang/CharSequence;)Landroid/view/MenuItem;

    return-void
.end method

.method synthetic lambda$bindIcon$0$com-gmhub-apps-AppsController(Ljava/lang/String;ILjava/lang/ref/WeakReference;)V
    .locals 7

    :try_start_0
    iget-object v0, p0, Lcom/gmhub/apps/AppsController;->context:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v0

    invoke-virtual {v0, p1}, Landroid/content/pm/PackageManager;->getApplicationIcon(Ljava/lang/String;)Landroid/graphics/drawable/Drawable;

    move-result-object v6
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    iget-object v0, p0, Lcom/gmhub/apps/AppsController;->main:Landroid/os/Handler;

    new-instance v1, Lcom/gmhub/apps/AppsController$$ExternalSyntheticLambda3;

    move-object v2, p0

    move-object v5, p1

    move v3, p2

    move-object v4, p3

    invoke-direct/range {v1 .. v6}, Lcom/gmhub/apps/AppsController$$ExternalSyntheticLambda3;-><init>(Lcom/gmhub/apps/AppsController;ILjava/lang/ref/WeakReference;Ljava/lang/String;Landroid/graphics/drawable/Drawable;)V

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    :catch_0
    return-void
.end method

.method synthetic lambda$bindIcon$1$com-gmhub-apps-AppsController(ILjava/lang/ref/WeakReference;Ljava/lang/String;Landroid/graphics/drawable/Drawable;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/gmhub/apps/AppsController;->current(I)Z

    move-result p1

    if-nez p1, :cond_0

    goto :goto_0

    :cond_0
    invoke-virtual {p2}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Landroid/widget/ImageView;

    if-eqz p1, :cond_3

    iget-object p2, p0, Lcom/gmhub/apps/AppsController;->iconBindings:Ljava/util/WeakHashMap;

    invoke-virtual {p2, p1}, Ljava/util/WeakHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p2

    invoke-virtual {p3, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p2

    if-nez p2, :cond_1

    goto :goto_0

    :cond_1
    invoke-virtual {p4}, Landroid/graphics/drawable/Drawable;->getConstantState()Landroid/graphics/drawable/Drawable$ConstantState;

    move-result-object p2

    if-eqz p2, :cond_2

    iget-object p0, p0, Lcom/gmhub/apps/AppsController;->iconCache:Landroid/util/LruCache;

    invoke-virtual {p4}, Landroid/graphics/drawable/Drawable;->getConstantState()Landroid/graphics/drawable/Drawable$ConstantState;

    move-result-object p2

    invoke-virtual {p0, p3, p2}, Landroid/util/LruCache;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    :cond_2
    invoke-virtual {p1, p4}, Landroid/widget/ImageView;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V

    :cond_3
    :goto_0
    return-void
.end method

.method synthetic lambda$chooseOptional$0$com-gmhub-apps-AppsController(IZ)V
    .locals 9

    new-instance v5, Ljava/util/ArrayList;

    invoke-direct {v5}, Ljava/util/ArrayList;-><init>()V

    new-instance v3, Ljava/util/ArrayList;

    invoke-direct {v3}, Ljava/util/ArrayList;-><init>()V

    sget-object v0, Lcom/gmhub/apps/AppsController;->OPTIONAL:[Ljava/lang/String;

    array-length v1, v0

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v1, :cond_0

    aget-object v4, v0, v2

    :try_start_0
    invoke-direct {p0}, Lcom/gmhub/apps/AppsController;->backend()Lcom/gmhub/apps/AppBackend;

    move-result-object v6

    invoke-virtual {v6, v4}, Lcom/gmhub/apps/AppBackend;->info(Ljava/lang/String;)Landroid/content/pm/ApplicationInfo;

    move-result-object v6

    invoke-interface {v3, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v8, p0, Lcom/gmhub/apps/AppsController;->context:Landroid/content/Context;

    invoke-virtual {v8}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v8

    invoke-virtual {v6, v8}, Landroid/content/pm/ApplicationInfo;->loadLabel(Landroid/content/pm/PackageManager;)Ljava/lang/CharSequence;

    move-result-object v6

    invoke-virtual {v7, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    const-string v6, "\n"

    invoke-virtual {v7, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v7, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-interface {v5, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_0
    iget-object v6, p0, Lcom/gmhub/apps/AppsController;->main:Landroid/os/Handler;

    new-instance v0, Lcom/gmhub/apps/AppsController$$ExternalSyntheticLambda10;

    move-object v1, p0

    move v2, p1

    move v4, p2

    invoke-direct/range {v0 .. v5}, Lcom/gmhub/apps/AppsController$$ExternalSyntheticLambda10;-><init>(Lcom/gmhub/apps/AppsController;ILjava/util/List;ZLjava/util/List;)V

    invoke-virtual {v6, v0}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method synthetic lambda$chooseOptional$1$com-gmhub-apps-AppsController(ILjava/util/List;ZLjava/util/List;)V
    .locals 3

    invoke-direct {p0, p1}, Lcom/gmhub/apps/AppsController;->current(I)Z

    move-result p1

    if-nez p1, :cond_0

    return-void

    :cond_0
    invoke-interface {p2}, Ljava/util/List;->isEmpty()Z

    move-result p1

    const/4 v0, 0x0

    if-eqz p1, :cond_1

    iget-object p1, p0, Lcom/gmhub/apps/AppsController;->context:Landroid/content/Context;

    const-string p2, "gm_apps_empty"

    invoke-direct {p0, p2}, Lcom/gmhub/apps/AppsController;->text(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    invoke-static {p1, p0, v0}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object p0

    invoke-virtual {p0}, Landroid/widget/Toast;->show()V

    return-void

    :cond_1
    invoke-interface {p2}, Ljava/util/List;->size()I

    move-result p1

    new-array p1, p1, [Z

    new-instance v1, Landroid/app/AlertDialog$Builder;

    iget-object v2, p0, Lcom/gmhub/apps/AppsController;->context:Landroid/content/Context;

    invoke-direct {v1, v2}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    if-eqz p3, :cond_2

    const-string v2, "gm_apps_enable_selected"

    goto :goto_0

    :cond_2
    const-string v2, "gm_apps_disable_selected"

    :goto_0
    invoke-direct {p0, v2}, Lcom/gmhub/apps/AppsController;->text(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v1

    new-array v0, v0, [Ljava/lang/String;

    invoke-interface {p4, v0}, Ljava/util/List;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object p4

    check-cast p4, [Ljava/lang/CharSequence;

    new-instance v0, Lcom/gmhub/apps/AppsController$$ExternalSyntheticLambda8;

    invoke-direct {v0, p1}, Lcom/gmhub/apps/AppsController$$ExternalSyntheticLambda8;-><init>([Z)V

    invoke-virtual {v1, p4, p1, v0}, Landroid/app/AlertDialog$Builder;->setMultiChoiceItems([Ljava/lang/CharSequence;[ZLandroid/content/DialogInterface$OnMultiChoiceClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object p4

    const/high16 v0, 0x1040000

    const/4 v1, 0x0

    invoke-virtual {p4, v0, v1}, Landroid/app/AlertDialog$Builder;->setNegativeButton(ILandroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object p4

    new-instance v0, Lcom/gmhub/apps/AppsController$$ExternalSyntheticLambda9;

    invoke-direct {v0, p0, p1, p2, p3}, Lcom/gmhub/apps/AppsController$$ExternalSyntheticLambda9;-><init>(Lcom/gmhub/apps/AppsController;[ZLjava/util/List;Z)V

    const p1, 0x104000a

    invoke-virtual {p4, p1, v0}, Landroid/app/AlertDialog$Builder;->setPositiveButton(ILandroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object p1

    invoke-virtual {p1}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    move-result-object p1

    iput-object p1, p0, Lcom/gmhub/apps/AppsController;->dialog:Landroid/app/AlertDialog;

    return-void
.end method

.method synthetic lambda$chooseOptional$3$com-gmhub-apps-AppsController([ZLjava/util/List;ZLandroid/content/DialogInterface;I)V
    .locals 2

    new-instance p4, Ljava/util/ArrayList;

    invoke-direct {p4}, Ljava/util/ArrayList;-><init>()V

    const/4 p5, 0x0

    move v0, p5

    :goto_0
    array-length v1, p1

    if-ge v0, v1, :cond_1

    aget-boolean v1, p1, v0

    if-eqz v1, :cond_0

    invoke-interface {p2, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    invoke-interface {p4, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_1
    invoke-interface {p4}, Ljava/util/List;->isEmpty()Z

    move-result p1

    if-nez p1, :cond_2

    invoke-direct {p0, p4, p3, p5}, Lcom/gmhub/apps/AppsController;->perform(Ljava/util/List;ZZ)V

    :cond_2
    return-void
.end method

.method synthetic lambda$new$0$com-gmhub-apps-AppsController()V
    .locals 0

    invoke-direct {p0}, Lcom/gmhub/apps/AppsController;->reload()V

    return-void
.end method

.method synthetic lambda$perform$0$com-gmhub-apps-AppsController(ZLjava/util/List;Z)V
    .locals 8

    const-string v0, "GMHubApps"

    const/4 v1, 0x0

    :try_start_0
    invoke-direct {p0}, Lcom/gmhub/apps/AppsController;->backend()Lcom/gmhub/apps/AppBackend;

    move-result-object v2

    if-eqz p1, :cond_0

    invoke-virtual {v2}, Lcom/gmhub/apps/AppBackend;->keys()Ljava/util/Set;

    move-result-object v3

    goto :goto_0

    :cond_0
    const/4 v3, 0x0

    :goto_0
    if-eqz p1, :cond_1

    move-object p2, v3

    :cond_1
    invoke-interface {p2}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object p2
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_3

    move v3, v1

    :cond_2
    :goto_1
    :try_start_1
    invoke-interface {p2}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_5

    invoke-interface {p2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/String;
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_2

    if-eqz p1, :cond_3

    :try_start_2
    iget-object v5, v2, Lcom/gmhub/apps/AppBackend;->engine:Lcom/gmhub/apps/AppStateEngine;

    invoke-virtual {v5, v4}, Lcom/gmhub/apps/AppStateEngine;->restore(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_2

    goto :goto_2

    :cond_3
    iget-object v5, v2, Lcom/gmhub/apps/AppBackend;->engine:Lcom/gmhub/apps/AppStateEngine;

    invoke-virtual {v5, v4, p3}, Lcom/gmhub/apps/AppStateEngine;->change(Ljava/lang/String;Z)Z

    move-result v4
    :try_end_2
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_2 .. :try_end_2} :catch_1
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0

    if-eqz v4, :cond_2

    :goto_2
    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    :catch_0
    move-exception v5

    add-int/lit8 v3, v3, 0x1

    :try_start_3
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "Cannot change "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v6, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v0, v4, v5}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_1

    :catch_1
    if-eqz p1, :cond_4

    invoke-virtual {v2, v4}, Lcom/gmhub/apps/AppBackend;->remove(Ljava/lang/String;)V
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_2

    goto :goto_1

    :cond_4
    add-int/lit8 v3, v3, 0x1

    goto :goto_1

    :catch_2
    move-exception p1

    move p2, v1

    move v1, v3

    goto :goto_3

    :catch_3
    move-exception p1

    move p2, v1

    :goto_3
    add-int/lit8 v3, v1, 0x1

    const-string p3, "App operation failed"

    invoke-static {v0, p3, p1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    move v1, p2

    :cond_5
    iget-object p1, p0, Lcom/gmhub/apps/AppsController;->main:Landroid/os/Handler;

    new-instance p2, Lcom/gmhub/apps/AppsController$$ExternalSyntheticLambda7;

    invoke-direct {p2, p0, v1, v3}, Lcom/gmhub/apps/AppsController$$ExternalSyntheticLambda7;-><init>(Lcom/gmhub/apps/AppsController;II)V

    invoke-virtual {p1, p2}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method synthetic lambda$perform$1$com-gmhub-apps-AppsController(II)V
    .locals 3

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/gmhub/apps/AppsController;->busy:Z

    iget-boolean v1, p0, Lcom/gmhub/apps/AppsController;->active:Z

    if-eqz v1, :cond_0

    iget-boolean v1, p0, Lcom/gmhub/apps/AppsController;->closed:Z

    if-nez v1, :cond_0

    iget-object v1, p0, Lcom/gmhub/apps/AppsController;->host:Lcom/gmhub/apps/AppsController$Host;

    invoke-interface {v1, v0}, Lcom/gmhub/apps/AppsController$Host;->busy(Z)V

    iget-object v1, p0, Lcom/gmhub/apps/AppsController;->context:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v2

    invoke-virtual {v2}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v2

    invoke-virtual {v2}, Landroid/content/res/Configuration;->getLocales()Landroid/os/LocaleList;

    move-result-object v2

    invoke-virtual {v2, v0}, Landroid/os/LocaleList;->get(I)Ljava/util/Locale;

    move-result-object v0

    const-string v2, "gm_apps_result"

    invoke-direct {p0, v2}, Lcom/gmhub/apps/AppsController;->text(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p1

    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p2

    filled-new-array {p1, p2}, [Ljava/lang/Object;

    move-result-object p1

    invoke-static {v0, v2, p1}, Ljava/lang/String;->format(Ljava/util/Locale;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    const/4 p2, 0x1

    invoke-static {v1, p1, p2}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/Toast;->show()V

    invoke-direct {p0}, Lcom/gmhub/apps/AppsController;->reload()V

    :cond_0
    return-void
.end method

.method synthetic lambda$reload$0$com-gmhub-apps-AppsController(ZLjava/lang/String;I)V
    .locals 11

    :try_start_0
    invoke-direct {p0}, Lcom/gmhub/apps/AppsController;->backend()Lcom/gmhub/apps/AppBackend;

    move-result-object v0

    iget-object v1, p0, Lcom/gmhub/apps/AppsController;->context:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v1

    invoke-virtual {v0}, Lcom/gmhub/apps/AppBackend;->protectedPackages()Ljava/util/Set;

    move-result-object v2

    new-instance v3, Ljava/util/ArrayList;

    invoke-direct {v3}, Ljava/util/ArrayList;-><init>()V

    const v4, 0x8200

    invoke-virtual {v1, v4}, Landroid/content/pm/PackageManager;->getInstalledApplications(I)Ljava/util/List;

    move-result-object v4

    invoke-interface {v4}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v4

    :goto_0
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    const/4 v6, 0x0

    if-eqz v5, :cond_5

    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Landroid/content/pm/ApplicationInfo;

    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/Thread;->isInterrupted()Z

    move-result v7

    if-nez v7, :cond_6

    iget-boolean v7, p0, Lcom/gmhub/apps/AppsController;->closed:Z

    if-eqz v7, :cond_0

    goto/16 :goto_1

    :cond_0
    const/4 v7, 0x1

    if-nez p1, :cond_1

    iget v8, v5, Landroid/content/pm/ApplicationInfo;->flags:I

    and-int/2addr v8, v7

    if-eqz v8, :cond_1

    goto :goto_0

    :cond_1
    invoke-virtual {v5, v1}, Landroid/content/pm/ApplicationInfo;->loadLabel(Landroid/content/pm/PackageManager;)Ljava/lang/CharSequence;

    move-result-object v8

    invoke-interface {v8}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v8

    iget-object v9, v5, Landroid/content/pm/ApplicationInfo;->packageName:Ljava/lang/String;

    sget-object v10, Ljava/util/Locale;->ROOT:Ljava/util/Locale;

    invoke-virtual {v9, v10}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v9, p2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v9

    if-nez v9, :cond_2

    sget-object v9, Ljava/util/Locale;->ROOT:Ljava/util/Locale;

    invoke-virtual {v8, v9}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v9, p2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v9

    if-nez v9, :cond_2

    goto :goto_0

    :cond_2
    new-instance v9, Lcom/gmhub/apps/AppsController$Row;

    iget-boolean v10, v5, Landroid/content/pm/ApplicationInfo;->enabled:Z

    if-eqz v10, :cond_3

    invoke-virtual {v0, v5, v2}, Lcom/gmhub/apps/AppBackend;->canDisable(Landroid/content/pm/ApplicationInfo;Ljava/util/Set;)Z

    move-result v10

    if-eqz v10, :cond_4

    :cond_3
    move v6, v7

    :cond_4
    invoke-direct {v9, v5, v8, v6}, Lcom/gmhub/apps/AppsController$Row;-><init>(Landroid/content/pm/ApplicationInfo;Ljava/lang/String;Z)V

    invoke-interface {v3, v9}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    :cond_5
    iget-object p1, p0, Lcom/gmhub/apps/AppsController;->context:Landroid/content/Context;

    invoke-virtual {p1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object p1

    invoke-virtual {p1}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object p1

    invoke-virtual {p1}, Landroid/content/res/Configuration;->getLocales()Landroid/os/LocaleList;

    move-result-object p1

    invoke-virtual {p1, v6}, Landroid/os/LocaleList;->get(I)Ljava/util/Locale;

    move-result-object p1

    invoke-static {p1}, Ljava/text/Collator;->getInstance(Ljava/util/Locale;)Ljava/text/Collator;

    move-result-object p1

    new-instance p2, Lcom/gmhub/apps/AppsController$$ExternalSyntheticLambda4;

    invoke-direct {p2, p1}, Lcom/gmhub/apps/AppsController$$ExternalSyntheticLambda4;-><init>(Ljava/text/Collator;)V

    invoke-static {v3, p2}, Ljava/util/Collections;->sort(Ljava/util/List;Ljava/util/Comparator;)V

    iget-object p1, p0, Lcom/gmhub/apps/AppsController;->main:Landroid/os/Handler;

    new-instance p2, Lcom/gmhub/apps/AppsController$$ExternalSyntheticLambda5;

    invoke-direct {p2, p0, p3, v3}, Lcom/gmhub/apps/AppsController$$ExternalSyntheticLambda5;-><init>(Lcom/gmhub/apps/AppsController;ILjava/util/List;)V

    invoke-virtual {p1, p2}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    const-string p2, "GMHubApps"

    const-string v0, "Cannot list applications"

    invoke-static {p2, v0, p1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    iget-object p1, p0, Lcom/gmhub/apps/AppsController;->main:Landroid/os/Handler;

    new-instance p2, Lcom/gmhub/apps/AppsController$$ExternalSyntheticLambda6;

    invoke-direct {p2, p0, p3}, Lcom/gmhub/apps/AppsController$$ExternalSyntheticLambda6;-><init>(Lcom/gmhub/apps/AppsController;I)V

    invoke-virtual {p1, p2}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    :cond_6
    :goto_1
    return-void
.end method

.method synthetic lambda$reload$2$com-gmhub-apps-AppsController(ILjava/util/List;)V
    .locals 1

    invoke-direct {p0, p1}, Lcom/gmhub/apps/AppsController;->current(I)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x0

    invoke-direct {p0, p2, v0, p1}, Lcom/gmhub/apps/AppsController;->render(Ljava/util/List;II)V

    :cond_0
    return-void
.end method

.method synthetic lambda$reload$3$com-gmhub-apps-AppsController(I)V
    .locals 1

    invoke-direct {p0, p1}, Lcom/gmhub/apps/AppsController;->current(I)Z

    move-result p1

    if-eqz p1, :cond_0

    iget-object p1, p0, Lcom/gmhub/apps/AppsController;->host:Lcom/gmhub/apps/AppsController$Host;

    const-string v0, "gm_apps_load_failed"

    invoke-direct {p0, v0}, Lcom/gmhub/apps/AppsController;->text(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-interface {p1, v0}, Lcom/gmhub/apps/AppsController$Host;->clear(Ljava/lang/String;)V

    iget-object p0, p0, Lcom/gmhub/apps/AppsController;->host:Lcom/gmhub/apps/AppsController$Host;

    const/4 p1, 0x0

    invoke-interface {p0, p1}, Lcom/gmhub/apps/AppsController$Host;->busy(Z)V

    :cond_0
    return-void
.end method

.method synthetic lambda$render$0$com-gmhub-apps-AppsController(Ljava/util/List;II)V
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Lcom/gmhub/apps/AppsController;->render(Ljava/util/List;II)V

    return-void
.end method

.method synthetic lambda$select$0$com-gmhub-apps-AppsController(Landroid/content/DialogInterface;I)V
    .locals 0

    sget-object p1, Ljava/util/Collections;->EMPTY_LIST:Ljava/util/List;

    const/4 p2, 0x1

    invoke-direct {p0, p1, p2, p2}, Lcom/gmhub/apps/AppsController;->perform(Ljava/util/List;ZZ)V

    return-void
.end method

.method public pause()V
    .locals 3

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/gmhub/apps/AppsController;->active:Z

    iget v0, p0, Lcom/gmhub/apps/AppsController;->generation:I

    const/4 v1, 0x1

    add-int/2addr v0, v1

    iput v0, p0, Lcom/gmhub/apps/AppsController;->generation:I

    iget-object v0, p0, Lcom/gmhub/apps/AppsController;->main:Landroid/os/Handler;

    iget-object v2, p0, Lcom/gmhub/apps/AppsController;->search:Ljava/lang/Runnable;

    invoke-virtual {v0, v2}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    iget-object v0, p0, Lcom/gmhub/apps/AppsController;->inventory:Ljava/util/concurrent/Future;

    if-eqz v0, :cond_0

    invoke-interface {v0, v1}, Ljava/util/concurrent/Future;->cancel(Z)Z

    :cond_0
    iget-object v0, p0, Lcom/gmhub/apps/AppsController;->dialog:Landroid/app/AlertDialog;

    if-eqz v0, :cond_1

    invoke-virtual {v0}, Landroid/app/AlertDialog;->dismiss()V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/gmhub/apps/AppsController;->dialog:Landroid/app/AlertDialog;

    :cond_1
    iget-object v0, p0, Lcom/gmhub/apps/AppsController;->icons:Ljava/util/concurrent/ThreadPoolExecutor;

    invoke-virtual {v0}, Ljava/util/concurrent/ThreadPoolExecutor;->getQueue()Ljava/util/concurrent/BlockingQueue;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/concurrent/BlockingQueue;->clear()V

    iget-object v0, p0, Lcom/gmhub/apps/AppsController;->iconBindings:Ljava/util/WeakHashMap;

    invoke-virtual {v0}, Ljava/util/WeakHashMap;->clear()V

    iget-object p0, p0, Lcom/gmhub/apps/AppsController;->iconCache:Landroid/util/LruCache;

    invoke-virtual {p0}, Landroid/util/LruCache;->evictAll()V

    return-void
.end method

.method public prepareMenu(Landroid/view/Menu;)V
    .locals 7

    const/4 v0, 0x1

    const/4 v1, 0x2

    const/4 v2, 0x3

    const/4 v3, 0x4

    filled-new-array {v0, v1, v2, v3}, [I

    move-result-object v1

    const/4 v4, 0x0

    :goto_0
    if-ge v4, v3, :cond_1

    aget v5, v1, v4

    invoke-interface {p1, v5}, Landroid/view/Menu;->findItem(I)Landroid/view/MenuItem;

    move-result-object v5

    if-eqz v5, :cond_0

    iget-boolean v6, p0, Lcom/gmhub/apps/AppsController;->busy:Z

    xor-int/2addr v6, v0

    invoke-interface {v5, v6}, Landroid/view/MenuItem;->setEnabled(Z)Landroid/view/MenuItem;

    :cond_0
    add-int/lit8 v4, v4, 0x1

    goto :goto_0

    :cond_1
    invoke-interface {p1, v2}, Landroid/view/Menu;->findItem(I)Landroid/view/MenuItem;

    move-result-object p1

    if-eqz p1, :cond_3

    iget-boolean v0, p0, Lcom/gmhub/apps/AppsController;->showSystem:Z

    if-eqz v0, :cond_2

    const-string v0, "paradox_mgr_hide_sys"

    goto :goto_1

    :cond_2
    const-string v0, "paradox_mgr_show_sys"

    :goto_1
    invoke-direct {p0, v0}, Lcom/gmhub/apps/AppsController;->text(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    invoke-interface {p1, p0}, Landroid/view/MenuItem;->setTitle(Ljava/lang/CharSequence;)Landroid/view/MenuItem;

    :cond_3
    return-void
.end method

.method public resume()V
    .locals 2

    iget-boolean v0, p0, Lcom/gmhub/apps/AppsController;->closed:Z

    if-nez v0, :cond_0

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/gmhub/apps/AppsController;->active:Z

    iget-object v0, p0, Lcom/gmhub/apps/AppsController;->host:Lcom/gmhub/apps/AppsController$Host;

    iget-boolean v1, p0, Lcom/gmhub/apps/AppsController;->busy:Z

    invoke-interface {v0, v1}, Lcom/gmhub/apps/AppsController$Host;->busy(Z)V

    invoke-direct {p0}, Lcom/gmhub/apps/AppsController;->reload()V

    :cond_0
    return-void
.end method

.method public search(Ljava/lang/String;)V
    .locals 2

    if-nez p1, :cond_0

    const-string p1, ""

    goto :goto_0

    :cond_0
    invoke-virtual {p1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object p1

    :goto_0
    iput-object p1, p0, Lcom/gmhub/apps/AppsController;->query:Ljava/lang/String;

    iget p1, p0, Lcom/gmhub/apps/AppsController;->generation:I

    const/4 v0, 0x1

    add-int/2addr p1, v0

    iput p1, p0, Lcom/gmhub/apps/AppsController;->generation:I

    iget-object p1, p0, Lcom/gmhub/apps/AppsController;->inventory:Ljava/util/concurrent/Future;

    if-eqz p1, :cond_1

    invoke-interface {p1, v0}, Ljava/util/concurrent/Future;->cancel(Z)Z

    :cond_1
    iget-object p1, p0, Lcom/gmhub/apps/AppsController;->main:Landroid/os/Handler;

    iget-object v0, p0, Lcom/gmhub/apps/AppsController;->search:Ljava/lang/Runnable;

    invoke-virtual {p1, v0}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    iget-object p1, p0, Lcom/gmhub/apps/AppsController;->main:Landroid/os/Handler;

    iget-object p0, p0, Lcom/gmhub/apps/AppsController;->search:Ljava/lang/Runnable;

    const-wide/16 v0, 0xfa

    invoke-virtual {p1, p0, v0, v1}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    return-void
.end method

.method public select(Landroid/view/MenuItem;)Z
    .locals 4

    invoke-interface {p1}, Landroid/view/MenuItem;->getItemId()I

    move-result p1

    const/4 v0, 0x0

    const/4 v1, 0x1

    if-lt p1, v1, :cond_6

    const/4 v2, 0x4

    if-le p1, v2, :cond_0

    goto :goto_1

    :cond_0
    iget-boolean v3, p0, Lcom/gmhub/apps/AppsController;->active:Z

    if-eqz v3, :cond_5

    iget-boolean v3, p0, Lcom/gmhub/apps/AppsController;->busy:Z

    if-nez v3, :cond_5

    iget-boolean v3, p0, Lcom/gmhub/apps/AppsController;->closed:Z

    if-eqz v3, :cond_1

    goto :goto_0

    :cond_1
    const/4 v3, 0x3

    if-ne p1, v3, :cond_2

    iget-boolean p1, p0, Lcom/gmhub/apps/AppsController;->showSystem:Z

    xor-int/2addr p1, v1

    iput-boolean p1, p0, Lcom/gmhub/apps/AppsController;->showSystem:Z

    invoke-direct {p0}, Lcom/gmhub/apps/AppsController;->reload()V

    return v1

    :cond_2
    if-ne p1, v1, :cond_3

    new-instance p1, Landroid/app/AlertDialog$Builder;

    iget-object v0, p0, Lcom/gmhub/apps/AppsController;->context:Landroid/content/Context;

    invoke-direct {p1, v0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    const-string v0, "gm_apps_restore"

    invoke-direct {p0, v0}, Lcom/gmhub/apps/AppsController;->text(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object p1

    const-string v0, "gm_apps_restore_summary"

    invoke-direct {p0, v0}, Lcom/gmhub/apps/AppsController;->text(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object p1

    const/high16 v0, 0x1040000

    const/4 v2, 0x0

    invoke-virtual {p1, v0, v2}, Landroid/app/AlertDialog$Builder;->setNegativeButton(ILandroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object p1

    new-instance v0, Lcom/gmhub/apps/AppsController$$ExternalSyntheticLambda11;

    invoke-direct {v0, p0}, Lcom/gmhub/apps/AppsController$$ExternalSyntheticLambda11;-><init>(Lcom/gmhub/apps/AppsController;)V

    const v2, 0x104000a

    invoke-virtual {p1, v2, v0}, Landroid/app/AlertDialog$Builder;->setPositiveButton(ILandroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object p1

    invoke-virtual {p1}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    move-result-object p1

    iput-object p1, p0, Lcom/gmhub/apps/AppsController;->dialog:Landroid/app/AlertDialog;

    goto :goto_0

    :cond_3
    if-ne p1, v2, :cond_4

    move v0, v1

    :cond_4
    invoke-direct {p0, v0}, Lcom/gmhub/apps/AppsController;->chooseOptional(Z)V

    :cond_5
    :goto_0
    return v1

    :cond_6
    :goto_1
    return v0
.end method
