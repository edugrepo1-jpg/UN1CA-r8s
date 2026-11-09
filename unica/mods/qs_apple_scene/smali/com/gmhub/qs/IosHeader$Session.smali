.class final Lcom/gmhub/qs/IosHeader$Session;
.super Ljava/lang/Object;
.source "IosHeader.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/gmhub/qs/IosHeader;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "Session"
.end annotation


# instance fields
.field final actions:Lcom/gmhub/qs/NativeHeaderActions;

.field final availableFlow:Ljava/lang/Object;

.field final editFlow:Ljava/lang/Object;

.field final factory:Ljava/lang/Object;

.field final release:Ljava/lang/Object;

.field final update:Ljava/lang/Object;


# direct methods
.method constructor <init>(Lcom/gmhub/qs/IosHeader$Runtime;Ljava/lang/Object;Landroid/content/Context;)V
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/ReflectiveOperationException;
        }
    .end annotation

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const-string v0, "gmhub_qs_plus"

    const-string v1, "drawable"

    invoke-static {p3, v0, v1}, Lcom/gmhub/qs/IosHeader;->access$500(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    const-string v0, "gmhub_qs_power"

    invoke-static {p3, v0, v1}, Lcom/gmhub/qs/IosHeader;->access$500(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    const-string v0, "power"

    const-string v1, "action_failed"

    const-string v2, "edit"

    const-string v3, "add"

    const-string v4, "done"

    filled-new-array {v2, v3, v4, v0, v1}, [Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    :goto_0
    const/4 v2, 0x5

    if-ge v1, v2, :cond_0

    aget-object v2, v0, v1

    new-instance v3, Ljava/lang/StringBuilder;

    const-string v4, "gmhub_qs_"

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    const-string v3, "string"

    invoke-static {p3, v2, v3}, Lcom/gmhub/qs/IosHeader;->access$500(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_0
    new-instance p3, Lcom/gmhub/qs/NativeHeaderActions;

    invoke-direct {p3, p2}, Lcom/gmhub/qs/NativeHeaderActions;-><init>(Ljava/lang/Object;)V

    iput-object p3, p0, Lcom/gmhub/qs/IosHeader$Session;->actions:Lcom/gmhub/qs/NativeHeaderActions;

    iget-object p3, p1, Lcom/gmhub/qs/IosHeader$Runtime;->edit:Ljava/lang/reflect/Field;

    invoke-virtual {p3, p2}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p3

    const-string v0, "editMode"

    invoke-static {p3, v0}, Lcom/gmhub/qs/IosHeader;->access$600(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p3

    iput-object p3, p0, Lcom/gmhub/qs/IosHeader$Session;->editFlow:Ljava/lang/Object;

    iget-object p3, p1, Lcom/gmhub/qs/IosHeader$Runtime;->available:Ljava/lang/reflect/Field;

    invoke-virtual {p3, p2}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p2

    const-string p3, "hasAvailableTiles"

    invoke-static {p2, p3}, Lcom/gmhub/qs/IosHeader;->access$600(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p2

    iput-object p2, p0, Lcom/gmhub/qs/IosHeader$Session;->availableFlow:Ljava/lang/Object;

    iget-object p2, p1, Lcom/gmhub/qs/IosHeader$Runtime;->function1:Ljava/lang/Class;

    new-instance p3, Lcom/gmhub/qs/IosHeader$Session$$ExternalSyntheticLambda0;

    invoke-direct {p3}, Lcom/gmhub/qs/IosHeader$Session$$ExternalSyntheticLambda0;-><init>()V

    invoke-virtual {p1, p2, p3}, Lcom/gmhub/qs/IosHeader$Runtime;->function(Ljava/lang/Class;Lcom/gmhub/qs/IosHeader$Callback;)Ljava/lang/Object;

    move-result-object p2

    iput-object p2, p0, Lcom/gmhub/qs/IosHeader$Session;->factory:Ljava/lang/Object;

    iget-object p2, p1, Lcom/gmhub/qs/IosHeader$Runtime;->function1:Ljava/lang/Class;

    new-instance p3, Lcom/gmhub/qs/IosHeader$Session$$ExternalSyntheticLambda1;

    invoke-direct {p3, p0, p1}, Lcom/gmhub/qs/IosHeader$Session$$ExternalSyntheticLambda1;-><init>(Lcom/gmhub/qs/IosHeader$Session;Lcom/gmhub/qs/IosHeader$Runtime;)V

    invoke-virtual {p1, p2, p3}, Lcom/gmhub/qs/IosHeader$Runtime;->function(Ljava/lang/Class;Lcom/gmhub/qs/IosHeader$Callback;)Ljava/lang/Object;

    move-result-object p2

    iput-object p2, p0, Lcom/gmhub/qs/IosHeader$Session;->update:Ljava/lang/Object;

    iget-object p2, p1, Lcom/gmhub/qs/IosHeader$Runtime;->function1:Ljava/lang/Class;

    new-instance p3, Lcom/gmhub/qs/IosHeader$Session$$ExternalSyntheticLambda2;

    invoke-direct {p3, p1}, Lcom/gmhub/qs/IosHeader$Session$$ExternalSyntheticLambda2;-><init>(Lcom/gmhub/qs/IosHeader$Runtime;)V

    invoke-virtual {p1, p2, p3}, Lcom/gmhub/qs/IosHeader$Runtime;->function(Ljava/lang/Class;Lcom/gmhub/qs/IosHeader$Callback;)Ljava/lang/Object;

    move-result-object p1

    iput-object p1, p0, Lcom/gmhub/qs/IosHeader$Session;->release:Ljava/lang/Object;

    return-void
.end method

.method static synthetic lambda$new$0([Ljava/lang/Object;)Ljava/lang/Object;
    .locals 2

    new-instance v0, Lcom/gmhub/qs/IosHeader$HeaderView;

    const/4 v1, 0x0

    aget-object p0, p0, v1

    check-cast p0, Landroid/content/Context;

    invoke-direct {v0, p0}, Lcom/gmhub/qs/IosHeader$HeaderView;-><init>(Landroid/content/Context;)V

    return-object v0
.end method

.method static synthetic lambda$new$2(Lcom/gmhub/qs/IosHeader$Runtime;[Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    const/4 v0, 0x0

    aget-object p1, p1, v0

    check-cast p1, Lcom/gmhub/qs/IosHeader$HeaderView;

    invoke-virtual {p1}, Lcom/gmhub/qs/IosHeader$HeaderView;->release()V

    iget-object p0, p0, Lcom/gmhub/qs/IosHeader$Runtime;->unit:Ljava/lang/Object;

    return-object p0
.end method


# virtual methods
.method synthetic lambda$new$1$com-gmhub-qs-IosHeader$Session(Lcom/gmhub/qs/IosHeader$Runtime;[Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    const/4 v0, 0x0

    aget-object p2, p2, v0

    check-cast p2, Lcom/gmhub/qs/IosHeader$HeaderView;

    iget-object p0, p0, Lcom/gmhub/qs/IosHeader$Session;->actions:Lcom/gmhub/qs/NativeHeaderActions;

    invoke-virtual {p2, p0}, Lcom/gmhub/qs/IosHeader$HeaderView;->bind(Lcom/gmhub/qs/NativeHeaderActions;)V

    iget-object p0, p1, Lcom/gmhub/qs/IosHeader$Runtime;->unit:Ljava/lang/Object;

    return-object p0
.end method
