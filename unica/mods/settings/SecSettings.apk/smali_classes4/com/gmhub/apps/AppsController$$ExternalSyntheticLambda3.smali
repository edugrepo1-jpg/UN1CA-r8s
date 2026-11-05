.class public final synthetic Lcom/gmhub/apps/AppsController$$ExternalSyntheticLambda3;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field public final synthetic f$0:Lcom/gmhub/apps/AppsController;

.field public final synthetic f$1:I

.field public final synthetic f$2:Ljava/lang/ref/WeakReference;

.field public final synthetic f$3:Ljava/lang/String;

.field public final synthetic f$4:Landroid/graphics/drawable/Drawable;


# direct methods
.method public synthetic constructor <init>(Lcom/gmhub/apps/AppsController;ILjava/lang/ref/WeakReference;Ljava/lang/String;Landroid/graphics/drawable/Drawable;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/gmhub/apps/AppsController$$ExternalSyntheticLambda3;->f$0:Lcom/gmhub/apps/AppsController;

    iput p2, p0, Lcom/gmhub/apps/AppsController$$ExternalSyntheticLambda3;->f$1:I

    iput-object p3, p0, Lcom/gmhub/apps/AppsController$$ExternalSyntheticLambda3;->f$2:Ljava/lang/ref/WeakReference;

    iput-object p4, p0, Lcom/gmhub/apps/AppsController$$ExternalSyntheticLambda3;->f$3:Ljava/lang/String;

    iput-object p5, p0, Lcom/gmhub/apps/AppsController$$ExternalSyntheticLambda3;->f$4:Landroid/graphics/drawable/Drawable;

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 4

    iget-object v0, p0, Lcom/gmhub/apps/AppsController$$ExternalSyntheticLambda3;->f$0:Lcom/gmhub/apps/AppsController;

    iget v1, p0, Lcom/gmhub/apps/AppsController$$ExternalSyntheticLambda3;->f$1:I

    iget-object v2, p0, Lcom/gmhub/apps/AppsController$$ExternalSyntheticLambda3;->f$2:Ljava/lang/ref/WeakReference;

    iget-object v3, p0, Lcom/gmhub/apps/AppsController$$ExternalSyntheticLambda3;->f$3:Ljava/lang/String;

    iget-object p0, p0, Lcom/gmhub/apps/AppsController$$ExternalSyntheticLambda3;->f$4:Landroid/graphics/drawable/Drawable;

    invoke-virtual {v0, v1, v2, v3, p0}, Lcom/gmhub/apps/AppsController;->lambda$bindIcon$1$com-gmhub-apps-AppsController(ILjava/lang/ref/WeakReference;Ljava/lang/String;Landroid/graphics/drawable/Drawable;)V

    return-void
.end method
