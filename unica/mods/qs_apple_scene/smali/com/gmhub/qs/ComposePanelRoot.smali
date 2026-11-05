.class public final Lcom/gmhub/qs/ComposePanelRoot;
.super Ljava/lang/Object;
.source "ComposePanelRoot.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/gmhub/qs/ComposePanelRoot$Abi;,
        Lcom/gmhub/qs/ComposePanelRoot$Session;,
        Lcom/gmhub/qs/ComposePanelRoot$Callback;
    }
.end annotation


# static fields
.field private static final CONTENT_KEY:I = 0x474d5103

.field private static final GRID:Ljava/lang/String; = "com.android.systemui.samsung.quicksetting.ui.base.spannablegrid."

.field private static final LAMBDA_KEY:I = 0x474d5104

.field private static final ROOT_KEY:I = 0x474d5101

.field private static final RUNTIME:Ljava/lang/String; = "androidx.compose.runtime."

.field private static final SCENE:Ljava/lang/String; = "com.android.systemui.samsung.quicksetting.ui."

.field private static final SESSION_KEY:I = 0x474d5102

.field public static final SETTING:Ljava/lang/String; = "gmhub_qs_style"

.field private static final TAG:Ljava/lang/String; = "GMHubQs"

.field private static volatile abi:Lcom/gmhub/qs/ComposePanelRoot$Abi;

.field private static attempted:Z

.field private static volatile original:Ljava/lang/reflect/Method;


