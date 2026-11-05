.class public final Lcom/gmhub/apps/AppStateEngine;
.super Ljava/lang/Object;
.source "AppStateEngine.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/gmhub/apps/AppStateEngine$Access;,
        Lcom/gmhub/apps/AppStateEngine$Journal;,
        Lcom/gmhub/apps/AppStateEngine$Record;
    }
.end annotation


# instance fields
.field private final access:Lcom/gmhub/apps/AppStateEngine$Access;

.field private final journal:Lcom/gmhub/apps/AppStateEngine$Journal;


# direct methods
.method public constructor <init>(Lcom/gmhub/apps/AppStateEngine$Access;Lcom/gmhub/apps/AppStateEngine$Journal;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/gmhub/apps/AppStateEngine;->access:Lcom/gmhub/apps/AppStateEngine$Access;

    iput-object p2, p0, Lcom/gmhub/apps/AppStateEngine;->journal:Lcom/gmhub/apps/AppStateEngine$Journal;

    return-void
.end method

.method static synthetic access$000(I)V
    .locals 0

    invoke-static {p0}, Lcom/gmhub/apps/AppStateEngine;->valid(I)V

    return-void
.end method

.method public static packageName(Ljava/lang/String;)V
    .locals 2

    if-eqz p0, :cond_0

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    const/16 v1, 0xff

    if-gt v0, v1, :cond_0

    const-string v0, "[A-Za-z_][A-Za-z0-9_]*(\\.[A-Za-z_][A-Za-z0-9_]*)*"

    invoke-virtual {p0, v0}, Ljava/lang/String;->matches(Ljava/lang/String;)Z

    move-result p0

    if-eqz p0, :cond_0

    return-void

    :cond_0
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string v0, "Invalid package name"

    invoke-direct {p0, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0
.end method

.method private static valid(I)V
    .locals 1

    if-ltz p0, :cond_0

    const/4 v0, 0x4

    if-gt p0, v0, :cond_0

    return-void

    :cond_0
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string v0, "Invalid package state"

    invoke-direct {p0, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0
.end method


# virtual methods
.method public declared-synchronized change(Ljava/lang/String;Z)Z
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    monitor-enter p0

    :try_start_0
    invoke-static {p1}, Lcom/gmhub/apps/AppStateEngine;->packageName(Ljava/lang/String;)V

    if-nez p2, :cond_1

    iget-object v0, p0, Lcom/gmhub/apps/AppStateEngine;->access:Lcom/gmhub/apps/AppStateEngine$Access;

    invoke-interface {v0, p1}, Lcom/gmhub/apps/AppStateEngine$Access;->canDisable(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    new-instance p1, Ljava/lang/SecurityException;

    const-string p2, "Protected app"

    invoke-direct {p1, p2}, Ljava/lang/SecurityException;-><init>(Ljava/lang/String;)V

    throw p1

    :cond_1
    :goto_0
    iget-object v0, p0, Lcom/gmhub/apps/AppStateEngine;->access:Lcom/gmhub/apps/AppStateEngine$Access;

    invoke-interface {v0, p1}, Lcom/gmhub/apps/AppStateEngine$Access;->read(Ljava/lang/String;)I

    move-result v0

    const/4 v1, 0x1

    if-eqz p2, :cond_2

    move p2, v1

    goto :goto_1

    :cond_2
    const/4 p2, 0x3

    :goto_1
    invoke-static {v0}, Lcom/gmhub/apps/AppStateEngine;->valid(I)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-ne v0, p2, :cond_3

    monitor-exit p0

    const/4 p0, 0x0

    return p0

    :cond_3
    :try_start_1
    iget-object v2, p0, Lcom/gmhub/apps/AppStateEngine;->journal:Lcom/gmhub/apps/AppStateEngine$Journal;

    invoke-interface {v2, p1}, Lcom/gmhub/apps/AppStateEngine$Journal;->get(Ljava/lang/String;)Lcom/gmhub/apps/AppStateEngine$Record;

    move-result-object v2

    if-eqz v2, :cond_5

    iget v3, v2, Lcom/gmhub/apps/AppStateEngine$Record;->applied:I

    if-eq v0, v3, :cond_4

    iget v3, v2, Lcom/gmhub/apps/AppStateEngine$Record;->original:I

    if-ne v0, v3, :cond_5

    :cond_4
    iget v3, v2, Lcom/gmhub/apps/AppStateEngine$Record;->original:I

    goto :goto_2

    :cond_5
    move v3, v0

    :goto_2
    iget-object v4, p0, Lcom/gmhub/apps/AppStateEngine;->journal:Lcom/gmhub/apps/AppStateEngine$Journal;

    new-instance v5, Lcom/gmhub/apps/AppStateEngine$Record;

    invoke-direct {v5, v3, p2}, Lcom/gmhub/apps/AppStateEngine$Record;-><init>(II)V

    invoke-interface {v4, p1, v5}, Lcom/gmhub/apps/AppStateEngine$Journal;->put(Ljava/lang/String;Lcom/gmhub/apps/AppStateEngine$Record;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :try_start_2
    iget-object v3, p0, Lcom/gmhub/apps/AppStateEngine;->access:Lcom/gmhub/apps/AppStateEngine$Access;

    invoke-interface {v3, p1, p2}, Lcom/gmhub/apps/AppStateEngine$Access;->write(Ljava/lang/String;I)V

    iget-object v3, p0, Lcom/gmhub/apps/AppStateEngine;->access:Lcom/gmhub/apps/AppStateEngine$Access;

    invoke-interface {v3, p1}, Lcom/gmhub/apps/AppStateEngine$Access;->read(Ljava/lang/String;)I

    move-result v3
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    if-ne v3, p2, :cond_6

    monitor-exit p0

    return v1

    :cond_6
    :try_start_3
    new-instance v3, Ljava/lang/IllegalStateException;

    const-string v4, "Package state not confirmed"

    invoke-direct {v3, v4}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v3
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_0
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    :catch_0
    move-exception v3

    :try_start_4
    iget-object v4, p0, Lcom/gmhub/apps/AppStateEngine;->access:Lcom/gmhub/apps/AppStateEngine$Access;

    invoke-interface {v4, p1}, Lcom/gmhub/apps/AppStateEngine$Access;->read(Ljava/lang/String;)I

    move-result v4
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_1
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    if-ne v4, p2, :cond_7

    monitor-exit p0

    return v1

    :cond_7
    if-ne v4, v0, :cond_9

    if-nez v2, :cond_8

    :try_start_5
    iget-object p2, p0, Lcom/gmhub/apps/AppStateEngine;->journal:Lcom/gmhub/apps/AppStateEngine$Journal;

    invoke-interface {p2, p1}, Lcom/gmhub/apps/AppStateEngine$Journal;->remove(Ljava/lang/String;)V

    goto :goto_3

    :cond_8
    iget-object p2, p0, Lcom/gmhub/apps/AppStateEngine;->journal:Lcom/gmhub/apps/AppStateEngine$Journal;

    invoke-interface {p2, p1, v2}, Lcom/gmhub/apps/AppStateEngine$Journal;->put(Ljava/lang/String;Lcom/gmhub/apps/AppStateEngine$Record;)V
    :try_end_5
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_5} :catch_1
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    goto :goto_3

    :catch_1
    move-exception p1

    :try_start_6
    invoke-virtual {v3, p1}, Ljava/lang/Exception;->addSuppressed(Ljava/lang/Throwable;)V

    :cond_9
    :goto_3
    throw v3

    :catchall_0
    move-exception p1

    monitor-exit p0
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_0

    throw p1
.end method

.method public declared-synchronized restore(Ljava/lang/String;)Z
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    monitor-enter p0

    :try_start_0
    invoke-static {p1}, Lcom/gmhub/apps/AppStateEngine;->packageName(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/gmhub/apps/AppStateEngine;->journal:Lcom/gmhub/apps/AppStateEngine$Journal;

    invoke-interface {v0, p1}, Lcom/gmhub/apps/AppStateEngine$Journal;->get(Ljava/lang/String;)Lcom/gmhub/apps/AppStateEngine$Record;

    move-result-object v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    const/4 v1, 0x0

    if-nez v0, :cond_0

    monitor-exit p0

    return v1

    :cond_0
    :try_start_1
    iget-object v2, p0, Lcom/gmhub/apps/AppStateEngine;->access:Lcom/gmhub/apps/AppStateEngine$Access;

    invoke-interface {v2, p1}, Lcom/gmhub/apps/AppStateEngine$Access;->read(Ljava/lang/String;)I

    move-result v2

    iget v3, v0, Lcom/gmhub/apps/AppStateEngine$Record;->original:I

    if-ne v2, v3, :cond_1

    iget-object v0, p0, Lcom/gmhub/apps/AppStateEngine;->journal:Lcom/gmhub/apps/AppStateEngine$Journal;

    invoke-interface {v0, p1}, Lcom/gmhub/apps/AppStateEngine$Journal;->remove(Ljava/lang/String;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    monitor-exit p0

    return v1

    :cond_1
    :try_start_2
    iget v1, v0, Lcom/gmhub/apps/AppStateEngine$Record;->applied:I

    if-ne v2, v1, :cond_5

    iget v1, v0, Lcom/gmhub/apps/AppStateEngine$Record;->original:I

    const/4 v2, 0x1

    if-eq v1, v2, :cond_3

    iget-object v1, p0, Lcom/gmhub/apps/AppStateEngine;->access:Lcom/gmhub/apps/AppStateEngine$Access;

    invoke-interface {v1, p1}, Lcom/gmhub/apps/AppStateEngine$Access;->canDisable(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_2

    goto :goto_0

    :cond_2
    new-instance p1, Ljava/lang/SecurityException;

    const-string v0, "Protected app"

    invoke-direct {p1, v0}, Ljava/lang/SecurityException;-><init>(Ljava/lang/String;)V

    throw p1

    :cond_3
    :goto_0
    iget-object v1, p0, Lcom/gmhub/apps/AppStateEngine;->access:Lcom/gmhub/apps/AppStateEngine$Access;

    iget v3, v0, Lcom/gmhub/apps/AppStateEngine$Record;->original:I

    invoke-interface {v1, p1, v3}, Lcom/gmhub/apps/AppStateEngine$Access;->write(Ljava/lang/String;I)V

    iget-object v1, p0, Lcom/gmhub/apps/AppStateEngine;->access:Lcom/gmhub/apps/AppStateEngine$Access;

    invoke-interface {v1, p1}, Lcom/gmhub/apps/AppStateEngine$Access;->read(Ljava/lang/String;)I

    move-result v1

    iget v0, v0, Lcom/gmhub/apps/AppStateEngine$Record;->original:I

    if-ne v1, v0, :cond_4

    iget-object v0, p0, Lcom/gmhub/apps/AppStateEngine;->journal:Lcom/gmhub/apps/AppStateEngine$Journal;

    invoke-interface {v0, p1}, Lcom/gmhub/apps/AppStateEngine$Journal;->remove(Ljava/lang/String;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    monitor-exit p0

    return v2

    :cond_4
    :try_start_3
    new-instance p1, Ljava/lang/IllegalStateException;

    const-string v0, "Restore not confirmed"

    invoke-direct {p1, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1

    :cond_5
    new-instance p1, Ljava/lang/IllegalStateException;

    const-string v0, "App changed outside the Hub"

    invoke-direct {p1, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1

    :catchall_0
    move-exception p1

    monitor-exit p0
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    throw p1
.end method
