.class final Lcom/gmhub/qs/ComposePanelRoot$Session;
.super Ljava/lang/Object;
.source "ComposePanelRoot.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/gmhub/qs/ComposePanelRoot;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "Session"
.end annotation


# instance fields
.field final api:Lcom/gmhub/qs/ComposePanelRoot$Abi;

.field closed:Z

.field final context:Landroid/content/Context;

.field final effect:Ljava/lang/Object;

.field final observer:Landroid/database/ContentObserver;

.field registered:Z

.field final result:Ljava/lang/Object;

.field final selection:Ljava/lang/Object;

.field final user:I


# direct methods
.method constructor <init>(Lcom/gmhub/qs/ComposePanelRoot$Abi;Landroid/content/Context;I)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/gmhub/qs/ComposePanelRoot$Session;->api:Lcom/gmhub/qs/ComposePanelRoot$Abi;

    iput-object p2, p0, Lcom/gmhub/qs/ComposePanelRoot$Session;->context:Landroid/content/Context;

    iput p3, p0, Lcom/gmhub/qs/ComposePanelRoot$Session;->user:I

    iget-object p2, p1, Lcom/gmhub/qs/ComposePanelRoot$Abi;->state:Ljava/lang/reflect/Method;

    invoke-virtual {p0}, Lcom/gmhub/qs/ComposePanelRoot$Session;->read()I

    move-result p3

    invoke-static {p3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p3

    filled-new-array {p3}, [Ljava/lang/Object;

    move-result-object p3

    const/4 v0, 0x0

    invoke-static {p2, v0, p3}, Lcom/gmhub/qs/ComposePanelRoot;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p2

    iput-object p2, p0, Lcom/gmhub/qs/ComposePanelRoot$Session;->selection:Ljava/lang/Object;

    new-instance p2, Lcom/gmhub/qs/ComposePanelRoot$Session$1;

    new-instance p3, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v0

    invoke-direct {p3, v0}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    invoke-direct {p2, p0, p3}, Lcom/gmhub/qs/ComposePanelRoot$Session$1;-><init>(Lcom/gmhub/qs/ComposePanelRoot$Session;Landroid/os/Handler;)V

    iput-object p2, p0, Lcom/gmhub/qs/ComposePanelRoot$Session;->observer:Landroid/database/ContentObserver;

    iget-object p2, p1, Lcom/gmhub/qs/ComposePanelRoot$Abi;->disposable:Ljava/lang/Class;

    new-instance p3, Lcom/gmhub/qs/ComposePanelRoot$Session$$ExternalSyntheticLambda0;

    invoke-direct {p3, p0}, Lcom/gmhub/qs/ComposePanelRoot$Session$$ExternalSyntheticLambda0;-><init>(Lcom/gmhub/qs/ComposePanelRoot$Session;)V

    invoke-virtual {p1, p2, p3}, Lcom/gmhub/qs/ComposePanelRoot$Abi;->function(Ljava/lang/Class;Lcom/gmhub/qs/ComposePanelRoot$Callback;)Ljava/lang/Object;

    move-result-object p2

    iput-object p2, p0, Lcom/gmhub/qs/ComposePanelRoot$Session;->result:Ljava/lang/Object;

    iget-object p2, p1, Lcom/gmhub/qs/ComposePanelRoot$Abi;->function1:Ljava/lang/Class;

    new-instance p3, Lcom/gmhub/qs/ComposePanelRoot$Session$$ExternalSyntheticLambda1;

    invoke-direct {p3, p0}, Lcom/gmhub/qs/ComposePanelRoot$Session$$ExternalSyntheticLambda1;-><init>(Lcom/gmhub/qs/ComposePanelRoot$Session;)V

    invoke-virtual {p1, p2, p3}, Lcom/gmhub/qs/ComposePanelRoot$Abi;->function(Ljava/lang/Class;Lcom/gmhub/qs/ComposePanelRoot$Callback;)Ljava/lang/Object;

    move-result-object p1

    iput-object p1, p0, Lcom/gmhub/qs/ComposePanelRoot$Session;->effect:Ljava/lang/Object;

    return-void
.end method


# virtual methods
.method activate()V
    .locals 4

    iget-boolean v0, p0, Lcom/gmhub/qs/ComposePanelRoot$Session;->closed:Z

    if-nez v0, :cond_1

    iget-boolean v0, p0, Lcom/gmhub/qs/ComposePanelRoot$Session;->registered:Z

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :try_start_0
    iget-object v1, p0, Lcom/gmhub/qs/ComposePanelRoot$Session;->context:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    const-string v2, "gmhub_qs_style"

    invoke-static {v2}, Landroid/provider/Settings$Secure;->getUriFor(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v2

    iget-object v3, p0, Lcom/gmhub/qs/ComposePanelRoot$Session;->observer:Landroid/database/ContentObserver;

    invoke-virtual {v1, v2, v0, v3}, Landroid/content/ContentResolver;->registerContentObserver(Landroid/net/Uri;ZLandroid/database/ContentObserver;)V

    const/4 v1, 0x1

    iput-boolean v1, p0, Lcom/gmhub/qs/ComposePanelRoot$Session;->registered:Z

    invoke-virtual {p0}, Lcom/gmhub/qs/ComposePanelRoot$Session;->refresh()V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v1

    iget-object v2, p0, Lcom/gmhub/qs/ComposePanelRoot$Session;->api:Lcom/gmhub/qs/ComposePanelRoot$Abi;

    iget-object v2, v2, Lcom/gmhub/qs/ComposePanelRoot$Abi;->setValue:Ljava/lang/reflect/Method;

    iget-object v3, p0, Lcom/gmhub/qs/ComposePanelRoot$Session;->selection:Ljava/lang/Object;

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    invoke-static {v2, v3, v0}, Lcom/gmhub/qs/ComposePanelRoot;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v0, Ljava/lang/StringBuilder;

    const-string v2, "Cannot observe QS appearance for user "

    invoke-direct {v0, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget p0, p0, Lcom/gmhub/qs/ComposePanelRoot$Session;->user:I

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    const-string v0, "GMHubQs"

    invoke-static {v0, p0, v1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    :cond_1
    :goto_0
    return-void
.end method

.method close()V
    .locals 2

    iget-boolean v0, p0, Lcom/gmhub/qs/ComposePanelRoot$Session;->closed:Z

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/gmhub/qs/ComposePanelRoot$Session;->closed:Z

    iget-boolean v0, p0, Lcom/gmhub/qs/ComposePanelRoot$Session;->registered:Z

    if-nez v0, :cond_1

    goto :goto_0

    :cond_1
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/gmhub/qs/ComposePanelRoot$Session;->registered:Z

    :try_start_0
    iget-object v0, p0, Lcom/gmhub/qs/ComposePanelRoot$Session;->context:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    iget-object p0, p0, Lcom/gmhub/qs/ComposePanelRoot$Session;->observer:Landroid/database/ContentObserver;

    invoke-virtual {v0, p0}, Landroid/content/ContentResolver;->unregisterContentObserver(Landroid/database/ContentObserver;)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p0

    const-string v0, "GMHubQs"

    const-string v1, "QS observer already unavailable"

    invoke-static {v0, v1, p0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    :goto_0
    return-void
.end method

.method synthetic lambda$new$0$com-gmhub-qs-ComposePanelRoot$Session([Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    invoke-virtual {p0}, Lcom/gmhub/qs/ComposePanelRoot$Session;->close()V

    const/4 p0, 0x0

    return-object p0
.end method

.method synthetic lambda$new$1$com-gmhub-qs-ComposePanelRoot$Session([Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    invoke-virtual {p0}, Lcom/gmhub/qs/ComposePanelRoot$Session;->activate()V

    iget-object p0, p0, Lcom/gmhub/qs/ComposePanelRoot$Session;->result:Ljava/lang/Object;

    return-object p0
.end method

.method read()I
    .locals 2

    const/4 v0, 0x0

    :try_start_0
    iget-object p0, p0, Lcom/gmhub/qs/ComposePanelRoot$Session;->context:Landroid/content/Context;

    invoke-virtual {p0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object p0

    const-string v1, "gmhub_qs_style"

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

.method refresh()V
    .locals 2

    iget-boolean v0, p0, Lcom/gmhub/qs/ComposePanelRoot$Session;->closed:Z

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/gmhub/qs/ComposePanelRoot$Session;->api:Lcom/gmhub/qs/ComposePanelRoot$Abi;

    iget-object v0, v0, Lcom/gmhub/qs/ComposePanelRoot$Abi;->setValue:Ljava/lang/reflect/Method;

    iget-object v1, p0, Lcom/gmhub/qs/ComposePanelRoot$Session;->selection:Ljava/lang/Object;

    invoke-virtual {p0}, Lcom/gmhub/qs/ComposePanelRoot$Session;->read()I

    move-result p0

    invoke-static {p0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p0

    filled-new-array {p0}, [Ljava/lang/Object;

    move-result-object p0

    invoke-static {v0, v1, p0}, Lcom/gmhub/qs/ComposePanelRoot;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    :cond_0
    return-void
.end method
