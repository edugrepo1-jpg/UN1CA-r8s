.class public final synthetic Lcom/gmhub/qs/IosHeader$Runtime$$ExternalSyntheticLambda0;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Lcom/gmhub/qs/IosHeader$Callback;


# instance fields
.field public final synthetic f$0:Lcom/gmhub/qs/IosHeader$Runtime;

.field public final synthetic f$1:Ljava/lang/Object;

.field public final synthetic f$2:Ljava/lang/Object;

.field public final synthetic f$3:I


# direct methods
.method public synthetic constructor <init>(Lcom/gmhub/qs/IosHeader$Runtime;Ljava/lang/Object;Ljava/lang/Object;I)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/gmhub/qs/IosHeader$Runtime$$ExternalSyntheticLambda0;->f$0:Lcom/gmhub/qs/IosHeader$Runtime;

    iput-object p2, p0, Lcom/gmhub/qs/IosHeader$Runtime$$ExternalSyntheticLambda0;->f$1:Ljava/lang/Object;

    iput-object p3, p0, Lcom/gmhub/qs/IosHeader$Runtime$$ExternalSyntheticLambda0;->f$2:Ljava/lang/Object;

    iput p4, p0, Lcom/gmhub/qs/IosHeader$Runtime$$ExternalSyntheticLambda0;->f$3:I

    return-void
.end method


# virtual methods
.method public final invoke([Ljava/lang/Object;)Ljava/lang/Object;
    .locals 3

    iget-object v0, p0, Lcom/gmhub/qs/IosHeader$Runtime$$ExternalSyntheticLambda0;->f$0:Lcom/gmhub/qs/IosHeader$Runtime;

    iget-object v1, p0, Lcom/gmhub/qs/IosHeader$Runtime$$ExternalSyntheticLambda0;->f$1:Ljava/lang/Object;

    iget-object v2, p0, Lcom/gmhub/qs/IosHeader$Runtime$$ExternalSyntheticLambda0;->f$2:Ljava/lang/Object;

    iget p0, p0, Lcom/gmhub/qs/IosHeader$Runtime$$ExternalSyntheticLambda0;->f$3:I

    invoke-virtual {v0, v1, v2, p0, p1}, Lcom/gmhub/qs/IosHeader$Runtime;->lambda$render$0$com-gmhub-qs-IosHeader$Runtime(Ljava/lang/Object;Ljava/lang/Object;I[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    return-object p0
.end method
