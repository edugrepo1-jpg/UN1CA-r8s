.class public final synthetic Lcom/gmhub/qs/IosHeader$Session$$ExternalSyntheticLambda1;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Lcom/gmhub/qs/IosHeader$Callback;


# instance fields
.field public final synthetic f$0:Lcom/gmhub/qs/IosHeader$Session;

.field public final synthetic f$1:Lcom/gmhub/qs/IosHeader$Runtime;


# direct methods
.method public synthetic constructor <init>(Lcom/gmhub/qs/IosHeader$Session;Lcom/gmhub/qs/IosHeader$Runtime;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/gmhub/qs/IosHeader$Session$$ExternalSyntheticLambda1;->f$0:Lcom/gmhub/qs/IosHeader$Session;

    iput-object p2, p0, Lcom/gmhub/qs/IosHeader$Session$$ExternalSyntheticLambda1;->f$1:Lcom/gmhub/qs/IosHeader$Runtime;

    return-void
.end method


# virtual methods
.method public final invoke([Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    iget-object v0, p0, Lcom/gmhub/qs/IosHeader$Session$$ExternalSyntheticLambda1;->f$0:Lcom/gmhub/qs/IosHeader$Session;

    iget-object p0, p0, Lcom/gmhub/qs/IosHeader$Session$$ExternalSyntheticLambda1;->f$1:Lcom/gmhub/qs/IosHeader$Runtime;

    invoke-virtual {v0, p0, p1}, Lcom/gmhub/qs/IosHeader$Session;->lambda$new$1$com-gmhub-qs-IosHeader$Session(Lcom/gmhub/qs/IosHeader$Runtime;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    return-object p0
.end method
