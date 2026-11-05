.class public final Lcom/gmhub/refresh/DisplayScale;
.super Ljava/lang/Object;
.source "DisplayScale.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/gmhub/refresh/DisplayScale$State;,
        Lcom/gmhub/refresh/DisplayScale$Port;,
        Lcom/gmhub/refresh/DisplayScale$NativePort;
    }
.end annotation


# direct methods
.method private constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static apply(Landroid/content/Context;Ljava/lang/String;)Z
    .locals 1

    :try_start_0
    new-instance v0, Lcom/gmhub/refresh/DisplayScale$NativePort;

    invoke-direct {v0, p0}, Lcom/gmhub/refresh/DisplayScale$NativePort;-><init>(Landroid/content/Context;)V

    invoke-static {v0, p1}, Lcom/gmhub/refresh/DisplayScale;->apply(Lcom/gmhub/refresh/DisplayScale$Port;Ljava/lang/String;)Z

    move-result p0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return p0

    :catch_0
    move-exception p0

    const-string p1, "GMHubDisplay"

    const-string v0, "WindowManager unavailable"

    invoke-static {p1, v0, p0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    const/4 p0, 0x0

    return p0
.end method

.method static declared-synchronized apply(Lcom/gmhub/refresh/DisplayScale$Port;Ljava/lang/String;)Z
    .locals 14

    const-class v1, Lcom/gmhub/refresh/DisplayScale;

    monitor-enter v1

    const/4 v2, 0x0

    const/4 v3, 0x0

    :try_start_0
    invoke-interface {p0}, Lcom/gmhub/refresh/DisplayScale$Port;->sameUser()Z

    move-result v0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_7
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-nez v0, :cond_0

    monitor-exit v1

    return v3

    :cond_0
    :try_start_1
    invoke-interface {p0}, Lcom/gmhub/refresh/DisplayScale$Port;->read()Lcom/gmhub/refresh/DisplayScale$State;

    move-result-object v4
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_7
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :try_start_2
    invoke-static {v4}, Lcom/gmhub/refresh/DisplayScale;->coherent(Lcom/gmhub/refresh/DisplayScale$State;)Z

    move-result v0
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_6
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    if-nez v0, :cond_1

    monitor-exit v1

    return v3

    :cond_1
    :try_start_3
    const-string v0, "720x1600"

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    const/16 p1, 0x2d0

    const/16 v0, 0x640

    :goto_0
    move v6, p1

    move v7, v0

    goto :goto_1

    :cond_2
    const-string v0, "1080x2400"

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_d

    const/16 p1, 0x438

    const/16 v0, 0x960

    goto :goto_0

    :goto_1
    iget p1, v4, Lcom/gmhub/refresh/DisplayScale$State;->density:I

    int-to-double v8, p1

    int-to-double v10, v6

    mul-double/2addr v8, v10

    iget p1, v4, Lcom/gmhub/refresh/DisplayScale$State;->width:I

    int-to-double v10, p1

    div-double/2addr v8, v10

    invoke-static {v8, v9}, Ljava/lang/Math;->round(D)J

    move-result-wide v8

    long-to-int p1, v8

    const/16 v0, 0xa0

    if-lt p1, v0, :cond_c

    const/16 v0, 0x320

    if-le p1, v0, :cond_3

    goto/16 :goto_9

    :cond_3
    invoke-static {v4, v6, v7}, Lcom/gmhub/refresh/DisplayScale;->sizeMatches(Lcom/gmhub/refresh/DisplayScale$State;II)Z

    move-result v0
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_6
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    const/4 v11, 0x1

    if-nez v0, :cond_5

    :try_start_4
    new-instance v5, Lcom/gmhub/refresh/DisplayScale$State;

    iget v8, v4, Lcom/gmhub/refresh/DisplayScale$State;->density:I

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v9, ","

    invoke-virtual {v0, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    iget-object v10, v4, Lcom/gmhub/refresh/DisplayScale$State;->densitySetting:Ljava/lang/String;

    invoke-direct/range {v5 .. v10}, Lcom/gmhub/refresh/DisplayScale$State;-><init>(IIILjava/lang/String;Ljava/lang/String;)V
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_1
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    :try_start_5
    invoke-interface {p0, v6, v7, v3}, Lcom/gmhub/refresh/DisplayScale$Port;->size(IIZ)V

    invoke-interface {p0}, Lcom/gmhub/refresh/DisplayScale$Port;->read()Lcom/gmhub/refresh/DisplayScale$State;

    move-result-object v0

    invoke-interface {p0}, Lcom/gmhub/refresh/DisplayScale$Port;->sameUser()Z

    move-result v8

    if-eqz v8, :cond_4

    invoke-static {v0, v5}, Lcom/gmhub/refresh/DisplayScale;->sameSize(Lcom/gmhub/refresh/DisplayScale$State;Lcom/gmhub/refresh/DisplayScale$State;)Z

    move-result v8

    if-eqz v8, :cond_4

    invoke-static {v0, v4}, Lcom/gmhub/refresh/DisplayScale;->sameDensity(Lcom/gmhub/refresh/DisplayScale$State;Lcom/gmhub/refresh/DisplayScale$State;)Z

    move-result v0

    if-eqz v0, :cond_4

    move-object v12, v5

    move v13, v11

    goto :goto_2

    :cond_4
    new-instance p1, Ljava/lang/IllegalStateException;

    const-string v0, "Size not confirmed"

    invoke-direct {p1, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1
    :try_end_5
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_5} :catch_0
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    :catch_0
    move-exception v0

    move-object p1, v0

    move-object v12, v5

    move v13, v11

    goto/16 :goto_8

    :catch_1
    move-exception v0

    move-object p1, v0

    move-object v5, v2

    move-object v12, v5

    move-object v2, v4

    move v13, v11

    move v11, v3

    goto/16 :goto_b

    :cond_5
    move-object v12, v2

    move v13, v3

    :goto_2
    :try_start_6
    iget v0, v4, Lcom/gmhub/refresh/DisplayScale$State;->density:I
    :try_end_6
    .catch Ljava/lang/Exception; {:try_start_6 .. :try_end_6} :catch_5
    .catchall {:try_start_6 .. :try_end_6} :catchall_0

    if-eq p1, v0, :cond_8

    :try_start_7
    invoke-interface {p0}, Lcom/gmhub/refresh/DisplayScale$Port;->read()Lcom/gmhub/refresh/DisplayScale$State;

    move-result-object v0

    invoke-interface {p0}, Lcom/gmhub/refresh/DisplayScale$Port;->sameUser()Z

    move-result v5

    if-eqz v5, :cond_7

    if-nez v12, :cond_6

    move-object v5, v4

    goto :goto_3

    :cond_6
    move-object v5, v12

    :goto_3
    invoke-static {v0, v5}, Lcom/gmhub/refresh/DisplayScale;->sameSize(Lcom/gmhub/refresh/DisplayScale$State;Lcom/gmhub/refresh/DisplayScale$State;)Z

    move-result v5

    if-eqz v5, :cond_7

    invoke-static {v0, v4}, Lcom/gmhub/refresh/DisplayScale;->sameDensity(Lcom/gmhub/refresh/DisplayScale$State;Lcom/gmhub/refresh/DisplayScale$State;)Z

    move-result v5

    if-eqz v5, :cond_7

    new-instance v5, Lcom/gmhub/refresh/DisplayScale$State;

    iget-object v9, v0, Lcom/gmhub/refresh/DisplayScale$State;->sizeSetting:Ljava/lang/String;

    invoke-static {p1}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v10

    move v8, p1

    invoke-direct/range {v5 .. v10}, Lcom/gmhub/refresh/DisplayScale$State;-><init>(IIILjava/lang/String;Ljava/lang/String;)V
    :try_end_7
    .catch Ljava/lang/Exception; {:try_start_7 .. :try_end_7} :catch_3
    .catchall {:try_start_7 .. :try_end_7} :catchall_0

    :try_start_8
    invoke-interface {p0, v8, v3}, Lcom/gmhub/refresh/DisplayScale$Port;->density(IZ)V
    :try_end_8
    .catch Ljava/lang/Exception; {:try_start_8 .. :try_end_8} :catch_2
    .catchall {:try_start_8 .. :try_end_8} :catchall_0

    move-object v2, v5

    move p1, v11

    goto :goto_4

    :catch_2
    move-exception v0

    move-object p1, v0

    goto :goto_a

    :cond_7
    :try_start_9
    new-instance p1, Ljava/lang/IllegalStateException;

    const-string v0, "Display changed"

    invoke-direct {p1, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1
    :try_end_9
    .catch Ljava/lang/Exception; {:try_start_9 .. :try_end_9} :catch_3
    .catchall {:try_start_9 .. :try_end_9} :catchall_0

    :catch_3
    move-exception v0

    goto :goto_7

    :cond_8
    move p1, v3

    :goto_4
    :try_start_a
    invoke-interface {p0}, Lcom/gmhub/refresh/DisplayScale$Port;->read()Lcom/gmhub/refresh/DisplayScale$State;

    move-result-object v0

    invoke-interface {p0}, Lcom/gmhub/refresh/DisplayScale$Port;->sameUser()Z

    move-result v5

    if-eqz v5, :cond_b

    if-nez v12, :cond_9

    move-object v5, v4

    goto :goto_5

    :cond_9
    move-object v5, v12

    :goto_5
    invoke-static {v0, v5}, Lcom/gmhub/refresh/DisplayScale;->sameSize(Lcom/gmhub/refresh/DisplayScale$State;Lcom/gmhub/refresh/DisplayScale$State;)Z

    move-result v5

    if-eqz v5, :cond_b

    if-nez v2, :cond_a

    move-object v5, v4

    goto :goto_6

    :cond_a
    move-object v5, v2

    :goto_6
    invoke-static {v0, v5}, Lcom/gmhub/refresh/DisplayScale;->sameDensity(Lcom/gmhub/refresh/DisplayScale$State;Lcom/gmhub/refresh/DisplayScale$State;)Z

    move-result v0
    :try_end_a
    .catch Ljava/lang/Exception; {:try_start_a .. :try_end_a} :catch_4
    .catchall {:try_start_a .. :try_end_a} :catchall_0

    if-eqz v0, :cond_b

    monitor-exit v1

    return v11

    :cond_b
    :try_start_b
    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v5, "Scale not confirmed"

    invoke-direct {v0, v5}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0
    :try_end_b
    .catch Ljava/lang/Exception; {:try_start_b .. :try_end_b} :catch_4
    .catchall {:try_start_b .. :try_end_b} :catchall_0

    :catch_4
    move-exception v0

    move v11, p1

    :goto_7
    move-object p1, v0

    move-object v5, v2

    goto :goto_a

    :catch_5
    move-exception v0

    move-object p1, v0

    :goto_8
    move-object v5, v2

    move v11, v3

    goto :goto_a

    :cond_c
    :goto_9
    monitor-exit v1

    return v3

    :cond_d
    monitor-exit v1

    return v3

    :catch_6
    move-exception v0

    move-object p1, v0

    move-object v5, v2

    move-object v12, v5

    move v11, v3

    move v13, v11

    :goto_a
    move-object v2, v4

    goto :goto_b

    :catchall_0
    move-exception v0

    move-object p0, v0

    goto/16 :goto_e

    :catch_7
    move-exception v0

    move-object p1, v0

    move-object v5, v2

    move-object v12, v5

    move v11, v3

    move v13, v11

    :goto_b
    :try_start_c
    const-string v0, "GMHubDisplay"

    const-string v4, "Logical scale not confirmed"

    invoke-static {v0, v4, p1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I
    :try_end_c
    .catchall {:try_start_c .. :try_end_c} :catchall_0

    if-eqz v2, :cond_14

    :try_start_d
    invoke-interface {p0}, Lcom/gmhub/refresh/DisplayScale$Port;->sameUser()Z

    move-result p1
    :try_end_d
    .catch Ljava/lang/Exception; {:try_start_d .. :try_end_d} :catch_8
    .catchall {:try_start_d .. :try_end_d} :catchall_0

    if-nez p1, :cond_e

    monitor-exit v1

    return v3

    :cond_e
    :try_start_e
    invoke-interface {p0}, Lcom/gmhub/refresh/DisplayScale$Port;->read()Lcom/gmhub/refresh/DisplayScale$State;

    move-result-object p1

    if-eqz v11, :cond_11

    invoke-static {p1, v2}, Lcom/gmhub/refresh/DisplayScale;->sameDensity(Lcom/gmhub/refresh/DisplayScale$State;Lcom/gmhub/refresh/DisplayScale$State;)Z

    move-result v0

    if-nez v0, :cond_11

    if-eqz v5, :cond_10

    invoke-static {p1, v5}, Lcom/gmhub/refresh/DisplayScale;->sameDensity(Lcom/gmhub/refresh/DisplayScale$State;Lcom/gmhub/refresh/DisplayScale$State;)Z

    move-result p1

    if-eqz p1, :cond_10

    iget p1, v2, Lcom/gmhub/refresh/DisplayScale$State;->density:I

    iget-object v0, v2, Lcom/gmhub/refresh/DisplayScale$State;->densitySetting:Ljava/lang/String;

    invoke-static {v0}, Lcom/gmhub/refresh/DisplayScale;->unset(Ljava/lang/String;)Z

    move-result v0

    invoke-interface {p0, p1, v0}, Lcom/gmhub/refresh/DisplayScale$Port;->density(IZ)V

    invoke-interface {p0}, Lcom/gmhub/refresh/DisplayScale$Port;->read()Lcom/gmhub/refresh/DisplayScale$State;

    move-result-object p1

    invoke-static {p1, v2}, Lcom/gmhub/refresh/DisplayScale;->sameDensity(Lcom/gmhub/refresh/DisplayScale$State;Lcom/gmhub/refresh/DisplayScale$State;)Z

    move-result p1

    if-eqz p1, :cond_f

    goto :goto_c

    :cond_f
    new-instance p0, Ljava/lang/IllegalStateException;

    const-string p1, "Density rollback rejected"

    invoke-direct {p0, p1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p0

    :cond_10
    new-instance p0, Ljava/lang/IllegalStateException;

    const-string p1, "External density change"

    invoke-direct {p0, p1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p0

    :cond_11
    :goto_c
    invoke-interface {p0}, Lcom/gmhub/refresh/DisplayScale$Port;->read()Lcom/gmhub/refresh/DisplayScale$State;

    move-result-object p1

    if-eqz v13, :cond_14

    invoke-static {p1, v2}, Lcom/gmhub/refresh/DisplayScale;->sameSize(Lcom/gmhub/refresh/DisplayScale$State;Lcom/gmhub/refresh/DisplayScale$State;)Z

    move-result v0

    if-nez v0, :cond_14

    if-eqz v12, :cond_13

    invoke-static {p1, v12}, Lcom/gmhub/refresh/DisplayScale;->sameSize(Lcom/gmhub/refresh/DisplayScale$State;Lcom/gmhub/refresh/DisplayScale$State;)Z

    move-result p1

    if-eqz p1, :cond_13

    iget p1, v2, Lcom/gmhub/refresh/DisplayScale$State;->width:I

    iget v0, v2, Lcom/gmhub/refresh/DisplayScale$State;->height:I

    iget-object v4, v2, Lcom/gmhub/refresh/DisplayScale$State;->sizeSetting:Ljava/lang/String;

    invoke-static {v4}, Lcom/gmhub/refresh/DisplayScale;->unset(Ljava/lang/String;)Z

    move-result v4

    invoke-interface {p0, p1, v0, v4}, Lcom/gmhub/refresh/DisplayScale$Port;->size(IIZ)V

    invoke-interface {p0}, Lcom/gmhub/refresh/DisplayScale$Port;->read()Lcom/gmhub/refresh/DisplayScale$State;

    move-result-object p0

    invoke-static {p0, v2}, Lcom/gmhub/refresh/DisplayScale;->sameSize(Lcom/gmhub/refresh/DisplayScale$State;Lcom/gmhub/refresh/DisplayScale$State;)Z

    move-result p0

    if-eqz p0, :cond_12

    goto :goto_d

    :cond_12
    new-instance p0, Ljava/lang/IllegalStateException;

    const-string p1, "Size rollback rejected"

    invoke-direct {p0, p1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p0

    :cond_13
    new-instance p0, Ljava/lang/IllegalStateException;

    const-string p1, "External size change"

    invoke-direct {p0, p1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p0
    :try_end_e
    .catch Ljava/lang/Exception; {:try_start_e .. :try_end_e} :catch_8
    .catchall {:try_start_e .. :try_end_e} :catchall_0

    :catch_8
    move-exception v0

    move-object p0, v0

    :try_start_f
    const-string p1, "GMHubDisplay"

    const-string v0, "Scale rollback not confirmed"

    invoke-static {p1, v0, p0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I
    :try_end_f
    .catchall {:try_start_f .. :try_end_f} :catchall_0

    :cond_14
    :goto_d
    monitor-exit v1

    return v3

    :goto_e
    :try_start_10
    monitor-exit v1
    :try_end_10
    .catchall {:try_start_10 .. :try_end_10} :catchall_0

    throw p0
.end method

.method private static coherent(Lcom/gmhub/refresh/DisplayScale$State;)Z
    .locals 3

    iget v0, p0, Lcom/gmhub/refresh/DisplayScale$State;->width:I

    if-lez v0, :cond_2

    iget v0, p0, Lcom/gmhub/refresh/DisplayScale$State;->height:I

    if-lez v0, :cond_2

    iget v0, p0, Lcom/gmhub/refresh/DisplayScale$State;->density:I

    const/16 v1, 0xa0

    if-lt v0, v1, :cond_2

    iget v0, p0, Lcom/gmhub/refresh/DisplayScale$State;->density:I

    const/16 v1, 0x320

    if-gt v0, v1, :cond_2

    iget-object v0, p0, Lcom/gmhub/refresh/DisplayScale$State;->sizeSetting:Ljava/lang/String;

    invoke-static {v0}, Lcom/gmhub/refresh/DisplayScale;->unset(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/gmhub/refresh/DisplayScale$State;->sizeSetting:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    iget v2, p0, Lcom/gmhub/refresh/DisplayScale$State;->width:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v2, ","

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v2, p0, Lcom/gmhub/refresh/DisplayScale$State;->height:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    :cond_0
    iget-object v0, p0, Lcom/gmhub/refresh/DisplayScale$State;->densitySetting:Ljava/lang/String;

    invoke-static {v0}, Lcom/gmhub/refresh/DisplayScale;->unset(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    iget-object v0, p0, Lcom/gmhub/refresh/DisplayScale$State;->densitySetting:Ljava/lang/String;

    iget p0, p0, Lcom/gmhub/refresh/DisplayScale$State;->density:I

    invoke-static {p0}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p0

    if-eqz p0, :cond_2

    :cond_1
    const/4 p0, 0x1

    return p0

    :cond_2
    const/4 p0, 0x0

    return p0
.end method

.method public static report(Landroid/content/Context;Z)V
    .locals 4

    if-eqz p1, :cond_0

    const-string v0, "gm_resolution_confirmed"

    goto :goto_0

    :cond_0
    const-string v0, "gm_resolution_failed"

    :goto_0
    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    const-string v2, "string"

    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v0, v2, v3}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    if-nez v0, :cond_2

    if-eqz p1, :cond_1

    const-string p1, "Logical scale confirmed"

    goto :goto_1

    :cond_1
    const-string p1, "Logical scale not confirmed"

    goto :goto_1

    :cond_2
    invoke-virtual {p0, v0}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p1

    :goto_1
    const/4 v0, 0x1

    invoke-static {p0, p1, v0}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object p0

    invoke-virtual {p0}, Landroid/widget/Toast;->show()V

    return-void
.end method

.method private static sameDensity(Lcom/gmhub/refresh/DisplayScale$State;Lcom/gmhub/refresh/DisplayScale$State;)Z
    .locals 2

    iget v0, p0, Lcom/gmhub/refresh/DisplayScale$State;->density:I

    iget v1, p1, Lcom/gmhub/refresh/DisplayScale$State;->density:I

    if-ne v0, v1, :cond_0

    iget-object p0, p0, Lcom/gmhub/refresh/DisplayScale$State;->densitySetting:Ljava/lang/String;

    iget-object p1, p1, Lcom/gmhub/refresh/DisplayScale$State;->densitySetting:Ljava/lang/String;

    invoke-static {p0, p1}, Ljava/util/Objects;->equals(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result p0

    if-eqz p0, :cond_0

    const/4 p0, 0x1

    return p0

    :cond_0
    const/4 p0, 0x0

    return p0
.end method

.method private static sameSize(Lcom/gmhub/refresh/DisplayScale$State;Lcom/gmhub/refresh/DisplayScale$State;)Z
    .locals 2

    iget v0, p1, Lcom/gmhub/refresh/DisplayScale$State;->width:I

    iget v1, p1, Lcom/gmhub/refresh/DisplayScale$State;->height:I

    invoke-static {p0, v0, v1}, Lcom/gmhub/refresh/DisplayScale;->sizeMatches(Lcom/gmhub/refresh/DisplayScale$State;II)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object p0, p0, Lcom/gmhub/refresh/DisplayScale$State;->sizeSetting:Ljava/lang/String;

    iget-object p1, p1, Lcom/gmhub/refresh/DisplayScale$State;->sizeSetting:Ljava/lang/String;

    invoke-static {p0, p1}, Ljava/util/Objects;->equals(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result p0

    if-eqz p0, :cond_0

    const/4 p0, 0x1

    return p0

    :cond_0
    const/4 p0, 0x0

    return p0
.end method

.method private static sizeMatches(Lcom/gmhub/refresh/DisplayScale$State;II)Z
    .locals 1

    iget v0, p0, Lcom/gmhub/refresh/DisplayScale$State;->width:I

    if-ne v0, p1, :cond_0

    iget p0, p0, Lcom/gmhub/refresh/DisplayScale$State;->height:I

    if-ne p0, p2, :cond_0

    const/4 p0, 0x1

    return p0

    :cond_0
    const/4 p0, 0x0

    return p0
.end method

.method private static unset(Ljava/lang/String;)Z
    .locals 0

    if-eqz p0, :cond_1

    invoke-virtual {p0}, Ljava/lang/String;->isEmpty()Z

    move-result p0

    if-eqz p0, :cond_0

    goto :goto_0

    :cond_0
    const/4 p0, 0x0

    return p0

    :cond_1
    :goto_0
    const/4 p0, 0x1

    return p0
.end method

.method public static value(Landroid/content/Context;)Ljava/lang/String;
    .locals 2

    :try_start_0
    new-instance v0, Lcom/gmhub/refresh/DisplayScale$NativePort;

    invoke-direct {v0, p0}, Lcom/gmhub/refresh/DisplayScale$NativePort;-><init>(Landroid/content/Context;)V

    invoke-virtual {v0}, Lcom/gmhub/refresh/DisplayScale$NativePort;->read()Lcom/gmhub/refresh/DisplayScale$State;

    move-result-object p0

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget v1, p0, Lcom/gmhub/refresh/DisplayScale$State;->width:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, "x"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget p0, p0, Lcom/gmhub/refresh/DisplayScale$State;->height:I

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-object p0

    :catch_0
    const/4 p0, 0x0

    return-object p0
.end method
