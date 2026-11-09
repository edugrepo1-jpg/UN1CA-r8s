.class public final Lcom/gmhub/qs/NativeHeaderActions;
.super Ljava/lang/Object;
.source "NativeHeaderActions.java"

# interfaces
.implements Ljava/lang/AutoCloseable;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/gmhub/qs/NativeHeaderActions$State;
    }
.end annotation


# static fields
.field private static final PANEL:Ljava/lang/String; = "com.android.systemui.samsung.quicksetting.ui.panel."


# instance fields
.field private final available:Ljava/lang/Object;

.field private closed:Z

.field private final done:Ljava/lang/Object;

.field private final doneInvoke:Ljava/lang/reflect/Method;

.field private doneRequested:Z

.field private final edit:Ljava/lang/Object;

.field private final editingValue:Ljava/lang/reflect/Method;

.field private final gallerySource:Ljava/lang/Object;

.field private final galleryValue:Ljava/lang/reflect/Method;

.field private final galleryVisible:Ljava/lang/Object;

.field private final galleryWrite:Ljava/lang/reflect/Method;

.field private final hasAvailable:Ljava/lang/Object;

.field private final hasAvailableValue:Ljava/lang/reflect/Method;

.field private final host:Ljava/lang/Object;

.field private final keyguard:Ljava/lang/Object;

.field private final launchEdit:Ljava/lang/reflect/Method;

.field private final launchPower:Ljava/lang/reflect/Method;

.field private final model:Ljava/lang/Object;

.field private final owner:Ljava/lang/Thread;

.field private final quickPanel:Ljava/lang/Object;

.field private final sourceValue:Ljava/lang/reflect/Method;

.field private final sourceWrite:Ljava/lang/reflect/Method;

.field private final unlocked:Ljava/lang/reflect/Method;

.field private final user:I

.field private final userId:Ljava/lang/reflect/Method;

.field private final visible:Ljava/lang/reflect/Method;

.field private wasEditing:Z


