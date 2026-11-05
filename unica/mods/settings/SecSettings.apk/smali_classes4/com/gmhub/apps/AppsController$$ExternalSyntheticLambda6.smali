.class public final synthetic Lcom/gmhub/apps/AppsController$$ExternalSyntheticLambda6;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field public final synthetic f$0:Lcom/gmhub/apps/AppsController;

.field public final synthetic f$1:I


# direct methods
.method public synthetic constructor <init>(Lcom/gmhub/apps/AppsController;I)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/gmhub/apps/AppsController$$ExternalSyntheticLambda6;->f$0:Lcom/gmhub/apps/AppsController;

    iput p2, p0, Lcom/gmhub/apps/AppsController$$ExternalSyntheticLambda6;->f$1:I

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 1

    iget-object v0, p0, Lcom/gmhub/apps/AppsController$$ExternalSyntheticLambda6;->f$0:Lcom/gmhub/apps/AppsController;

    iget p0, p0, Lcom/gmhub/apps/AppsController$$ExternalSyntheticLambda6;->f$1:I

    invoke-virtual {v0, p0}, Lcom/gmhub/apps/AppsController;->lambda$reload$3$com-gmhub-apps-AppsController(I)V

    return-void
.end method
