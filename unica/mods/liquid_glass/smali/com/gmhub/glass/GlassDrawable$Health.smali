.class final Lcom/gmhub/glass/GlassDrawable$Health;
.super Ljava/lang/Object;
.source "GlassDrawable.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/gmhub/glass/GlassDrawable;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = "Health"
.end annotation


# static fields
.field private static final RETRY_DELAY_MS:J = 0x3a98L


# instance fields
.field private final incompatible:[Z

.field private final logged:[Z

.field private final retryAt:[J


# direct methods
.method constructor <init>()V
    .locals 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x4

    new-array v1, v0, [Z

    iput-object v1, p0, Lcom/gmhub/glass/GlassDrawable$Health;->incompatible:[Z

    new-array v1, v0, [Z

    iput-object v1, p0, Lcom/gmhub/glass/GlassDrawable$Health;->logged:[Z

    new-array v0, v0, [J

    iput-object v0, p0, Lcom/gmhub/glass/GlassDrawable$Health;->retryAt:[J

    return-void
.end method


# virtual methods
.method declared-synchronized available(IJ)Z
    .locals 3

    monitor-enter p0

    const/4 v0, 0x1

    if-lt p1, v0, :cond_0

    const/4 v1, 0x3

    if-gt p1, v1, :cond_0

    const-wide/16 v1, 0x0

    cmp-long v1, p2, v1

    if-ltz v1, :cond_0

    :try_start_0
    iget-object v1, p0, Lcom/gmhub/glass/GlassDrawable$Health;->incompatible:[Z

    aget-boolean v1, v1, p1

    if-nez v1, :cond_0

    iget-object v1, p0, Lcom/gmhub/glass/GlassDrawable$Health;->retryAt:[J

    aget-wide v1, v1, p1

    cmp-long p1, p2, v1

    if-ltz p1, :cond_0

    goto :goto_0

    :catchall_0
    move-exception p1

    monitor-exit p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw p1

    :cond_0
    const/4 v0, 0x0

    :goto_0
    monitor-exit p0

    return v0
.end method

.method declared-synchronized record(IJZ)Z
    .locals 3

    monitor-enter p0

    const/4 v0, 0x1

    if-lt p1, v0, :cond_1

    const/4 v1, 0x3

    if-gt p1, v1, :cond_1

    :try_start_0
    iget-object v1, p0, Lcom/gmhub/glass/GlassDrawable$Health;->incompatible:[Z

    aget-boolean v2, v1, p1

    or-int/2addr p4, v2

    aput-boolean p4, v1, p1

    const-wide/16 v1, 0x0

    invoke-static {v1, v2, p2, p3}, Ljava/lang/Math;->max(JJ)J

    move-result-wide p2

    iget-object p4, p0, Lcom/gmhub/glass/GlassDrawable$Health;->retryAt:[J

    const-wide v1, 0x7fffffffffffc567L

    cmp-long v1, p2, v1

    if-lez v1, :cond_0

    const-wide p2, 0x7fffffffffffffffL

    goto :goto_0

    :cond_0
    const-wide/16 v1, 0x3a98

    add-long/2addr p2, v1

    :goto_0
    aput-wide p2, p4, p1

    iget-object p2, p0, Lcom/gmhub/glass/GlassDrawable$Health;->logged:[Z

    aget-boolean p3, p2, p1

    xor-int/2addr p3, v0

    aput-boolean v0, p2, p1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return p3

    :cond_1
    :try_start_1
    new-instance p1, Ljava/lang/IllegalArgumentException;

    const-string p2, "Invalid glass engine"

    invoke-direct {p1, p2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p1

    :catchall_0
    move-exception p1

    monitor-exit p0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw p1
.end method
