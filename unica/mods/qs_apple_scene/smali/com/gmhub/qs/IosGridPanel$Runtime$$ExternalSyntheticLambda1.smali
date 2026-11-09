.class public final synthetic Lcom/gmhub/qs/IosGridPanel$Runtime$$ExternalSyntheticLambda1;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Lcom/gmhub/qs/IosGridPanel$Callback;


# instance fields
.field public final synthetic f$0:Lcom/gmhub/qs/IosGridPanel$Runtime;

.field public final synthetic f$1:Lcom/gmhub/qs/IosGridPanel$Session;

.field public final synthetic f$2:Lcom/gmhub/qs/NativePageNavigation$Pages;


# direct methods
.method public synthetic constructor <init>(Lcom/gmhub/qs/IosGridPanel$Runtime;Lcom/gmhub/qs/IosGridPanel$Session;Lcom/gmhub/qs/NativePageNavigation$Pages;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/gmhub/qs/IosGridPanel$Runtime$$ExternalSyntheticLambda1;->f$0:Lcom/gmhub/qs/IosGridPanel$Runtime;

    iput-object p2, p0, Lcom/gmhub/qs/IosGridPanel$Runtime$$ExternalSyntheticLambda1;->f$1:Lcom/gmhub/qs/IosGridPanel$Session;

    iput-object p3, p0, Lcom/gmhub/qs/IosGridPanel$Runtime$$ExternalSyntheticLambda1;->f$2:Lcom/gmhub/qs/NativePageNavigation$Pages;

    return-void
.end method


# virtual methods
.method public final invoke([Ljava/lang/Object;)Ljava/lang/Object;
    .locals 2

    iget-object v0, p0, Lcom/gmhub/qs/IosGridPanel$Runtime$$ExternalSyntheticLambda1;->f$0:Lcom/gmhub/qs/IosGridPanel$Runtime;

    iget-object v1, p0, Lcom/gmhub/qs/IosGridPanel$Runtime$$ExternalSyntheticLambda1;->f$1:Lcom/gmhub/qs/IosGridPanel$Session;

    iget-object p0, p0, Lcom/gmhub/qs/IosGridPanel$Runtime$$ExternalSyntheticLambda1;->f$2:Lcom/gmhub/qs/NativePageNavigation$Pages;

    invoke-virtual {v0, v1, p0, p1}, Lcom/gmhub/qs/IosGridPanel$Runtime;->lambda$render$2$com-gmhub-qs-IosGridPanel$Runtime(Lcom/gmhub/qs/IosGridPanel$Session;Lcom/gmhub/qs/NativePageNavigation$Pages;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    return-object p0
.end method