# direct methods
.method private constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$000(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/ClassNotFoundException;
        }
    .end annotation

    invoke-static {p0, p1}, Lcom/gmhub/qs/ComposePanelRoot;->type(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object p0

    return-object p0
.end method

.method static synthetic access$100(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/NoSuchMethodException;
        }
    .end annotation

    invoke-static {p0, p1, p2}, Lcom/gmhub/qs/ComposePanelRoot;->method(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object p0

    return-object p0
.end method

.method static synthetic access$200(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/reflect/Field;
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/NoSuchFieldException;
        }
    .end annotation

    invoke-static {p0, p1}, Lcom/gmhub/qs/ComposePanelRoot;->field(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object p0

    return-object p0
.end method

.method static synthetic access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    invoke-static {p0, p1, p2}, Lcom/gmhub/qs/ComposePanelRoot;->call(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    return-object p0
.end method

.method static synthetic access$400()Ljava/lang/reflect/Method;
    .locals 1

    sget-object v0, Lcom/gmhub/qs/ComposePanelRoot;->original:Ljava/lang/reflect/Method;

    return-object v0
.end method

.method private static varargs call(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    :try_start_0
    invoke-virtual {p0, p1, p2}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0
    :try_end_0
    .catch Ljava/lang/reflect/InvocationTargetException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/ReflectiveOperationException; {:try_start_0 .. :try_end_0} :catch_0

    return-object p0

    :catch_0
    move-exception p0

    new-instance p1, Ljava/lang/IllegalStateException;

    const-string p2, "Native QS invocation contract changed"

    invoke-direct {p1, p2, p0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw p1

    :catch_1
    move-exception p0

    invoke-virtual {p0}, Ljava/lang/reflect/InvocationTargetException;->getCause()Ljava/lang/Throwable;

    move-result-object p0

    instance-of p1, p0, Ljava/lang/RuntimeException;

    if-nez p1, :cond_1

    instance-of p1, p0, Ljava/lang/Error;

    if-eqz p1, :cond_0

    check-cast p0, Ljava/lang/Error;

    throw p0

    :cond_0
    new-instance p1, Ljava/lang/IllegalStateException;

    const-string p2, "Native QS callback failed"

    invoke-direct {p1, p2, p0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw p1

    :cond_1
    check-cast p0, Ljava/lang/RuntimeException;

    throw p0
.end method

.method public static content(Ljava/lang/Object;Ljava/lang/Object;Ljava/util/List;Ljava/lang/Object;Ljava/lang/Object;I)V
    .locals 8
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Object;",
            "Ljava/lang/Object;",
            "Ljava/util/List<",
            "*>;",
            "Ljava/lang/Object;",
            "Ljava/lang/Object;",
            "I)V"
        }
    .end annotation

    invoke-virtual {p4}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v0

    invoke-static {v0}, Lcom/gmhub/qs/ComposePanelRoot;->get(Ljava/lang/ClassLoader;)Lcom/gmhub/qs/ComposePanelRoot$Abi;

    move-result-object v1

    if-nez v1, :cond_0

    sget-object v0, Lcom/gmhub/qs/ComposePanelRoot;->original:Ljava/lang/reflect/Method;

    invoke-static {p5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p5

    filled-new-array/range {p0 .. p5}, [Ljava/lang/Object;

    move-result-object p0

    const/4 p1, 0x0

    invoke-static {v0, p1, p0}, Lcom/gmhub/qs/ComposePanelRoot;->call(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    return-void

    :cond_0
    move-object v2, p0

    move-object v3, p1

    move-object v4, p2

    move-object v5, p3

    move-object v6, p4

    move v7, p5

    invoke-virtual/range {v1 .. v7}, Lcom/gmhub/qs/ComposePanelRoot$Abi;->content(Ljava/lang/Object;Ljava/lang/Object;Ljava/util/List;Ljava/lang/Object;Ljava/lang/Object;I)V

    return-void
.end method

.method private static field(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/reflect/Field;
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Class<",
            "*>;",
            "Ljava/lang/String;",
            ")",
            "Ljava/lang/reflect/Field;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/NoSuchFieldException;
        }
    .end annotation

    invoke-virtual {p0, p1}, Ljava/lang/Class;->getField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object p0

    const/4 p1, 0x1

    invoke-virtual {p0, p1}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    return-object p0
.end method

.method private static declared-synchronized get(Ljava/lang/ClassLoader;)Lcom/gmhub/qs/ComposePanelRoot$Abi;
    .locals 10

    const-class v1, Lcom/gmhub/qs/ComposePanelRoot;

    monitor-enter v1

    :try_start_0
    sget-boolean v0, Lcom/gmhub/qs/ComposePanelRoot;->attempted:Z

    if-eqz v0, :cond_0

    sget-object p0, Lcom/gmhub/qs/ComposePanelRoot;->abi:Lcom/gmhub/qs/ComposePanelRoot$Abi;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v1

    return-object p0

    :cond_0
    const/4 v0, 0x1

    :try_start_1
    sput-boolean v0, Lcom/gmhub/qs/ComposePanelRoot;->attempted:Z
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :try_start_2
    const-string v0, "com.android.systemui.samsung.quicksetting.ui.SecQuickSettingSceneKt"

    invoke-static {p0, v0}, Lcom/gmhub/qs/ComposePanelRoot;->type(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    const-string v2, "SecQuickSettingSceneMain"

    const-string v3, "com.android.compose.animation.scene.ContentScope"

    invoke-static {p0, v3}, Lcom/gmhub/qs/ComposePanelRoot;->type(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v4

    const-string v3, "androidx.compose.ui.Modifier"

    invoke-static {p0, v3}, Lcom/gmhub/qs/ComposePanelRoot;->type(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v5

    const-class v6, Ljava/util/List;

    const-string v3, "com.android.systemui.samsung.quicksetting.ui.panel.QuickTileBoxViewModel"

    invoke-static {p0, v3}, Lcom/gmhub/qs/ComposePanelRoot;->type(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v7

    const-string v3, "androidx.compose.runtime.Composer"

    invoke-static {p0, v3}, Lcom/gmhub/qs/ComposePanelRoot;->type(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v8

    sget-object v9, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    filled-new-array/range {v4 .. v9}, [Ljava/lang/Class;

    move-result-object v3

    invoke-virtual {v0, v2, v3}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    sput-object v0, Lcom/gmhub/qs/ComposePanelRoot;->original:Ljava/lang/reflect/Method;

    new-instance v0, Lcom/gmhub/qs/ComposePanelRoot$Abi;

    invoke-direct {v0, p0}, Lcom/gmhub/qs/ComposePanelRoot$Abi;-><init>(Ljava/lang/ClassLoader;)V

    sput-object v0, Lcom/gmhub/qs/ComposePanelRoot;->abi:Lcom/gmhub/qs/ComposePanelRoot$Abi;
    :try_end_2
    .catch Ljava/lang/ReflectiveOperationException; {:try_start_2 .. :try_end_2} :catch_0
    .catch Ljava/lang/LinkageError; {:try_start_2 .. :try_end_2} :catch_0
    .catch Ljava/lang/SecurityException; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_0

    :catch_0
    move-exception v0

    move-object p0, v0

    :try_start_3
    const-string v0, "GMHubQs"

    const-string v2, "Native QS appearance contract unavailable; using One UI"

    invoke-static {v0, v2, p0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    sget-object v0, Lcom/gmhub/qs/ComposePanelRoot;->original:Ljava/lang/reflect/Method;

    if-eqz v0, :cond_1

    :goto_0
    sget-object p0, Lcom/gmhub/qs/ComposePanelRoot;->abi:Lcom/gmhub/qs/ComposePanelRoot$Abi;
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    monitor-exit v1

    return-object p0

    :cond_1
    :try_start_4
    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v2, "Native Samsung scene missing"

    invoke-direct {v0, v2, p0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw v0

    :catchall_0
    move-exception v0

    move-object p0, v0

    monitor-exit v1
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    throw p0
.end method

.method private static varargs method(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Class<",
            "*>;",
            "Ljava/lang/String;",
            "[",
            "Ljava/lang/Class<",
            "*>;)",
            "Ljava/lang/reflect/Method;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/NoSuchMethodException;
        }
    .end annotation

    invoke-virtual {p0, p1, p2}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object p0

    const/4 p1, 0x1

    invoke-virtual {p0, p1}, Ljava/lang/reflect/Method;->setAccessible(Z)V

    return-object p0
.end method

.method public static shape(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 6

    sget-object v0, Lcom/gmhub/qs/ComposePanelRoot;->abi:Lcom/gmhub/qs/ComposePanelRoot$Abi;

    if-nez v0, :cond_0

    goto :goto_1

    :cond_0
    iget-object v1, v0, Lcom/gmhub/qs/ComposePanelRoot$Abi;->consume:Ljava/lang/reflect/Method;

    iget-object v2, v0, Lcom/gmhub/qs/ComposePanelRoot$Abi;->localStyle:Ljava/lang/Object;

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, p2, v2}, Lcom/gmhub/qs/ComposePanelRoot;->call(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p2

    const/4 v1, 0x1

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v2, p2}, Ljava/lang/Integer;->equals(Ljava/lang/Object;)Z

    move-result p2

    if-nez p2, :cond_1

    goto :goto_1

    :cond_1
    :try_start_0
    iget-object p2, v0, Lcom/gmhub/qs/ComposePanelRoot$Abi;->tileItem:Ljava/lang/reflect/Field;

    invoke-virtual {p2, p0}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p2

    iget-object v2, v0, Lcom/gmhub/qs/ComposePanelRoot$Abi;->media:Ljava/lang/Class;

    invoke-virtual {v2, p2}, Ljava/lang/Class;->isInstance(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_7

    iget-object v2, v0, Lcom/gmhub/qs/ComposePanelRoot$Abi;->legacyMedia:Ljava/lang/Class;

    invoke-virtual {v2, p2}, Ljava/lang/Class;->isInstance(Ljava/lang/Object;)Z

    move-result p2

    if-eqz p2, :cond_2

    goto :goto_1

    :cond_2
    iget-object p2, v0, Lcom/gmhub/qs/ComposePanelRoot$Abi;->tileScope:Ljava/lang/reflect/Field;

    invoke-virtual {p2, p0}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    iget-object p2, v0, Lcom/gmhub/qs/ComposePanelRoot$Abi;->inAvailableGrid:Ljava/lang/reflect/Field;

    invoke-virtual {p2, p0}, Ljava/lang/reflect/Field;->getBoolean(Ljava/lang/Object;)Z

    move-result p2

    if-nez p2, :cond_7

    iget-object p2, v0, Lcom/gmhub/qs/ComposePanelRoot$Abi;->expanded:Ljava/lang/reflect/Field;

    invoke-virtual {p2, p0}, Ljava/lang/reflect/Field;->getBoolean(Ljava/lang/Object;)Z

    move-result p2

    if-eqz p2, :cond_3

    goto :goto_1

    :cond_3
    iget-object p2, v0, Lcom/gmhub/qs/ComposePanelRoot$Abi;->spanSize:Ljava/lang/reflect/Field;

    invoke-virtual {p2, p0}, Ljava/lang/reflect/Field;->getLong(Ljava/lang/Object;)J

    move-result-wide v2

    const/16 p0, 0x20

    shr-long v4, v2, p0

    long-to-int p0, v4

    long-to-int p2, v2

    if-lt p0, v1, :cond_7

    if-ge p2, v1, :cond_4

    goto :goto_1

    :cond_4
    if-eq p0, v1, :cond_6

    if-ne p2, v1, :cond_5

    goto :goto_0

    :cond_5
    iget-object p0, v0, Lcom/gmhub/qs/ComposePanelRoot$Abi;->card:Ljava/lang/Object;

    return-object p0

    :cond_6
    :goto_0
    iget-object p0, v0, Lcom/gmhub/qs/ComposePanelRoot$Abi;->capsule:Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/IllegalAccessException; {:try_start_0 .. :try_end_0} :catch_0

    return-object p0

    :catch_0
    :cond_7
    :goto_1
    return-object p1
.end method

.method private static type(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/ClassLoader;",
            "Ljava/lang/String;",
            ")",
            "Ljava/lang/Class<",
            "*>;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/ClassNotFoundException;
        }
    .end annotation

    const/4 v0, 0x0

    invoke-static {p1, v0, p0}, Ljava/lang/Class;->forName(Ljava/lang/String;ZLjava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object p0

    return-object p0
.end method
