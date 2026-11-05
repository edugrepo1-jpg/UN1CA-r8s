.class public final synthetic Lcom/gmhub/apps/AppsController$$ExternalSyntheticLambda12;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field public final synthetic f$0:Lcom/gmhub/apps/AppsController;

.field public final synthetic f$1:I

.field public final synthetic f$2:Z


# direct methods
.method public synthetic constructor <init>(Lcom/gmhub/apps/AppsController;IZ)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/gmhub/apps/AppsController$$ExternalSyntheticLambda12;->f$0:Lcom/gmhub/apps/AppsController;

    iput p2, p0, Lcom/gmhub/apps/AppsController$$ExternalSyntheticLambda12;->f$1:I

    iput-boolean p3, p0, Lcom/gmhub/apps/AppsController$$ExternalSyntheticLambda12;->f$2:Z

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 2

    iget-object v0, p0, Lcom/gmhub/apps/AppsController$$ExternalSyntheticLambda12;->f$0:Lcom/gmhub/apps/AppsController;

    iget v1, p0, Lcom/gmhub/apps/AppsController$$ExternalSyntheticLambda12;->f$1:I

    iget-boolean p0, p0, Lcom/gmhub/apps/AppsController$$ExternalSyntheticLambda12;->f$2:Z

    invoke-virtual {v0, v1, p0}, Lcom/gmhub/apps/AppsController;->lambda$chooseOptional$0$com-gmhub-apps-AppsController(IZ)V

    return-void
.end method
