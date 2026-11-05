.class public final Lcom/gmhub/profiles/ProfileEngine$State;
.super Ljava/lang/Object;
.source "ProfileEngine.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/gmhub/profiles/ProfileEngine;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "State"
.end annotation


# instance fields
.field public final entries:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Lcom/gmhub/profiles/ProfileEngine$Entry;",
            ">;"
        }
    .end annotation
.end field

.field public final mode:Ljava/lang/String;

.field public final pending:Z


# direct methods
.method public constructor <init>(Ljava/lang/String;ZLjava/util/Map;)V
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Z",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Lcom/gmhub/profiles/ProfileEngine$Entry;",
            ">;)V"
        }
    .end annotation

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const-string v0, "battery"

    const-string v1, "pure_black"

    const-string v2, "stock"

    const-string v3, "smooth"

    const-string v4, "gaming"

    filled-new-array {v2, v3, v4, v0, v1}, [Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0, p1}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    iput-object p1, p0, Lcom/gmhub/profiles/ProfileEngine$State;->mode:Ljava/lang/String;

    iput-boolean p2, p0, Lcom/gmhub/profiles/ProfileEngine$State;->pending:Z

    new-instance p1, Ljava/util/LinkedHashMap;

    invoke-direct {p1, p3}, Ljava/util/LinkedHashMap;-><init>(Ljava/util/Map;)V

    invoke-static {p1}, Ljava/util/Collections;->unmodifiableMap(Ljava/util/Map;)Ljava/util/Map;

    move-result-object p1

    iput-object p1, p0, Lcom/gmhub/profiles/ProfileEngine$State;->entries:Ljava/util/Map;

    return-void

    :cond_0
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string p1, "Unknown profile"

    invoke-direct {p0, p1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0
.end method

.method public static empty()Lcom/gmhub/profiles/ProfileEngine$State;
    .locals 4

    new-instance v0, Lcom/gmhub/profiles/ProfileEngine$State;

    const/4 v1, 0x0

    sget-object v2, Ljava/util/Collections;->EMPTY_MAP:Ljava/util/Map;

    const-string v3, "stock"

    invoke-direct {v0, v3, v1, v2}, Lcom/gmhub/profiles/ProfileEngine$State;-><init>(Ljava/lang/String;ZLjava/util/Map;)V

    return-object v0
.end method
