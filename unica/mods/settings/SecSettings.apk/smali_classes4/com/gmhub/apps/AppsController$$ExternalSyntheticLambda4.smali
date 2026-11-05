.class public final synthetic Lcom/gmhub/apps/AppsController$$ExternalSyntheticLambda4;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/util/Comparator;


# instance fields
.field public final synthetic f$0:Ljava/text/Collator;


# direct methods
.method public synthetic constructor <init>(Ljava/text/Collator;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/gmhub/apps/AppsController$$ExternalSyntheticLambda4;->f$0:Ljava/text/Collator;

    return-void
.end method


# virtual methods
.method public final compare(Ljava/lang/Object;Ljava/lang/Object;)I
    .locals 0

    iget-object p0, p0, Lcom/gmhub/apps/AppsController$$ExternalSyntheticLambda4;->f$0:Ljava/text/Collator;

    check-cast p1, Lcom/gmhub/apps/AppsController$Row;

    check-cast p2, Lcom/gmhub/apps/AppsController$Row;

    invoke-static {p0, p1, p2}, Lcom/gmhub/apps/AppsController;->lambda$reload$1(Ljava/text/Collator;Lcom/gmhub/apps/AppsController$Row;Lcom/gmhub/apps/AppsController$Row;)I

    move-result p0

    return p0
.end method
