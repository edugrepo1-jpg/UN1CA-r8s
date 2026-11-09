.class public final Lcom/gmhub/qs/IosGridPanel;
.super Ljava/lang/Object;
.source "IosGridPanel.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/gmhub/qs/IosGridPanel$Runtime;,
        Lcom/gmhub/qs/IosGridPanel$RailView;,
        Lcom/gmhub/qs/IosGridPanel$Session;,
        Lcom/gmhub/qs/IosGridPanel$Callback;
    }
.end annotation


# static fields
.field private static final C:Ljava/lang/String; = "androidx.compose.runtime."

.field private static final CUSTOM:I = 0x474d5303

.field private static final NATIVE:I = 0x474d5302

.field private static final P:Ljava/lang/String; = "com.android.systemui.samsung.quicksetting.ui.panel."

.field private static final ROOT:I = 0x474d5301

.field private static final SESSION:I = 0x474d5304

.field private static api:Lcom/gmhub/qs/IosGridPanel$Runtime;

.field private static attempted:Z

.field private static original:Ljava/lang/reflect/Method;


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

    invoke-static {p0, p1}, Lcom/gmhub/qs/IosGridPanel;->type(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

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

    invoke-static {p0, p1, p2}, Lcom/gmhub/qs/IosGridPanel;->method(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

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

    invoke-static {p0, p1}, Lcom/gmhub/qs/IosGridPanel;->field(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object p0

    return-object p0
.end method

.method static synthetic access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    invoke-static {p0, p1, p2}, Lcom/gmhub/qs/IosGridPanel;->call(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    return-object p0
.end method

.method static synthetic access$400()Ljava/lang/reflect/Method;
    .locals 1

    sget-object v0, Lcom/gmhub/qs/IosGridPanel;->original:Ljava/lang/reflect/Method;

    return-object v0
.end method

.method static synthetic access$500(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I
    .locals 0

    invoke-static {p0, p1, p2}, Lcom/gmhub/qs/IosGridPanel;->id(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result p0

    return p0
.end method

.method static active(Ljava/lang/Object;)Z
    .locals 3

    sget-object v0, Lcom/gmhub/qs/IosGridPanel;->api:Lcom/gmhub/qs/IosGridPanel$Runtime;

    if-eqz v0, :cond_0

    sget-object v1, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    iget-object v2, v0, Lcom/gmhub/qs/IosGridPanel$Runtime;->consume:Ljava/lang/reflect/Method;

    iget-object v0, v0, Lcom/gmhub/qs/IosGridPanel$Runtime;->localRail:Ljava/lang/Object;

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    invoke-static {v2, p0, v0}, Lcom/gmhub/qs/IosGridPanel;->call(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    invoke-virtual {v1, p0}, Ljava/lang/Boolean;->equals(Ljava/lang/Object;)Z

    move-result p0

    if-eqz p0, :cond_0

    const/4 p0, 0x1

    return p0

    :cond_0
    const/4 p0, 0x0

    return p0
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

    invoke-direct {p1, p0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/Throwable;)V

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

    invoke-direct {p1, p0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/Throwable;)V

    throw p1

    :cond_1
    check-cast p0, Ljava/lang/RuntimeException;

    throw p0
.end method

.method static content([Ljava/lang/Object;)V
    .locals 2

    const/16 v0, 0xb

    aget-object v0, p0, v0

    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v0

    invoke-static {v0}, Lcom/gmhub/qs/IosGridPanel;->get(Ljava/lang/ClassLoader;)Lcom/gmhub/qs/IosGridPanel$Runtime;

    move-result-object v0

    if-nez v0, :cond_0

    sget-object v0, Lcom/gmhub/qs/IosGridPanel;->original:Ljava/lang/reflect/Method;

    const/4 v1, 0x0

    invoke-static {v0, v1, p0}, Lcom/gmhub/qs/IosGridPanel;->call(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    return-void

    :cond_0
    invoke-virtual {v0, p0}, Lcom/gmhub/qs/IosGridPanel$Runtime;->render([Ljava/lang/Object;)V

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

.method private static declared-synchronized get(Ljava/lang/ClassLoader;)Lcom/gmhub/qs/IosGridPanel$Runtime;
    .locals 18

    move-object/from16 v0, p0

    const-class v1, Lcom/gmhub/qs/IosGridPanel;

    monitor-enter v1

    :try_start_0
    sget-boolean v2, Lcom/gmhub/qs/IosGridPanel;->attempted:Z

    if-eqz v2, :cond_0

    sget-object v0, Lcom/gmhub/qs/IosGridPanel;->api:Lcom/gmhub/qs/IosGridPanel$Runtime;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v1

    return-object v0

    :cond_0
    const/4 v2, 0x1

    :try_start_1
    sput-boolean v2, Lcom/gmhub/qs/IosGridPanel;->attempted:Z
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :try_start_2
    const-string v2, "com.android.systemui.samsung.quicksetting.ui.panel.QuickSettingTileGridKt"

    invoke-static {v0, v2}, Lcom/gmhub/qs/IosGridPanel;->type(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v2

    const-string v3, "QuickSettingTileGrid-RLNbq1o"

    const-string v4, "com.android.compose.animation.scene.ContentScope"

    invoke-static {v0, v4}, Lcom/gmhub/qs/IosGridPanel;->type(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v5

    sget-object v6, Ljava/lang/Long;->TYPE:Ljava/lang/Class;

    sget-object v7, Ljava/lang/Long;->TYPE:Ljava/lang/Class;

    const-string v4, "androidx.compose.runtime.State"

    invoke-static {v0, v4}, Lcom/gmhub/qs/IosGridPanel;->type(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v8

    const-string v4, "com.android.systemui.samsung.quicksetting.ui.base.spannablegrid.SpannableGridState"

    invoke-static {v0, v4}, Lcom/gmhub/qs/IosGridPanel;->type(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v9

    const-string v4, "androidx.compose.foundation.ScrollState"

    invoke-static {v0, v4}, Lcom/gmhub/qs/IosGridPanel;->type(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v10

    const-string v4, "kotlin.jvm.functions.Function0"

    invoke-static {v0, v4}, Lcom/gmhub/qs/IosGridPanel;->type(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v11

    const-string v4, "com.android.systemui.samsung.quicksetting.ui.panel.ContextMenuScope"

    invoke-static {v0, v4}, Lcom/gmhub/qs/IosGridPanel;->type(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v12

    sget-object v13, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    const-string v4, "com.android.systemui.samsung.quicksetting.ui.banner.TopBannerViewModel"

    invoke-static {v0, v4}, Lcom/gmhub/qs/IosGridPanel;->type(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v14

    const-string v4, "com.android.systemui.samsung.quicksetting.ui.banner.BottomBannerViewModel"

    invoke-static {v0, v4}, Lcom/gmhub/qs/IosGridPanel;->type(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v15

    const-string v4, "androidx.compose.runtime.Composer"

    invoke-static {v0, v4}, Lcom/gmhub/qs/IosGridPanel;->type(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v16

    sget-object v17, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    filled-new-array/range {v5 .. v17}, [Ljava/lang/Class;

    move-result-object v4

    invoke-virtual {v2, v3, v4}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v2

    sput-object v2, Lcom/gmhub/qs/IosGridPanel;->original:Ljava/lang/reflect/Method;

    new-instance v2, Lcom/gmhub/qs/IosGridPanel$Runtime;

    invoke-direct {v2, v0}, Lcom/gmhub/qs/IosGridPanel$Runtime;-><init>(Ljava/lang/ClassLoader;)V

    sput-object v2, Lcom/gmhub/qs/IosGridPanel;->api:Lcom/gmhub/qs/IosGridPanel$Runtime;
    :try_end_2
    .catch Ljava/lang/ReflectiveOperationException; {:try_start_2 .. :try_end_2} :catch_0
    .catch Ljava/lang/LinkageError; {:try_start_2 .. :try_end_2} :catch_0
    .catch Ljava/lang/SecurityException; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_0

    :catch_0
    move-exception v0

    :try_start_3
    const-string v2, "GMHubQs"

    const-string v3, "Page rail contract unavailable; preserving native grid"

    invoke-static {v2, v3, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    sget-object v2, Lcom/gmhub/qs/IosGridPanel;->original:Ljava/lang/reflect/Method;

    if-eqz v2, :cond_1

    :goto_0
    sget-object v0, Lcom/gmhub/qs/IosGridPanel;->api:Lcom/gmhub/qs/IosGridPanel$Runtime;
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    monitor-exit v1

    return-object v0

    :cond_1
    :try_start_4
    new-instance v2, Ljava/lang/IllegalStateException;

    const-string v3, "Native grid missing"

    invoke-direct {v2, v3, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw v2

    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    throw v0
.end method

.method private static id(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I
    .locals 1

    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object p0

    const-string v0, "com.android.systemui"

    invoke-virtual {p0, p1, p2, v0}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result p0

    if-eqz p0, :cond_0

    return p0

    :cond_0
    new-instance p0, Ljava/lang/IllegalStateException;

    new-instance p2, Ljava/lang/StringBuilder;

    const-string v0, "Missing page resource: "

    invoke-direct {p2, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p0, p1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

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
