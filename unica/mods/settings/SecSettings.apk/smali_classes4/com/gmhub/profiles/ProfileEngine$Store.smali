.class public interface abstract Lcom/gmhub/profiles/ProfileEngine$Store;
.super Ljava/lang/Object;
.source "ProfileEngine.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/gmhub/profiles/ProfileEngine;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x609
    name = "Store"
.end annotation


# virtual methods
.method public abstract load()Lcom/gmhub/profiles/ProfileEngine$State;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation
.end method

.method public abstract save(Lcom/gmhub/profiles/ProfileEngine$State;)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation
.end method
