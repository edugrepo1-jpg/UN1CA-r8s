.class public final Lcom/gmhub/monitor/ResourceController;
.super Ljava/lang/Object;
.source "ResourceController.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/gmhub/monitor/ResourceController$Host;,
        Lcom/gmhub/monitor/ResourceController$Row;
    }
.end annotation


# instance fields
.field private active:Z

.field private final battery:Z

.field private closed:Z

.field private final context:Landroid/content/Context;

.field private gauge:Lcom/gmhub/monitor/SamsungBatteryReader$Snapshot;

.field private gaugeEpoch:I

.field private generation:I

.field private final host:Lcom/gmhub/monitor/ResourceController$Host;

.field private final main:Landroid/os/Handler;

.field private nextGaugeRead:J

.field private pending:Ljava/util/concurrent/Future;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/concurrent/Future<",
            "*>;"
        }
    .end annotation
.end field

.field private final shown:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Lcom/gmhub/monitor/ResourceController$Row;",
            ">;"
        }
    .end annotation
.end field

.field private final tick:Ljava/lang/Runnable;

.field private final worker:Ljava/util/concurrent/ExecutorService;


# direct methods
.method public constructor <init>(Lcom/gmhub/monitor/ResourceController$Host;Z)V
    .locals 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    iput-object v0, p0, Lcom/gmhub/monitor/ResourceController;->main:Landroid/os/Handler;

    invoke-static {}, Ljava/util/concurrent/Executors;->newSingleThreadExecutor()Ljava/util/concurrent/ExecutorService;

    move-result-object v0

    iput-object v0, p0, Lcom/gmhub/monitor/ResourceController;->worker:Ljava/util/concurrent/ExecutorService;

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/gmhub/monitor/ResourceController;->shown:Ljava/util/Map;

    const/4 v0, -0x1

    iput v0, p0, Lcom/gmhub/monitor/ResourceController;->gaugeEpoch:I

    new-instance v0, Lcom/gmhub/monitor/ResourceController$$ExternalSyntheticLambda1;

    invoke-direct {v0, p0}, Lcom/gmhub/monitor/ResourceController$$ExternalSyntheticLambda1;-><init>(Lcom/gmhub/monitor/ResourceController;)V

    iput-object v0, p0, Lcom/gmhub/monitor/ResourceController;->tick:Ljava/lang/Runnable;

    iput-object p1, p0, Lcom/gmhub/monitor/ResourceController;->host:Lcom/gmhub/monitor/ResourceController$Host;

    invoke-interface {p1}, Lcom/gmhub/monitor/ResourceController$Host;->context()Landroid/content/Context;

    move-result-object p1

    iput-object p1, p0, Lcom/gmhub/monitor/ResourceController;->context:Landroid/content/Context;

    iput-boolean p2, p0, Lcom/gmhub/monitor/ResourceController;->battery:Z

    return-void
.end method

