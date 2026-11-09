.class public final Lcom/gmhub/qs/NativePageNavigation$Request;
.super Ljava/lang/Object;
.source "NativePageNavigation.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/gmhub/qs/NativePageNavigation;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Request"
.end annotation


# instance fields
.field private cancelled:Z

.field private final max:I

.field private final owner:Lcom/gmhub/qs/NativePageNavigation;

.field private final target:I

.field private final viewport:I


# direct methods
.method constructor <init>(Lcom/gmhub/qs/NativePageNavigation;ILcom/gmhub/qs/NativePageNavigation$Pages;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/gmhub/qs/NativePageNavigation$Request;->owner:Lcom/gmhub/qs/NativePageNavigation;

    iput p2, p0, Lcom/gmhub/qs/NativePageNavigation$Request;->target:I

    iget p1, p3, Lcom/gmhub/qs/NativePageNavigation$Pages;->viewport:I

    iput p1, p0, Lcom/gmhub/qs/NativePageNavigation$Request;->viewport:I

    iget p1, p3, Lcom/gmhub/qs/NativePageNavigation$Pages;->max:I

    iput p1, p0, Lcom/gmhub/qs/NativePageNavigation$Request;->max:I

    return-void
.end method

.method static synthetic access$000(Lcom/gmhub/qs/NativePageNavigation$Request;)Lcom/gmhub/qs/NativePageNavigation;
    .locals 0

    iget-object p0, p0, Lcom/gmhub/qs/NativePageNavigation$Request;->owner:Lcom/gmhub/qs/NativePageNavigation;

    return-object p0
.end method

.method static synthetic access$100(Lcom/gmhub/qs/NativePageNavigation$Request;)Z
    .locals 0

    iget-boolean p0, p0, Lcom/gmhub/qs/NativePageNavigation$Request;->cancelled:Z

    return p0
.end method

.method static synthetic access$102(Lcom/gmhub/qs/NativePageNavigation$Request;Z)Z
    .locals 0

    iput-boolean p1, p0, Lcom/gmhub/qs/NativePageNavigation$Request;->cancelled:Z

    return p1
.end method

.method static synthetic access$200(Lcom/gmhub/qs/NativePageNavigation$Request;)I
    .locals 0

    iget p0, p0, Lcom/gmhub/qs/NativePageNavigation$Request;->viewport:I

    return p0
.end method

.method static synthetic access$300(Lcom/gmhub/qs/NativePageNavigation$Request;)I
    .locals 0

    iget p0, p0, Lcom/gmhub/qs/NativePageNavigation$Request;->max:I

    return p0
.end method

.method static synthetic access$400(Lcom/gmhub/qs/NativePageNavigation$Request;)I
    .locals 0

    iget p0, p0, Lcom/gmhub/qs/NativePageNavigation$Request;->target:I

    return p0
.end method
