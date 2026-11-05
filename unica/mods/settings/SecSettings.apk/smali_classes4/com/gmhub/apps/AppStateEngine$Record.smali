.class public final Lcom/gmhub/apps/AppStateEngine$Record;
.super Ljava/lang/Object;
.source "AppStateEngine.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/gmhub/apps/AppStateEngine;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Record"
.end annotation


# instance fields
.field public final applied:I

.field public final original:I


# direct methods
.method public constructor <init>(II)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    invoke-static {p1}, Lcom/gmhub/apps/AppStateEngine;->access$000(I)V

    invoke-static {p2}, Lcom/gmhub/apps/AppStateEngine;->access$000(I)V

    iput p1, p0, Lcom/gmhub/apps/AppStateEngine$Record;->original:I

    iput p2, p0, Lcom/gmhub/apps/AppStateEngine$Record;->applied:I

    return-void
.end method

.method public static decode(Ljava/lang/String;)Lcom/gmhub/apps/AppStateEngine$Record;
    .locals 3

    if-eqz p0, :cond_0

    const-string v0, "[0-4]:[0-4]"

    invoke-virtual {p0, v0}, Ljava/lang/String;->matches(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    new-instance v0, Lcom/gmhub/apps/AppStateEngine$Record;

    const/4 v1, 0x0

    invoke-virtual {p0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v1

    add-int/lit8 v1, v1, -0x30

    const/4 v2, 0x2

    invoke-virtual {p0, v2}, Ljava/lang/String;->charAt(I)C

    move-result p0

    add-int/lit8 p0, p0, -0x30

    invoke-direct {v0, v1, p0}, Lcom/gmhub/apps/AppStateEngine$Record;-><init>(II)V

    return-object v0

    :cond_0
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string v0, "Invalid app-state journal"

    invoke-direct {p0, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0
.end method


# virtual methods
.method public encode()Ljava/lang/String;
    .locals 2

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget v1, p0, Lcom/gmhub/apps/AppStateEngine$Record;->original:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, ":"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget p0, p0, Lcom/gmhub/apps/AppStateEngine$Record;->applied:I

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method
