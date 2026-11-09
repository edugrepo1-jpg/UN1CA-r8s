.class final Lcom/gmhub/qs/IosGridPanel$Session;
.super Ljava/lang/Object;
.source "IosGridPanel.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/gmhub/qs/IosGridPanel;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "Session"
.end annotation


# instance fields
.field final api:Lcom/gmhub/qs/IosGridPanel$Runtime;

.field final context:Landroid/content/Context;

.field final effect:Ljava/lang/Object;

.field final factory:Ljava/lang/Object;

.field final navigation:Lcom/gmhub/qs/NativePageNavigation;

.field final pages:Ljava/lang/Object;

.field final release:Ljava/lang/Object;

.field final request:Ljava/lang/Object;


# direct methods
.method constructor <init>(Lcom/gmhub/qs/IosGridPanel$Runtime;Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;Landroid/content/Context;)V
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/ReflectiveOperationException;
        }
    .end annotation

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    if-eqz p5, :cond_1

    iput-object p1, p0, Lcom/gmhub/qs/IosGridPanel$Session;->api:Lcom/gmhub/qs/IosGridPanel$Runtime;

    iput-object p5, p0, Lcom/gmhub/qs/IosGridPanel$Session;->context:Landroid/content/Context;

    const-string v0, "favorite"

    const-string v1, "page"

    filled-new-array {v0, v1}, [Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    move v2, v1

    :goto_0
    const/4 v3, 0x2

    if-ge v2, v3, :cond_0

    aget-object v3, v0, v2

    new-instance v4, Ljava/lang/StringBuilder;

    const-string v5, "gmhub_qs_"

    invoke-direct {v4, v5}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    const-string v4, "drawable"

    invoke-static {p5, v3, v4}, Lcom/gmhub/qs/IosGridPanel;->access$500(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_0
    const-string v0, "gmhub_qs_page_number"

    const-string v2, "string"

    invoke-static {p5, v0, v2}, Lcom/gmhub/qs/IosGridPanel;->access$500(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    new-instance p5, Lcom/gmhub/qs/NativePageNavigation;

    invoke-direct {p5, p2, p3, p4}, Lcom/gmhub/qs/NativePageNavigation;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)V

    iput-object p5, p0, Lcom/gmhub/qs/IosGridPanel$Session;->navigation:Lcom/gmhub/qs/NativePageNavigation;

    iget-object p2, p1, Lcom/gmhub/qs/IosGridPanel$Runtime;->derived:Ljava/lang/reflect/Method;

    iget-object p3, p1, Lcom/gmhub/qs/IosGridPanel$Runtime;->policy:Ljava/lang/reflect/Method;

    new-array p4, v1, [Ljava/lang/Object;

    const/4 p5, 0x0

    invoke-static {p3, p5, p4}, Lcom/gmhub/qs/IosGridPanel;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p3

    iget-object p4, p1, Lcom/gmhub/qs/IosGridPanel$Runtime;->loader:Ljava/lang/ClassLoader;

    const-string v0, "kotlin.jvm.functions.Function0"

    invoke-static {p4, v0}, Lcom/gmhub/qs/IosGridPanel;->access$000(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object p4

    new-instance v0, Lcom/gmhub/qs/IosGridPanel$Session$$ExternalSyntheticLambda0;

    invoke-direct {v0, p0}, Lcom/gmhub/qs/IosGridPanel$Session$$ExternalSyntheticLambda0;-><init>(Lcom/gmhub/qs/IosGridPanel$Session;)V

    invoke-virtual {p1, p4, v0}, Lcom/gmhub/qs/IosGridPanel$Runtime;->fn(Ljava/lang/Class;Lcom/gmhub/qs/IosGridPanel$Callback;)Ljava/lang/Object;

    move-result-object p4

    filled-new-array {p3, p4}, [Ljava/lang/Object;

    move-result-object p3

    invoke-static {p2, p5, p3}, Lcom/gmhub/qs/IosGridPanel;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p2

    iput-object p2, p0, Lcom/gmhub/qs/IosGridPanel$Session;->pages:Ljava/lang/Object;

    iget-object p2, p1, Lcom/gmhub/qs/IosGridPanel$Runtime;->state:Ljava/lang/reflect/Method;

    filled-new-array {p5}, [Ljava/lang/Object;

    move-result-object p3

    invoke-static {p2, p5, p3}, Lcom/gmhub/qs/IosGridPanel;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p2

    iput-object p2, p0, Lcom/gmhub/qs/IosGridPanel$Session;->request:Ljava/lang/Object;

    iget-object p2, p1, Lcom/gmhub/qs/IosGridPanel$Runtime;->f1:Ljava/lang/Class;

    new-instance p3, Lcom/gmhub/qs/IosGridPanel$Session$$ExternalSyntheticLambda1;

    invoke-direct {p3}, Lcom/gmhub/qs/IosGridPanel$Session$$ExternalSyntheticLambda1;-><init>()V

    invoke-virtual {p1, p2, p3}, Lcom/gmhub/qs/IosGridPanel$Runtime;->fn(Ljava/lang/Class;Lcom/gmhub/qs/IosGridPanel$Callback;)Ljava/lang/Object;

    move-result-object p2

    iput-object p2, p0, Lcom/gmhub/qs/IosGridPanel$Session;->factory:Ljava/lang/Object;

    iget-object p2, p1, Lcom/gmhub/qs/IosGridPanel$Runtime;->f1:Ljava/lang/Class;

    new-instance p3, Lcom/gmhub/qs/IosGridPanel$Session$$ExternalSyntheticLambda2;

    invoke-direct {p3, p1}, Lcom/gmhub/qs/IosGridPanel$Session$$ExternalSyntheticLambda2;-><init>(Lcom/gmhub/qs/IosGridPanel$Runtime;)V

    invoke-virtual {p1, p2, p3}, Lcom/gmhub/qs/IosGridPanel$Runtime;->fn(Ljava/lang/Class;Lcom/gmhub/qs/IosGridPanel$Callback;)Ljava/lang/Object;

    move-result-object p2

    iput-object p2, p0, Lcom/gmhub/qs/IosGridPanel$Session;->release:Ljava/lang/Object;

    iget-object p2, p1, Lcom/gmhub/qs/IosGridPanel$Runtime;->f1:Ljava/lang/Class;

    new-instance p3, Lcom/gmhub/qs/IosGridPanel$Session$$ExternalSyntheticLambda3;

    invoke-direct {p3, p0, p1}, Lcom/gmhub/qs/IosGridPanel$Session$$ExternalSyntheticLambda3;-><init>(Lcom/gmhub/qs/IosGridPanel$Session;Lcom/gmhub/qs/IosGridPanel$Runtime;)V

    invoke-virtual {p1, p2, p3}, Lcom/gmhub/qs/IosGridPanel$Runtime;->fn(Ljava/lang/Class;Lcom/gmhub/qs/IosGridPanel$Callback;)Ljava/lang/Object;

    move-result-object p1

    iput-object p1, p0, Lcom/gmhub/qs/IosGridPanel$Session;->effect:Ljava/lang/Object;

    return-void

    :cond_1
    new-instance p0, Ljava/lang/IllegalStateException;

    const-string p1, "Missing native user context"

    invoke-direct {p0, p1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p0
.end method

.method static synthetic lambda$new$1([Ljava/lang/Object;)Ljava/lang/Object;
    .locals 2

    new-instance v0, Lcom/gmhub/qs/IosGridPanel$RailView;

    const/4 v1, 0x0

    aget-object p0, p0, v1

    check-cast p0, Landroid/content/Context;

    invoke-direct {v0, p0}, Lcom/gmhub/qs/IosGridPanel$RailView;-><init>(Landroid/content/Context;)V

    return-object v0
.end method

.method static synthetic lambda$new$2(Lcom/gmhub/qs/IosGridPanel$Runtime;[Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    const/4 v0, 0x0

    aget-object p1, p1, v0

    check-cast p1, Lcom/gmhub/qs/IosGridPanel$RailView;

    invoke-virtual {p1}, Lcom/gmhub/qs/IosGridPanel$RailView;->release()V

    iget-object p0, p0, Lcom/gmhub/qs/IosGridPanel$Runtime;->unit:Ljava/lang/Object;

    return-object p0
.end method


# virtual methods
.method synthetic lambda$new$0$com-gmhub-qs-IosGridPanel$Session([Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    iget-object p0, p0, Lcom/gmhub/qs/IosGridPanel$Session;->navigation:Lcom/gmhub/qs/NativePageNavigation;

    invoke-virtual {p0}, Lcom/gmhub/qs/NativePageNavigation;->pages()Lcom/gmhub/qs/NativePageNavigation$Pages;

    move-result-object p0

    return-object p0
.end method

.method synthetic lambda$new$3$com-gmhub-qs-IosGridPanel$Session(Lcom/gmhub/qs/IosGridPanel$Runtime;[Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    iget-object p2, p1, Lcom/gmhub/qs/IosGridPanel$Runtime;->disposable:Ljava/lang/Class;

    new-instance v0, Lcom/gmhub/qs/IosGridPanel$Session$$ExternalSyntheticLambda4;

    invoke-direct {v0, p0}, Lcom/gmhub/qs/IosGridPanel$Session$$ExternalSyntheticLambda4;-><init>(Lcom/gmhub/qs/IosGridPanel$Session;)V

    invoke-virtual {p1, p2, v0}, Lcom/gmhub/qs/IosGridPanel$Runtime;->fn(Ljava/lang/Class;Lcom/gmhub/qs/IosGridPanel$Callback;)Ljava/lang/Object;

    move-result-object p0

    return-object p0
.end method

.method synthetic lambda$new$4$com-gmhub-qs-IosGridPanel$Session([Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    iget-object p0, p0, Lcom/gmhub/qs/IosGridPanel$Session;->navigation:Lcom/gmhub/qs/NativePageNavigation;

    invoke-virtual {p0}, Lcom/gmhub/qs/NativePageNavigation;->close()V

    const/4 p0, 0x0

    return-object p0
.end method

.method select(I)V
    .locals 1

    iget-object v0, p0, Lcom/gmhub/qs/IosGridPanel$Session;->navigation:Lcom/gmhub/qs/NativePageNavigation;

    invoke-virtual {v0, p1}, Lcom/gmhub/qs/NativePageNavigation;->request(I)Lcom/gmhub/qs/NativePageNavigation$Request;

    move-result-object p1

    if-eqz p1, :cond_0

    iget-object v0, p0, Lcom/gmhub/qs/IosGridPanel$Session;->api:Lcom/gmhub/qs/IosGridPanel$Runtime;

    iget-object v0, v0, Lcom/gmhub/qs/IosGridPanel$Runtime;->setValue:Ljava/lang/reflect/Method;

    iget-object p0, p0, Lcom/gmhub/qs/IosGridPanel$Session;->request:Ljava/lang/Object;

    filled-new-array {p1}, [Ljava/lang/Object;

    move-result-object p1

    invoke-static {v0, p0, p1}, Lcom/gmhub/qs/IosGridPanel;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    :cond_0
    return-void
.end method
