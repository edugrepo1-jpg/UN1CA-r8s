.class final Lcom/gmhub/qs/IosHeader$Runtime;
.super Ljava/lang/Object;
.source "IosHeader.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/gmhub/qs/IosHeader;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "Runtime"
.end annotation


# instance fields
.field final androidView:Ljava/lang/reflect/Method;

.field final available:Ljava/lang/reflect/Field;

.field final changed:Ljava/lang/reflect/Method;

.field final changedInt:Ljava/lang/reflect/Method;

.field final collect:Ljava/lang/reflect/Method;

.field final consume:Ljava/lang/reflect/Method;

.field final edit:Ljava/lang/reflect/Field;

.field final empty:Ljava/lang/Object;

.field final end:Ljava/lang/reflect/Method;

.field final endReplace:Ljava/lang/reflect/Method;

.field final failed:Ljava/lang/Object;

.field final fillWidth:Ljava/lang/reflect/Method;

.field final focusModifier:Ljava/lang/reflect/Method;

.field final function1:Ljava/lang/Class;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/Class<",
            "*>;"
        }
    .end annotation
.end field

.field final function2:Ljava/lang/Class;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/Class<",
            "*>;"
        }
    .end annotation
.end field

.field final getContext:Ljava/lang/reflect/Method;

.field final getUser:Ljava/lang/reflect/Method;

.field final height:Ljava/lang/reflect/Method;

.field final host:Ljava/lang/reflect/Field;

.field final loader:Ljava/lang/ClassLoader;

.field final localModel:Ljava/lang/Object;

.field final popover:Ljava/lang/reflect/Method;

.field final portrait:Ljava/lang/reflect/Method;

.field final remember:Ljava/lang/reflect/Method;

.field final remembered:Ljava/lang/reflect/Method;

.field final replace:Ljava/lang/reflect/Method;

.field final start:Ljava/lang/reflect/Method;

.field final stateValue:Ljava/lang/reflect/Method;

.field final tablet:Ljava/lang/reflect/Method;

.field final unit:Ljava/lang/Object;

.field final updateScope:Ljava/lang/reflect/Method;


