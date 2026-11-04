.class public final Lcom/gmhub/monitor/ThermalReader$Reading;
.super Ljava/lang/Object;
.source "ThermalReader.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/gmhub/monitor/ThermalReader;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Reading"
.end annotation


# instance fields
.field public final milliCelsius:Ljava/lang/Integer;

.field public final sensor:Ljava/lang/String;

.field public final zone:Ljava/lang/String;


# direct methods
.method constructor <init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Integer;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/gmhub/monitor/ThermalReader$Reading;->zone:Ljava/lang/String;

    iput-object p2, p0, Lcom/gmhub/monitor/ThermalReader$Reading;->sensor:Ljava/lang/String;

    iput-object p3, p0, Lcom/gmhub/monitor/ThermalReader$Reading;->milliCelsius:Ljava/lang/Integer;

    return-void
.end method


# virtual methods
.method public temperature(Ljava/util/Locale;Ljava/lang/String;)Ljava/lang/String;
    .locals 4

    iget-object p0, p0, Lcom/gmhub/monitor/ThermalReader$Reading;->milliCelsius:Ljava/lang/Integer;

    if-nez p0, :cond_0

    return-object p2

    :cond_0
    invoke-virtual {p0}, Ljava/lang/Integer;->intValue()I

    move-result p0

    int-to-double v0, p0

    const-wide v2, 0x408f400000000000L    # 1000.0

    div-double/2addr v0, v2

    invoke-static {v0, v1}, Ljava/lang/Double;->valueOf(D)Ljava/lang/Double;

    move-result-object p0

    filled-new-array {p0}, [Ljava/lang/Object;

    move-result-object p0

    const-string p2, "%.1f \u00b0C"

    invoke-static {p1, p2, p0}, Ljava/lang/String;->format(Ljava/util/Locale;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method
