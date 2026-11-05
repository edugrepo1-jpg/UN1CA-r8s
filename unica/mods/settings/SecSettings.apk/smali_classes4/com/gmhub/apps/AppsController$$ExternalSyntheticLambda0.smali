.class public final synthetic Lcom/gmhub/apps/AppsController$$ExternalSyntheticLambda0;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field public final synthetic f$0:Lcom/gmhub/apps/AppsController;

.field public final synthetic f$1:Z

.field public final synthetic f$2:Ljava/util/List;

.field public final synthetic f$3:Z


# direct methods
.method public synthetic constructor <init>(Lcom/gmhub/apps/AppsController;ZLjava/util/List;Z)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/gmhub/apps/AppsController$$ExternalSyntheticLambda0;->f$0:Lcom/gmhub/apps/AppsController;

    iput-boolean p2, p0, Lcom/gmhub/apps/AppsController$$ExternalSyntheticLambda0;->f$1:Z

    iput-object p3, p0, Lcom/gmhub/apps/AppsController$$ExternalSyntheticLambda0;->f$2:Ljava/util/List;

    iput-boolean p4, p0, Lcom/gmhub/apps/AppsController$$ExternalSyntheticLambda0;->f$3:Z

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 3

    iget-object v0, p0, Lcom/gmhub/apps/AppsController$$ExternalSyntheticLambda0;->f$0:Lcom/gmhub/apps/AppsController;

    iget-boolean v1, p0, Lcom/gmhub/apps/AppsController$$ExternalSyntheticLambda0;->f$1:Z

    iget-object v2, p0, Lcom/gmhub/apps/AppsController$$ExternalSyntheticLambda0;->f$2:Ljava/util/List;

    iget-boolean p0, p0, Lcom/gmhub/apps/AppsController$$ExternalSyntheticLambda0;->f$3:Z

    invoke-virtual {v0, v1, v2, p0}, Lcom/gmhub/apps/AppsController;->lambda$perform$0$com-gmhub-apps-AppsController(ZLjava/util/List;Z)V

    return-void
.end method