# direct methods
.method constructor <init>(Ljava/lang/ClassLoader;)V
    .locals 10
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/ReflectiveOperationException;
        }
    .end annotation

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    iput-object v0, p0, Lcom/gmhub/qs/IosHeader$Runtime;->failed:Ljava/lang/Object;

    iput-object p1, p0, Lcom/gmhub/qs/IosHeader$Runtime;->loader:Ljava/lang/ClassLoader;

    const-string v0, "androidx.compose.runtime.Composer"

    invoke-static {p1, v0}, Lcom/gmhub/qs/IosHeader;->access$000(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v6

    const-string v0, "androidx.compose.ui.Modifier"

    invoke-static {p1, v0}, Lcom/gmhub/qs/IosHeader;->access$000(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v2

    const-string v0, "kotlin.jvm.functions.Function1"

    invoke-static {p1, v0}, Lcom/gmhub/qs/IosHeader;->access$000(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v1

    iput-object v1, p0, Lcom/gmhub/qs/IosHeader$Runtime;->function1:Ljava/lang/Class;

    const-string v0, "kotlin.jvm.functions.Function2"

    invoke-static {p1, v0}, Lcom/gmhub/qs/IosHeader;->access$000(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    iput-object v0, p0, Lcom/gmhub/qs/IosHeader$Runtime;->function2:Ljava/lang/Class;

    sget-object v3, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    filled-new-array {v3}, [Ljava/lang/Class;

    move-result-object v3

    const-string v4, "startRestartGroup"

    invoke-static {v6, v4, v3}, Lcom/gmhub/qs/IosHeader;->access$100(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v3

    iput-object v3, p0, Lcom/gmhub/qs/IosHeader$Runtime;->start:Ljava/lang/reflect/Method;

    const/4 v3, 0x0

    new-array v4, v3, [Ljava/lang/Class;

    const-string v5, "endRestartGroup"

    invoke-static {v6, v5, v4}, Lcom/gmhub/qs/IosHeader;->access$100(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v4

    iput-object v4, p0, Lcom/gmhub/qs/IosHeader$Runtime;->end:Ljava/lang/reflect/Method;

    sget-object v4, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    filled-new-array {v4}, [Ljava/lang/Class;

    move-result-object v4

    const-string v5, "startReplaceGroup"

    invoke-static {v6, v5, v4}, Lcom/gmhub/qs/IosHeader;->access$100(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v4

    iput-object v4, p0, Lcom/gmhub/qs/IosHeader$Runtime;->replace:Ljava/lang/reflect/Method;

    const-string v4, "endReplaceGroup"

    new-array v5, v3, [Ljava/lang/Class;

    invoke-static {v6, v4, v5}, Lcom/gmhub/qs/IosHeader;->access$100(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v4

    iput-object v4, p0, Lcom/gmhub/qs/IosHeader$Runtime;->endReplace:Ljava/lang/reflect/Method;

    const-string v4, "androidx.compose.runtime.CompositionLocal"

    invoke-static {p1, v4}, Lcom/gmhub/qs/IosHeader;->access$000(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v4

    filled-new-array {v4}, [Ljava/lang/Class;

    move-result-object v4

    const-string v5, "consume"

    invoke-static {v6, v5, v4}, Lcom/gmhub/qs/IosHeader;->access$100(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v4

    iput-object v4, p0, Lcom/gmhub/qs/IosHeader$Runtime;->consume:Ljava/lang/reflect/Method;

    const-class v4, Ljava/lang/Object;

    filled-new-array {v4}, [Ljava/lang/Class;

    move-result-object v4

    const-string v5, "changedInstance"

    invoke-static {v6, v5, v4}, Lcom/gmhub/qs/IosHeader;->access$100(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v4

    iput-object v4, p0, Lcom/gmhub/qs/IosHeader$Runtime;->changed:Ljava/lang/reflect/Method;

    sget-object v4, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    filled-new-array {v4}, [Ljava/lang/Class;

    move-result-object v4

    const-string v5, "changed"

    invoke-static {v6, v5, v4}, Lcom/gmhub/qs/IosHeader;->access$100(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v4

    iput-object v4, p0, Lcom/gmhub/qs/IosHeader$Runtime;->changedInt:Ljava/lang/reflect/Method;

    const-string v4, "rememberedValue"

    new-array v5, v3, [Ljava/lang/Class;

    invoke-static {v6, v4, v5}, Lcom/gmhub/qs/IosHeader;->access$100(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v4

    iput-object v4, p0, Lcom/gmhub/qs/IosHeader$Runtime;->remembered:Ljava/lang/reflect/Method;

    const-class v4, Ljava/lang/Object;

    filled-new-array {v4}, [Ljava/lang/Class;

    move-result-object v4

    const-string v5, "updateRememberedValue"

    invoke-static {v6, v5, v4}, Lcom/gmhub/qs/IosHeader;->access$100(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v4

    iput-object v4, p0, Lcom/gmhub/qs/IosHeader$Runtime;->remember:Ljava/lang/reflect/Method;

    const-string v4, "Companion"

    invoke-static {v6, v4}, Lcom/gmhub/qs/IosHeader;->access$200(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v4

    const/4 v5, 0x0

    invoke-virtual {v4, v5}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    const-string v7, "androidx.compose.runtime.Composer$Companion"

    invoke-static {p1, v7}, Lcom/gmhub/qs/IosHeader;->access$000(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v7

    const-string v8, "getEmpty"

    new-array v9, v3, [Ljava/lang/Class;

    invoke-static {v7, v8, v9}, Lcom/gmhub/qs/IosHeader;->access$100(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v7

    invoke-virtual {v7, v4, v5}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    iput-object v4, p0, Lcom/gmhub/qs/IosHeader$Runtime;->empty:Ljava/lang/Object;

    const-string v4, "kotlin.Unit"

    invoke-static {p1, v4}, Lcom/gmhub/qs/IosHeader;->access$000(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v4

    const-string v7, "INSTANCE"

    invoke-static {v4, v7}, Lcom/gmhub/qs/IosHeader;->access$200(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v4

    invoke-virtual {v4, v5}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    iput-object v4, p0, Lcom/gmhub/qs/IosHeader$Runtime;->unit:Ljava/lang/Object;

    const-string v4, "com.android.systemui.samsung.quicksetting.ui.SecQuickSettingSceneKt"

    invoke-static {p1, v4}, Lcom/gmhub/qs/IosHeader;->access$000(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v4

    const-string v7, "LocalViewModel"

    invoke-static {v4, v7}, Lcom/gmhub/qs/IosHeader;->access$200(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v4

    invoke-virtual {v4, v5}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    iput-object v4, p0, Lcom/gmhub/qs/IosHeader$Runtime;->localModel:Ljava/lang/Object;

    const-string v4, "com.android.systemui.samsung.quicksetting.ui.panel.QuickSettingSceneViewModel"

    invoke-static {p1, v4}, Lcom/gmhub/qs/IosHeader;->access$000(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v4

    const-string v5, "qsHost"

    invoke-static {v4, v5}, Lcom/gmhub/qs/IosHeader;->access$200(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v5

    iput-object v5, p0, Lcom/gmhub/qs/IosHeader$Runtime;->host:Ljava/lang/reflect/Field;

    const-string v5, "$$delegate_0"

    invoke-static {v4, v5}, Lcom/gmhub/qs/IosHeader;->access$200(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v5

    iput-object v5, p0, Lcom/gmhub/qs/IosHeader$Runtime;->edit:Ljava/lang/reflect/Field;

    const-string v5, "$$delegate_3"

    invoke-static {v4, v5}, Lcom/gmhub/qs/IosHeader;->access$200(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v5

    iput-object v5, p0, Lcom/gmhub/qs/IosHeader$Runtime;->available:Ljava/lang/reflect/Field;

    const-class v5, Landroid/content/res/Configuration;

    filled-new-array {v5}, [Ljava/lang/Class;

    move-result-object v5

    const-string v7, "isPortraitPanel"

    invoke-static {v4, v7, v5}, Lcom/gmhub/qs/IosHeader;->access$100(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v5

    iput-object v5, p0, Lcom/gmhub/qs/IosHeader$Runtime;->portrait:Ljava/lang/reflect/Method;

    const-string v5, "isTablet"

    new-array v7, v3, [Ljava/lang/Class;

    invoke-static {v4, v5, v7}, Lcom/gmhub/qs/IosHeader;->access$100(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v5

    iput-object v5, p0, Lcom/gmhub/qs/IosHeader$Runtime;->tablet:Ljava/lang/reflect/Method;

    const-string v5, "isPopOverEnabled"

    new-array v7, v3, [Ljava/lang/Class;

    invoke-static {v4, v5, v7}, Lcom/gmhub/qs/IosHeader;->access$100(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v4

    iput-object v4, p0, Lcom/gmhub/qs/IosHeader$Runtime;->popover:Ljava/lang/reflect/Method;

    const-string v4, "com.android.systemui.qs.QSHost"

    invoke-static {p1, v4}, Lcom/gmhub/qs/IosHeader;->access$000(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v4

    const-string v5, "getUserId"

    new-array v7, v3, [Ljava/lang/Class;

    invoke-static {v4, v5, v7}, Lcom/gmhub/qs/IosHeader;->access$100(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v5

    iput-object v5, p0, Lcom/gmhub/qs/IosHeader$Runtime;->getUser:Ljava/lang/reflect/Method;

    const-string v5, "getUserContext"

    new-array v7, v3, [Ljava/lang/Class;

    invoke-static {v4, v5, v7}, Lcom/gmhub/qs/IosHeader;->access$100(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v4

    iput-object v4, p0, Lcom/gmhub/qs/IosHeader$Runtime;->getContext:Ljava/lang/reflect/Method;

    const-string v4, "androidx.lifecycle.compose.FlowExtKt"

    invoke-static {p1, v4}, Lcom/gmhub/qs/IosHeader;->access$000(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v4

    const-string v5, "kotlinx.coroutines.flow.StateFlow"

    invoke-static {p1, v5}, Lcom/gmhub/qs/IosHeader;->access$000(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v5

    sget-object v7, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    filled-new-array {v5, v6, v7}, [Ljava/lang/Class;

    move-result-object v5

    const-string v7, "collectAsStateWithLifecycle"

    invoke-static {v4, v7, v5}, Lcom/gmhub/qs/IosHeader;->access$100(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v4

    iput-object v4, p0, Lcom/gmhub/qs/IosHeader$Runtime;->collect:Ljava/lang/reflect/Method;

    const-string v4, "androidx.compose.runtime.State"

    invoke-static {p1, v4}, Lcom/gmhub/qs/IosHeader;->access$000(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v4

    const-string v5, "getValue"

    new-array v3, v3, [Ljava/lang/Class;

    invoke-static {v4, v5, v3}, Lcom/gmhub/qs/IosHeader;->access$100(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v3

    iput-object v3, p0, Lcom/gmhub/qs/IosHeader$Runtime;->stateValue:Ljava/lang/reflect/Method;

    const-string v3, "androidx.compose.ui.viewinterop.AndroidView_androidKt"

    invoke-static {p1, v3}, Lcom/gmhub/qs/IosHeader;->access$000(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v9

    sget-object v7, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    sget-object v8, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    move-object v3, v1

    move-object v4, v1

    move-object v5, v1

    filled-new-array/range {v1 .. v8}, [Ljava/lang/Class;

    move-result-object v1

    const-string v3, "AndroidView"

    invoke-static {v9, v3, v1}, Lcom/gmhub/qs/IosHeader;->access$100(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    iput-object v1, p0, Lcom/gmhub/qs/IosHeader$Runtime;->androidView:Ljava/lang/reflect/Method;

    const-string v1, "androidx.compose.foundation.layout.SizeKt"

    invoke-static {p1, v1}, Lcom/gmhub/qs/IosHeader;->access$000(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v1

    sget-object v3, Ljava/lang/Float;->TYPE:Ljava/lang/Class;

    filled-new-array {v2, v3}, [Ljava/lang/Class;

    move-result-object v3

    const-string v4, "fillMaxWidth"

    invoke-static {v1, v4, v3}, Lcom/gmhub/qs/IosHeader;->access$100(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v3

    iput-object v3, p0, Lcom/gmhub/qs/IosHeader$Runtime;->fillWidth:Ljava/lang/reflect/Method;

    sget-object v3, Ljava/lang/Float;->TYPE:Ljava/lang/Class;

    filled-new-array {v2, v3}, [Ljava/lang/Class;

    move-result-object v3

    const-string v4, "height-3ABfNKs"

    invoke-static {v1, v4, v3}, Lcom/gmhub/qs/IosHeader;->access$100(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    iput-object v1, p0, Lcom/gmhub/qs/IosHeader$Runtime;->height:Ljava/lang/reflect/Method;

    const-string v1, "androidx.compose.ui.focus.FocusRequesterModifierKt"

    invoke-static {p1, v1}, Lcom/gmhub/qs/IosHeader;->access$000(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v1

    const-string v3, "androidx.compose.ui.focus.FocusRequester"

    invoke-static {p1, v3}, Lcom/gmhub/qs/IosHeader;->access$000(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v3

    filled-new-array {v2, v3}, [Ljava/lang/Class;

    move-result-object v2

    const-string v3, "focusRequester"

    invoke-static {v1, v3, v2}, Lcom/gmhub/qs/IosHeader;->access$100(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    iput-object v1, p0, Lcom/gmhub/qs/IosHeader$Runtime;->focusModifier:Ljava/lang/reflect/Method;

    const-string v1, "androidx.compose.runtime.ScopeUpdateScope"

    invoke-static {p1, v1}, Lcom/gmhub/qs/IosHeader;->access$000(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object p1

    const-string v1, "updateScope"

    filled-new-array {v0}, [Ljava/lang/Class;

    move-result-object v0

    invoke-static {p1, v1, v0}, Lcom/gmhub/qs/IosHeader;->access$100(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object p1

    iput-object p1, p0, Lcom/gmhub/qs/IosHeader$Runtime;->updateScope:Ljava/lang/reflect/Method;

    return-void
.end method

.method static synthetic lambda$function$0(Ljava/lang/Class;Lcom/gmhub/qs/IosHeader$Callback;Ljava/lang/Object;Ljava/lang/reflect/Method;[Ljava/lang/Object;)Ljava/lang/Object;
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Throwable;
        }
    .end annotation

    invoke-virtual {p3}, Ljava/lang/reflect/Method;->getDeclaringClass()Ljava/lang/Class;

    move-result-object v0

    const-class v1, Ljava/lang/Object;

    const/4 v2, 0x0

    if-ne v0, v1, :cond_3

    invoke-virtual {p3}, Ljava/lang/reflect/Method;->getName()Ljava/lang/String;

    move-result-object v0

    const-string v1, "equals"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    aget-object p0, p4, v2

    if-ne p2, p0, :cond_0

    const/4 v2, 0x1

    :cond_0
    invoke-static {v2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object p0

    return-object p0

    :cond_1
    invoke-virtual {p3}, Ljava/lang/reflect/Method;->getName()Ljava/lang/String;

    move-result-object v0

    const-string v1, "hashCode"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    invoke-static {p2}, Ljava/lang/System;->identityHashCode(Ljava/lang/Object;)I

    move-result p0

    invoke-static {p0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p0

    return-object p0

    :cond_2
    invoke-virtual {p3}, Ljava/lang/reflect/Method;->getName()Ljava/lang/String;

    move-result-object p2

    const-string p3, "toString"

    invoke-virtual {p2, p3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p2

    if-eqz p2, :cond_3

    new-instance p1, Ljava/lang/StringBuilder;

    const-string p2, "GMHubHeader/"

    invoke-direct {p1, p2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p0}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object p0

    invoke-virtual {p1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0

    :cond_3
    if-nez p4, :cond_4

    new-array p4, v2, [Ljava/lang/Object;

    :cond_4
    invoke-interface {p1, p4}, Lcom/gmhub/qs/IosHeader$Callback;->invoke([Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    return-object p0
.end method


# virtual methods
.method function(Ljava/lang/Class;Lcom/gmhub/qs/IosHeader$Callback;)Ljava/lang/Object;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Class<",
            "*>;",
            "Lcom/gmhub/qs/IosHeader$Callback;",
            ")",
            "Ljava/lang/Object;"
        }
    .end annotation

    iget-object p0, p0, Lcom/gmhub/qs/IosHeader$Runtime;->loader:Ljava/lang/ClassLoader;

    filled-new-array {p1}, [Ljava/lang/Class;

    move-result-object v0

    new-instance v1, Lcom/gmhub/qs/IosHeader$Runtime$$ExternalSyntheticLambda1;

    invoke-direct {v1, p1, p2}, Lcom/gmhub/qs/IosHeader$Runtime$$ExternalSyntheticLambda1;-><init>(Ljava/lang/Class;Lcom/gmhub/qs/IosHeader$Callback;)V

    invoke-static {p0, v0, v1}, Ljava/lang/reflect/Proxy;->newProxyInstance(Ljava/lang/ClassLoader;[Ljava/lang/Class;Ljava/lang/reflect/InvocationHandler;)Ljava/lang/Object;

    move-result-object p0

    return-object p0
.end method

.method synthetic lambda$render$0$com-gmhub-qs-IosHeader$Runtime(Ljava/lang/Object;Ljava/lang/Object;I[Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    const/4 v0, 0x0

    aget-object p4, p4, v0

    or-int/lit8 p3, p3, 0x1

    invoke-static {p1, p2, p4, p3}, Lcom/gmhub/qs/IosHeader;->content(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;I)V

    iget-object p0, p0, Lcom/gmhub/qs/IosHeader$Runtime;->unit:Ljava/lang/Object;

    return-object p0
.end method

.method render(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;I)V
    .locals 11

    iget-object v0, p0, Lcom/gmhub/qs/IosHeader$Runtime;->start:Ljava/lang/reflect/Method;

    const v1, 0x474d5201

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, p3, v1}, Lcom/gmhub/qs/IosHeader;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v7

    invoke-static {v7}, Lcom/gmhub/qs/ComposePanelRoot;->ios(Ljava/lang/Object;)Z

    move-result p3

    const/4 v1, 0x0

    if-eqz p3, :cond_0

    iget-object v0, p0, Lcom/gmhub/qs/IosHeader$Runtime;->consume:Ljava/lang/reflect/Method;

    iget-object v2, p0, Lcom/gmhub/qs/IosHeader$Runtime;->localModel:Ljava/lang/Object;

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v0, v7, v2}, Lcom/gmhub/qs/IosHeader;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    goto :goto_0

    :cond_0
    move-object v0, v1

    :goto_0
    const/4 v10, 0x0

    const/4 v2, -0x1

    if-eqz p3, :cond_2

    :try_start_0
    iget-object v3, p0, Lcom/gmhub/qs/IosHeader$Runtime;->host:Ljava/lang/reflect/Field;

    invoke-virtual {v3, v0}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    iget-object v4, p0, Lcom/gmhub/qs/IosHeader$Runtime;->getContext:Ljava/lang/reflect/Method;

    new-array v5, v10, [Ljava/lang/Object;

    invoke-static {v4, v3, v5}, Lcom/gmhub/qs/IosHeader;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Landroid/content/Context;
    :try_end_0
    .catch Ljava/lang/IllegalAccessException; {:try_start_0 .. :try_end_0} :catch_0

    :try_start_1
    iget-object v5, p0, Lcom/gmhub/qs/IosHeader$Runtime;->getUser:Ljava/lang/reflect/Method;

    new-array v6, v10, [Ljava/lang/Object;

    invoke-static {v5, v3, v6}, Lcom/gmhub/qs/IosHeader;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/Number;

    invoke-virtual {v3}, Ljava/lang/Number;->intValue()I

    move-result v2

    if-eqz v4, :cond_1

    sget-object v3, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    iget-object v5, p0, Lcom/gmhub/qs/IosHeader$Runtime;->portrait:Ljava/lang/reflect/Method;

    invoke-virtual {v4}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v6

    invoke-virtual {v6}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v6

    filled-new-array {v6}, [Ljava/lang/Object;

    move-result-object v6

    invoke-static {v5, v0, v6}, Lcom/gmhub/qs/IosHeader;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v5

    invoke-virtual {v3, v5}, Ljava/lang/Boolean;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_1

    sget-object v3, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    iget-object v5, p0, Lcom/gmhub/qs/IosHeader$Runtime;->tablet:Ljava/lang/reflect/Method;

    new-array v6, v10, [Ljava/lang/Object;

    invoke-static {v5, v0, v6}, Lcom/gmhub/qs/IosHeader;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v5

    invoke-virtual {v3, v5}, Ljava/lang/Boolean;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_1

    sget-object v3, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    iget-object v5, p0, Lcom/gmhub/qs/IosHeader$Runtime;->popover:Ljava/lang/reflect/Method;

    new-array v6, v10, [Ljava/lang/Object;

    invoke-static {v5, v0, v6}, Lcom/gmhub/qs/IosHeader;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v5

    invoke-virtual {v3, v5}, Ljava/lang/Boolean;->equals(Ljava/lang/Object;)Z

    move-result v3
    :try_end_1
    .catch Ljava/lang/IllegalAccessException; {:try_start_1 .. :try_end_1} :catch_1

    if-nez v3, :cond_1

    const/4 v3, 0x1

    goto :goto_1

    :cond_1
    move v3, v10

    :goto_1
    and-int/2addr p3, v3

    goto :goto_2

    :catch_0
    move-object v4, v1

    :catch_1
    move p3, v10

    goto :goto_2

    :cond_2
    move-object v4, v1

    :goto_2
    iget-object v3, p0, Lcom/gmhub/qs/IosHeader$Runtime;->replace:Ljava/lang/reflect/Method;

    if-eqz p3, :cond_3

    const v5, 0x474d5202

    goto :goto_3

    :cond_3
    const v5, 0x474d5203

    :goto_3
    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    filled-new-array {v5}, [Ljava/lang/Object;

    move-result-object v5

    invoke-static {v3, v7, v5}, Lcom/gmhub/qs/IosHeader;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    if-nez p3, :cond_4

    invoke-static {}, Lcom/gmhub/qs/IosHeader;->access$400()Ljava/lang/reflect/Method;

    move-result-object p3

    invoke-static {p4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    filled-new-array {p1, p2, v7, v0}, [Ljava/lang/Object;

    move-result-object v0

    invoke-static {p3, v1, v0}, Lcom/gmhub/qs/IosHeader;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    goto/16 :goto_6

    :cond_4
    iget-object p3, p0, Lcom/gmhub/qs/IosHeader$Runtime;->replace:Ljava/lang/reflect/Method;

    const v3, 0x474d5204

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {p3, v7, v3}, Lcom/gmhub/qs/IosHeader;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    iget-object p3, p0, Lcom/gmhub/qs/IosHeader$Runtime;->changed:Ljava/lang/reflect/Method;

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {p3, v7, v3}, Lcom/gmhub/qs/IosHeader;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p3

    check-cast p3, Ljava/lang/Boolean;

    invoke-virtual {p3}, Ljava/lang/Boolean;->booleanValue()Z

    move-result p3

    iget-object v3, p0, Lcom/gmhub/qs/IosHeader$Runtime;->changedInt:Ljava/lang/reflect/Method;

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v3, v7, v2}, Lcom/gmhub/qs/IosHeader;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/Boolean;

    invoke-virtual {v2}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v2

    or-int/2addr p3, v2

    iget-object v2, p0, Lcom/gmhub/qs/IosHeader$Runtime;->remembered:Ljava/lang/reflect/Method;

    new-array v3, v10, [Ljava/lang/Object;

    invoke-static {v2, v7, v3}, Lcom/gmhub/qs/IosHeader;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    if-nez p3, :cond_5

    iget-object p3, p0, Lcom/gmhub/qs/IosHeader$Runtime;->empty:Ljava/lang/Object;

    if-ne v2, p3, :cond_6

    :cond_5
    :try_start_2
    new-instance p3, Lcom/gmhub/qs/IosHeader$Session;

    invoke-direct {p3, p0, v0, v4}, Lcom/gmhub/qs/IosHeader$Session;-><init>(Lcom/gmhub/qs/IosHeader$Runtime;Ljava/lang/Object;Landroid/content/Context;)V
    :try_end_2
    .catch Ljava/lang/ReflectiveOperationException; {:try_start_2 .. :try_end_2} :catch_2
    .catch Ljava/lang/IllegalStateException; {:try_start_2 .. :try_end_2} :catch_2

    goto :goto_4

    :catch_2
    move-exception v0

    move-object p3, v0

    const-string v0, "GMHubQs"

    const-string v2, "Header action binding unavailable; preserving native controls"

    invoke-static {v0, v2, p3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    iget-object p3, p0, Lcom/gmhub/qs/IosHeader$Runtime;->failed:Ljava/lang/Object;

    :goto_4
    move-object v2, p3

    iget-object p3, p0, Lcom/gmhub/qs/IosHeader$Runtime;->remember:Ljava/lang/reflect/Method;

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v0

    invoke-static {p3, v7, v0}, Lcom/gmhub/qs/IosHeader;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    :cond_6
    iget-object p3, p0, Lcom/gmhub/qs/IosHeader$Runtime;->endReplace:Ljava/lang/reflect/Method;

    new-array v0, v10, [Ljava/lang/Object;

    invoke-static {p3, v7, v0}, Lcom/gmhub/qs/IosHeader;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    iget-object p3, p0, Lcom/gmhub/qs/IosHeader$Runtime;->failed:Ljava/lang/Object;

    if-ne v2, p3, :cond_7

    invoke-static {}, Lcom/gmhub/qs/IosHeader;->access$400()Ljava/lang/reflect/Method;

    move-result-object p3

    invoke-static {p4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    filled-new-array {p1, p2, v7, v0}, [Ljava/lang/Object;

    move-result-object v0

    invoke-static {p3, v1, v0}, Lcom/gmhub/qs/IosHeader;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    goto/16 :goto_6

    :cond_7
    check-cast v2, Lcom/gmhub/qs/IosHeader$Session;

    iget-object p3, p0, Lcom/gmhub/qs/IosHeader$Runtime;->stateValue:Ljava/lang/reflect/Method;

    iget-object v0, p0, Lcom/gmhub/qs/IosHeader$Runtime;->collect:Ljava/lang/reflect/Method;

    iget-object v3, v2, Lcom/gmhub/qs/IosHeader$Session;->editFlow:Ljava/lang/Object;

    invoke-static {v10}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    filled-new-array {v3, v7, v5}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v0, v1, v3}, Lcom/gmhub/qs/IosHeader;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    new-array v3, v10, [Ljava/lang/Object;

    invoke-static {p3, v0, v3}, Lcom/gmhub/qs/IosHeader;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    iget-object p3, p0, Lcom/gmhub/qs/IosHeader$Runtime;->stateValue:Ljava/lang/reflect/Method;

    iget-object v0, p0, Lcom/gmhub/qs/IosHeader$Runtime;->collect:Ljava/lang/reflect/Method;

    iget-object v3, v2, Lcom/gmhub/qs/IosHeader$Session;->availableFlow:Ljava/lang/Object;

    invoke-static {v10}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    filled-new-array {v3, v7, v5}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v0, v1, v3}, Lcom/gmhub/qs/IosHeader;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    new-array v3, v10, [Ljava/lang/Object;

    invoke-static {p3, v0, v3}, Lcom/gmhub/qs/IosHeader;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    iget-object p3, v2, Lcom/gmhub/qs/IosHeader$Session;->actions:Lcom/gmhub/qs/NativeHeaderActions;

    invoke-virtual {p3}, Lcom/gmhub/qs/NativeHeaderActions;->current()Z

    move-result p3

    if-nez p3, :cond_8

    invoke-static {}, Lcom/gmhub/qs/IosHeader;->access$400()Ljava/lang/reflect/Method;

    move-result-object p3

    invoke-static {p4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    filled-new-array {p1, p2, v7, v0}, [Ljava/lang/Object;

    move-result-object v0

    invoke-static {p3, v1, v0}, Lcom/gmhub/qs/IosHeader;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_6

    :cond_8
    iget-object p3, p0, Lcom/gmhub/qs/IosHeader$Runtime;->fillWidth:Ljava/lang/reflect/Method;

    const/high16 v0, 0x3f800000    # 1.0f

    invoke-static {v0}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v0

    filled-new-array {p1, v0}, [Ljava/lang/Object;

    move-result-object v0

    invoke-static {p3, v1, v0}, Lcom/gmhub/qs/IosHeader;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p3

    invoke-virtual {v4}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v0

    iget v0, v0, Landroid/content/res/Configuration;->fontScale:F

    const/high16 v3, 0x3fc00000    # 1.5f

    cmpl-float v3, v0, v3

    if-lez v3, :cond_9

    const/high16 v3, 0x42300000    # 44.0f

    goto :goto_5

    :cond_9
    const/high16 v3, 0x41c00000    # 24.0f

    :goto_5
    mul-float/2addr v3, v0

    const/high16 v0, 0x41800000    # 16.0f

    add-float/2addr v3, v0

    const/high16 v0, 0x42600000    # 56.0f

    invoke-static {v0, v3}, Ljava/lang/Math;->max(FF)F

    move-result v0

    iget-object v3, p0, Lcom/gmhub/qs/IosHeader$Runtime;->height:Ljava/lang/reflect/Method;

    invoke-static {v0}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v0

    filled-new-array {p3, v0}, [Ljava/lang/Object;

    move-result-object p3

    invoke-static {v3, v1, p3}, Lcom/gmhub/qs/IosHeader;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p3

    if-eqz p2, :cond_a

    iget-object v0, p0, Lcom/gmhub/qs/IosHeader$Runtime;->focusModifier:Ljava/lang/reflect/Method;

    filled-new-array {p3, p2}, [Ljava/lang/Object;

    move-result-object p3

    invoke-static {v0, v1, p3}, Lcom/gmhub/qs/IosHeader;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p3

    :cond_a
    move-object v3, p3

    iget-object p3, p0, Lcom/gmhub/qs/IosHeader$Runtime;->androidView:Ljava/lang/reflect/Method;

    move-object v0, v2

    iget-object v2, v0, Lcom/gmhub/qs/IosHeader$Session;->factory:Ljava/lang/Object;

    iget-object v5, v0, Lcom/gmhub/qs/IosHeader$Session;->release:Ljava/lang/Object;

    iget-object v6, v0, Lcom/gmhub/qs/IosHeader$Session;->update:Ljava/lang/Object;

    invoke-static {v10}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v8

    invoke-static {v10}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v9

    const/4 v4, 0x0

    filled-new-array/range {v2 .. v9}, [Ljava/lang/Object;

    move-result-object v0

    invoke-static {p3, v1, v0}, Lcom/gmhub/qs/IosHeader;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    :goto_6
    iget-object p3, p0, Lcom/gmhub/qs/IosHeader$Runtime;->endReplace:Ljava/lang/reflect/Method;

    new-array v0, v10, [Ljava/lang/Object;

    invoke-static {p3, v7, v0}, Lcom/gmhub/qs/IosHeader;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    iget-object p3, p0, Lcom/gmhub/qs/IosHeader$Runtime;->end:Ljava/lang/reflect/Method;

    new-array v0, v10, [Ljava/lang/Object;

    invoke-static {p3, v7, v0}, Lcom/gmhub/qs/IosHeader;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p3

    if-eqz p3, :cond_b

    iget-object v0, p0, Lcom/gmhub/qs/IosHeader$Runtime;->updateScope:Ljava/lang/reflect/Method;

    iget-object v1, p0, Lcom/gmhub/qs/IosHeader$Runtime;->function2:Ljava/lang/Class;

    new-instance v2, Lcom/gmhub/qs/IosHeader$Runtime$$ExternalSyntheticLambda0;

    invoke-direct {v2, p0, p1, p2, p4}, Lcom/gmhub/qs/IosHeader$Runtime$$ExternalSyntheticLambda0;-><init>(Lcom/gmhub/qs/IosHeader$Runtime;Ljava/lang/Object;Ljava/lang/Object;I)V

    invoke-virtual {p0, v1, v2}, Lcom/gmhub/qs/IosHeader$Runtime;->function(Ljava/lang/Class;Lcom/gmhub/qs/IosHeader$Callback;)Ljava/lang/Object;

    move-result-object p0

    filled-new-array {p0}, [Ljava/lang/Object;

    move-result-object p0

    invoke-static {v0, p3, p0}, Lcom/gmhub/qs/IosHeader;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    :cond_b
    return-void
.end method
