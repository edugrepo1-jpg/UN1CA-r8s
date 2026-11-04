.class public final synthetic Lcom/gmhub/monitor/ThermalReader$$ExternalSyntheticLambda1;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/util/function/ToIntFunction;


# direct methods
.method public synthetic constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final applyAsInt(Ljava/lang/Object;)I
    .locals 0

    check-cast p1, Ljava/io/File;

    invoke-static {p1}, Lcom/gmhub/monitor/ThermalReader;->lambda$read$1(Ljava/io/File;)I

    move-result p0

    return p0
.end method
