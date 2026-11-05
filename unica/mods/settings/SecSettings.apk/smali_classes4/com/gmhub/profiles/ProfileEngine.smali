.class public final Lcom/gmhub/profiles/ProfileEngine;
.super Ljava/lang/Object;
.source "ProfileEngine.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/gmhub/profiles/ProfileEngine$Access;,
        Lcom/gmhub/profiles/ProfileEngine$Store;,
        Lcom/gmhub/profiles/ProfileEngine$State;,
        Lcom/gmhub/profiles/ProfileEngine$Entry;,
        Lcom/gmhub/profiles/ProfileEngine$RestoreResult;
    }
.end annotation


# instance fields
.field private final access:Lcom/gmhub/profiles/ProfileEngine$Access;

.field private final store:Lcom/gmhub/profiles/ProfileEngine$Store;


# direct methods
.method public constructor <init>(Lcom/gmhub/profiles/ProfileEngine$Access;Lcom/gmhub/profiles/ProfileEngine$Store;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/gmhub/profiles/ProfileEngine;->access:Lcom/gmhub/profiles/ProfileEngine$Access;

    iput-object p2, p0, Lcom/gmhub/profiles/ProfileEngine;->store:Lcom/gmhub/profiles/ProfileEngine$Store;

    return-void
.end method

.method private set(Ljava/lang/String;Ljava/lang/String;)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    :try_start_0
    iget-object v0, p0, Lcom/gmhub/profiles/ProfileEngine;->access:Lcom/gmhub/profiles/ProfileEngine$Access;

    invoke-interface {v0, p1, p2}, Lcom/gmhub/profiles/ProfileEngine$Access;->write(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    iget-object v1, p0, Lcom/gmhub/profiles/ProfileEngine;->access:Lcom/gmhub/profiles/ProfileEngine$Access;

    invoke-interface {v1, p1}, Lcom/gmhub/profiles/ProfileEngine$Access;->read(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1, p2}, Ljava/util/Objects;->equals(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    :goto_0
    iget-object p0, p0, Lcom/gmhub/profiles/ProfileEngine;->access:Lcom/gmhub/profiles/ProfileEngine$Access;

    invoke-interface {p0, p1}, Lcom/gmhub/profiles/ProfileEngine$Access;->read(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    invoke-static {p0, p2}, Ljava/util/Objects;->equals(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result p0

    if-eqz p0, :cond_0

    return-void

    :cond_0
    new-instance p0, Ljava/lang/IllegalStateException;

    new-instance p2, Ljava/lang/StringBuilder;

    const-string v0, "Unconfirmed setting: "

    invoke-direct {p2, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p0, p1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p0

    :cond_1
    throw v0
.end method


# virtual methods
.method public declared-synchronized apply(Ljava/lang/String;Ljava/util/Map;)V
    .locals 10
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    monitor-enter p0

    :try_start_0
    const-string v0, "smooth"

    const-string v1, "gaming"

    const-string v2, "battery"

    filled-new-array {v0, v1, v2}, [Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0, p1}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_c

    invoke-interface {p2}, Ljava/util/Map;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_c

    iget-object v0, p0, Lcom/gmhub/profiles/ProfileEngine;->store:Lcom/gmhub/profiles/ProfileEngine$Store;

    invoke-interface {v0}, Lcom/gmhub/profiles/ProfileEngine$Store;->load()Lcom/gmhub/profiles/ProfileEngine$State;

    move-result-object v0

    iget-boolean v1, v0, Lcom/gmhub/profiles/ProfileEngine$State;->pending:Z

    if-nez v1, :cond_b

    new-instance v1, Ljava/util/LinkedHashMap;

    invoke-direct {v1, p2}, Ljava/util/LinkedHashMap;-><init>(Ljava/util/Map;)V

    new-instance p2, Ljava/util/LinkedHashMap;

    invoke-direct {p2}, Ljava/util/LinkedHashMap;-><init>()V

    iget-object v2, v0, Lcom/gmhub/profiles/ProfileEngine$State;->entries:Ljava/util/Map;

    invoke-interface {v2}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v2

    invoke-interface {v2}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :cond_0
    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_1

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/util/Map$Entry;

    invoke-interface {v3}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v4

    invoke-virtual {v1, v4}, Ljava/util/LinkedHashMap;->containsKey(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_0

    iget-object v4, p0, Lcom/gmhub/profiles/ProfileEngine;->access:Lcom/gmhub/profiles/ProfileEngine$Access;

    invoke-interface {v3}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/String;

    invoke-interface {v4, v5}, Lcom/gmhub/profiles/ProfileEngine$Access;->read(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-interface {v3}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lcom/gmhub/profiles/ProfileEngine$Entry;

    iget-object v5, v5, Lcom/gmhub/profiles/ProfileEngine$Entry;->applied:Ljava/lang/String;

    invoke-static {v4, v5}, Ljava/util/Objects;->equals(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_0

    invoke-interface {v3}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/String;

    invoke-interface {v3}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/gmhub/profiles/ProfileEngine$Entry;

    iget-object v3, v3, Lcom/gmhub/profiles/ProfileEngine$Entry;->original:Ljava/lang/String;

    invoke-virtual {v1, v4, v3}, Ljava/util/LinkedHashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_0

    :cond_1
    new-instance v2, Ljava/util/LinkedHashMap;

    invoke-direct {v2}, Ljava/util/LinkedHashMap;-><init>()V

    new-instance v3, Ljava/util/LinkedHashMap;

    invoke-direct {v3}, Ljava/util/LinkedHashMap;-><init>()V

    invoke-virtual {v1}, Ljava/util/LinkedHashMap;->entrySet()Ljava/util/Set;

    move-result-object v4

    invoke-interface {v4}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v4

    :cond_2
    :goto_1
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_4

    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/util/Map$Entry;

    invoke-interface {v5}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/lang/String;

    iget-object v7, p0, Lcom/gmhub/profiles/ProfileEngine;->access:Lcom/gmhub/profiles/ProfileEngine$Access;

    invoke-interface {v7, v6}, Lcom/gmhub/profiles/ProfileEngine$Access;->read(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    invoke-interface {v5}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/String;

    invoke-virtual {p2, v6, v7}, Ljava/util/LinkedHashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v8, v0, Lcom/gmhub/profiles/ProfileEngine$State;->entries:Ljava/util/Map;

    invoke-interface {v8, v6}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Lcom/gmhub/profiles/ProfileEngine$Entry;

    if-eqz v8, :cond_3

    iget-object v9, v8, Lcom/gmhub/profiles/ProfileEngine$Entry;->applied:Ljava/lang/String;

    invoke-static {v7, v9}, Ljava/util/Objects;->equals(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v9

    if-eqz v9, :cond_3

    iget-object v8, v8, Lcom/gmhub/profiles/ProfileEngine$Entry;->original:Ljava/lang/String;

    goto :goto_2

    :cond_3
    move-object v8, v7

    :goto_2
    new-instance v9, Lcom/gmhub/profiles/ProfileEngine$Entry;

    filled-new-array {v7, v5}, [Ljava/lang/String;

    move-result-object v7

    invoke-static {v7}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v7

    invoke-direct {v9, v8, v5, v7}, Lcom/gmhub/profiles/ProfileEngine$Entry;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/util/Collection;)V

    invoke-virtual {v2, v6, v9}, Ljava/util/LinkedHashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    invoke-static {v8, v5}, Ljava/util/Objects;->equals(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v7

    if-nez v7, :cond_2

    new-instance v7, Lcom/gmhub/profiles/ProfileEngine$Entry;

    invoke-direct {v7, v8, v5}, Lcom/gmhub/profiles/ProfileEngine$Entry;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v3, v6, v7}, Ljava/util/LinkedHashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_1

    :cond_4
    iget-object v4, p0, Lcom/gmhub/profiles/ProfileEngine;->store:Lcom/gmhub/profiles/ProfileEngine$Store;

    new-instance v5, Lcom/gmhub/profiles/ProfileEngine$State;

    const/4 v6, 0x1

    invoke-direct {v5, p1, v6, v2}, Lcom/gmhub/profiles/ProfileEngine$State;-><init>(Ljava/lang/String;ZLjava/util/Map;)V

    invoke-interface {v4, v5}, Lcom/gmhub/profiles/ProfileEngine$Store;->save(Lcom/gmhub/profiles/ProfileEngine$State;)V

    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    const/4 v4, 0x0

    :try_start_1
    invoke-virtual {v1}, Ljava/util/LinkedHashMap;->entrySet()Ljava/util/Set;

    move-result-object v5

    invoke-interface {v5}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v5

    :goto_3
    invoke-interface {v5}, Ljava/util/Iterator;->hasNext()Z

    move-result v7

    if-eqz v7, :cond_6

    invoke-interface {v5}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Ljava/util/Map$Entry;

    invoke-interface {v7}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v8

    invoke-virtual {p2, v8}, Ljava/util/LinkedHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v8

    invoke-interface {v7}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v9

    invoke-static {v8, v9}, Ljava/util/Objects;->equals(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v8

    if-eqz v8, :cond_5

    goto :goto_3

    :cond_5
    invoke-interface {v7}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Ljava/lang/String;

    invoke-interface {v2, v8}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    invoke-interface {v7}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Ljava/lang/String;

    invoke-interface {v7}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Ljava/lang/String;

    invoke-direct {p0, v8, v7}, Lcom/gmhub/profiles/ProfileEngine;->set(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_3

    :cond_6
    iget-object v5, p0, Lcom/gmhub/profiles/ProfileEngine;->store:Lcom/gmhub/profiles/ProfileEngine$Store;

    new-instance v7, Lcom/gmhub/profiles/ProfileEngine$State;

    invoke-direct {v7, p1, v4, v3}, Lcom/gmhub/profiles/ProfileEngine$State;-><init>(Ljava/lang/String;ZLjava/util/Map;)V

    invoke-interface {v5, v7}, Lcom/gmhub/profiles/ProfileEngine$Store;->save(Lcom/gmhub/profiles/ProfileEngine$State;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    monitor-exit p0

    return-void

    :catch_0
    move-exception p1

    :try_start_2
    invoke-static {v2}, Ljava/util/Collections;->reverse(Ljava/util/List;)V

    invoke-interface {v2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_4
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_9

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/String;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    :try_start_3
    iget-object v5, p0, Lcom/gmhub/profiles/ProfileEngine;->access:Lcom/gmhub/profiles/ProfileEngine$Access;

    invoke-interface {v5, v3}, Lcom/gmhub/profiles/ProfileEngine$Access;->read(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {p2, v3}, Ljava/util/LinkedHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v7

    invoke-static {v5, v7}, Ljava/util/Objects;->equals(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_7

    goto :goto_4

    :cond_7
    invoke-virtual {v1, v3}, Ljava/util/LinkedHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v7

    invoke-static {v5, v7}, Ljava/util/Objects;->equals(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_8

    invoke-virtual {p2, v3}, Ljava/util/LinkedHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/String;

    invoke-direct {p0, v3, v5}, Lcom/gmhub/profiles/ProfileEngine;->set(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_4

    :cond_8
    new-instance v5, Ljava/lang/IllegalStateException;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "Changed outside this transaction: "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v6, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v5, v3}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v5
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_1
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    :catch_1
    move-exception v3

    :try_start_4
    invoke-virtual {p1, v3}, Ljava/lang/Exception;->addSuppressed(Ljava/lang/Throwable;)V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    move v6, v4

    goto :goto_4

    :cond_9
    if-eqz v6, :cond_a

    :try_start_5
    iget-object p2, p0, Lcom/gmhub/profiles/ProfileEngine;->store:Lcom/gmhub/profiles/ProfileEngine$Store;

    invoke-interface {p2, v0}, Lcom/gmhub/profiles/ProfileEngine$Store;->save(Lcom/gmhub/profiles/ProfileEngine$State;)V
    :try_end_5
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_5} :catch_2
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    goto :goto_5

    :catch_2
    move-exception p2

    :try_start_6
    invoke-virtual {p1, p2}, Ljava/lang/Exception;->addSuppressed(Ljava/lang/Throwable;)V

    :cond_a
    :goto_5
    throw p1

    :cond_b
    new-instance p1, Ljava/lang/IllegalStateException;

    const-string p2, "Restore the incomplete transaction first"

    invoke-direct {p1, p2}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1

    :cond_c
    new-instance p1, Ljava/lang/IllegalArgumentException;

    const-string p2, "Invalid profile plan"

    invoke-direct {p1, p2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p1

    :catchall_0
    move-exception p1

    monitor-exit p0
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_0

    throw p1
.end method

.method public declared-synchronized restore()Lcom/gmhub/profiles/ProfileEngine$RestoreResult;
    .locals 11
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lcom/gmhub/profiles/ProfileEngine;->store:Lcom/gmhub/profiles/ProfileEngine$Store;

    invoke-interface {v0}, Lcom/gmhub/profiles/ProfileEngine$Store;->load()Lcom/gmhub/profiles/ProfileEngine$State;

    move-result-object v0

    new-instance v1, Ljava/util/LinkedHashMap;

    iget-object v2, v0, Lcom/gmhub/profiles/ProfileEngine$State;->entries:Ljava/util/Map;

    invoke-direct {v1, v2}, Ljava/util/LinkedHashMap;-><init>(Ljava/util/Map;)V

    invoke-virtual {v1}, Ljava/util/LinkedHashMap;->isEmpty()Z

    move-result v2

    const/4 v3, 0x1

    if-nez v2, :cond_0

    iget-object v2, p0, Lcom/gmhub/profiles/ProfileEngine;->store:Lcom/gmhub/profiles/ProfileEngine$Store;

    new-instance v4, Lcom/gmhub/profiles/ProfileEngine$State;

    iget-object v5, v0, Lcom/gmhub/profiles/ProfileEngine$State;->mode:Ljava/lang/String;

    invoke-direct {v4, v5, v3, v1}, Lcom/gmhub/profiles/ProfileEngine$State;-><init>(Ljava/lang/String;ZLjava/util/Map;)V

    invoke-interface {v2, v4}, Lcom/gmhub/profiles/ProfileEngine$Store;->save(Lcom/gmhub/profiles/ProfileEngine$State;)V

    :cond_0
    iget-object v2, v0, Lcom/gmhub/profiles/ProfileEngine$State;->entries:Ljava/util/Map;

    invoke-interface {v2}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v2

    invoke-interface {v2}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v2

    const/4 v4, 0x0

    move v5, v4

    move v6, v5

    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v7

    if-eqz v7, :cond_4

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Ljava/util/Map$Entry;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :try_start_1
    iget-object v8, p0, Lcom/gmhub/profiles/ProfileEngine;->access:Lcom/gmhub/profiles/ProfileEngine$Access;

    invoke-interface {v7}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Ljava/lang/String;

    invoke-interface {v8, v9}, Lcom/gmhub/profiles/ProfileEngine$Access;->read(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    invoke-interface {v7}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Lcom/gmhub/profiles/ProfileEngine$Entry;

    iget-object v10, v9, Lcom/gmhub/profiles/ProfileEngine$Entry;->original:Ljava/lang/String;

    invoke-static {v8, v10}, Ljava/util/Objects;->equals(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v10

    if-nez v10, :cond_2

    iget-object v10, v9, Lcom/gmhub/profiles/ProfileEngine$Entry;->owned:Ljava/util/List;

    invoke-interface {v10, v8}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v8

    if-nez v8, :cond_1

    add-int/lit8 v5, v5, 0x1

    goto :goto_1

    :cond_1
    invoke-interface {v7}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Ljava/lang/String;

    iget-object v9, v9, Lcom/gmhub/profiles/ProfileEngine$Entry;->original:Ljava/lang/String;

    invoke-direct {p0, v8, v9}, Lcom/gmhub/profiles/ProfileEngine;->set(Ljava/lang/String;Ljava/lang/String;)V

    add-int/lit8 v4, v4, 0x1

    :cond_2
    :goto_1
    invoke-interface {v7}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v7

    invoke-virtual {v1, v7}, Ljava/util/LinkedHashMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v7, p0, Lcom/gmhub/profiles/ProfileEngine;->store:Lcom/gmhub/profiles/ProfileEngine$Store;

    invoke-virtual {v1}, Ljava/util/LinkedHashMap;->isEmpty()Z

    move-result v8

    if-eqz v8, :cond_3

    invoke-static {}, Lcom/gmhub/profiles/ProfileEngine$State;->empty()Lcom/gmhub/profiles/ProfileEngine$State;

    move-result-object v8

    goto :goto_2

    :cond_3
    new-instance v8, Lcom/gmhub/profiles/ProfileEngine$State;

    iget-object v9, v0, Lcom/gmhub/profiles/ProfileEngine$State;->mode:Ljava/lang/String;

    invoke-direct {v8, v9, v3, v1}, Lcom/gmhub/profiles/ProfileEngine$State;-><init>(Ljava/lang/String;ZLjava/util/Map;)V

    :goto_2
    invoke-interface {v7, v8}, Lcom/gmhub/profiles/ProfileEngine$Store;->save(Lcom/gmhub/profiles/ProfileEngine$State;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    :catch_0
    add-int/lit8 v6, v6, 0x1

    goto :goto_0

    :cond_4
    :try_start_2
    invoke-virtual {v1}, Ljava/util/LinkedHashMap;->isEmpty()Z

    move-result v2

    if-eqz v2, :cond_5

    iget-object v0, p0, Lcom/gmhub/profiles/ProfileEngine;->store:Lcom/gmhub/profiles/ProfileEngine$Store;

    invoke-static {}, Lcom/gmhub/profiles/ProfileEngine$State;->empty()Lcom/gmhub/profiles/ProfileEngine$State;

    move-result-object v1

    invoke-interface {v0, v1}, Lcom/gmhub/profiles/ProfileEngine$Store;->save(Lcom/gmhub/profiles/ProfileEngine$State;)V

    goto :goto_3

    :cond_5
    iget-object v2, p0, Lcom/gmhub/profiles/ProfileEngine;->store:Lcom/gmhub/profiles/ProfileEngine$Store;

    new-instance v7, Lcom/gmhub/profiles/ProfileEngine$State;

    iget-object v0, v0, Lcom/gmhub/profiles/ProfileEngine$State;->mode:Ljava/lang/String;

    invoke-direct {v7, v0, v3, v1}, Lcom/gmhub/profiles/ProfileEngine$State;-><init>(Ljava/lang/String;ZLjava/util/Map;)V

    invoke-interface {v2, v7}, Lcom/gmhub/profiles/ProfileEngine$Store;->save(Lcom/gmhub/profiles/ProfileEngine$State;)V

    :goto_3
    new-instance v0, Lcom/gmhub/profiles/ProfileEngine$RestoreResult;

    invoke-direct {v0, v4, v5, v6}, Lcom/gmhub/profiles/ProfileEngine$RestoreResult;-><init>(III)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    monitor-exit p0

    return-object v0

    :catchall_0
    move-exception v0

    :try_start_3
    monitor-exit p0
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    throw v0
.end method

.method public declared-synchronized state()Lcom/gmhub/profiles/ProfileEngine$State;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lcom/gmhub/profiles/ProfileEngine;->store:Lcom/gmhub/profiles/ProfileEngine$Store;

    invoke-interface {v0}, Lcom/gmhub/profiles/ProfileEngine$Store;->load()Lcom/gmhub/profiles/ProfileEngine$State;

    move-result-object v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-object v0

    :catchall_0
    move-exception v0

    :try_start_1
    monitor-exit p0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v0
.end method

.method public declared-synchronized status()Ljava/lang/String;
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lcom/gmhub/profiles/ProfileEngine;->store:Lcom/gmhub/profiles/ProfileEngine$Store;

    invoke-interface {v0}, Lcom/gmhub/profiles/ProfileEngine$Store;->load()Lcom/gmhub/profiles/ProfileEngine$State;

    move-result-object v0

    iget-boolean v1, v0, Lcom/gmhub/profiles/ProfileEngine$State;->pending:Z

    if-eqz v1, :cond_0

    const-string v0, "pending"
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-object v0

    :cond_0
    :try_start_1
    iget-object v1, v0, Lcom/gmhub/profiles/ProfileEngine$State;->entries:Ljava/util/Map;

    invoke-interface {v1}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :cond_1
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_2

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/util/Map$Entry;

    iget-object v3, p0, Lcom/gmhub/profiles/ProfileEngine;->access:Lcom/gmhub/profiles/ProfileEngine$Access;

    invoke-interface {v2}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/String;

    invoke-interface {v3, v4}, Lcom/gmhub/profiles/ProfileEngine$Access;->read(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-interface {v2}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/gmhub/profiles/ProfileEngine$Entry;

    iget-object v2, v2, Lcom/gmhub/profiles/ProfileEngine$Entry;->applied:Ljava/lang/String;

    invoke-static {v3, v2}, Ljava/util/Objects;->equals(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_1

    const-string v0, "custom"
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    monitor-exit p0

    return-object v0

    :cond_2
    :try_start_2
    iget-object v0, v0, Lcom/gmhub/profiles/ProfileEngine$State;->mode:Ljava/lang/String;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    monitor-exit p0

    return-object v0

    :catchall_0
    move-exception v0

    :try_start_3
    monitor-exit p0
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    throw v0
.end method
