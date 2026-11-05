.class public final Lcom/gmhub/profiles/ProfileController;
.super Ljava/lang/Object;
.source "ProfileController.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/gmhub/profiles/ProfileController$Host;
    }
.end annotation


# instance fields
.field private active:Z

.field private backend:Lcom/gmhub/profiles/ProfileBackend;

.field private busy:Z

.field private closed:Z

.field private final context:Landroid/content/Context;

.field private final host:Lcom/gmhub/profiles/ProfileController$Host;

.field private last:Ljava/lang/String;

.field private final main:Landroid/os/Handler;

.field private summary:Ljava/lang/String;

.field private final worker:Ljava/util/concurrent/ExecutorService;


# direct methods
.method public constructor <init>(Lcom/gmhub/profiles/ProfileController$Host;)V
    .locals 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    iput-object v0, p0, Lcom/gmhub/profiles/ProfileController;->main:Landroid/os/Handler;

    invoke-static {}, Ljava/util/concurrent/Executors;->newSingleThreadExecutor()Ljava/util/concurrent/ExecutorService;

    move-result-object v0

    iput-object v0, p0, Lcom/gmhub/profiles/ProfileController;->worker:Ljava/util/concurrent/ExecutorService;

    const-string v0, ""

    iput-object v0, p0, Lcom/gmhub/profiles/ProfileController;->last:Ljava/lang/String;

    iput-object v0, p0, Lcom/gmhub/profiles/ProfileController;->summary:Ljava/lang/String;

    iput-object p1, p0, Lcom/gmhub/profiles/ProfileController;->host:Lcom/gmhub/profiles/ProfileController$Host;

    invoke-interface {p1}, Lcom/gmhub/profiles/ProfileController$Host;->context()Landroid/content/Context;

    move-result-object p1

    iput-object p1, p0, Lcom/gmhub/profiles/ProfileController;->context:Landroid/content/Context;

    return-void
.end method

.method private backend()Lcom/gmhub/profiles/ProfileBackend;
    .locals 2

    iget-object v0, p0, Lcom/gmhub/profiles/ProfileController;->backend:Lcom/gmhub/profiles/ProfileBackend;

    if-nez v0, :cond_0

    new-instance v0, Lcom/gmhub/profiles/ProfileBackend;

    iget-object v1, p0, Lcom/gmhub/profiles/ProfileController;->context:Landroid/content/Context;

    invoke-direct {v0, v1}, Lcom/gmhub/profiles/ProfileBackend;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/gmhub/profiles/ProfileController;->backend:Lcom/gmhub/profiles/ProfileBackend;

    :cond_0
    iget-object p0, p0, Lcom/gmhub/profiles/ProfileController;->backend:Lcom/gmhub/profiles/ProfileBackend;

    return-object p0
.end method

