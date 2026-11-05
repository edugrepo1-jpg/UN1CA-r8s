.class public final synthetic Lcom/gmhub/apps/AppsController$$ExternalSyntheticLambda9;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# instance fields
.field public final synthetic f$0:Lcom/gmhub/apps/AppsController;

.field public final synthetic f$1:[Z

.field public final synthetic f$2:Ljava/util/List;

.field public final synthetic f$3:Z


# direct methods
.method public synthetic constructor <init>(Lcom/gmhub/apps/AppsController;[ZLjava/util/List;Z)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/gmhub/apps/AppsController$$ExternalSyntheticLambda9;->f$0:Lcom/gmhub/apps/AppsController;

    iput-object p2, p0, Lcom/gmhub/apps/AppsController$$ExternalSyntheticLambda9;->f$1:[Z

    iput-object p3, p0, Lcom/gmhub/apps/AppsController$$ExternalSyntheticLambda9;->f$2:Ljava/util/List;

    iput-boolean p4, p0, Lcom/gmhub/apps/AppsController$$ExternalSyntheticLambda9;->f$3:Z

    return-void
.end method


# virtual methods
.method public final onClick(Landroid/content/DialogInterface;I)V
    .locals 6

    iget-object v0, p0, Lcom/gmhub/apps/AppsController$$ExternalSyntheticLambda9;->f$0:Lcom/gmhub/apps/AppsController;

    iget-object v1, p0, Lcom/gmhub/apps/AppsController$$ExternalSyntheticLambda9;->f$1:[Z

    iget-object v2, p0, Lcom/gmhub/apps/AppsController$$ExternalSyntheticLambda9;->f$2:Ljava/util/List;

    iget-boolean v3, p0, Lcom/gmhub/apps/AppsController$$ExternalSyntheticLambda9;->f$3:Z

    move-object v4, p1

    move v5, p2

    invoke-virtual/range {v0 .. v5}, Lcom/gmhub/apps/AppsController;->lambda$chooseOptional$3$com-gmhub-apps-AppsController([ZLjava/util/List;ZLandroid/content/DialogInterface;I)V

    return-void
.end method