# direct methods
.method public constructor <init>(Ljava/lang/Object;)V
    .locals 7
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/ReflectiveOperationException;
        }
    .end annotation

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    move-result-object v0

    iput-object v0, p0, Lcom/gmhub/qs/NativeHeaderActions;->owner:Ljava/lang/Thread;

    invoke-static {p1}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    iput-object v0, p0, Lcom/gmhub/qs/NativeHeaderActions;->model:Ljava/lang/Object;

    const-string v0, "qsHost"

    invoke-static {p1, v0}, Lcom/gmhub/qs/NativeHeaderActions;->field(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    iput-object v0, p0, Lcom/gmhub/qs/NativeHeaderActions;->host:Ljava/lang/Object;

    const-string v1, "$$delegate_0"

    invoke-static {p1, v1}, Lcom/gmhub/qs/NativeHeaderActions;->field(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    iput-object v1, p0, Lcom/gmhub/qs/NativeHeaderActions;->edit:Ljava/lang/Object;

    const-string v2, "keyguardStateController"

    invoke-static {p1, v2}, Lcom/gmhub/qs/NativeHeaderActions;->field(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v2

    iput-object v2, p0, Lcom/gmhub/qs/NativeHeaderActions;->keyguard:Ljava/lang/Object;

    const-string v3, "$$delegate_3"

    invoke-static {p1, v3}, Lcom/gmhub/qs/NativeHeaderActions;->field(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v3

    iput-object v3, p0, Lcom/gmhub/qs/NativeHeaderActions;->available:Ljava/lang/Object;

    const/4 v4, 0x0

    new-array v5, v4, [Ljava/lang/Class;

    const-string v6, "getUserId"

    invoke-static {v0, v6, v5}, Lcom/gmhub/qs/NativeHeaderActions;->method(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v5

    iput-object v5, p0, Lcom/gmhub/qs/NativeHeaderActions;->userId:Ljava/lang/reflect/Method;

    new-array v6, v4, [Ljava/lang/Object;

    invoke-static {v5, v0, v6}, Lcom/gmhub/qs/NativeHeaderActions;->call(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Number;

    invoke-virtual {v0}, Ljava/lang/Number;->intValue()I

    move-result v0

    iput v0, p0, Lcom/gmhub/qs/NativeHeaderActions;->user:I

    const-string v0, "launchEditMode"

    new-array v5, v4, [Ljava/lang/Class;

    invoke-static {p1, v0, v5}, Lcom/gmhub/qs/NativeHeaderActions;->method(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    iput-object v0, p0, Lcom/gmhub/qs/NativeHeaderActions;->launchEdit:Ljava/lang/reflect/Method;

    const-string v0, "launchPowerMenu"

    new-array v5, v4, [Ljava/lang/Class;

    invoke-static {p1, v0, v5}, Lcom/gmhub/qs/NativeHeaderActions;->method(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    iput-object v0, p0, Lcom/gmhub/qs/NativeHeaderActions;->launchPower:Ljava/lang/reflect/Method;

    const-string v0, "editMode"

    invoke-static {v1, v0}, Lcom/gmhub/qs/NativeHeaderActions;->field(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    new-array v1, v4, [Ljava/lang/Class;

    const-string v5, "getValue"

    invoke-static {v0, v5, v1}, Lcom/gmhub/qs/NativeHeaderActions;->method(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    iput-object v0, p0, Lcom/gmhub/qs/NativeHeaderActions;->editingValue:Ljava/lang/reflect/Method;

    const-string v0, "isUnlocked"

    new-array v1, v4, [Ljava/lang/Class;

    invoke-static {v2, v0, v1}, Lcom/gmhub/qs/NativeHeaderActions;->method(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    iput-object v0, p0, Lcom/gmhub/qs/NativeHeaderActions;->unlocked:Ljava/lang/reflect/Method;

    const-string v0, "isVisible"

    new-array v1, v4, [Ljava/lang/Class;

    invoke-static {v2, v0, v1}, Lcom/gmhub/qs/NativeHeaderActions;->method(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    iput-object v0, p0, Lcom/gmhub/qs/NativeHeaderActions;->visible:Ljava/lang/reflect/Method;

    const-string v0, "hasAvailableTiles"

    invoke-static {v3, v0}, Lcom/gmhub/qs/NativeHeaderActions;->field(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    iput-object v0, p0, Lcom/gmhub/qs/NativeHeaderActions;->hasAvailable:Ljava/lang/Object;

    new-array v1, v4, [Ljava/lang/Class;

    invoke-static {v0, v5, v1}, Lcom/gmhub/qs/NativeHeaderActions;->method(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    iput-object v0, p0, Lcom/gmhub/qs/NativeHeaderActions;->hasAvailableValue:Ljava/lang/reflect/Method;

    const-string v0, "_availableTilesSource"

    invoke-static {v3, v0}, Lcom/gmhub/qs/NativeHeaderActions;->field(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    iput-object v0, p0, Lcom/gmhub/qs/NativeHeaderActions;->gallerySource:Ljava/lang/Object;

    const-string v1, "_showAvailableTiles"

    invoke-static {v3, v1}, Lcom/gmhub/qs/NativeHeaderActions;->field(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    iput-object v1, p0, Lcom/gmhub/qs/NativeHeaderActions;->galleryVisible:Ljava/lang/Object;

    new-array v2, v4, [Ljava/lang/Class;

    invoke-static {v0, v5, v2}, Lcom/gmhub/qs/NativeHeaderActions;->method(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v2

    iput-object v2, p0, Lcom/gmhub/qs/NativeHeaderActions;->sourceValue:Ljava/lang/reflect/Method;

    const-class v2, Ljava/lang/Object;

    filled-new-array {v2}, [Ljava/lang/Class;

    move-result-object v2

    const-string v3, "setValue"

    invoke-static {v0, v3, v2}, Lcom/gmhub/qs/NativeHeaderActions;->method(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    iput-object v0, p0, Lcom/gmhub/qs/NativeHeaderActions;->sourceWrite:Ljava/lang/reflect/Method;

    new-array v0, v4, [Ljava/lang/Class;

    invoke-static {v1, v5, v0}, Lcom/gmhub/qs/NativeHeaderActions;->method(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    iput-object v0, p0, Lcom/gmhub/qs/NativeHeaderActions;->galleryValue:Ljava/lang/reflect/Method;

    const-class v0, Ljava/lang/Object;

    filled-new-array {v0}, [Ljava/lang/Class;

    move-result-object v0

    invoke-static {v1, v3, v0}, Lcom/gmhub/qs/NativeHeaderActions;->method(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    iput-object v0, p0, Lcom/gmhub/qs/NativeHeaderActions;->galleryWrite:Ljava/lang/reflect/Method;

    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v0

    const-string v1, "com.android.systemui.samsung.quicksetting.ui.panel.AvailableTilesSource"

    invoke-static {v1, v4, v0}, Ljava/lang/Class;->forName(Ljava/lang/String;ZLjava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object v1

    const-string v2, "QUICK_PANEL"

    invoke-virtual {v1, v2}, Ljava/lang/Class;->getField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    iput-object v1, p0, Lcom/gmhub/qs/NativeHeaderActions;->quickPanel:Ljava/lang/Object;

    const-string v1, "com.android.systemui.samsung.quicksetting.ui.panel.SecQuickSettingHeaderKt$$ExternalSyntheticLambda35"

    invoke-static {v1, v4, v0}, Ljava/lang/Class;->forName(Ljava/lang/String;ZLjava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object v0

    sget-object v1, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    filled-new-array {v1}, [Ljava/lang/Class;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/Class;->getConstructor([Ljava/lang/Class;)Ljava/lang/reflect/Constructor;

    move-result-object v1

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/reflect/Constructor;->newInstance([Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    iput-object v1, p0, Lcom/gmhub/qs/NativeHeaderActions;->done:Ljava/lang/Object;

    const-string v3, "f$0"

    invoke-virtual {v0, v3}, Ljava/lang/Class;->getField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v3

    invoke-virtual {v3, v1, p1}, Ljava/lang/reflect/Field;->set(Ljava/lang/Object;Ljava/lang/Object;)V

    const-string p1, "invoke"

    invoke-virtual {v0, p1, v2}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object p1

    iput-object p1, p0, Lcom/gmhub/qs/NativeHeaderActions;->doneInvoke:Ljava/lang/reflect/Method;

    return-void
.end method

.method private static bool(Ljava/lang/Object;)Z
    .locals 1

    instance-of v0, p0, Ljava/lang/Boolean;

    if-eqz v0, :cond_0

    check-cast p0, Ljava/lang/Boolean;

    invoke-virtual {p0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result p0

    return p0

    :cond_0
    new-instance p0, Ljava/lang/IllegalStateException;

    const-string v0, "Changed native header boolean"

    invoke-direct {p0, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p0
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

    const-string p2, "Native header action failed"

    invoke-direct {p1, p2, p0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw p1

    :cond_1
    check-cast p0, Ljava/lang/RuntimeException;

    throw p0
.end method

.method private editing()Z
    .locals 2

    :try_start_0
    iget-object v0, p0, Lcom/gmhub/qs/NativeHeaderActions;->editingValue:Ljava/lang/reflect/Method;

    iget-object p0, p0, Lcom/gmhub/qs/NativeHeaderActions;->edit:Ljava/lang/Object;

    const-string v1, "editMode"

    invoke-static {p0, v1}, Lcom/gmhub/qs/NativeHeaderActions;->field(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p0

    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {v0, p0, v1}, Lcom/gmhub/qs/NativeHeaderActions;->call(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    invoke-static {p0}, Lcom/gmhub/qs/NativeHeaderActions;->bool(Ljava/lang/Object;)Z

    move-result p0
    :try_end_0
    .catch Ljava/lang/ReflectiveOperationException; {:try_start_0 .. :try_end_0} :catch_0

    return p0

    :catch_0
    move-exception p0

    new-instance v0, Ljava/lang/IllegalStateException;

    invoke-direct {v0, p0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/Throwable;)V

    throw v0
.end method

.method private static field(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/ReflectiveOperationException;
        }
    .end annotation

    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/Class;->getField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object p1

    const/4 v0, 0x1

    invoke-virtual {p1, v0}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    invoke-virtual {p1, p0}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    return-object p0
.end method

.method private static varargs method(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Object;",
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

    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object p0

    invoke-virtual {p0, p1, p2}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object p0

    const/4 p1, 0x1

    invoke-virtual {p0, p1}, Ljava/lang/reflect/Method;->setAccessible(Z)V

    return-object p0
.end method

.method private ui()V
    .locals 1

    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    move-result-object v0

    iget-object p0, p0, Lcom/gmhub/qs/NativeHeaderActions;->owner:Ljava/lang/Thread;

    if-ne v0, p0, :cond_0

    return-void

    :cond_0
    new-instance p0, Ljava/lang/IllegalStateException;

    const-string v0, "QS UI owner required"

    invoke-direct {p0, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p0
.end method

.method private unlocked()Z
    .locals 4

    iget-object v0, p0, Lcom/gmhub/qs/NativeHeaderActions;->unlocked:Ljava/lang/reflect/Method;

    iget-object v1, p0, Lcom/gmhub/qs/NativeHeaderActions;->keyguard:Ljava/lang/Object;

    const/4 v2, 0x0

    new-array v3, v2, [Ljava/lang/Object;

    invoke-static {v0, v1, v3}, Lcom/gmhub/qs/NativeHeaderActions;->call(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    invoke-static {v0}, Lcom/gmhub/qs/NativeHeaderActions;->bool(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/gmhub/qs/NativeHeaderActions;->visible:Ljava/lang/reflect/Method;

    iget-object p0, p0, Lcom/gmhub/qs/NativeHeaderActions;->keyguard:Ljava/lang/Object;

    new-array v1, v2, [Ljava/lang/Object;

    invoke-static {v0, p0, v1}, Lcom/gmhub/qs/NativeHeaderActions;->call(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    invoke-static {p0}, Lcom/gmhub/qs/NativeHeaderActions;->bool(Ljava/lang/Object;)Z

    move-result p0

    if-nez p0, :cond_0

    const/4 p0, 0x1

    return p0

    :cond_0
    return v2
.end method


# virtual methods
.method public close()V
    .locals 1

    invoke-direct {p0}, Lcom/gmhub/qs/NativeHeaderActions;->ui()V

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/gmhub/qs/NativeHeaderActions;->closed:Z

    return-void
.end method

.method public current()Z
    .locals 4

    invoke-direct {p0}, Lcom/gmhub/qs/NativeHeaderActions;->ui()V

    iget-boolean v0, p0, Lcom/gmhub/qs/NativeHeaderActions;->closed:Z

    const/4 v1, 0x0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/gmhub/qs/NativeHeaderActions;->userId:Ljava/lang/reflect/Method;

    iget-object v2, p0, Lcom/gmhub/qs/NativeHeaderActions;->host:Ljava/lang/Object;

    new-array v3, v1, [Ljava/lang/Object;

    invoke-static {v0, v2, v3}, Lcom/gmhub/qs/NativeHeaderActions;->call(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Number;

    invoke-virtual {v0}, Ljava/lang/Number;->intValue()I

    move-result v0

    iget p0, p0, Lcom/gmhub/qs/NativeHeaderActions;->user:I

    if-ne v0, p0, :cond_0

    const/4 p0, 0x1

    return p0

    :cond_0
    return v1
.end method

.method public done()Z
    .locals 3

    invoke-virtual {p0}, Lcom/gmhub/qs/NativeHeaderActions;->current()Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_1

    invoke-direct {p0}, Lcom/gmhub/qs/NativeHeaderActions;->editing()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-direct {p0}, Lcom/gmhub/qs/NativeHeaderActions;->unlocked()Z

    move-result v0

    if-eqz v0, :cond_1

    iget-boolean v0, p0, Lcom/gmhub/qs/NativeHeaderActions;->doneRequested:Z

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/gmhub/qs/NativeHeaderActions;->wasEditing:Z

    iput-boolean v0, p0, Lcom/gmhub/qs/NativeHeaderActions;->doneRequested:Z

    iget-object v2, p0, Lcom/gmhub/qs/NativeHeaderActions;->doneInvoke:Ljava/lang/reflect/Method;

    iget-object p0, p0, Lcom/gmhub/qs/NativeHeaderActions;->done:Ljava/lang/Object;

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {v2, p0, v1}, Lcom/gmhub/qs/NativeHeaderActions;->call(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    return v0

    :cond_1
    :goto_0
    return v1
.end method

.method public edit()Z
    .locals 2

    invoke-virtual {p0}, Lcom/gmhub/qs/NativeHeaderActions;->current()Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_1

    invoke-direct {p0}, Lcom/gmhub/qs/NativeHeaderActions;->editing()Z

    move-result v0

    if-nez v0, :cond_1

    invoke-direct {p0}, Lcom/gmhub/qs/NativeHeaderActions;->unlocked()Z

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lcom/gmhub/qs/NativeHeaderActions;->launchEdit:Ljava/lang/reflect/Method;

    iget-object p0, p0, Lcom/gmhub/qs/NativeHeaderActions;->model:Ljava/lang/Object;

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {v0, p0, v1}, Lcom/gmhub/qs/NativeHeaderActions;->call(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    const/4 p0, 0x1

    return p0

    :cond_1
    :goto_0
    return v1
.end method

.method public gallery()Z
    .locals 6

    invoke-virtual {p0}, Lcom/gmhub/qs/NativeHeaderActions;->current()Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_a

    invoke-direct {p0}, Lcom/gmhub/qs/NativeHeaderActions;->editing()Z

    move-result v0

    if-eqz v0, :cond_a

    invoke-direct {p0}, Lcom/gmhub/qs/NativeHeaderActions;->unlocked()Z

    move-result v0

    if-eqz v0, :cond_a

    iget-object v0, p0, Lcom/gmhub/qs/NativeHeaderActions;->hasAvailableValue:Ljava/lang/reflect/Method;

    iget-object v2, p0, Lcom/gmhub/qs/NativeHeaderActions;->hasAvailable:Ljava/lang/Object;

    new-array v3, v1, [Ljava/lang/Object;

    invoke-static {v0, v2, v3}, Lcom/gmhub/qs/NativeHeaderActions;->call(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    invoke-static {v0}, Lcom/gmhub/qs/NativeHeaderActions;->bool(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    goto/16 :goto_2

    :cond_0
    iget-object v0, p0, Lcom/gmhub/qs/NativeHeaderActions;->sourceValue:Ljava/lang/reflect/Method;

    iget-object v2, p0, Lcom/gmhub/qs/NativeHeaderActions;->gallerySource:Ljava/lang/Object;

    new-array v3, v1, [Ljava/lang/Object;

    invoke-static {v0, v2, v3}, Lcom/gmhub/qs/NativeHeaderActions;->call(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    iget-object v2, p0, Lcom/gmhub/qs/NativeHeaderActions;->quickPanel:Ljava/lang/Object;

    const/4 v3, 0x1

    if-ne v0, v2, :cond_1

    iget-object v2, p0, Lcom/gmhub/qs/NativeHeaderActions;->galleryValue:Ljava/lang/reflect/Method;

    iget-object v4, p0, Lcom/gmhub/qs/NativeHeaderActions;->galleryVisible:Ljava/lang/Object;

    new-array v5, v1, [Ljava/lang/Object;

    invoke-static {v2, v4, v5}, Lcom/gmhub/qs/NativeHeaderActions;->call(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    invoke-static {v2}, Lcom/gmhub/qs/NativeHeaderActions;->bool(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_1

    return v3

    :cond_1
    :try_start_0
    iget-object v2, p0, Lcom/gmhub/qs/NativeHeaderActions;->sourceWrite:Ljava/lang/reflect/Method;

    iget-object v4, p0, Lcom/gmhub/qs/NativeHeaderActions;->gallerySource:Ljava/lang/Object;

    iget-object v5, p0, Lcom/gmhub/qs/NativeHeaderActions;->quickPanel:Ljava/lang/Object;

    filled-new-array {v5}, [Ljava/lang/Object;

    move-result-object v5

    invoke-static {v2, v4, v5}, Lcom/gmhub/qs/NativeHeaderActions;->call(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v2, p0, Lcom/gmhub/qs/NativeHeaderActions;->sourceValue:Ljava/lang/reflect/Method;

    iget-object v4, p0, Lcom/gmhub/qs/NativeHeaderActions;->gallerySource:Ljava/lang/Object;

    new-array v5, v1, [Ljava/lang/Object;

    invoke-static {v2, v4, v5}, Lcom/gmhub/qs/NativeHeaderActions;->call(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    iget-object v4, p0, Lcom/gmhub/qs/NativeHeaderActions;->quickPanel:Ljava/lang/Object;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eq v2, v4, :cond_3

    invoke-virtual {p0}, Lcom/gmhub/qs/NativeHeaderActions;->current()Z

    move-result v2

    if-eqz v2, :cond_2

    iget-object v2, p0, Lcom/gmhub/qs/NativeHeaderActions;->galleryValue:Ljava/lang/reflect/Method;

    iget-object v3, p0, Lcom/gmhub/qs/NativeHeaderActions;->galleryVisible:Ljava/lang/Object;

    new-array v4, v1, [Ljava/lang/Object;

    invoke-static {v2, v3, v4}, Lcom/gmhub/qs/NativeHeaderActions;->call(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    invoke-static {v2}, Lcom/gmhub/qs/NativeHeaderActions;->bool(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_2

    iget-object v2, p0, Lcom/gmhub/qs/NativeHeaderActions;->sourceValue:Ljava/lang/reflect/Method;

    iget-object v3, p0, Lcom/gmhub/qs/NativeHeaderActions;->gallerySource:Ljava/lang/Object;

    new-array v4, v1, [Ljava/lang/Object;

    invoke-static {v2, v3, v4}, Lcom/gmhub/qs/NativeHeaderActions;->call(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    iget-object v3, p0, Lcom/gmhub/qs/NativeHeaderActions;->quickPanel:Ljava/lang/Object;

    if-ne v2, v3, :cond_2

    if-eq v0, v3, :cond_2

    iget-object v2, p0, Lcom/gmhub/qs/NativeHeaderActions;->sourceWrite:Ljava/lang/reflect/Method;

    iget-object p0, p0, Lcom/gmhub/qs/NativeHeaderActions;->gallerySource:Ljava/lang/Object;

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    invoke-static {v2, p0, v0}, Lcom/gmhub/qs/NativeHeaderActions;->call(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    :cond_2
    return v1

    :cond_3
    :try_start_1
    invoke-virtual {p0}, Lcom/gmhub/qs/NativeHeaderActions;->current()Z

    move-result v2

    if-eqz v2, :cond_7

    invoke-direct {p0}, Lcom/gmhub/qs/NativeHeaderActions;->editing()Z

    move-result v2

    if-eqz v2, :cond_7

    invoke-direct {p0}, Lcom/gmhub/qs/NativeHeaderActions;->unlocked()Z

    move-result v2

    if-nez v2, :cond_4

    goto :goto_1

    :cond_4
    iget-object v2, p0, Lcom/gmhub/qs/NativeHeaderActions;->galleryWrite:Ljava/lang/reflect/Method;

    iget-object v4, p0, Lcom/gmhub/qs/NativeHeaderActions;->galleryVisible:Ljava/lang/Object;

    sget-object v5, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    filled-new-array {v5}, [Ljava/lang/Object;

    move-result-object v5

    invoke-static {v2, v4, v5}, Lcom/gmhub/qs/NativeHeaderActions;->call(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    invoke-virtual {p0}, Lcom/gmhub/qs/NativeHeaderActions;->current()Z

    move-result v2

    if-eqz v2, :cond_5

    iget-object v2, p0, Lcom/gmhub/qs/NativeHeaderActions;->galleryValue:Ljava/lang/reflect/Method;

    iget-object v4, p0, Lcom/gmhub/qs/NativeHeaderActions;->galleryVisible:Ljava/lang/Object;

    new-array v5, v1, [Ljava/lang/Object;

    invoke-static {v2, v4, v5}, Lcom/gmhub/qs/NativeHeaderActions;->call(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    invoke-static {v2}, Lcom/gmhub/qs/NativeHeaderActions;->bool(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_5

    iget-object v2, p0, Lcom/gmhub/qs/NativeHeaderActions;->sourceValue:Ljava/lang/reflect/Method;

    iget-object v4, p0, Lcom/gmhub/qs/NativeHeaderActions;->gallerySource:Ljava/lang/Object;

    new-array v5, v1, [Ljava/lang/Object;

    invoke-static {v2, v4, v5}, Lcom/gmhub/qs/NativeHeaderActions;->call(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    iget-object v4, p0, Lcom/gmhub/qs/NativeHeaderActions;->quickPanel:Ljava/lang/Object;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    if-ne v2, v4, :cond_5

    goto :goto_0

    :cond_5
    move v3, v1

    :goto_0
    invoke-virtual {p0}, Lcom/gmhub/qs/NativeHeaderActions;->current()Z

    move-result v2

    if-eqz v2, :cond_6

    iget-object v2, p0, Lcom/gmhub/qs/NativeHeaderActions;->galleryValue:Ljava/lang/reflect/Method;

    iget-object v4, p0, Lcom/gmhub/qs/NativeHeaderActions;->galleryVisible:Ljava/lang/Object;

    new-array v5, v1, [Ljava/lang/Object;

    invoke-static {v2, v4, v5}, Lcom/gmhub/qs/NativeHeaderActions;->call(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    invoke-static {v2}, Lcom/gmhub/qs/NativeHeaderActions;->bool(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_6

    iget-object v2, p0, Lcom/gmhub/qs/NativeHeaderActions;->sourceValue:Ljava/lang/reflect/Method;

    iget-object v4, p0, Lcom/gmhub/qs/NativeHeaderActions;->gallerySource:Ljava/lang/Object;

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {v2, v4, v1}, Lcom/gmhub/qs/NativeHeaderActions;->call(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    iget-object v2, p0, Lcom/gmhub/qs/NativeHeaderActions;->quickPanel:Ljava/lang/Object;

    if-ne v1, v2, :cond_6

    if-eq v0, v2, :cond_6

    iget-object v1, p0, Lcom/gmhub/qs/NativeHeaderActions;->sourceWrite:Ljava/lang/reflect/Method;

    iget-object p0, p0, Lcom/gmhub/qs/NativeHeaderActions;->gallerySource:Ljava/lang/Object;

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    invoke-static {v1, p0, v0}, Lcom/gmhub/qs/NativeHeaderActions;->call(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    :cond_6
    return v3

    :cond_7
    :goto_1
    invoke-virtual {p0}, Lcom/gmhub/qs/NativeHeaderActions;->current()Z

    move-result v2

    if-eqz v2, :cond_8

    iget-object v2, p0, Lcom/gmhub/qs/NativeHeaderActions;->galleryValue:Ljava/lang/reflect/Method;

    iget-object v3, p0, Lcom/gmhub/qs/NativeHeaderActions;->galleryVisible:Ljava/lang/Object;

    new-array v4, v1, [Ljava/lang/Object;

    invoke-static {v2, v3, v4}, Lcom/gmhub/qs/NativeHeaderActions;->call(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    invoke-static {v2}, Lcom/gmhub/qs/NativeHeaderActions;->bool(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_8

    iget-object v2, p0, Lcom/gmhub/qs/NativeHeaderActions;->sourceValue:Ljava/lang/reflect/Method;

    iget-object v3, p0, Lcom/gmhub/qs/NativeHeaderActions;->gallerySource:Ljava/lang/Object;

    new-array v4, v1, [Ljava/lang/Object;

    invoke-static {v2, v3, v4}, Lcom/gmhub/qs/NativeHeaderActions;->call(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    iget-object v3, p0, Lcom/gmhub/qs/NativeHeaderActions;->quickPanel:Ljava/lang/Object;

    if-ne v2, v3, :cond_8

    if-eq v0, v3, :cond_8

    iget-object v2, p0, Lcom/gmhub/qs/NativeHeaderActions;->sourceWrite:Ljava/lang/reflect/Method;

    iget-object p0, p0, Lcom/gmhub/qs/NativeHeaderActions;->gallerySource:Ljava/lang/Object;

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    invoke-static {v2, p0, v0}, Lcom/gmhub/qs/NativeHeaderActions;->call(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    :cond_8
    return v1

    :catchall_0
    move-exception v2

    invoke-virtual {p0}, Lcom/gmhub/qs/NativeHeaderActions;->current()Z

    move-result v3

    if-eqz v3, :cond_9

    iget-object v3, p0, Lcom/gmhub/qs/NativeHeaderActions;->galleryValue:Ljava/lang/reflect/Method;

    iget-object v4, p0, Lcom/gmhub/qs/NativeHeaderActions;->galleryVisible:Ljava/lang/Object;

    new-array v5, v1, [Ljava/lang/Object;

    invoke-static {v3, v4, v5}, Lcom/gmhub/qs/NativeHeaderActions;->call(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    invoke-static {v3}, Lcom/gmhub/qs/NativeHeaderActions;->bool(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_9

    iget-object v3, p0, Lcom/gmhub/qs/NativeHeaderActions;->sourceValue:Ljava/lang/reflect/Method;

    iget-object v4, p0, Lcom/gmhub/qs/NativeHeaderActions;->gallerySource:Ljava/lang/Object;

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {v3, v4, v1}, Lcom/gmhub/qs/NativeHeaderActions;->call(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    iget-object v3, p0, Lcom/gmhub/qs/NativeHeaderActions;->quickPanel:Ljava/lang/Object;

    if-ne v1, v3, :cond_9

    if-eq v0, v3, :cond_9

    iget-object v1, p0, Lcom/gmhub/qs/NativeHeaderActions;->sourceWrite:Ljava/lang/reflect/Method;

    iget-object p0, p0, Lcom/gmhub/qs/NativeHeaderActions;->gallerySource:Ljava/lang/Object;

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    invoke-static {v1, p0, v0}, Lcom/gmhub/qs/NativeHeaderActions;->call(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    :cond_9
    throw v2

    :cond_a
    :goto_2
    return v1
.end method

.method public power()Z
    .locals 2

    invoke-virtual {p0}, Lcom/gmhub/qs/NativeHeaderActions;->current()Z

    move-result v0

    const/4 v1, 0x0

    if-nez v0, :cond_0

    return v1

    :cond_0
    iget-object v0, p0, Lcom/gmhub/qs/NativeHeaderActions;->launchPower:Ljava/lang/reflect/Method;

    iget-object p0, p0, Lcom/gmhub/qs/NativeHeaderActions;->model:Ljava/lang/Object;

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {v0, p0, v1}, Lcom/gmhub/qs/NativeHeaderActions;->call(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    const/4 p0, 0x1

    return p0
.end method

.method public state()Lcom/gmhub/qs/NativeHeaderActions$State;
    .locals 8

    invoke-virtual {p0}, Lcom/gmhub/qs/NativeHeaderActions;->current()Z

    move-result v0

    if-nez v0, :cond_0

    new-instance v1, Lcom/gmhub/qs/NativeHeaderActions$State;

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v2, 0x0

    const/4 v3, 0x0

    const/4 v4, 0x0

    invoke-direct/range {v1 .. v6}, Lcom/gmhub/qs/NativeHeaderActions$State;-><init>(ZZZZZ)V

    return-object v1

    :cond_0
    invoke-direct {p0}, Lcom/gmhub/qs/NativeHeaderActions;->editing()Z

    move-result v4

    const/4 v0, 0x0

    if-eqz v4, :cond_1

    iget-boolean v1, p0, Lcom/gmhub/qs/NativeHeaderActions;->wasEditing:Z

    if-nez v1, :cond_1

    iput-boolean v0, p0, Lcom/gmhub/qs/NativeHeaderActions;->doneRequested:Z

    :cond_1
    iput-boolean v4, p0, Lcom/gmhub/qs/NativeHeaderActions;->wasEditing:Z

    invoke-direct {p0}, Lcom/gmhub/qs/NativeHeaderActions;->unlocked()Z

    move-result v5

    new-instance v2, Lcom/gmhub/qs/NativeHeaderActions$State;

    iget-object v1, p0, Lcom/gmhub/qs/NativeHeaderActions;->hasAvailableValue:Ljava/lang/reflect/Method;

    iget-object v3, p0, Lcom/gmhub/qs/NativeHeaderActions;->hasAvailable:Ljava/lang/Object;

    new-array v6, v0, [Ljava/lang/Object;

    invoke-static {v1, v3, v6}, Lcom/gmhub/qs/NativeHeaderActions;->call(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    invoke-static {v1}, Lcom/gmhub/qs/NativeHeaderActions;->bool(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v4, :cond_2

    if-eqz v5, :cond_2

    iget-boolean p0, p0, Lcom/gmhub/qs/NativeHeaderActions;->doneRequested:Z

    if-nez p0, :cond_2

    const/4 v0, 0x1

    :cond_2
    move v7, v0

    const/4 v3, 0x1

    invoke-direct/range {v2 .. v7}, Lcom/gmhub/qs/NativeHeaderActions$State;-><init>(ZZZZZ)V

    return-object v2
.end method