.method private description(Ljava/lang/String;)Ljava/lang/String;
    .locals 2

    const-string v0, "custom"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    const-string p1, "gm_profiles_custom"

    invoke-direct {p0, p1}, Lcom/gmhub/profiles/ProfileController;->text(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    return-object p0

    :cond_0
    const-string v0, "pending"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    const-string p1, "gm_profiles_pending"

    invoke-direct {p0, p1}, Lcom/gmhub/profiles/ProfileController;->text(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    return-object p0

    :cond_1
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "paradox_core_mode_"

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p1, "_desc"

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p0, p1}, Lcom/gmhub/profiles/ProfileController;->text(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method private execute(Ljava/lang/String;)V
    .locals 4

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/gmhub/profiles/ProfileController;->busy:Z

    iget-object v0, p0, Lcom/gmhub/profiles/ProfileController;->host:Lcom/gmhub/profiles/ProfileController$Host;

    iget-object v1, p0, Lcom/gmhub/profiles/ProfileController;->last:Ljava/lang/String;

    const-string v2, "gm_profiles_working"

    invoke-direct {p0, v2}, Lcom/gmhub/profiles/ProfileController;->text(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    const/4 v3, 0x0

    invoke-interface {v0, v1, v2, v3}, Lcom/gmhub/profiles/ProfileController$Host;->show(Ljava/lang/String;Ljava/lang/String;Z)V

    iget-object v0, p0, Lcom/gmhub/profiles/ProfileController;->worker:Ljava/util/concurrent/ExecutorService;

    new-instance v1, Lcom/gmhub/profiles/ProfileController$$ExternalSyntheticLambda0;

    invoke-direct {v1, p0, p1}, Lcom/gmhub/profiles/ProfileController$$ExternalSyntheticLambda0;-><init>(Lcom/gmhub/profiles/ProfileController;Ljava/lang/String;)V

    invoke-interface {v0, v1}, Ljava/util/concurrent/ExecutorService;->submit(Ljava/lang/Runnable;)Ljava/util/concurrent/Future;

    return-void
.end method

.method public static label(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;
    .locals 4

    const-string v0, "custom"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    const-string v0, "gm_profiles_custom_label"

    goto :goto_0

    :cond_0
    const-string v0, "pending"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    const-string v0, "gm_profiles_pending_label"

    goto :goto_0

    :cond_1
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "paradox_core_mode_"

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    :goto_0
    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    const-string v2, "string"

    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v0, v2, v3}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    if-nez v0, :cond_2

    return-object p1

    :cond_2
    invoke-virtual {p0, v0}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method private text(Ljava/lang/String;)Ljava/lang/String;
    .locals 3

    iget-object v0, p0, Lcom/gmhub/profiles/ProfileController;->context:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    iget-object v1, p0, Lcom/gmhub/profiles/ProfileController;->context:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v1

    const-string v2, "string"

    invoke-virtual {v0, p1, v2, v1}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    if-nez v0, :cond_0

    return-object p1

    :cond_0
    iget-object p0, p0, Lcom/gmhub/profiles/ProfileController;->context:Landroid/content/Context;

    invoke-virtual {p0, v0}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method


# virtual methods
.method public close()V
    .locals 1

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/gmhub/profiles/ProfileController;->active:Z

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/gmhub/profiles/ProfileController;->closed:Z

    iget-object p0, p0, Lcom/gmhub/profiles/ProfileController;->worker:Ljava/util/concurrent/ExecutorService;

    invoke-interface {p0}, Ljava/util/concurrent/ExecutorService;->shutdown()V

    return-void
.end method

.method synthetic lambda$execute$0$com-gmhub-profiles-ProfileController(Ljava/lang/String;)V
    .locals 11

    const-string v1, ""

    const/4 v2, 0x1

    :try_start_0
    invoke-direct {p0}, Lcom/gmhub/profiles/ProfileController;->backend()Lcom/gmhub/profiles/ProfileBackend;

    move-result-object v0

    if-eqz p1, :cond_3

    const-string v3, "stock"

    invoke-virtual {p1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_2

    iget-object v3, v0, Lcom/gmhub/profiles/ProfileBackend;->engine:Lcom/gmhub/profiles/ProfileEngine;

    invoke-virtual {v3}, Lcom/gmhub/profiles/ProfileEngine;->restore()Lcom/gmhub/profiles/ProfileEngine$RestoreResult;

    move-result-object v3

    iget v4, v3, Lcom/gmhub/profiles/ProfileEngine$RestoreResult;->failed:I

    if-eqz v4, :cond_0

    const-string v3, "gm_profiles_restore_conflict"

    invoke-direct {p0, v3}, Lcom/gmhub/profiles/ProfileController;->text(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    goto :goto_1

    :cond_0
    iget v3, v3, Lcom/gmhub/profiles/ProfileEngine$RestoreResult;->conflicts:I

    if-eqz v3, :cond_1

    const-string v3, "gm_profiles_preserved"

    :goto_0
    invoke-direct {p0, v3}, Lcom/gmhub/profiles/ProfileController;->text(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    goto :goto_1

    :cond_1
    const-string v3, "paradox_core_restored"

    goto :goto_0

    :cond_2
    iget-object v3, v0, Lcom/gmhub/profiles/ProfileBackend;->engine:Lcom/gmhub/profiles/ProfileEngine;

    invoke-virtual {v0, p1}, Lcom/gmhub/profiles/ProfileBackend;->plan(Ljava/lang/String;)Ljava/util/Map;

    move-result-object v4

    invoke-virtual {v3, p1, v4}, Lcom/gmhub/profiles/ProfileEngine;->apply(Ljava/lang/String;Ljava/util/Map;)V

    const-string v3, "gm_profiles_confirmed"

    invoke-direct {p0, v3}, Lcom/gmhub/profiles/ProfileController;->text(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    goto :goto_1

    :cond_3
    const/4 v3, 0x0

    :goto_1
    iget-object v4, v0, Lcom/gmhub/profiles/ProfileBackend;->engine:Lcom/gmhub/profiles/ProfileEngine;

    invoke-virtual {v4}, Lcom/gmhub/profiles/ProfileEngine;->status()Ljava/lang/String;

    move-result-object v1

    if-eqz p1, :cond_4

    invoke-virtual {v0, v1}, Lcom/gmhub/profiles/ProfileBackend;->publishStatus(Ljava/lang/String;)V

    :cond_4
    invoke-direct {p0, v1}, Lcom/gmhub/profiles/ProfileController;->description(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_2

    :catch_0
    move-exception v0

    const-string v3, "GMHubProfiles"

    const-string v4, "Profile operation not confirmed"

    invoke-static {v3, v4, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    const-string v0, "gm_profiles_failed"

    invoke-direct {p0, v0}, Lcom/gmhub/profiles/ProfileController;->text(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    iget-object v0, p0, Lcom/gmhub/profiles/ProfileController;->backend:Lcom/gmhub/profiles/ProfileBackend;

    if-nez v0, :cond_6

    const-string v0, "gm_profiles_unavailable"

    invoke-direct {p0, v0}, Lcom/gmhub/profiles/ProfileController;->text(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const/4 v2, 0x0

    :cond_5
    :goto_2
    move-object v7, v0

    move-object v6, v1

    move v8, v2

    move-object v9, v3

    goto :goto_3

    :cond_6
    :try_start_1
    iget-object v0, v0, Lcom/gmhub/profiles/ProfileBackend;->engine:Lcom/gmhub/profiles/ProfileEngine;

    invoke-virtual {v0}, Lcom/gmhub/profiles/ProfileEngine;->status()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/gmhub/profiles/ProfileController;->description(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    if-eqz p1, :cond_5

    iget-object v4, p0, Lcom/gmhub/profiles/ProfileController;->backend:Lcom/gmhub/profiles/ProfileBackend;

    invoke-virtual {v4, v1}, Lcom/gmhub/profiles/ProfileBackend;->publishStatus(Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_2

    :catch_1
    const-string v0, "gm_profiles_unreadable"

    invoke-direct {p0, v0}, Lcom/gmhub/profiles/ProfileController;->text(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_2

    :goto_3
    iget-object v0, p0, Lcom/gmhub/profiles/ProfileController;->main:Landroid/os/Handler;

    new-instance v4, Lcom/gmhub/profiles/ProfileController$$ExternalSyntheticLambda1;

    move-object v5, p0

    move-object v10, p1

    invoke-direct/range {v4 .. v10}, Lcom/gmhub/profiles/ProfileController$$ExternalSyntheticLambda1;-><init>(Lcom/gmhub/profiles/ProfileController;Ljava/lang/String;Ljava/lang/String;ZLjava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v0, v4}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method synthetic lambda$execute$1$com-gmhub-profiles-ProfileController(Ljava/lang/String;Ljava/lang/String;ZLjava/lang/String;Ljava/lang/String;)V
    .locals 1

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/gmhub/profiles/ProfileController;->busy:Z

    iput-object p1, p0, Lcom/gmhub/profiles/ProfileController;->last:Ljava/lang/String;

    iput-object p2, p0, Lcom/gmhub/profiles/ProfileController;->summary:Ljava/lang/String;

    iget-boolean v0, p0, Lcom/gmhub/profiles/ProfileController;->active:Z

    if-eqz v0, :cond_0

    iget-boolean v0, p0, Lcom/gmhub/profiles/ProfileController;->closed:Z

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/gmhub/profiles/ProfileController;->host:Lcom/gmhub/profiles/ProfileController$Host;

    invoke-interface {v0, p1, p2, p3}, Lcom/gmhub/profiles/ProfileController$Host;->show(Ljava/lang/String;Ljava/lang/String;Z)V

    if-eqz p4, :cond_0

    if-eqz p5, :cond_0

    iget-object p0, p0, Lcom/gmhub/profiles/ProfileController;->context:Landroid/content/Context;

    const/4 p1, 0x1

    invoke-static {p0, p4, p1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object p0

    invoke-virtual {p0}, Landroid/widget/Toast;->show()V

    :cond_0
    return-void
.end method

.method public pause()V
    .locals 1

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/gmhub/profiles/ProfileController;->active:Z

    return-void
.end method

.method public restore()V
    .locals 1

    iget-boolean v0, p0, Lcom/gmhub/profiles/ProfileController;->active:Z

    if-eqz v0, :cond_0

    iget-boolean v0, p0, Lcom/gmhub/profiles/ProfileController;->closed:Z

    if-nez v0, :cond_0

    iget-boolean v0, p0, Lcom/gmhub/profiles/ProfileController;->busy:Z

    if-nez v0, :cond_0

    const-string v0, "stock"

    invoke-direct {p0, v0}, Lcom/gmhub/profiles/ProfileController;->execute(Ljava/lang/String;)V

    :cond_0
    return-void
.end method

.method public resume()V
    .locals 3

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/gmhub/profiles/ProfileController;->active:Z

    iget-boolean v0, p0, Lcom/gmhub/profiles/ProfileController;->busy:Z

    if-nez v0, :cond_0

    iget-boolean v0, p0, Lcom/gmhub/profiles/ProfileController;->closed:Z

    if-nez v0, :cond_0

    const/4 v0, 0x0

    invoke-direct {p0, v0}, Lcom/gmhub/profiles/ProfileController;->execute(Ljava/lang/String;)V

    return-void

    :cond_0
    iget-boolean v0, p0, Lcom/gmhub/profiles/ProfileController;->closed:Z

    if-nez v0, :cond_1

    iget-object v0, p0, Lcom/gmhub/profiles/ProfileController;->host:Lcom/gmhub/profiles/ProfileController$Host;

    iget-object v1, p0, Lcom/gmhub/profiles/ProfileController;->last:Ljava/lang/String;

    iget-object p0, p0, Lcom/gmhub/profiles/ProfileController;->summary:Ljava/lang/String;

    const/4 v2, 0x0

    invoke-interface {v0, v1, p0, v2}, Lcom/gmhub/profiles/ProfileController$Host;->show(Ljava/lang/String;Ljava/lang/String;Z)V

    :cond_1
    return-void
.end method

.method public select(Ljava/lang/String;)Z
    .locals 4

    const-string v0, "gaming"

    const-string v1, "battery"

    const-string v2, "stock"

    const-string v3, "smooth"

    filled-new-array {v2, v3, v0, v1}, [Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0, p1}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v0

    const/4 v1, 0x0

    if-nez v0, :cond_0

    return v1

    :cond_0
    iget-boolean v0, p0, Lcom/gmhub/profiles/ProfileController;->active:Z

    if-eqz v0, :cond_1

    iget-boolean v0, p0, Lcom/gmhub/profiles/ProfileController;->closed:Z

    if-nez v0, :cond_1

    iget-boolean v0, p0, Lcom/gmhub/profiles/ProfileController;->busy:Z

    if-nez v0, :cond_1

    invoke-direct {p0, p1}, Lcom/gmhub/profiles/ProfileController;->execute(Ljava/lang/String;)V

    :cond_1
    return v1
.end method
