.class public final synthetic Lcom/gmhub/theme/PureBlackControl$$ExternalSyntheticLambda1;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field public final synthetic f$0:Landroid/content/Context;

.field public final synthetic f$1:Ljava/lang/Boolean;


# direct methods
.method public synthetic constructor <init>(Landroid/content/Context;Ljava/lang/Boolean;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/gmhub/theme/PureBlackControl$$ExternalSyntheticLambda1;->f$0:Landroid/content/Context;

    iput-object p2, p0, Lcom/gmhub/theme/PureBlackControl$$ExternalSyntheticLambda1;->f$1:Ljava/lang/Boolean;

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 1

    iget-object v0, p0, Lcom/gmhub/theme/PureBlackControl$$ExternalSyntheticLambda1;->f$0:Landroid/content/Context;

    iget-object p0, p0, Lcom/gmhub/theme/PureBlackControl$$ExternalSyntheticLambda1;->f$1:Ljava/lang/Boolean;

    invoke-static {v0, p0}, Lcom/gmhub/theme/PureBlackControl;->lambda$submit$0(Landroid/content/Context;Ljava/lang/Boolean;)V

    return-void
.end method
