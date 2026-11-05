.class public final synthetic Lcom/gmhub/profiles/ProfileController$$ExternalSyntheticLambda1;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field public final synthetic f$0:Lcom/gmhub/profiles/ProfileController;

.field public final synthetic f$1:Ljava/lang/String;

.field public final synthetic f$2:Ljava/lang/String;

.field public final synthetic f$3:Z

.field public final synthetic f$4:Ljava/lang/String;

.field public final synthetic f$5:Ljava/lang/String;


# direct methods
.method public synthetic constructor <init>(Lcom/gmhub/profiles/ProfileController;Ljava/lang/String;Ljava/lang/String;ZLjava/lang/String;Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/gmhub/profiles/ProfileController$$ExternalSyntheticLambda1;->f$0:Lcom/gmhub/profiles/ProfileController;

    iput-object p2, p0, Lcom/gmhub/profiles/ProfileController$$ExternalSyntheticLambda1;->f$1:Ljava/lang/String;

    iput-object p3, p0, Lcom/gmhub/profiles/ProfileController$$ExternalSyntheticLambda1;->f$2:Ljava/lang/String;

    iput-boolean p4, p0, Lcom/gmhub/profiles/ProfileController$$ExternalSyntheticLambda1;->f$3:Z

    iput-object p5, p0, Lcom/gmhub/profiles/ProfileController$$ExternalSyntheticLambda1;->f$4:Ljava/lang/String;

    iput-object p6, p0, Lcom/gmhub/profiles/ProfileController$$ExternalSyntheticLambda1;->f$5:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 6

    iget-object v0, p0, Lcom/gmhub/profiles/ProfileController$$ExternalSyntheticLambda1;->f$0:Lcom/gmhub/profiles/ProfileController;

    iget-object v1, p0, Lcom/gmhub/profiles/ProfileController$$ExternalSyntheticLambda1;->f$1:Ljava/lang/String;

    iget-object v2, p0, Lcom/gmhub/profiles/ProfileController$$ExternalSyntheticLambda1;->f$2:Ljava/lang/String;

    iget-boolean v3, p0, Lcom/gmhub/profiles/ProfileController$$ExternalSyntheticLambda1;->f$3:Z

    iget-object v4, p0, Lcom/gmhub/profiles/ProfileController$$ExternalSyntheticLambda1;->f$4:Ljava/lang/String;

    iget-object v5, p0, Lcom/gmhub/profiles/ProfileController$$ExternalSyntheticLambda1;->f$5:Ljava/lang/String;

    invoke-virtual/range {v0 .. v5}, Lcom/gmhub/profiles/ProfileController;->lambda$execute$1$com-gmhub-profiles-ProfileController(Ljava/lang/String;Ljava/lang/String;ZLjava/lang/String;Ljava/lang/String;)V

    return-void
.end method