.method private battery(I)Ljava/util/Map;
    .locals 11
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(I)",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Lcom/gmhub/monitor/ResourceController$Row;",
            ">;"
        }
    .end annotation

    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v0

    iget-object v2, p0, Lcom/gmhub/monitor/ResourceController;->gauge:Lcom/gmhub/monitor/SamsungBatteryReader$Snapshot;

    if-eqz v2, :cond_0

    iget v2, p0, Lcom/gmhub/monitor/ResourceController;->gaugeEpoch:I

    if-ne v2, p1, :cond_0

    iget-wide v2, p0, Lcom/gmhub/monitor/ResourceController;->nextGaugeRead:J

    cmp-long v2, v0, v2

    if-ltz v2, :cond_1

    :cond_0
    new-instance v2, Ljava/io/File;

    const-string v3, "/sys/class/power_supply/battery"

    invoke-direct {v2, v3}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-static {v2}, Lcom/gmhub/monitor/SamsungBatteryReader;->read(Ljava/io/File;)Lcom/gmhub/monitor/SamsungBatteryReader$Snapshot;

    move-result-object v2

    iput-object v2, p0, Lcom/gmhub/monitor/ResourceController;->gauge:Lcom/gmhub/monitor/SamsungBatteryReader$Snapshot;

    iput p1, p0, Lcom/gmhub/monitor/ResourceController;->gaugeEpoch:I

    const-wide/16 v2, 0x7530

    add-long/2addr v0, v2

    iput-wide v0, p0, Lcom/gmhub/monitor/ResourceController;->nextGaugeRead:J

    :cond_1
    iget-object p1, p0, Lcom/gmhub/monitor/ResourceController;->context:Landroid/content/Context;

    const-class v0, Landroid/os/BatteryManager;

    invoke-virtual {p1, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Landroid/os/BatteryManager;

    const/4 v0, 0x0

    :try_start_0
    iget-object v1, p0, Lcom/gmhub/monitor/ResourceController;->context:Landroid/content/Context;

    new-instance v2, Landroid/content/IntentFilter;

    const-string v3, "android.intent.action.BATTERY_CHANGED"

    invoke-direct {v2, v3}, Landroid/content/IntentFilter;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, v0, v2}, Landroid/content/Context;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    iget-object v1, p0, Lcom/gmhub/monitor/ResourceController;->context:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/res/Configuration;->getLocales()Landroid/os/LocaleList;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Landroid/os/LocaleList;->get(I)Ljava/util/Locale;

    move-result-object v1

    const-string v2, "gm_resource_unavailable"

    invoke-direct {p0, v2}, Lcom/gmhub/monitor/ResourceController;->text(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x2

    invoke-direct {p0, p1, v4}, Lcom/gmhub/monitor/ResourceController;->property(Landroid/os/BatteryManager;I)I

    move-result v5

    invoke-static {v5, v1, v3}, Lcom/gmhub/monitor/BatteryUnits;->current(ILjava/util/Locale;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    const/4 v6, 0x1

    if-nez v0, :cond_2

    move v7, v6

    goto :goto_0

    :cond_2
    const-string v7, "status"

    invoke-virtual {v0, v7, v6}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result v7

    :goto_0
    if-eq v7, v4, :cond_6

    const/4 v4, 0x3

    if-eq v7, v4, :cond_5

    const/4 v4, 0x4

    if-eq v7, v4, :cond_4

    const/4 v4, 0x5

    if-eq v7, v4, :cond_3

    move-object v4, v2

    goto :goto_1

    :cond_3
    const-string v4, "gm_battery_full"

    goto :goto_1

    :cond_4
    const-string v4, "gm_battery_paused"

    goto :goto_1

    :cond_5
    const-string v4, "gm_battery_discharging"

    goto :goto_1

    :cond_6
    const-string v4, "gm_battery_charging"

    :goto_1
    if-nez v0, :cond_7

    move v7, v6

    goto :goto_2

    :cond_7
    const-string v7, "health"

    invoke-virtual {v0, v7, v6}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result v7

    :goto_2
    packed-switch v7, :pswitch_data_0

    goto :goto_3

    :pswitch_0
    const-string v2, "gm_battery_health_cold"

    goto :goto_3

    :pswitch_1
    const-string v2, "gm_battery_health_failure"

    goto :goto_3

    :pswitch_2
    const-string v2, "gm_battery_health_voltage"

    goto :goto_3

    :pswitch_3
    const-string v2, "gm_battery_health_dead"

    goto :goto_3

    :pswitch_4
    const-string v2, "gm_battery_health_hot"

    goto :goto_3

    :pswitch_5
    const-string v2, "gm_battery_health_good"

    :goto_3
    const-string v7, "%d"

    if-eqz v0, :cond_8

    const-string v8, "android.os.extra.CYCLE_COUNT"

    invoke-virtual {v0, v8}, Landroid/content/Intent;->hasExtra(Ljava/lang/String;)Z

    move-result v9

    if-eqz v9, :cond_8

    const/4 v9, -0x1

    invoke-virtual {v0, v8, v9}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result v0

    if-ltz v0, :cond_8

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    invoke-static {v1, v7, v0}, Ljava/lang/String;->format(Ljava/util/Locale;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    goto :goto_4

    :cond_8
    move-object v0, v3

    :goto_4
    invoke-virtual {v0, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v8

    if-eqz v8, :cond_9

    iget-object v8, p0, Lcom/gmhub/monitor/ResourceController;->gauge:Lcom/gmhub/monitor/SamsungBatteryReader$Snapshot;

    iget-object v8, v8, Lcom/gmhub/monitor/SamsungBatteryReader$Snapshot;->cycles:Ljava/lang/Integer;

    if-eqz v8, :cond_9

    iget-object v0, p0, Lcom/gmhub/monitor/ResourceController;->gauge:Lcom/gmhub/monitor/SamsungBatteryReader$Snapshot;

    iget-object v0, v0, Lcom/gmhub/monitor/SamsungBatteryReader$Snapshot;->cycles:Ljava/lang/Integer;

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    invoke-static {v1, v7, v0}, Ljava/lang/String;->format(Ljava/util/Locale;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    :cond_9
    new-instance v7, Ljava/util/LinkedHashMap;

    invoke-direct {v7}, Ljava/util/LinkedHashMap;-><init>()V

    new-instance v8, Lcom/gmhub/monitor/ResourceController$Row;

    const-string v9, "gm_battery_current"

    invoke-direct {p0, v9}, Lcom/gmhub/monitor/ResourceController;->text(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v9

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v10, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v5, " \u00b7 "

    invoke-virtual {v10, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-direct {p0, v4}, Lcom/gmhub/monitor/ResourceController;->text(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v10, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-direct {v8, v9, v4}, Lcom/gmhub/monitor/ResourceController$Row;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    const-string v4, "bat_current"

    invoke-interface {v7, v4, v8}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v4, Lcom/gmhub/monitor/ResourceController$Row;

    const-string v5, "gm_battery_full_capacity"

    invoke-direct {p0, v5}, Lcom/gmhub/monitor/ResourceController;->text(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    iget-object v8, p0, Lcom/gmhub/monitor/ResourceController;->gauge:Lcom/gmhub/monitor/SamsungBatteryReader$Snapshot;

    iget-object v8, v8, Lcom/gmhub/monitor/SamsungBatteryReader$Snapshot;->fullCapacityMah:Ljava/lang/Integer;

    if-nez v8, :cond_a

    move-object v8, v3

    goto :goto_5

    :cond_a
    iget-object v8, p0, Lcom/gmhub/monitor/ResourceController;->gauge:Lcom/gmhub/monitor/SamsungBatteryReader$Snapshot;

    iget-object v8, v8, Lcom/gmhub/monitor/SamsungBatteryReader$Snapshot;->fullCapacityMah:Ljava/lang/Integer;

    filled-new-array {v8}, [Ljava/lang/Object;

    move-result-object v8

    const-string v9, "%d mAh"

    invoke-static {v1, v9, v8}, Ljava/lang/String;->format(Ljava/util/Locale;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v8

    :goto_5
    invoke-direct {v4, v5, v8}, Lcom/gmhub/monitor/ResourceController$Row;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    const-string v5, "bat_capacity"

    invoke-interface {v7, v5, v4}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v4, Lcom/gmhub/monitor/ResourceController$Row;

    const-string v5, "gm_battery_cycles"

    invoke-direct {p0, v5}, Lcom/gmhub/monitor/ResourceController;->text(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    invoke-direct {v4, v5, v0}, Lcom/gmhub/monitor/ResourceController$Row;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "bat_cycles"

    invoke-interface {v7, v0, v4}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v0, Lcom/gmhub/monitor/ResourceController$Row;

    const-string v4, "gm_battery_asoc"

    invoke-direct {p0, v4}, Lcom/gmhub/monitor/ResourceController;->text(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    iget-object v5, p0, Lcom/gmhub/monitor/ResourceController;->gauge:Lcom/gmhub/monitor/SamsungBatteryReader$Snapshot;

    iget-object v5, v5, Lcom/gmhub/monitor/SamsungBatteryReader$Snapshot;->asocPercent:Ljava/lang/Integer;

    if-nez v5, :cond_b

    move-object v5, v3

    goto :goto_6

    :cond_b
    iget-object v5, p0, Lcom/gmhub/monitor/ResourceController;->gauge:Lcom/gmhub/monitor/SamsungBatteryReader$Snapshot;

    iget-object v5, v5, Lcom/gmhub/monitor/SamsungBatteryReader$Snapshot;->asocPercent:Ljava/lang/Integer;

    filled-new-array {v5}, [Ljava/lang/Object;

    move-result-object v5

    const-string v8, "%d%%"

    invoke-static {v1, v8, v5}, Ljava/lang/String;->format(Ljava/util/Locale;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    :goto_6
    invoke-direct {v0, v4, v5}, Lcom/gmhub/monitor/ResourceController$Row;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    const-string v4, "bat_health"

    invoke-interface {v7, v4, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v0, Lcom/gmhub/monitor/ResourceController$Row;

    const-string v4, "gm_battery_remaining_charge"

    invoke-direct {p0, v4}, Lcom/gmhub/monitor/ResourceController;->text(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-direct {p0, p1, v6}, Lcom/gmhub/monitor/ResourceController;->property(Landroid/os/BatteryManager;I)I

    move-result p1

    invoke-static {p1, v1, v3}, Lcom/gmhub/monitor/BatteryUnits;->charge(ILjava/util/Locale;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-direct {v0, v4, p1}, Lcom/gmhub/monitor/ResourceController$Row;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    const-string p1, "gm_battery_charge_remaining"

    invoke-interface {v7, p1, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    new-instance p1, Lcom/gmhub/monitor/ResourceController$Row;

    const-string v0, "gm_battery_health_status"

    invoke-direct {p0, v0}, Lcom/gmhub/monitor/ResourceController;->text(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v2}, Lcom/gmhub/monitor/ResourceController;->text(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    invoke-direct {p1, v0, p0}, Lcom/gmhub/monitor/ResourceController$Row;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    const-string p0, "gm_battery_condition"

    invoke-interface {v7, p0, p1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-object v7

    nop

    :pswitch_data_0
    .packed-switch 0x2
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method private bytes(Ljava/lang/Long;)Ljava/lang/String;
    .locals 2

    if-nez p1, :cond_0

    const-string p1, "gm_resource_unavailable"

    invoke-direct {p0, p1}, Lcom/gmhub/monitor/ResourceController;->text(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    return-object p0

    :cond_0
    iget-object p0, p0, Lcom/gmhub/monitor/ResourceController;->context:Landroid/content/Context;

    invoke-virtual {p1}, Ljava/lang/Long;->longValue()J

    move-result-wide v0

    invoke-static {p0, v0, v1}, Landroid/text/format/Formatter;->formatFileSize(Landroid/content/Context;J)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method private memory()Ljava/util/Map;
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Lcom/gmhub/monitor/ResourceController$Row;",
            ">;"
        }
    .end annotation

    new-instance v0, Ljava/io/File;

    const-string v1, "/proc/meminfo"

    invoke-direct {v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    new-instance v1, Ljava/io/File;

    const-string v2, "/sys/block"

    invoke-direct {v1, v2}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-static {v0, v1}, Lcom/gmhub/monitor/MemoryReader;->read(Ljava/io/File;Ljava/io/File;)Lcom/gmhub/monitor/MemoryReader$Snapshot;

    move-result-object v0

    new-instance v1, Ljava/util/LinkedHashMap;

    invoke-direct {v1}, Ljava/util/LinkedHashMap;-><init>()V

    new-instance v2, Lcom/gmhub/monitor/ResourceController$Row;

    const-string v3, "gm_resource_ram"

    invoke-direct {p0, v3}, Lcom/gmhub/monitor/ResourceController;->text(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    iget-object v4, v0, Lcom/gmhub/monitor/MemoryReader$Snapshot;->usedBytes:Ljava/lang/Long;

    iget-object v5, v0, Lcom/gmhub/monitor/MemoryReader$Snapshot;->totalBytes:Ljava/lang/Long;

    invoke-direct {p0, v4, v5}, Lcom/gmhub/monitor/ResourceController;->pair(Ljava/lang/Long;Ljava/lang/Long;)Ljava/lang/String;

    move-result-object v4

    invoke-direct {v2, v3, v4}, Lcom/gmhub/monitor/ResourceController$Row;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    const-string v3, "ram_monitor"

    invoke-interface {v1, v3, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v2, Lcom/gmhub/monitor/ResourceController$Row;

    const-string v3, "gm_resource_active"

    invoke-direct {p0, v3}, Lcom/gmhub/monitor/ResourceController;->text(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    iget-object v4, v0, Lcom/gmhub/monitor/MemoryReader$Snapshot;->activeBytes:Ljava/lang/Long;

    invoke-direct {p0, v4}, Lcom/gmhub/monitor/ResourceController;->bytes(Ljava/lang/Long;)Ljava/lang/String;

    move-result-object v4

    invoke-direct {v2, v3, v4}, Lcom/gmhub/monitor/ResourceController$Row;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    const-string v3, "active_monitor"

    invoke-interface {v1, v3, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v2, Lcom/gmhub/monitor/ResourceController$Row;

    const-string v3, "gm_resource_cached"

    invoke-direct {p0, v3}, Lcom/gmhub/monitor/ResourceController;->text(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    iget-object v4, v0, Lcom/gmhub/monitor/MemoryReader$Snapshot;->cachedBytes:Ljava/lang/Long;

    invoke-direct {p0, v4}, Lcom/gmhub/monitor/ResourceController;->bytes(Ljava/lang/Long;)Ljava/lang/String;

    move-result-object v4

    invoke-direct {v2, v3, v4}, Lcom/gmhub/monitor/ResourceController$Row;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    const-string v3, "cached_monitor"

    invoke-interface {v1, v3, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v2, v0, Lcom/gmhub/monitor/MemoryReader$Snapshot;->zramLogicalBytes:Ljava/lang/Long;

    iget-object v3, v0, Lcom/gmhub/monitor/MemoryReader$Snapshot;->zramCapacityBytes:Ljava/lang/Long;

    invoke-direct {p0, v2, v3}, Lcom/gmhub/monitor/ResourceController;->pair(Ljava/lang/Long;Ljava/lang/Long;)Ljava/lang/String;

    move-result-object v2

    iget-object v3, v0, Lcom/gmhub/monitor/MemoryReader$Snapshot;->zramRamBytes:Ljava/lang/Long;

    if-eqz v3, :cond_0

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, "\n"

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, "gm_resource_zram_ram"

    invoke-direct {p0, v2}, Lcom/gmhub/monitor/ResourceController;->text(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, ": "

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v2, v0, Lcom/gmhub/monitor/MemoryReader$Snapshot;->zramRamBytes:Ljava/lang/Long;

    invoke-direct {p0, v2}, Lcom/gmhub/monitor/ResourceController;->bytes(Ljava/lang/Long;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    :cond_0
    new-instance v3, Lcom/gmhub/monitor/ResourceController$Row;

    const-string v4, "gm_resource_zram"

    invoke-direct {p0, v4}, Lcom/gmhub/monitor/ResourceController;->text(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-direct {v3, v4, v2}, Lcom/gmhub/monitor/ResourceController$Row;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    const-string v2, "zram_monitor"

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v2, Lcom/gmhub/monitor/ResourceController$Row;

    const-string v3, "gm_resource_swap"

    invoke-direct {p0, v3}, Lcom/gmhub/monitor/ResourceController;->text(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    iget-object v4, v0, Lcom/gmhub/monitor/MemoryReader$Snapshot;->swapUsedBytes:Ljava/lang/Long;

    iget-object v0, v0, Lcom/gmhub/monitor/MemoryReader$Snapshot;->swapTotalBytes:Ljava/lang/Long;

    invoke-direct {p0, v4, v0}, Lcom/gmhub/monitor/ResourceController;->pair(Ljava/lang/Long;Ljava/lang/Long;)Ljava/lang/String;

    move-result-object p0

    invoke-direct {v2, v3, p0}, Lcom/gmhub/monitor/ResourceController$Row;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    const-string p0, "gm_swap_monitor"

    invoke-interface {v1, p0, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-object v1
.end method

.method private pair(Ljava/lang/Long;Ljava/lang/Long;)Ljava/lang/String;
    .locals 1

    if-eqz p1, :cond_1

    if-nez p2, :cond_0

    goto :goto_0

    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-direct {p0, p1}, Lcom/gmhub/monitor/ResourceController;->bytes(Ljava/lang/Long;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p1, " / "

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-direct {p0, p2}, Lcom/gmhub/monitor/ResourceController;->bytes(Ljava/lang/Long;)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0

    :cond_1
    :goto_0
    const-string p1, "gm_resource_unavailable"

    invoke-direct {p0, p1}, Lcom/gmhub/monitor/ResourceController;->text(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method private property(Landroid/os/BatteryManager;I)I
    .locals 0

    const/high16 p0, -0x80000000

    if-nez p1, :cond_0

    return p0

    :cond_0
    :try_start_0
    invoke-virtual {p1, p2}, Landroid/os/BatteryManager;->getIntProperty(I)I

    move-result p0
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return p0
.end method

.method private sample()V
    .locals 3

    iget-boolean v0, p0, Lcom/gmhub/monitor/ResourceController;->active:Z

    if-eqz v0, :cond_1

    iget-boolean v0, p0, Lcom/gmhub/monitor/ResourceController;->closed:Z

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    iget v0, p0, Lcom/gmhub/monitor/ResourceController;->generation:I

    iget-object v1, p0, Lcom/gmhub/monitor/ResourceController;->worker:Ljava/util/concurrent/ExecutorService;

    new-instance v2, Lcom/gmhub/monitor/ResourceController$$ExternalSyntheticLambda0;

    invoke-direct {v2, p0, v0}, Lcom/gmhub/monitor/ResourceController$$ExternalSyntheticLambda0;-><init>(Lcom/gmhub/monitor/ResourceController;I)V

    invoke-interface {v1, v2}, Ljava/util/concurrent/ExecutorService;->submit(Ljava/lang/Runnable;)Ljava/util/concurrent/Future;

    move-result-object v0

    iput-object v0, p0, Lcom/gmhub/monitor/ResourceController;->pending:Ljava/util/concurrent/Future;

    :cond_1
    :goto_0
    return-void
.end method

.method private text(Ljava/lang/String;)Ljava/lang/String;
    .locals 3

    iget-object v0, p0, Lcom/gmhub/monitor/ResourceController;->context:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    iget-object v1, p0, Lcom/gmhub/monitor/ResourceController;->context:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v1

    const-string v2, "string"

    invoke-virtual {v0, p1, v2, v1}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    if-nez v0, :cond_0

    return-object p1

    :cond_0
    iget-object p0, p0, Lcom/gmhub/monitor/ResourceController;->context:Landroid/content/Context;

    invoke-virtual {p0, v0}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method private unavailable()Ljava/util/Map;
    .locals 12
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Lcom/gmhub/monitor/ResourceController$Row;",
            ">;"
        }
    .end annotation

    new-instance v0, Ljava/util/LinkedHashMap;

    invoke-direct {v0}, Ljava/util/LinkedHashMap;-><init>()V

    iget-boolean v1, p0, Lcom/gmhub/monitor/ResourceController;->battery:Z

    const-string v2, "gm_resource_unavailable"

    const/4 v3, 0x1

    const/4 v4, 0x0

    if-eqz v1, :cond_0

    const-string v1, "bat_current"

    const-string v5, "gm_battery_current"

    filled-new-array {v1, v5}, [Ljava/lang/String;

    move-result-object v6

    const-string v1, "bat_capacity"

    const-string v5, "gm_battery_full_capacity"

    filled-new-array {v1, v5}, [Ljava/lang/String;

    move-result-object v7

    const-string v1, "bat_cycles"

    const-string v5, "gm_battery_cycles"

    filled-new-array {v1, v5}, [Ljava/lang/String;

    move-result-object v8

    const-string v1, "bat_health"

    const-string v5, "gm_battery_asoc"

    filled-new-array {v1, v5}, [Ljava/lang/String;

    move-result-object v9

    const-string v1, "gm_battery_charge_remaining"

    const-string v5, "gm_battery_remaining_charge"

    filled-new-array {v1, v5}, [Ljava/lang/String;

    move-result-object v10

    const-string v1, "gm_battery_condition"

    const-string v5, "gm_battery_health_status"

    filled-new-array {v1, v5}, [Ljava/lang/String;

    move-result-object v11

    filled-new-array/range {v6 .. v11}, [[Ljava/lang/String;

    move-result-object v1

    move v5, v4

    :goto_0
    const/4 v6, 0x6

    if-ge v5, v6, :cond_1

    aget-object v6, v1, v5

    aget-object v7, v6, v4

    new-instance v8, Lcom/gmhub/monitor/ResourceController$Row;

    aget-object v6, v6, v3

    invoke-direct {p0, v6}, Lcom/gmhub/monitor/ResourceController;->text(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-direct {p0, v2}, Lcom/gmhub/monitor/ResourceController;->text(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v9

    invoke-direct {v8, v6, v9}, Lcom/gmhub/monitor/ResourceController$Row;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    invoke-interface {v0, v7, v8}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    add-int/lit8 v5, v5, 0x1

    goto :goto_0

    :cond_0
    const-string v1, "ram_monitor"

    const-string v5, "gm_resource_ram"

    filled-new-array {v1, v5}, [Ljava/lang/String;

    move-result-object v1

    const-string v5, "active_monitor"

    const-string v6, "gm_resource_active"

    filled-new-array {v5, v6}, [Ljava/lang/String;

    move-result-object v5

    const-string v6, "cached_monitor"

    const-string v7, "gm_resource_cached"

    filled-new-array {v6, v7}, [Ljava/lang/String;

    move-result-object v6

    const-string v7, "zram_monitor"

    const-string v8, "gm_resource_zram"

    filled-new-array {v7, v8}, [Ljava/lang/String;

    move-result-object v7

    const-string v8, "gm_swap_monitor"

    const-string v9, "gm_resource_swap"

    filled-new-array {v8, v9}, [Ljava/lang/String;

    move-result-object v8

    filled-new-array {v1, v5, v6, v7, v8}, [[Ljava/lang/String;

    move-result-object v1

    move v5, v4

    :goto_1
    const/4 v6, 0x5

    if-ge v5, v6, :cond_1

    aget-object v6, v1, v5

    aget-object v7, v6, v4

    new-instance v8, Lcom/gmhub/monitor/ResourceController$Row;

    aget-object v6, v6, v3

    invoke-direct {p0, v6}, Lcom/gmhub/monitor/ResourceController;->text(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-direct {p0, v2}, Lcom/gmhub/monitor/ResourceController;->text(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v9

    invoke-direct {v8, v6, v9}, Lcom/gmhub/monitor/ResourceController$Row;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    invoke-interface {v0, v7, v8}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    add-int/lit8 v5, v5, 0x1

    goto :goto_1

    :cond_1
    return-object v0
.end method


# virtual methods
.method public close()V
    .locals 1

    invoke-virtual {p0}, Lcom/gmhub/monitor/ResourceController;->pause()V

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/gmhub/monitor/ResourceController;->closed:Z

    iget-object p0, p0, Lcom/gmhub/monitor/ResourceController;->worker:Ljava/util/concurrent/ExecutorService;

    invoke-interface {p0}, Ljava/util/concurrent/ExecutorService;->shutdownNow()Ljava/util/List;

    return-void
.end method

.method synthetic lambda$new$0$com-gmhub-monitor-ResourceController()V
    .locals 0

    invoke-direct {p0}, Lcom/gmhub/monitor/ResourceController;->sample()V

    return-void
.end method

.method synthetic lambda$sample$0$com-gmhub-monitor-ResourceController(I)V
    .locals 3

    :try_start_0
    iget-boolean v0, p0, Lcom/gmhub/monitor/ResourceController;->battery:Z

    if-eqz v0, :cond_0

    invoke-direct {p0, p1}, Lcom/gmhub/monitor/ResourceController;->battery(I)Ljava/util/Map;

    move-result-object v0

    goto :goto_0

    :cond_0
    invoke-direct {p0}, Lcom/gmhub/monitor/ResourceController;->memory()Ljava/util/Map;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    invoke-direct {p0}, Lcom/gmhub/monitor/ResourceController;->unavailable()Ljava/util/Map;

    move-result-object v0

    :goto_0
    iget-object v1, p0, Lcom/gmhub/monitor/ResourceController;->main:Landroid/os/Handler;

    new-instance v2, Lcom/gmhub/monitor/ResourceController$$ExternalSyntheticLambda2;

    invoke-direct {v2, p0, p1, v0}, Lcom/gmhub/monitor/ResourceController$$ExternalSyntheticLambda2;-><init>(Lcom/gmhub/monitor/ResourceController;ILjava/util/Map;)V

    invoke-virtual {v1, v2}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method synthetic lambda$sample$1$com-gmhub-monitor-ResourceController(ILjava/util/Map;)V
    .locals 5

    iget-boolean v0, p0, Lcom/gmhub/monitor/ResourceController;->active:Z

    if-eqz v0, :cond_4

    iget-boolean v0, p0, Lcom/gmhub/monitor/ResourceController;->closed:Z

    if-nez v0, :cond_4

    iget v0, p0, Lcom/gmhub/monitor/ResourceController;->generation:I

    if-eq p1, v0, :cond_0

    goto :goto_1

    :cond_0
    invoke-interface {p2}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object p1

    invoke-interface {p1}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :cond_1
    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_3

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/Map$Entry;

    iget-object v1, p0, Lcom/gmhub/monitor/ResourceController;->shown:Ljava/util/Map;

    invoke-interface {v0}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v2

    invoke-interface {v1, v2}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/gmhub/monitor/ResourceController$Row;

    invoke-interface {v0}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/gmhub/monitor/ResourceController$Row;

    if-eqz v1, :cond_2

    iget-object v3, v1, Lcom/gmhub/monitor/ResourceController$Row;->title:Ljava/lang/String;

    iget-object v4, v2, Lcom/gmhub/monitor/ResourceController$Row;->title:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_2

    iget-object v1, v1, Lcom/gmhub/monitor/ResourceController$Row;->value:Ljava/lang/String;

    iget-object v3, v2, Lcom/gmhub/monitor/ResourceController$Row;->value:Ljava/lang/String;

    invoke-virtual {v1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_1

    :cond_2
    iget-object v1, p0, Lcom/gmhub/monitor/ResourceController;->host:Lcom/gmhub/monitor/ResourceController$Host;

    invoke-interface {v0}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    iget-object v3, v2, Lcom/gmhub/monitor/ResourceController$Row;->title:Ljava/lang/String;

    iget-object v2, v2, Lcom/gmhub/monitor/ResourceController$Row;->value:Ljava/lang/String;

    invoke-interface {v1, v0, v3, v2}, Lcom/gmhub/monitor/ResourceController$Host;->row(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0

    :cond_3
    iget-object p1, p0, Lcom/gmhub/monitor/ResourceController;->shown:Ljava/util/Map;

    invoke-interface {p1}, Ljava/util/Map;->clear()V

    iget-object p1, p0, Lcom/gmhub/monitor/ResourceController;->shown:Ljava/util/Map;

    invoke-interface {p1, p2}, Ljava/util/Map;->putAll(Ljava/util/Map;)V

    iget-object p1, p0, Lcom/gmhub/monitor/ResourceController;->main:Landroid/os/Handler;

    iget-object p0, p0, Lcom/gmhub/monitor/ResourceController;->tick:Ljava/lang/Runnable;

    const-wide/16 v0, 0x7d0

    invoke-virtual {p1, p0, v0, v1}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    :cond_4
    :goto_1
    return-void
.end method

.method public pause()V
    .locals 3

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/gmhub/monitor/ResourceController;->active:Z

    iget v0, p0, Lcom/gmhub/monitor/ResourceController;->generation:I

    const/4 v1, 0x1

    add-int/2addr v0, v1

    iput v0, p0, Lcom/gmhub/monitor/ResourceController;->generation:I

    iget-object v0, p0, Lcom/gmhub/monitor/ResourceController;->main:Landroid/os/Handler;

    iget-object v2, p0, Lcom/gmhub/monitor/ResourceController;->tick:Ljava/lang/Runnable;

    invoke-virtual {v0, v2}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    iget-object p0, p0, Lcom/gmhub/monitor/ResourceController;->pending:Ljava/util/concurrent/Future;

    if-eqz p0, :cond_0

    invoke-interface {p0, v1}, Ljava/util/concurrent/Future;->cancel(Z)Z

    :cond_0
    return-void
.end method

.method public resume()V
    .locals 2

    iget-boolean v0, p0, Lcom/gmhub/monitor/ResourceController;->closed:Z

    if-eqz v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lcom/gmhub/monitor/ResourceController;->pending:Ljava/util/concurrent/Future;

    const/4 v1, 0x1

    if-eqz v0, :cond_1

    invoke-interface {v0, v1}, Ljava/util/concurrent/Future;->cancel(Z)Z

    :cond_1
    iput-boolean v1, p0, Lcom/gmhub/monitor/ResourceController;->active:Z

    iget v0, p0, Lcom/gmhub/monitor/ResourceController;->generation:I

    add-int/2addr v0, v1

    iput v0, p0, Lcom/gmhub/monitor/ResourceController;->generation:I

    iget-object v0, p0, Lcom/gmhub/monitor/ResourceController;->shown:Ljava/util/Map;

    invoke-interface {v0}, Ljava/util/Map;->clear()V

    iget-object v0, p0, Lcom/gmhub/monitor/ResourceController;->main:Landroid/os/Handler;

    iget-object v1, p0, Lcom/gmhub/monitor/ResourceController;->tick:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    invoke-direct {p0}, Lcom/gmhub/monitor/ResourceController;->sample()V

    return-void
.end method
