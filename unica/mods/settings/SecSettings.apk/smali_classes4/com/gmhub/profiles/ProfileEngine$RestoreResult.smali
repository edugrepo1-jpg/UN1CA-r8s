.class public final Lcom/gmhub/profiles/ProfileEngine$RestoreResult;
.super Ljava/lang/Object;
.source "ProfileEngine.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/gmhub/profiles/ProfileEngine;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "RestoreResult"
.end annotation


# instance fields
.field public final changed:I

.field public final conflicts:I

.field public final failed:I


# direct methods
.method constructor <init>(III)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput p1, p0, Lcom/gmhub/profiles/ProfileEngine$RestoreResult;->changed:I

    iput p2, p0, Lcom/gmhub/profiles/ProfileEngine$RestoreResult;->conflicts:I

    iput p3, p0, Lcom/gmhub/profiles/ProfileEngine$RestoreResult;->failed:I

    return-void
.end method
