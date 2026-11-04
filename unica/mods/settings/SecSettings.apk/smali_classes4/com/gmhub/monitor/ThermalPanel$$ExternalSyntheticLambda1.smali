.class public final synthetic Lcom/gmhub/monitor/ThermalPanel$$ExternalSyntheticLambda1;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field public final synthetic f$0:Lcom/gmhub/monitor/ThermalPanel;

.field public final synthetic f$1:I


# direct methods
.method public synthetic constructor <init>(Lcom/gmhub/monitor/ThermalPanel;I)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/gmhub/monitor/ThermalPanel$$ExternalSyntheticLambda1;->f$0:Lcom/gmhub/monitor/ThermalPanel;

    iput p2, p0, Lcom/gmhub/monitor/ThermalPanel$$ExternalSyntheticLambda1;->f$1:I

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 1

    iget-object v0, p0, Lcom/gmhub/monitor/ThermalPanel$$ExternalSyntheticLambda1;->f$0:Lcom/gmhub/monitor/ThermalPanel;

    iget p0, p0, Lcom/gmhub/monitor/ThermalPanel$$ExternalSyntheticLambda1;->f$1:I

    invoke-virtual {v0, p0}, Lcom/gmhub/monitor/ThermalPanel;->lambda$refreshLifecycle$1$com-gmhub-monitor-ThermalPanel(I)V

    return-void
.end method
