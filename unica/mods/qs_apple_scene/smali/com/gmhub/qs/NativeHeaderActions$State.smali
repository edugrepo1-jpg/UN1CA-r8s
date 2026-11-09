.class public final Lcom/gmhub/qs/NativeHeaderActions$State;
.super Ljava/lang/Object;
.source "NativeHeaderActions.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/gmhub/qs/NativeHeaderActions;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "State"
.end annotation


# instance fields
.field public final canAdd:Z

.field public final canFinish:Z

.field public final current:Z

.field public final editing:Z

.field public final unlocked:Z


# direct methods
.method constructor <init>(ZZZZZ)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-boolean p1, p0, Lcom/gmhub/qs/NativeHeaderActions$State;->current:Z

    iput-boolean p2, p0, Lcom/gmhub/qs/NativeHeaderActions$State;->editing:Z

    iput-boolean p3, p0, Lcom/gmhub/qs/NativeHeaderActions$State;->unlocked:Z

    iput-boolean p4, p0, Lcom/gmhub/qs/NativeHeaderActions$State;->canAdd:Z

    iput-boolean p5, p0, Lcom/gmhub/qs/NativeHeaderActions$State;->canFinish:Z

    return-void
.end method
