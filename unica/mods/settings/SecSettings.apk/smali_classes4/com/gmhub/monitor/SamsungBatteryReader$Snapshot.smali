.class public final Lcom/gmhub/monitor/SamsungBatteryReader$Snapshot;
.super Ljava/lang/Object;
.source "SamsungBatteryReader.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/gmhub/monitor/SamsungBatteryReader;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Snapshot"
.end annotation


# instance fields
.field public final asocPercent:Ljava/lang/Integer;

.field public final cycles:Ljava/lang/Integer;

.field public final fullCapacityMah:Ljava/lang/Integer;


# direct methods
.method constructor <init>(Ljava/lang/Integer;Ljava/lang/Integer;Ljava/lang/Integer;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/gmhub/monitor/SamsungBatteryReader$Snapshot;->fullCapacityMah:Ljava/lang/Integer;

    iput-object p2, p0, Lcom/gmhub/monitor/SamsungBatteryReader$Snapshot;->cycles:Ljava/lang/Integer;

    iput-object p3, p0, Lcom/gmhub/monitor/SamsungBatteryReader$Snapshot;->asocPercent:Ljava/lang/Integer;

    return-void
.end method
