.class Lcom/gmhub/qs/ComposePanelRoot$Session$1;
.super Landroid/database/ContentObserver;
.source "ComposePanelRoot.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/gmhub/qs/ComposePanelRoot$Session;-><init>(Lcom/gmhub/qs/ComposePanelRoot$Abi;Landroid/content/Context;I)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/gmhub/qs/ComposePanelRoot$Session;


# direct methods
.method constructor <init>(Lcom/gmhub/qs/ComposePanelRoot$Session;Landroid/os/Handler;)V
    .locals 0
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x8010,
            0x0
        }
        names = {
            null,
            null
        }
    .end annotation

    iput-object p1, p0, Lcom/gmhub/qs/ComposePanelRoot$Session$1;->this$0:Lcom/gmhub/qs/ComposePanelRoot$Session;

    invoke-direct {p0, p2}, Landroid/database/ContentObserver;-><init>(Landroid/os/Handler;)V

    return-void
.end method


# virtual methods
.method public onChange(Z)V
    .locals 0

    iget-object p0, p0, Lcom/gmhub/qs/ComposePanelRoot$Session$1;->this$0:Lcom/gmhub/qs/ComposePanelRoot$Session;

    invoke-virtual {p0}, Lcom/gmhub/qs/ComposePanelRoot$Session;->refresh()V

    return-void
.end method
