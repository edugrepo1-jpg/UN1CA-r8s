.class public final synthetic Lcom/gmhub/theme/PureBlackControl$$ExternalSyntheticLambda0;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field public final synthetic f$0:Z

.field public final synthetic f$1:Z

.field public final synthetic f$2:Ljava/lang/Boolean;

.field public final synthetic f$3:Ljava/lang/Exception;

.field public final synthetic f$4:Landroid/content/Context;


# direct methods
.method public synthetic constructor <init>(ZZLjava/lang/Boolean;Ljava/lang/Exception;Landroid/content/Context;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-boolean p1, p0, Lcom/gmhub/theme/PureBlackControl$$ExternalSyntheticLambda0;->f$0:Z

    iput-boolean p2, p0, Lcom/gmhub/theme/PureBlackControl$$ExternalSyntheticLambda0;->f$1:Z

    iput-object p3, p0, Lcom/gmhub/theme/PureBlackControl$$ExternalSyntheticLambda0;->f$2:Ljava/lang/Boolean;

    iput-object p4, p0, Lcom/gmhub/theme/PureBlackControl$$ExternalSyntheticLambda0;->f$3:Ljava/lang/Exception;

    iput-object p5, p0, Lcom/gmhub/theme/PureBlackControl$$ExternalSyntheticLambda0;->f$4:Landroid/content/Context;

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 4

    iget-boolean v0, p0, Lcom/gmhub/theme/PureBlackControl$$ExternalSyntheticLambda0;->f$0:Z

    iget-boolean v1, p0, Lcom/gmhub/theme/PureBlackControl$$ExternalSyntheticLambda0;->f$1:Z

    iget-object v2, p0, Lcom/gmhub/theme/PureBlackControl$$ExternalSyntheticLambda0;->f$2:Ljava/lang/Boolean;

    iget-object v3, p0, Lcom/gmhub/theme/PureBlackControl$$ExternalSyntheticLambda0;->f$3:Ljava/lang/Exception;

    iget-object p0, p0, Lcom/gmhub/theme/PureBlackControl$$ExternalSyntheticLambda0;->f$4:Landroid/content/Context;

    invoke-static {v0, v1, v2, v3, p0}, Lcom/gmhub/theme/PureBlackControl;->lambda$submit$1(ZZLjava/lang/Boolean;Ljava/lang/Exception;Landroid/content/Context;)V

    return-void
.end method
