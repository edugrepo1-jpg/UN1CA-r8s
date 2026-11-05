.class public final Lcom/gmhub/monitor/MemoryReader$Snapshot;
.super Ljava/lang/Object;
.source "MemoryReader.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/gmhub/monitor/MemoryReader;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Snapshot"
.end annotation


# instance fields
.field public final activeBytes:Ljava/lang/Long;

.field public final cachedBytes:Ljava/lang/Long;

.field public final swapTotalBytes:Ljava/lang/Long;

.field public final swapUsedBytes:Ljava/lang/Long;

.field public final totalBytes:Ljava/lang/Long;

.field public final usedBytes:Ljava/lang/Long;

.field public final zramCapacityBytes:Ljava/lang/Long;

.field public final zramLogicalBytes:Ljava/lang/Long;

.field public final zramRamBytes:Ljava/lang/Long;


# direct methods
.method constructor <init>(Ljava/util/Map;[Ljava/lang/Long;)V
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Long;",
            ">;[",
            "Ljava/lang/Long;",
            ")V"
        }
    .end annotation

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const-string v0, "MemTotal"

    invoke-interface {p1, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Long;

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Ljava/lang/Long;->longValue()J

    move-result-wide v1

    const-wide/16 v3, 0x0

    cmp-long v1, v1, v3

    if-nez v1, :cond_1

    :cond_0
    const/4 v0, 0x0

    :cond_1
    iput-object v0, p0, Lcom/gmhub/monitor/MemoryReader$Snapshot;->totalBytes:Ljava/lang/Long;

    const-string v1, "MemAvailable"

    invoke-interface {p1, v1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Long;

    invoke-static {v0, v1}, Lcom/gmhub/monitor/MemoryReader;->access$000(Ljava/lang/Long;Ljava/lang/Long;)Ljava/lang/Long;

    move-result-object v0

    iput-object v0, p0, Lcom/gmhub/monitor/MemoryReader$Snapshot;->usedBytes:Ljava/lang/Long;

    const-string v0, "Active"

    invoke-interface {p1, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Long;

    iput-object v0, p0, Lcom/gmhub/monitor/MemoryReader$Snapshot;->activeBytes:Ljava/lang/Long;

    const-string v0, "Cached"

    invoke-interface {p1, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Long;

    iput-object v0, p0, Lcom/gmhub/monitor/MemoryReader$Snapshot;->cachedBytes:Ljava/lang/Long;

    const-string v0, "SwapTotal"

    invoke-interface {p1, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Long;

    iput-object v0, p0, Lcom/gmhub/monitor/MemoryReader$Snapshot;->swapTotalBytes:Ljava/lang/Long;

    const-string v1, "SwapFree"

    invoke-interface {p1, v1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/Long;

    invoke-static {v0, p1}, Lcom/gmhub/monitor/MemoryReader;->access$000(Ljava/lang/Long;Ljava/lang/Long;)Ljava/lang/Long;

    move-result-object p1

    iput-object p1, p0, Lcom/gmhub/monitor/MemoryReader$Snapshot;->swapUsedBytes:Ljava/lang/Long;

    const/4 p1, 0x0

    aget-object p1, p2, p1

    iput-object p1, p0, Lcom/gmhub/monitor/MemoryReader$Snapshot;->zramLogicalBytes:Ljava/lang/Long;

    const/4 p1, 0x1

    aget-object p1, p2, p1

    iput-object p1, p0, Lcom/gmhub/monitor/MemoryReader$Snapshot;->zramCapacityBytes:Ljava/lang/Long;

    const/4 p1, 0x2

    aget-object p1, p2, p1

    iput-object p1, p0, Lcom/gmhub/monitor/MemoryReader$Snapshot;->zramRamBytes:Ljava/lang/Long;

    return-void
.end method
