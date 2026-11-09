.class public final synthetic Lcom/gmhub/qs/IosGridPanel$Runtime$$ExternalSyntheticLambda4;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Lcom/gmhub/qs/IosGridPanel$Callback;


# instance fields
.field public final synthetic f$0:Lcom/gmhub/qs/IosGridPanel$Runtime;

.field public final synthetic f$1:[Ljava/lang/Object;

.field public final synthetic f$2:Lcom/gmhub/qs/NativePageNavigation$Pages;

.field public final synthetic f$3:Lcom/gmhub/qs/IosGridPanel$Session;


# direct methods
.method public synthetic constructor <init>(Lcom/gmhub/qs/IosGridPanel$Runtime;[Ljava/lang/Object;Lcom/gmhub/qs/NativePageNavigation$Pages;Lcom/gmhub/qs/IosGridPanel$Session;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/gmhub/qs/IosGridPanel$Runtime$$ExternalSyntheticLambda4;->f$0:Lcom/gmhub/qs/IosGridPanel$Runtime;

    iput-object p2, p0, Lcom/gmhub/qs/IosGridPanel$Runtime$$ExternalSyntheticLambda4;->f$1:[Ljava/lang/Object;

    iput-object p3, p0, Lcom/gmhub/qs/IosGridPanel$Runtime$$ExternalSyntheticLambda4;->f$2:Lcom/gmhub/qs/NativePageNavigation$Pages;

    iput-object p4, p0, Lcom/gmhub/qs/IosGridPanel$Runtime$$ExternalSyntheticLambda4;->f$3:Lcom/gmhub/qs/IosGridPanel$Session;

    return-void
.end method


# virtual methods
.method public final invoke([Ljava/lang/Object;)Ljava/lang/Object;
    .locals 3

    iget-object v0, p0, Lcom/gmhub/qs/IosGridPanel$Runtime$$ExternalSyntheticLambda4;->f$0:Lcom/gmhub/qs/IosGridPanel$Runtime;

    iget-object v1, p0, Lcom/gmhub/qs/IosGridPanel$Runtime$$ExternalSyntheticLambda4;->f$1:[Ljava/lang/Object;

    iget-object v2, p0, Lcom/gmhub/qs/IosGridPanel$Runtime$$ExternalSyntheticLambda4;->f$2:Lcom/gmhub/qs/NativePageNavigation$Pages;

    iget-object p0, p0, Lcom/gmhub/qs/IosGridPanel$Runtime$$ExternalSyntheticLambda4;->f$3:Lcom/gmhub/qs/IosGridPanel$Session;

    invoke-virtual {v0, v1, v2, p0, p1}, Lcom/gmhub/qs/IosGridPanel$Runtime;->lambda$render$1$com-gmhub-qs-IosGridPanel$Runtime([Ljava/lang/Object;Lcom/gmhub/qs/NativePageNavigation$Pages;Lcom/gmhub/qs/IosGridPanel$Session;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    return-object p0
.end method
