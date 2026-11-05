.class public final synthetic Lcom/gmhub/apps/AppsController$$ExternalSyntheticLambda5;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field public final synthetic f$0:Lcom/gmhub/apps/AppsController;

.field public final synthetic f$1:I

.field public final synthetic f$2:Ljava/util/List;


# direct methods
.method public synthetic constructor <init>(Lcom/gmhub/apps/AppsController;ILjava/util/List;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/gmhub/apps/AppsController$$ExternalSyntheticLambda5;->f$0:Lcom/gmhub/apps/AppsController;

    iput p2, p0, Lcom/gmhub/apps/AppsController$$ExternalSyntheticLambda5;->f$1:I

    iput-object p3, p0, Lcom/gmhub/apps/AppsController$$ExternalSyntheticLambda5;->f$2:Ljava/util/List;

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 2

    iget-object v0, p0, Lcom/gmhub/apps/AppsController$$ExternalSyntheticLambda5;->f$0:Lcom/gmhub/apps/AppsController;

    iget v1, p0, Lcom/gmhub/apps/AppsController$$ExternalSyntheticLambda5;->f$1:I

    iget-object p0, p0, Lcom/gmhub/apps/AppsController$$ExternalSyntheticLambda5;->f$2:Ljava/util/List;

    invoke-virtual {v0, v1, p0}, Lcom/gmhub/apps/AppsController;->lambda$reload$2$com-gmhub-apps-AppsController(ILjava/util/List;)V

    return-void
.end method
