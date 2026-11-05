.class final Lcom/gmhub/monitor/ResourceController$Row;
.super Ljava/lang/Object;
.source "ResourceController.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/gmhub/monitor/ResourceController;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "Row"
.end annotation


# instance fields
.field final title:Ljava/lang/String;

.field final value:Ljava/lang/String;


# direct methods
.method constructor <init>(Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/gmhub/monitor/ResourceController$Row;->title:Ljava/lang/String;

    iput-object p2, p0, Lcom/gmhub/monitor/ResourceController$Row;->value:Ljava/lang/String;

    return-void
.end method
