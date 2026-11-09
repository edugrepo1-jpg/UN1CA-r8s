.class public final Lcom/gmhub/qs/NativePageNavigation$Pages;
.super Ljava/lang/Object;
.source "NativePageNavigation.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/gmhub/qs/NativePageNavigation;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Pages"
.end annotation


# instance fields
.field public final count:I

.field public final max:I

.field public final selected:I

.field public final viewport:I


# direct methods
.method constructor <init>(III)V
    .locals 6

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput p1, p0, Lcom/gmhub/qs/NativePageNavigation$Pages;->viewport:I

    iput p2, p0, Lcom/gmhub/qs/NativePageNavigation$Pages;->max:I

    if-lez p1, :cond_1

    if-ltz p2, :cond_1

    const v0, 0x7fffffff

    if-ne p2, v0, :cond_0

    goto :goto_0

    :cond_0
    int-to-long v0, p2

    int-to-long p1, p1

    add-long/2addr v0, p1

    const-wide/16 v2, 0x1

    sub-long/2addr v0, v2

    div-long/2addr v0, p1

    add-long/2addr v0, v2

    goto :goto_1

    :cond_1
    :goto_0
    const-wide/16 v0, 0x0

    :goto_1
    const-wide/16 p1, 0x20

    cmp-long p1, v0, p1

    const/4 p2, 0x0

    if-lez p1, :cond_2

    move p1, p2

    goto :goto_2

    :cond_2
    long-to-int p1, v0

    :goto_2
    iput p1, p0, Lcom/gmhub/qs/NativePageNavigation$Pages;->count:I

    const-wide v0, 0x7fffffffffffffffL

    move p1, p2

    :goto_3
    iget v2, p0, Lcom/gmhub/qs/NativePageNavigation$Pages;->count:I

    if-ge p2, v2, :cond_4

    invoke-virtual {p0, p2}, Lcom/gmhub/qs/NativePageNavigation$Pages;->target(I)I

    move-result v2

    int-to-long v2, v2

    int-to-long v4, p3

    sub-long/2addr v2, v4

    invoke-static {v2, v3}, Ljava/lang/Math;->abs(J)J

    move-result-wide v2

    cmp-long v4, v2, v0

    if-gez v4, :cond_3

    move p1, p2

    move-wide v0, v2

    :cond_3
    add-int/lit8 p2, p2, 0x1

    goto :goto_3

    :cond_4
    iput p1, p0, Lcom/gmhub/qs/NativePageNavigation$Pages;->selected:I

    return-void
.end method


# virtual methods
.method public equals(Ljava/lang/Object;)Z
    .locals 3

    instance-of v0, p1, Lcom/gmhub/qs/NativePageNavigation$Pages;

    const/4 v1, 0x0

    if-nez v0, :cond_0

    return v1

    :cond_0
    check-cast p1, Lcom/gmhub/qs/NativePageNavigation$Pages;

    iget v0, p0, Lcom/gmhub/qs/NativePageNavigation$Pages;->viewport:I

    iget v2, p1, Lcom/gmhub/qs/NativePageNavigation$Pages;->viewport:I

    if-ne v0, v2, :cond_1

    iget v0, p0, Lcom/gmhub/qs/NativePageNavigation$Pages;->max:I

    iget v2, p1, Lcom/gmhub/qs/NativePageNavigation$Pages;->max:I

    if-ne v0, v2, :cond_1

    iget v0, p0, Lcom/gmhub/qs/NativePageNavigation$Pages;->count:I

    iget v2, p1, Lcom/gmhub/qs/NativePageNavigation$Pages;->count:I

    if-ne v0, v2, :cond_1

    iget p0, p0, Lcom/gmhub/qs/NativePageNavigation$Pages;->selected:I

    iget p1, p1, Lcom/gmhub/qs/NativePageNavigation$Pages;->selected:I

    if-ne p0, p1, :cond_1

    const/4 p0, 0x1

    return p0

    :cond_1
    return v1
.end method

.method public hashCode()I
    .locals 2

    iget v0, p0, Lcom/gmhub/qs/NativePageNavigation$Pages;->viewport:I

    mul-int/lit8 v0, v0, 0x1f

    iget v1, p0, Lcom/gmhub/qs/NativePageNavigation$Pages;->max:I

    add-int/2addr v0, v1

    mul-int/lit8 v0, v0, 0x1f

    iget v1, p0, Lcom/gmhub/qs/NativePageNavigation$Pages;->count:I

    add-int/2addr v0, v1

    mul-int/lit8 v0, v0, 0x1f

    iget p0, p0, Lcom/gmhub/qs/NativePageNavigation$Pages;->selected:I

    add-int/2addr v0, p0

    return v0
.end method

.method public target(I)I
    .locals 4

    if-ltz p1, :cond_0

    iget v0, p0, Lcom/gmhub/qs/NativePageNavigation$Pages;->count:I

    if-ge p1, v0, :cond_0

    int-to-long v0, p1

    iget p1, p0, Lcom/gmhub/qs/NativePageNavigation$Pages;->viewport:I

    int-to-long v2, p1

    mul-long/2addr v0, v2

    iget p0, p0, Lcom/gmhub/qs/NativePageNavigation$Pages;->max:I

    int-to-long p0, p0

    invoke-static {v0, v1, p0, p1}, Ljava/lang/Math;->min(JJ)J

    move-result-wide p0

    long-to-int p0, p0

    return p0

    :cond_0
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string p1, "Unknown native viewport"

    invoke-direct {p0, p1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0
.end method
