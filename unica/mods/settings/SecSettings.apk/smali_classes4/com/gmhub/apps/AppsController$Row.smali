.class final Lcom/gmhub/apps/AppsController$Row;
.super Ljava/lang/Object;
.source "AppsController.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/gmhub/apps/AppsController;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "Row"
.end annotation


# instance fields
.field final editable:Z

.field final enabled:Z

.field final label:Ljava/lang/String;

.field final pkg:Ljava/lang/String;


# direct methods
.method constructor <init>(Landroid/content/pm/ApplicationInfo;Ljava/lang/String;Z)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iget-object v0, p1, Landroid/content/pm/ApplicationInfo;->packageName:Ljava/lang/String;

    iput-object v0, p0, Lcom/gmhub/apps/AppsController$Row;->pkg:Ljava/lang/String;

    iput-object p2, p0, Lcom/gmhub/apps/AppsController$Row;->label:Ljava/lang/String;

    iget-boolean p1, p1, Landroid/content/pm/ApplicationInfo;->enabled:Z

    iput-boolean p1, p0, Lcom/gmhub/apps/AppsController$Row;->enabled:Z

    iput-boolean p3, p0, Lcom/gmhub/apps/AppsController$Row;->editable:Z

    return-void
.end method
