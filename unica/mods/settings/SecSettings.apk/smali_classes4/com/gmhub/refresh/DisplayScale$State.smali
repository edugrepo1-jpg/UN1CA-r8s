.class final Lcom/gmhub/refresh/DisplayScale$State;
.super Ljava/lang/Object;
.source "DisplayScale.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/gmhub/refresh/DisplayScale;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = "State"
.end annotation


# instance fields
.field final density:I

.field final densitySetting:Ljava/lang/String;

.field final height:I

.field final sizeSetting:Ljava/lang/String;

.field final width:I


# direct methods
.method constructor <init>(IIILjava/lang/String;Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput p1, p0, Lcom/gmhub/refresh/DisplayScale$State;->width:I

    iput p2, p0, Lcom/gmhub/refresh/DisplayScale$State;->height:I

    iput p3, p0, Lcom/gmhub/refresh/DisplayScale$State;->density:I

    iput-object p4, p0, Lcom/gmhub/refresh/DisplayScale$State;->sizeSetting:Ljava/lang/String;

    iput-object p5, p0, Lcom/gmhub/refresh/DisplayScale$State;->densitySetting:Ljava/lang/String;

    return-void
.end method
