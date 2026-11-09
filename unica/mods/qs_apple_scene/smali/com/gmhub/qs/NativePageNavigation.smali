.class public final Lcom/gmhub/qs/NativePageNavigation;
.super Ljava/lang/Object;
.source "NativePageNavigation.java"

# interfaces
.implements Ljava/lang/AutoCloseable;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/gmhub/qs/NativePageNavigation$Pages;,
        Lcom/gmhub/qs/NativePageNavigation$Request;
    }
.end annotation


# instance fields
.field private final animate:Ljava/lang/reflect/Method;

.field private closed:Z

.field private final dragging:Ljava/lang/reflect/Method;

.field private final grid:Ljava/lang/Object;

.field private final host:Ljava/lang/Object;

.field private final intValue:Ljava/lang/reflect/Method;

.field private final max:Ljava/lang/reflect/Method;

.field private final owner:Ljava/lang/Thread;

.field private final scroll:Ljava/lang/Object;

.field private final user:I

.field private final userId:Ljava/lang/reflect/Method;

.field private final value:Ljava/lang/reflect/Method;

.field private final viewport:Ljava/lang/Object;


# direct methods
.method public constructor <init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)V
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/ReflectiveOperationException;
        }
    .end annotation

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    move-result-object v0

    iput-object v0, p0, Lcom/gmhub/qs/NativePageNavigation;->owner:Ljava/lang/Thread;

    const-string v0, "qsHost"

    invoke-static {p1, v0}, Lcom/gmhub/qs/NativePageNavigation;->field(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    iput-object v0, p0, Lcom/gmhub/qs/NativePageNavigation;->host:Ljava/lang/Object;

    iput-object p2, p0, Lcom/gmhub/qs/NativePageNavigation;->grid:Ljava/lang/Object;

    iput-object p3, p0, Lcom/gmhub/qs/NativePageNavigation;->scroll:Ljava/lang/Object;

    const-string v1, "getUserId"

    invoke-static {v0, v1}, Lcom/gmhub/qs/NativePageNavigation;->method(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/reflect/Method;

    move-result-object v1

    iput-object v1, p0, Lcom/gmhub/qs/NativePageNavigation;->userId:Ljava/lang/reflect/Method;

    const/4 v2, 0x0

    new-array v3, v2, [Ljava/lang/Object;

    invoke-static {v1, v0, v3}, Lcom/gmhub/qs/NativePageNavigation;->call(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Number;

    invoke-virtual {v0}, Ljava/lang/Number;->intValue()I

    move-result v0

    iput v0, p0, Lcom/gmhub/qs/NativePageNavigation;->user:I

    const-string v0, "getValue"

    invoke-static {p3, v0}, Lcom/gmhub/qs/NativePageNavigation;->method(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/reflect/Method;

    move-result-object v0

    iput-object v0, p0, Lcom/gmhub/qs/NativePageNavigation;->value:Ljava/lang/reflect/Method;

    const-string v0, "getMaxValue"

    invoke-static {p3, v0}, Lcom/gmhub/qs/NativePageNavigation;->method(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/reflect/Method;

    move-result-object v0

    iput-object v0, p0, Lcom/gmhub/qs/NativePageNavigation;->max:Ljava/lang/reflect/Method;

    const-string v0, "viewportSize$delegate"

    invoke-static {p3, v0}, Lcom/gmhub/qs/NativePageNavigation;->field(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p3

    iput-object p3, p0, Lcom/gmhub/qs/NativePageNavigation;->viewport:Ljava/lang/Object;

    const-string v0, "getIntValue"

    invoke-static {p3, v0}, Lcom/gmhub/qs/NativePageNavigation;->method(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/reflect/Method;

    move-result-object p3

    iput-object p3, p0, Lcom/gmhub/qs/NativePageNavigation;->intValue:Ljava/lang/reflect/Method;

    const-string p3, "isDragging"

    invoke-static {p2, p3}, Lcom/gmhub/qs/NativePageNavigation;->method(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/reflect/Method;

    move-result-object p2

    iput-object p2, p0, Lcom/gmhub/qs/NativePageNavigation;->dragging:Ljava/lang/reflect/Method;

    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object p1

    const-string p2, "androidx.compose.foundation.ScrollState"

    invoke-static {p2, v2, p1}, Ljava/lang/Class;->forName(Ljava/lang/String;ZLjava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object p2

    const-string p3, "kotlin.coroutines.Continuation"

    invoke-static {p3, v2, p1}, Ljava/lang/Class;->forName(Ljava/lang/String;ZLjava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object p1

    sget-object p3, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    filled-new-array {p2, p3, p1}, [Ljava/lang/Class;

    move-result-object p1

    const-string p3, "animateScrollTo$default"

    invoke-virtual {p2, p3, p1}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object p1

    iput-object p1, p0, Lcom/gmhub/qs/NativePageNavigation;->animate:Ljava/lang/reflect/Method;

    return-void
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

.method private static method(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/reflect/Method;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/NoSuchMethodException;
        }
    .end annotation

    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object p0

    const/4 v0, 0x0

    invoke-virtual {p0, p1, v0}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object p0

    const/4 p1, 0x1

    invoke-virtual {p0, p1}, Ljava/lang/reflect/Method;->setAccessible(Z)V

    return-object p0
.end method

.method private ui()V
    .locals 1

    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    move-result-object v0

    iget-object p0, p0, Lcom/gmhub/qs/NativePageNavigation;->owner:Ljava/lang/Thread;

    if-ne v0, p0, :cond_0

    return-void

    :cond_0
    new-instance p0, Ljava/lang/IllegalStateException;

    const-string v0, "QS UI owner required"

    invoke-direct {p0, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p0
.end method


# virtual methods
.method public accepts(Lcom/gmhub/qs/NativePageNavigation$Request;)Z
    .locals 6

    invoke-direct {p0}, Lcom/gmhub/qs/NativePageNavigation;->ui()V

    const/4 v0, 0x0

    if-eqz p1, :cond_2

    invoke-static {p1}, Lcom/gmhub/qs/NativePageNavigation$Request;->access$000(Lcom/gmhub/qs/NativePageNavigation$Request;)Lcom/gmhub/qs/NativePageNavigation;

    move-result-object v1

    if-ne v1, p0, :cond_2

    invoke-static {p1}, Lcom/gmhub/qs/NativePageNavigation$Request;->access$100(Lcom/gmhub/qs/NativePageNavigation$Request;)Z

    move-result v1

    if-eqz v1, :cond_0

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Lcom/gmhub/qs/NativePageNavigation;->current()Z

    move-result v1

    const/4 v2, 0x1

    if-eqz v1, :cond_1

    sget-object v1, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    iget-object v3, p0, Lcom/gmhub/qs/NativePageNavigation;->dragging:Ljava/lang/reflect/Method;

    iget-object v4, p0, Lcom/gmhub/qs/NativePageNavigation;->grid:Ljava/lang/Object;

    new-array v5, v0, [Ljava/lang/Object;

    invoke-static {v3, v4, v5}, Lcom/gmhub/qs/NativePageNavigation;->call(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/Boolean;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_1

    iget-object v1, p0, Lcom/gmhub/qs/NativePageNavigation;->intValue:Ljava/lang/reflect/Method;

    iget-object v3, p0, Lcom/gmhub/qs/NativePageNavigation;->viewport:Ljava/lang/Object;

    new-array v4, v0, [Ljava/lang/Object;

    invoke-static {v1, v3, v4}, Lcom/gmhub/qs/NativePageNavigation;->call(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Number;

    invoke-virtual {v1}, Ljava/lang/Number;->intValue()I

    move-result v1

    invoke-static {p1}, Lcom/gmhub/qs/NativePageNavigation$Request;->access$200(Lcom/gmhub/qs/NativePageNavigation$Request;)I

    move-result v3

    if-ne v1, v3, :cond_1

    iget-object v1, p0, Lcom/gmhub/qs/NativePageNavigation;->max:Ljava/lang/reflect/Method;

    iget-object p0, p0, Lcom/gmhub/qs/NativePageNavigation;->scroll:Ljava/lang/Object;

    new-array v3, v0, [Ljava/lang/Object;

    invoke-static {v1, p0, v3}, Lcom/gmhub/qs/NativePageNavigation;->call(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Ljava/lang/Number;

    invoke-virtual {p0}, Ljava/lang/Number;->intValue()I

    move-result p0

    invoke-static {p1}, Lcom/gmhub/qs/NativePageNavigation$Request;->access$300(Lcom/gmhub/qs/NativePageNavigation$Request;)I

    move-result v1

    if-ne p0, v1, :cond_1

    move v0, v2

    :cond_1
    if-nez v0, :cond_2

    invoke-static {p1, v2}, Lcom/gmhub/qs/NativePageNavigation$Request;->access$102(Lcom/gmhub/qs/NativePageNavigation$Request;Z)Z

    :cond_2
    :goto_0
    return v0
.end method

.method public animate(Lcom/gmhub/qs/NativePageNavigation$Request;Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    invoke-virtual {p0, p1}, Lcom/gmhub/qs/NativePageNavigation;->accepts(Lcom/gmhub/qs/NativePageNavigation$Request;)Z

    move-result v0

    if-nez v0, :cond_0

    return-object p3

    :cond_0
    iget-object p3, p0, Lcom/gmhub/qs/NativePageNavigation;->animate:Ljava/lang/reflect/Method;

    iget-object p0, p0, Lcom/gmhub/qs/NativePageNavigation;->scroll:Ljava/lang/Object;

    invoke-static {p1}, Lcom/gmhub/qs/NativePageNavigation$Request;->access$400(Lcom/gmhub/qs/NativePageNavigation$Request;)I

    move-result p1

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p1

    filled-new-array {p0, p1, p2}, [Ljava/lang/Object;

    move-result-object p0

    const/4 p1, 0x0

    invoke-static {p3, p1, p0}, Lcom/gmhub/qs/NativePageNavigation;->call(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    return-object p0
.end method

.method public close()V
    .locals 1

    invoke-direct {p0}, Lcom/gmhub/qs/NativePageNavigation;->ui()V

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/gmhub/qs/NativePageNavigation;->closed:Z

    return-void
.end method

.method public current()Z
    .locals 4

    invoke-direct {p0}, Lcom/gmhub/qs/NativePageNavigation;->ui()V

    iget-boolean v0, p0, Lcom/gmhub/qs/NativePageNavigation;->closed:Z

    const/4 v1, 0x0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/gmhub/qs/NativePageNavigation;->userId:Ljava/lang/reflect/Method;

    iget-object v2, p0, Lcom/gmhub/qs/NativePageNavigation;->host:Ljava/lang/Object;

    new-array v3, v1, [Ljava/lang/Object;

    invoke-static {v0, v2, v3}, Lcom/gmhub/qs/NativePageNavigation;->call(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Number;

    invoke-virtual {v0}, Ljava/lang/Number;->intValue()I

    move-result v0

    iget p0, p0, Lcom/gmhub/qs/NativePageNavigation;->user:I

    if-ne v0, p0, :cond_0

    const/4 p0, 0x1

    return p0

    :cond_0
    return v1
.end method

.method public pages()Lcom/gmhub/qs/NativePageNavigation$Pages;
    .locals 6

    invoke-virtual {p0}, Lcom/gmhub/qs/NativePageNavigation;->current()Z

    move-result v0

    const/4 v1, 0x0

    if-nez v0, :cond_0

    new-instance p0, Lcom/gmhub/qs/NativePageNavigation$Pages;

    invoke-direct {p0, v1, v1, v1}, Lcom/gmhub/qs/NativePageNavigation$Pages;-><init>(III)V

    return-object p0

    :cond_0
    new-instance v0, Lcom/gmhub/qs/NativePageNavigation$Pages;

    iget-object v2, p0, Lcom/gmhub/qs/NativePageNavigation;->intValue:Ljava/lang/reflect/Method;

    iget-object v3, p0, Lcom/gmhub/qs/NativePageNavigation;->viewport:Ljava/lang/Object;

    new-array v4, v1, [Ljava/lang/Object;

    invoke-static {v2, v3, v4}, Lcom/gmhub/qs/NativePageNavigation;->call(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/Number;

    invoke-virtual {v2}, Ljava/lang/Number;->intValue()I

    move-result v2

    iget-object v3, p0, Lcom/gmhub/qs/NativePageNavigation;->max:Ljava/lang/reflect/Method;

    iget-object v4, p0, Lcom/gmhub/qs/NativePageNavigation;->scroll:Ljava/lang/Object;

    new-array v5, v1, [Ljava/lang/Object;

    invoke-static {v3, v4, v5}, Lcom/gmhub/qs/NativePageNavigation;->call(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/Number;

    invoke-virtual {v3}, Ljava/lang/Number;->intValue()I

    move-result v3

    iget-object v4, p0, Lcom/gmhub/qs/NativePageNavigation;->value:Ljava/lang/reflect/Method;

    iget-object p0, p0, Lcom/gmhub/qs/NativePageNavigation;->scroll:Ljava/lang/Object;

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {v4, p0, v1}, Lcom/gmhub/qs/NativePageNavigation;->call(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Ljava/lang/Number;

    invoke-virtual {p0}, Ljava/lang/Number;->intValue()I

    move-result p0

    invoke-direct {v0, v2, v3, p0}, Lcom/gmhub/qs/NativePageNavigation$Pages;-><init>(III)V

    return-object v0
.end method

.method public request(I)Lcom/gmhub/qs/NativePageNavigation$Request;
    .locals 5

    invoke-virtual {p0}, Lcom/gmhub/qs/NativePageNavigation;->pages()Lcom/gmhub/qs/NativePageNavigation$Pages;

    move-result-object v0

    iget v1, v0, Lcom/gmhub/qs/NativePageNavigation$Pages;->count:I

    if-eqz v1, :cond_1

    if-ltz p1, :cond_1

    iget v1, v0, Lcom/gmhub/qs/NativePageNavigation$Pages;->count:I

    if-ge p1, v1, :cond_1

    sget-object v1, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    iget-object v2, p0, Lcom/gmhub/qs/NativePageNavigation;->dragging:Ljava/lang/reflect/Method;

    iget-object v3, p0, Lcom/gmhub/qs/NativePageNavigation;->grid:Ljava/lang/Object;

    const/4 v4, 0x0

    new-array v4, v4, [Ljava/lang/Object;

    invoke-static {v2, v3, v4}, Lcom/gmhub/qs/NativePageNavigation;->call(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/Boolean;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    goto :goto_0

    :cond_0
    new-instance v1, Lcom/gmhub/qs/NativePageNavigation$Request;

    invoke-virtual {v0, p1}, Lcom/gmhub/qs/NativePageNavigation$Pages;->target(I)I

    move-result p1

    invoke-direct {v1, p0, p1, v0}, Lcom/gmhub/qs/NativePageNavigation$Request;-><init>(Lcom/gmhub/qs/NativePageNavigation;ILcom/gmhub/qs/NativePageNavigation$Pages;)V

    return-object v1

    :cond_1
    :goto_0
    const/4 p0, 0x0

    return-object p0
.end method
