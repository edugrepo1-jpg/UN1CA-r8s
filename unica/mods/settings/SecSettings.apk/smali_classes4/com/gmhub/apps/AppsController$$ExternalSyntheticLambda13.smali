.class public final synthetic Lcom/gmhub/apps/AppsController$$ExternalSyntheticLambda13;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field public final synthetic f$0:Lcom/gmhub/apps/AppsController;

.field public final synthetic f$1:Ljava/lang/String;

.field public final synthetic f$2:I

.field public final synthetic f$3:Ljava/lang/ref/WeakReference;


# direct methods
.method public synthetic constructor <init>(Lcom/gmhub/apps/AppsController;Ljava/lang/String;ILjava/lang/ref/WeakReference;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/gmhub/apps/AppsController$$ExternalSyntheticLambda13;->f$0:Lcom/gmhub/apps/AppsController;

    iput-object p2, p0, Lcom/gmhub/apps/AppsController$$ExternalSyntheticLambda13;->f$1:Ljava/lang/String;

    iput p3, p0, Lcom/gmhub/apps/AppsController$$ExternalSyntheticLambda13;->f$2:I

    iput-object p4, p0, Lcom/gmhub/apps/AppsController$$ExternalSyntheticLambda13;->f$3:Ljava/lang/ref/WeakReference;

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 3

    iget-object v0, p0, Lcom/gmhub/apps/AppsController$$ExternalSyntheticLambda13;->f$0:Lcom/gmhub/apps/AppsController;

    iget-object v1, p0, Lcom/gmhub/apps/AppsController$$ExternalSyntheticLambda13;->f$1:Ljava/lang/String;

    iget v2, p0, Lcom/gmhub/apps/AppsController$$ExternalSyntheticLambda13;->f$2:I

    iget-object p0, p0, Lcom/gmhub/apps/AppsController$$ExternalSyntheticLambda13;->f$3:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0, v1, v2, p0}, Lcom/gmhub/apps/AppsController;->lambda$bindIcon$0$com-gmhub-apps-AppsController(Ljava/lang/String;ILjava/lang/ref/WeakReference;)V

    return-void
.end method
