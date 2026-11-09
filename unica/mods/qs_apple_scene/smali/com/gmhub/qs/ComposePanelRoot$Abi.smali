.class final Lcom/gmhub/qs/ComposePanelRoot$Abi;
.super Ljava/lang/Object;
.source "ComposePanelRoot.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/gmhub/qs/ComposePanelRoot;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "Abi"
.end annotation


# instance fields
.field final capsule:Ljava/lang/Object;

.field final card:Ljava/lang/Object;

.field final changedInt:Ljava/lang/reflect/Method;

.field final changedObject:Ljava/lang/reflect/Method;

.field final composable:Ljava/lang/reflect/Method;

.field final consume:Ljava/lang/reflect/Method;

.field final disposable:Ljava/lang/Class;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/Class<",
            "*>;"
        }
    .end annotation
.end field

.field final disposableEffect:Ljava/lang/reflect/Method;

.field final empty:Ljava/lang/Object;

.field final end:Ljava/lang/reflect/Method;

.field final endReplace:Ljava/lang/reflect/Method;

.field final expanded:Ljava/lang/reflect/Field;

.field final function0:Ljava/lang/Class;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/Class<",
            "*>;"
        }
    .end annotation
.end field

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

.field final galleryCard:Ljava/lang/Object;

.field final host:Ljava/lang/reflect/Field;

.field final inAvailableGrid:Ljava/lang/reflect/Field;

.field final legacyMedia:Ljava/lang/Class;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/Class<",
            "*>;"
        }
    .end annotation
.end field

.field final loader:Ljava/lang/ClassLoader;

.field final localModel:Ljava/lang/Object;

.field final localStyle:Ljava/lang/Object;

.field final media:Ljava/lang/Class;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/Class<",
            "*>;"
        }
    .end annotation
.end field

.field final modifier:Ljava/lang/Object;

.field final padding:Ljava/lang/reflect/Method;

.field final popover:Ljava/lang/reflect/Method;

.field final portrait:Ljava/lang/reflect/Method;

.field final provide:Ljava/lang/reflect/Method;

.field final provider:Ljava/lang/reflect/Method;

.field final remember:Ljava/lang/reflect/Method;

.field final remembered:Ljava/lang/reflect/Method;

.field final setValue:Ljava/lang/reflect/Method;

.field final spanSize:Ljava/lang/reflect/Field;

.field final start:Ljava/lang/reflect/Method;

.field final startReplace:Ljava/lang/reflect/Method;

.field final state:Ljava/lang/reflect/Method;

.field final tablet:Ljava/lang/reflect/Method;

.field final then:Ljava/lang/reflect/Method;

.field final tileItem:Ljava/lang/reflect/Field;

.field final tileScope:Ljava/lang/reflect/Field;

.field final unit:Ljava/lang/Object;

.field final updateScope:Ljava/lang/reflect/Method;

.field final userContext:Ljava/lang/reflect/Method;

.field final userId:Ljava/lang/reflect/Method;

.field final value:Ljava/lang/reflect/Method;


# direct methods
.method constructor <init>(Ljava/lang/ClassLoader;)V
    .locals 12
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/ReflectiveOperationException;
        }
    .end annotation

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/gmhub/qs/ComposePanelRoot$Abi;->loader:Ljava/lang/ClassLoader;

    const-string v0, "kotlin.jvm.functions.Function0"

    invoke-static {p1, v0}, Lcom/gmhub/qs/ComposePanelRoot;->access$000(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    iput-object v0, p0, Lcom/gmhub/qs/ComposePanelRoot$Abi;->function0:Ljava/lang/Class;

    const-string v1, "kotlin.jvm.functions.Function1"

    invoke-static {p1, v1}, Lcom/gmhub/qs/ComposePanelRoot;->access$000(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v1

    iput-object v1, p0, Lcom/gmhub/qs/ComposePanelRoot$Abi;->function1:Ljava/lang/Class;

    const-string v2, "kotlin.jvm.functions.Function2"

    invoke-static {p1, v2}, Lcom/gmhub/qs/ComposePanelRoot;->access$000(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v2

    iput-object v2, p0, Lcom/gmhub/qs/ComposePanelRoot$Abi;->function2:Ljava/lang/Class;

    const-string v3, "androidx.compose.runtime.Composer"

    invoke-static {p1, v3}, Lcom/gmhub/qs/ComposePanelRoot;->access$000(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v3

    const-string v4, "androidx.compose.runtime.CompositionLocal"

    invoke-static {p1, v4}, Lcom/gmhub/qs/ComposePanelRoot;->access$000(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v4

    const-string v5, "androidx.compose.runtime.CompositionLocalKt"

    invoke-static {p1, v5}, Lcom/gmhub/qs/ComposePanelRoot;->access$000(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v5

    sget-object v6, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    filled-new-array {v6}, [Ljava/lang/Class;

    move-result-object v6

    const-string v7, "startRestartGroup"

    invoke-static {v3, v7, v6}, Lcom/gmhub/qs/ComposePanelRoot;->access$100(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v6

    iput-object v6, p0, Lcom/gmhub/qs/ComposePanelRoot$Abi;->start:Ljava/lang/reflect/Method;

    const/4 v6, 0x0

    new-array v7, v6, [Ljava/lang/Class;

    const-string v8, "endRestartGroup"

    invoke-static {v3, v8, v7}, Lcom/gmhub/qs/ComposePanelRoot;->access$100(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v7

    iput-object v7, p0, Lcom/gmhub/qs/ComposePanelRoot$Abi;->end:Ljava/lang/reflect/Method;

    sget-object v7, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    filled-new-array {v7}, [Ljava/lang/Class;

    move-result-object v7

    const-string v8, "startReplaceGroup"

    invoke-static {v3, v8, v7}, Lcom/gmhub/qs/ComposePanelRoot;->access$100(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v7

    iput-object v7, p0, Lcom/gmhub/qs/ComposePanelRoot$Abi;->startReplace:Ljava/lang/reflect/Method;

    const-string v7, "endReplaceGroup"

    new-array v8, v6, [Ljava/lang/Class;

    invoke-static {v3, v7, v8}, Lcom/gmhub/qs/ComposePanelRoot;->access$100(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v7

    iput-object v7, p0, Lcom/gmhub/qs/ComposePanelRoot$Abi;->endReplace:Ljava/lang/reflect/Method;

    const-class v7, Ljava/lang/Object;

    filled-new-array {v7}, [Ljava/lang/Class;

    move-result-object v7

    const-string v8, "changedInstance"

    invoke-static {v3, v8, v7}, Lcom/gmhub/qs/ComposePanelRoot;->access$100(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v7

    iput-object v7, p0, Lcom/gmhub/qs/ComposePanelRoot$Abi;->changedObject:Ljava/lang/reflect/Method;

    sget-object v7, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    filled-new-array {v7}, [Ljava/lang/Class;

    move-result-object v7

    const-string v8, "changed"

    invoke-static {v3, v8, v7}, Lcom/gmhub/qs/ComposePanelRoot;->access$100(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v7

    iput-object v7, p0, Lcom/gmhub/qs/ComposePanelRoot$Abi;->changedInt:Ljava/lang/reflect/Method;

    const-string v7, "rememberedValue"

    new-array v8, v6, [Ljava/lang/Class;

    invoke-static {v3, v7, v8}, Lcom/gmhub/qs/ComposePanelRoot;->access$100(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v7

    iput-object v7, p0, Lcom/gmhub/qs/ComposePanelRoot$Abi;->remembered:Ljava/lang/reflect/Method;

    const-class v7, Ljava/lang/Object;

    filled-new-array {v7}, [Ljava/lang/Class;

    move-result-object v7

    const-string v8, "updateRememberedValue"

    invoke-static {v3, v8, v7}, Lcom/gmhub/qs/ComposePanelRoot;->access$100(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v7

    iput-object v7, p0, Lcom/gmhub/qs/ComposePanelRoot$Abi;->remember:Ljava/lang/reflect/Method;

    const-string v7, "consume"

    filled-new-array {v4}, [Ljava/lang/Class;

    move-result-object v4

    invoke-static {v3, v7, v4}, Lcom/gmhub/qs/ComposePanelRoot;->access$100(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v4

    iput-object v4, p0, Lcom/gmhub/qs/ComposePanelRoot$Abi;->consume:Ljava/lang/reflect/Method;

    const-string v4, "Companion"

    invoke-static {v3, v4}, Lcom/gmhub/qs/ComposePanelRoot;->access$200(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v7

    const/4 v8, 0x0

    invoke-virtual {v7, v8}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v7

    const-string v9, "androidx.compose.runtime.Composer$Companion"

    invoke-static {p1, v9}, Lcom/gmhub/qs/ComposePanelRoot;->access$000(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v9

    const-string v10, "getEmpty"

    new-array v11, v6, [Ljava/lang/Class;

    invoke-static {v9, v10, v11}, Lcom/gmhub/qs/ComposePanelRoot;->access$100(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v9

    invoke-virtual {v9, v7, v8}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v7

    iput-object v7, p0, Lcom/gmhub/qs/ComposePanelRoot$Abi;->empty:Ljava/lang/Object;

    const-string v7, "kotlin.Unit"

    invoke-static {p1, v7}, Lcom/gmhub/qs/ComposePanelRoot;->access$000(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v7

    const-string v9, "INSTANCE"

    invoke-static {v7, v9}, Lcom/gmhub/qs/ComposePanelRoot;->access$200(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v7

    invoke-virtual {v7, v8}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v7

    iput-object v7, p0, Lcom/gmhub/qs/ComposePanelRoot$Abi;->unit:Ljava/lang/Object;

    const-string v7, "androidx.compose.runtime.SnapshotStateKt"

    invoke-static {p1, v7}, Lcom/gmhub/qs/ComposePanelRoot;->access$000(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v7

    const-class v9, Ljava/lang/Object;

    filled-new-array {v9}, [Ljava/lang/Class;

    move-result-object v9

    const-string v10, "mutableStateOf$default"

    invoke-static {v7, v10, v9}, Lcom/gmhub/qs/ComposePanelRoot;->access$100(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v7

    iput-object v7, p0, Lcom/gmhub/qs/ComposePanelRoot$Abi;->state:Ljava/lang/reflect/Method;

    const-string v7, "androidx.compose.runtime.State"

    invoke-static {p1, v7}, Lcom/gmhub/qs/ComposePanelRoot;->access$000(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v7

    const-string v9, "getValue"

    new-array v10, v6, [Ljava/lang/Class;

    invoke-static {v7, v9, v10}, Lcom/gmhub/qs/ComposePanelRoot;->access$100(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v7

    iput-object v7, p0, Lcom/gmhub/qs/ComposePanelRoot$Abi;->value:Ljava/lang/reflect/Method;

    const-string v7, "androidx.compose.runtime.MutableState"

    invoke-static {p1, v7}, Lcom/gmhub/qs/ComposePanelRoot;->access$000(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v7

    const-class v9, Ljava/lang/Object;

    filled-new-array {v9}, [Ljava/lang/Class;

    move-result-object v9

    const-string v10, "setValue"

    invoke-static {v7, v10, v9}, Lcom/gmhub/qs/ComposePanelRoot;->access$100(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v7

    iput-object v7, p0, Lcom/gmhub/qs/ComposePanelRoot$Abi;->setValue:Ljava/lang/reflect/Method;

    const-string v7, "androidx.compose.runtime.DisposableEffectResult"

    invoke-static {p1, v7}, Lcom/gmhub/qs/ComposePanelRoot;->access$000(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v7

    iput-object v7, p0, Lcom/gmhub/qs/ComposePanelRoot$Abi;->disposable:Ljava/lang/Class;

    const-string v7, "androidx.compose.runtime.EffectsKt"

    invoke-static {p1, v7}, Lcom/gmhub/qs/ComposePanelRoot;->access$000(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v7

    const-class v9, Ljava/lang/Object;

    filled-new-array {v9, v1, v3}, [Ljava/lang/Class;

    move-result-object v1

    const-string v9, "DisposableEffect"

    invoke-static {v7, v9, v1}, Lcom/gmhub/qs/ComposePanelRoot;->access$100(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    iput-object v1, p0, Lcom/gmhub/qs/ComposePanelRoot$Abi;->disposableEffect:Ljava/lang/reflect/Method;

    const-string v1, "androidx.compose.runtime.ScopeUpdateScope"

    invoke-static {p1, v1}, Lcom/gmhub/qs/ComposePanelRoot;->access$000(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v1

    const-string v7, "updateScope"

    filled-new-array {v2}, [Ljava/lang/Class;

    move-result-object v9

    invoke-static {v1, v7, v9}, Lcom/gmhub/qs/ComposePanelRoot;->access$100(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    iput-object v1, p0, Lcom/gmhub/qs/ComposePanelRoot$Abi;->updateScope:Ljava/lang/reflect/Method;

    const-string v1, "androidx.compose.runtime.ProvidedValue"

    invoke-static {p1, v1}, Lcom/gmhub/qs/ComposePanelRoot;->access$000(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v1

    sget-object v7, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    filled-new-array {v1, v2, v3, v7}, [Ljava/lang/Class;

    move-result-object v1

    const-string v2, "CompositionLocalProvider"

    invoke-static {v5, v2, v1}, Lcom/gmhub/qs/ComposePanelRoot;->access$100(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    iput-object v1, p0, Lcom/gmhub/qs/ComposePanelRoot$Abi;->provider:Ljava/lang/reflect/Method;

    const-string v1, "androidx.compose.runtime.ProvidableCompositionLocal"

    invoke-static {p1, v1}, Lcom/gmhub/qs/ComposePanelRoot;->access$000(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v1

    const-class v2, Ljava/lang/Object;

    filled-new-array {v2}, [Ljava/lang/Class;

    move-result-object v2

    const-string v7, "provides"

    invoke-static {v1, v7, v2}, Lcom/gmhub/qs/ComposePanelRoot;->access$100(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    iput-object v1, p0, Lcom/gmhub/qs/ComposePanelRoot$Abi;->provide:Ljava/lang/reflect/Method;

    const-string v1, "androidx.compose.runtime.internal.ComposableLambdaKt"

    invoke-static {p1, v1}, Lcom/gmhub/qs/ComposePanelRoot;->access$000(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v1

    sget-object v2, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    sget-object v7, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    const-class v9, Ljava/lang/Object;

    sget-object v10, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    filled-new-array {v2, v7, v9, v3, v10}, [Ljava/lang/Class;

    move-result-object v2

    const-string v3, "rememberComposableLambda"

    invoke-static {v1, v3, v2}, Lcom/gmhub/qs/ComposePanelRoot;->access$100(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    iput-object v1, p0, Lcom/gmhub/qs/ComposePanelRoot$Abi;->composable:Ljava/lang/reflect/Method;

    const-string v1, "com.android.systemui.samsung.quicksetting.ui.SecQuickSettingSceneKt"

    invoke-static {p1, v1}, Lcom/gmhub/qs/ComposePanelRoot;->access$000(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v1

    const-string v2, "LocalViewModel"

    invoke-static {v1, v2}, Lcom/gmhub/qs/ComposePanelRoot;->access$200(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v1

    invoke-virtual {v1, v8}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    iput-object v1, p0, Lcom/gmhub/qs/ComposePanelRoot$Abi;->localModel:Ljava/lang/Object;

    const-string v1, "compositionLocalOf$default"

    filled-new-array {v0}, [Ljava/lang/Class;

    move-result-object v2

    invoke-static {v5, v1, v2}, Lcom/gmhub/qs/ComposePanelRoot;->access$100(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    new-instance v2, Lcom/gmhub/qs/ComposePanelRoot$Abi$$ExternalSyntheticLambda3;

    invoke-direct {v2}, Lcom/gmhub/qs/ComposePanelRoot$Abi$$ExternalSyntheticLambda3;-><init>()V

    invoke-virtual {p0, v0, v2}, Lcom/gmhub/qs/ComposePanelRoot$Abi;->function(Ljava/lang/Class;Lcom/gmhub/qs/ComposePanelRoot$Callback;)Ljava/lang/Object;

    move-result-object v0

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    invoke-virtual {v1, v8, v0}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    iput-object v0, p0, Lcom/gmhub/qs/ComposePanelRoot$Abi;->localStyle:Ljava/lang/Object;

    const-string v0, "com.android.systemui.samsung.quicksetting.ui.panel.QuickSettingSceneViewModel"

    invoke-static {p1, v0}, Lcom/gmhub/qs/ComposePanelRoot;->access$000(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    const-string v1, "qsHost"

    invoke-static {v0, v1}, Lcom/gmhub/qs/ComposePanelRoot;->access$200(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v1

    iput-object v1, p0, Lcom/gmhub/qs/ComposePanelRoot$Abi;->host:Ljava/lang/reflect/Field;

    const-class v1, Landroid/content/res/Configuration;

    filled-new-array {v1}, [Ljava/lang/Class;

    move-result-object v1

    const-string v2, "isPortraitPanel"

    invoke-static {v0, v2, v1}, Lcom/gmhub/qs/ComposePanelRoot;->access$100(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    iput-object v1, p0, Lcom/gmhub/qs/ComposePanelRoot$Abi;->portrait:Ljava/lang/reflect/Method;

    const-string v1, "isTablet"

    new-array v2, v6, [Ljava/lang/Class;

    invoke-static {v0, v1, v2}, Lcom/gmhub/qs/ComposePanelRoot;->access$100(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    iput-object v1, p0, Lcom/gmhub/qs/ComposePanelRoot$Abi;->tablet:Ljava/lang/reflect/Method;

    const-string v1, "isPopOverEnabled"

    new-array v2, v6, [Ljava/lang/Class;

    invoke-static {v0, v1, v2}, Lcom/gmhub/qs/ComposePanelRoot;->access$100(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    iput-object v0, p0, Lcom/gmhub/qs/ComposePanelRoot$Abi;->popover:Ljava/lang/reflect/Method;

    const-string v0, "androidx.compose.ui.Modifier"

    invoke-static {p1, v0}, Lcom/gmhub/qs/ComposePanelRoot;->access$000(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    invoke-static {v0, v4}, Lcom/gmhub/qs/ComposePanelRoot;->access$200(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v1

    invoke-virtual {v1, v8}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    iput-object v1, p0, Lcom/gmhub/qs/ComposePanelRoot$Abi;->modifier:Ljava/lang/Object;

    const-string v1, "androidx.compose.foundation.layout.PaddingKt"

    invoke-static {p1, v1}, Lcom/gmhub/qs/ComposePanelRoot;->access$000(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v1

    sget-object v2, Ljava/lang/Float;->TYPE:Ljava/lang/Class;

    sget-object v3, Ljava/lang/Float;->TYPE:Ljava/lang/Class;

    sget-object v4, Ljava/lang/Float;->TYPE:Ljava/lang/Class;

    sget-object v5, Ljava/lang/Float;->TYPE:Ljava/lang/Class;

    filled-new-array {v0, v2, v3, v4, v5}, [Ljava/lang/Class;

    move-result-object v2

    const-string v3, "padding-qDBjuR0"

    invoke-static {v1, v3, v2}, Lcom/gmhub/qs/ComposePanelRoot;->access$100(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    iput-object v1, p0, Lcom/gmhub/qs/ComposePanelRoot$Abi;->padding:Ljava/lang/reflect/Method;

    const-string v1, "then"

    filled-new-array {v0}, [Ljava/lang/Class;

    move-result-object v2

    invoke-static {v0, v1, v2}, Lcom/gmhub/qs/ComposePanelRoot;->access$100(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    iput-object v0, p0, Lcom/gmhub/qs/ComposePanelRoot$Abi;->then:Ljava/lang/reflect/Method;

    const-string v0, "com.android.systemui.qs.QSHost"

    invoke-static {p1, v0}, Lcom/gmhub/qs/ComposePanelRoot;->access$000(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    const-string v1, "getUserId"

    new-array v2, v6, [Ljava/lang/Class;

    invoke-static {v0, v1, v2}, Lcom/gmhub/qs/ComposePanelRoot;->access$100(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    iput-object v1, p0, Lcom/gmhub/qs/ComposePanelRoot$Abi;->userId:Ljava/lang/reflect/Method;

    const-string v1, "getUserContext"

    new-array v2, v6, [Ljava/lang/Class;

    invoke-static {v0, v1, v2}, Lcom/gmhub/qs/ComposePanelRoot;->access$100(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    iput-object v0, p0, Lcom/gmhub/qs/ComposePanelRoot$Abi;->userContext:Ljava/lang/reflect/Method;

    const-string v0, "com.android.systemui.samsung.quicksetting.ui.base.spannablegrid.SpannableGridTileKt$$ExternalSyntheticLambda6"

    invoke-static {p1, v0}, Lcom/gmhub/qs/ComposePanelRoot;->access$000(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    const-string v1, "f$1"

    invoke-static {v0, v1}, Lcom/gmhub/qs/ComposePanelRoot;->access$200(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v1

    iput-object v1, p0, Lcom/gmhub/qs/ComposePanelRoot$Abi;->tileItem:Ljava/lang/reflect/Field;

    const-string v1, "f$22"

    invoke-static {v0, v1}, Lcom/gmhub/qs/ComposePanelRoot;->access$200(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v0

    iput-object v0, p0, Lcom/gmhub/qs/ComposePanelRoot$Abi;->tileScope:Ljava/lang/reflect/Field;

    const-string v0, "com.android.systemui.samsung.quicksetting.ui.base.spannablegrid.SpannableGridTileScopeImpl"

    invoke-static {p1, v0}, Lcom/gmhub/qs/ComposePanelRoot;->access$000(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    const-string v1, "spanSize"

    invoke-static {v0, v1}, Lcom/gmhub/qs/ComposePanelRoot;->access$200(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v1

    iput-object v1, p0, Lcom/gmhub/qs/ComposePanelRoot$Abi;->spanSize:Ljava/lang/reflect/Field;

    const-string v1, "inAvailableGrid"

    invoke-static {v0, v1}, Lcom/gmhub/qs/ComposePanelRoot;->access$200(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v1

    iput-object v1, p0, Lcom/gmhub/qs/ComposePanelRoot$Abi;->inAvailableGrid:Ljava/lang/reflect/Field;

    const-string v1, "expanded"

    invoke-static {v0, v1}, Lcom/gmhub/qs/ComposePanelRoot;->access$200(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v0

    iput-object v0, p0, Lcom/gmhub/qs/ComposePanelRoot$Abi;->expanded:Ljava/lang/reflect/Field;

    const-string v0, "com.android.systemui.samsung.quicksetting.domain.model.items.MediaPlayer"

    invoke-static {p1, v0}, Lcom/gmhub/qs/ComposePanelRoot;->access$000(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    iput-object v0, p0, Lcom/gmhub/qs/ComposePanelRoot$Abi;->media:Ljava/lang/Class;

    const-string v0, "com.android.systemui.samsung.quicksetting.domain.model.items.LegacyMediaPlayer"

    invoke-static {p1, v0}, Lcom/gmhub/qs/ComposePanelRoot;->access$000(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    iput-object v0, p0, Lcom/gmhub/qs/ComposePanelRoot$Abi;->legacyMedia:Ljava/lang/Class;

    const-string v0, "androidx.compose.foundation.shape.RoundedCornerShapeKt"

    invoke-static {p1, v0}, Lcom/gmhub/qs/ComposePanelRoot;->access$000(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object p1

    sget-object v0, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    filled-new-array {v0}, [Ljava/lang/Class;

    move-result-object v0

    const-string v1, "RoundedCornerShape"

    invoke-static {p1, v1, v0}, Lcom/gmhub/qs/ComposePanelRoot;->access$100(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    const/16 v2, 0x32

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-virtual {v0, v8, v2}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    iput-object v0, p0, Lcom/gmhub/qs/ComposePanelRoot$Abi;->capsule:Ljava/lang/Object;

    sget-object v0, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    filled-new-array {v0}, [Ljava/lang/Class;

    move-result-object v0

    invoke-static {p1, v1, v0}, Lcom/gmhub/qs/ComposePanelRoot;->access$100(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    const/16 v1, 0x10

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-virtual {v0, v8, v1}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    iput-object v0, p0, Lcom/gmhub/qs/ComposePanelRoot$Abi;->galleryCard:Ljava/lang/Object;

    sget-object v0, Ljava/lang/Float;->TYPE:Ljava/lang/Class;

    filled-new-array {v0}, [Ljava/lang/Class;

    move-result-object v0

    const-string v1, "RoundedCornerShape-0680j_4"

    invoke-static {p1, v1, v0}, Lcom/gmhub/qs/ComposePanelRoot;->access$100(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object p1

    const/high16 v0, 0x42000000    # 32.0f

    invoke-static {v0}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v0

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    invoke-virtual {p1, v8, v0}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    iput-object p1, p0, Lcom/gmhub/qs/ComposePanelRoot$Abi;->card:Ljava/lang/Object;

    return-void
.end method

.method static synthetic lambda$function$0(Ljava/lang/Class;Lcom/gmhub/qs/ComposePanelRoot$Callback;Ljava/lang/Object;Ljava/lang/reflect/Method;[Ljava/lang/Object;)Ljava/lang/Object;
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Throwable;
        }
    .end annotation

    invoke-virtual {p3}, Ljava/lang/reflect/Method;->getDeclaringClass()Ljava/lang/Class;

    move-result-object v0

    const-class v1, Ljava/lang/Object;

    const/4 v2, 0x0

    if-ne v0, v1, :cond_4

    invoke-virtual {p3}, Ljava/lang/reflect/Method;->getName()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/String;->hashCode()I

    invoke-virtual {p1}, Ljava/lang/String;->hashCode()I

    move-result v0

    const/4 v1, 0x1

    const/4 v3, -0x1

    sparse-switch v0, :sswitch_data_0

    goto :goto_0

    :sswitch_0
    const-string v0, "hashCode"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-nez p1, :cond_0

    goto :goto_0

    :cond_0
    const/4 v3, 0x2

    goto :goto_0

    :sswitch_1
    const-string v0, "equals"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-nez p1, :cond_1

    goto :goto_0

    :cond_1
    move v3, v1

    goto :goto_0

    :sswitch_2
    const-string v0, "toString"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-nez p1, :cond_2

    goto :goto_0

    :cond_2
    move v3, v2

    :goto_0
    packed-switch v3, :pswitch_data_0

    new-instance p0, Ljava/lang/UnsupportedOperationException;

    invoke-virtual {p3}, Ljava/lang/reflect/Method;->getName()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p0, p1}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw p0

    :pswitch_0
    invoke-static {p2}, Ljava/lang/System;->identityHashCode(Ljava/lang/Object;)I

    move-result p0

    invoke-static {p0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p0

    return-object p0

    :pswitch_1
    aget-object p0, p4, v2

    if-ne p2, p0, :cond_3

    move v2, v1

    :cond_3
    invoke-static {v2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object p0

    return-object p0

    :pswitch_2
    new-instance p1, Ljava/lang/StringBuilder;

    const-string p2, "GMHubQs/"

    invoke-direct {p1, p2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p0}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object p0

    invoke-virtual {p1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0

    :cond_4
    if-nez p4, :cond_5

    new-array p4, v2, [Ljava/lang/Object;

    :cond_5
    invoke-interface {p1, p4}, Lcom/gmhub/qs/ComposePanelRoot$Callback;->invoke([Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    return-object p0

    :sswitch_data_0
    .sparse-switch
        -0x69e9ad94 -> :sswitch_2
        -0x4d378041 -> :sswitch_1
        0x8cdac1b -> :sswitch_0
    .end sparse-switch

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method static synthetic lambda$new$0([Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    const/4 p0, 0x0

    invoke-static {p0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p0

    return-object p0
.end method


# virtual methods
.method content(Ljava/lang/Object;Ljava/lang/Object;Ljava/util/List;Ljava/lang/Object;Ljava/lang/Object;I)V
    .locals 12
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

    iget-object v0, p0, Lcom/gmhub/qs/ComposePanelRoot$Abi;->start:Ljava/lang/reflect/Method;

    const v2, 0x474d5101

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    move-object/from16 v3, p5

    invoke-static {v0, v3, v2}, Lcom/gmhub/qs/ComposePanelRoot;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v7

    iget-object v0, p0, Lcom/gmhub/qs/ComposePanelRoot$Abi;->consume:Ljava/lang/reflect/Method;

    iget-object v2, p0, Lcom/gmhub/qs/ComposePanelRoot$Abi;->localModel:Ljava/lang/Object;

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v0, v7, v2}, Lcom/gmhub/qs/ComposePanelRoot;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    :try_start_0
    iget-object v2, p0, Lcom/gmhub/qs/ComposePanelRoot$Abi;->host:Ljava/lang/reflect/Field;

    invoke-virtual {v2, v0}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    iget-object v3, p0, Lcom/gmhub/qs/ComposePanelRoot$Abi;->userContext:Ljava/lang/reflect/Method;

    const/4 v8, 0x0

    new-array v4, v8, [Ljava/lang/Object;

    invoke-static {v3, v2, v4}, Lcom/gmhub/qs/ComposePanelRoot;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Landroid/content/Context;
    :try_end_0
    .catch Ljava/lang/IllegalAccessException; {:try_start_0 .. :try_end_0} :catch_0

    if-eqz v3, :cond_5

    iget-object v4, p0, Lcom/gmhub/qs/ComposePanelRoot$Abi;->userId:Ljava/lang/reflect/Method;

    new-array v5, v8, [Ljava/lang/Object;

    invoke-static {v4, v2, v5}, Lcom/gmhub/qs/ComposePanelRoot;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/Number;

    invoke-virtual {v2}, Ljava/lang/Number;->intValue()I

    move-result v2

    iget-object v4, p0, Lcom/gmhub/qs/ComposePanelRoot$Abi;->startReplace:Ljava/lang/reflect/Method;

    const v5, 0x474d5102

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    filled-new-array {v5}, [Ljava/lang/Object;

    move-result-object v5

    invoke-static {v4, v7, v5}, Lcom/gmhub/qs/ComposePanelRoot;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v4, p0, Lcom/gmhub/qs/ComposePanelRoot$Abi;->changedObject:Ljava/lang/reflect/Method;

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    invoke-static {v4, v7, v0}, Lcom/gmhub/qs/ComposePanelRoot;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Boolean;

    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    iget-object v4, p0, Lcom/gmhub/qs/ComposePanelRoot$Abi;->changedInt:Ljava/lang/reflect/Method;

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    filled-new-array {v5}, [Ljava/lang/Object;

    move-result-object v5

    invoke-static {v4, v7, v5}, Lcom/gmhub/qs/ComposePanelRoot;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/Boolean;

    invoke-virtual {v4}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v4

    or-int/2addr v0, v4

    iget-object v4, p0, Lcom/gmhub/qs/ComposePanelRoot$Abi;->remembered:Ljava/lang/reflect/Method;

    new-array v5, v8, [Ljava/lang/Object;

    invoke-static {v4, v7, v5}, Lcom/gmhub/qs/ComposePanelRoot;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    if-nez v0, :cond_1

    iget-object v0, p0, Lcom/gmhub/qs/ComposePanelRoot$Abi;->empty:Ljava/lang/Object;

    if-eq v4, v0, :cond_1

    instance-of v0, v4, Lcom/gmhub/qs/ComposePanelRoot$Session;

    if-nez v0, :cond_0

    goto :goto_0

    :cond_0
    check-cast v4, Lcom/gmhub/qs/ComposePanelRoot$Session;

    goto :goto_1

    :cond_1
    :goto_0
    new-instance v4, Lcom/gmhub/qs/ComposePanelRoot$Session;

    invoke-direct {v4, p0, v3, v2}, Lcom/gmhub/qs/ComposePanelRoot$Session;-><init>(Lcom/gmhub/qs/ComposePanelRoot$Abi;Landroid/content/Context;I)V

    iget-object v0, p0, Lcom/gmhub/qs/ComposePanelRoot$Abi;->remember:Ljava/lang/reflect/Method;

    filled-new-array {v4}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v0, v7, v2}, Lcom/gmhub/qs/ComposePanelRoot;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    :goto_1
    iget-object v0, p0, Lcom/gmhub/qs/ComposePanelRoot$Abi;->endReplace:Ljava/lang/reflect/Method;

    new-array v2, v8, [Ljava/lang/Object;

    invoke-static {v0, v7, v2}, Lcom/gmhub/qs/ComposePanelRoot;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Lcom/gmhub/qs/ComposePanelRoot$Abi;->disposableEffect:Ljava/lang/reflect/Method;

    iget-object v2, v4, Lcom/gmhub/qs/ComposePanelRoot$Session;->effect:Ljava/lang/Object;

    filled-new-array {v4, v2, v7}, [Ljava/lang/Object;

    move-result-object v2

    const/4 v9, 0x0

    invoke-static {v0, v9, v2}, Lcom/gmhub/qs/ComposePanelRoot;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Lcom/gmhub/qs/ComposePanelRoot$Abi;->value:Ljava/lang/reflect/Method;

    iget-object v2, v4, Lcom/gmhub/qs/ComposePanelRoot$Session;->selection:Ljava/lang/Object;

    new-array v3, v8, [Ljava/lang/Object;

    invoke-static {v0, v2, v3}, Lcom/gmhub/qs/ComposePanelRoot;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v10

    iget-object v0, p0, Lcom/gmhub/qs/ComposePanelRoot$Abi;->startReplace:Ljava/lang/reflect/Method;

    const v2, 0x474d5103

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v0, v7, v2}, Lcom/gmhub/qs/ComposePanelRoot;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Lcom/gmhub/qs/ComposePanelRoot$Abi;->changedObject:Ljava/lang/reflect/Method;

    filled-new-array {p1}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v0, v7, v2}, Lcom/gmhub/qs/ComposePanelRoot;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Boolean;

    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    iget-object v2, p0, Lcom/gmhub/qs/ComposePanelRoot$Abi;->changedObject:Ljava/lang/reflect/Method;

    filled-new-array {p2}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v2, v7, v3}, Lcom/gmhub/qs/ComposePanelRoot;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/Boolean;

    invoke-virtual {v2}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v2

    or-int/2addr v0, v2

    iget-object v2, p0, Lcom/gmhub/qs/ComposePanelRoot$Abi;->changedObject:Ljava/lang/reflect/Method;

    filled-new-array {p3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v2, v7, v3}, Lcom/gmhub/qs/ComposePanelRoot;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/Boolean;

    invoke-virtual {v2}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v2

    or-int/2addr v0, v2

    iget-object v2, p0, Lcom/gmhub/qs/ComposePanelRoot$Abi;->changedObject:Ljava/lang/reflect/Method;

    filled-new-array/range {p4 .. p4}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v2, v7, v3}, Lcom/gmhub/qs/ComposePanelRoot;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/Boolean;

    invoke-virtual {v2}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v2

    or-int/2addr v0, v2

    iget-object v2, p0, Lcom/gmhub/qs/ComposePanelRoot$Abi;->changedInt:Ljava/lang/reflect/Method;

    invoke-static/range {p6 .. p6}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v2, v7, v3}, Lcom/gmhub/qs/ComposePanelRoot;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/Boolean;

    invoke-virtual {v2}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v2

    or-int/2addr v0, v2

    iget-object v2, p0, Lcom/gmhub/qs/ComposePanelRoot$Abi;->remembered:Ljava/lang/reflect/Method;

    new-array v3, v8, [Ljava/lang/Object;

    invoke-static {v2, v7, v3}, Lcom/gmhub/qs/ComposePanelRoot;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    if-nez v0, :cond_2

    iget-object v0, p0, Lcom/gmhub/qs/ComposePanelRoot$Abi;->empty:Ljava/lang/Object;

    if-ne v2, v0, :cond_3

    :cond_2
    iget-object v11, p0, Lcom/gmhub/qs/ComposePanelRoot$Abi;->function2:Ljava/lang/Class;

    new-instance v0, Lcom/gmhub/qs/ComposePanelRoot$Abi$$ExternalSyntheticLambda0;

    move-object v1, p0

    move-object v2, p1

    move-object v3, p2

    move-object v4, p3

    move-object/from16 v5, p4

    move/from16 v6, p6

    invoke-direct/range {v0 .. v6}, Lcom/gmhub/qs/ComposePanelRoot$Abi$$ExternalSyntheticLambda0;-><init>(Lcom/gmhub/qs/ComposePanelRoot$Abi;Ljava/lang/Object;Ljava/lang/Object;Ljava/util/List;Ljava/lang/Object;I)V

    invoke-virtual {p0, v11, v0}, Lcom/gmhub/qs/ComposePanelRoot$Abi;->function(Ljava/lang/Class;Lcom/gmhub/qs/ComposePanelRoot$Callback;)Ljava/lang/Object;

    move-result-object v2

    iget-object v0, p0, Lcom/gmhub/qs/ComposePanelRoot$Abi;->remember:Ljava/lang/reflect/Method;

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v0, v7, v3}, Lcom/gmhub/qs/ComposePanelRoot;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    :cond_3
    iget-object v0, p0, Lcom/gmhub/qs/ComposePanelRoot$Abi;->endReplace:Ljava/lang/reflect/Method;

    new-array v3, v8, [Ljava/lang/Object;

    invoke-static {v0, v7, v3}, Lcom/gmhub/qs/ComposePanelRoot;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Lcom/gmhub/qs/ComposePanelRoot$Abi;->composable:Ljava/lang/reflect/Method;

    const v3, 0x474d5104

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    const/4 v4, 0x1

    invoke-static {v4}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v4

    invoke-static {v8}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    filled-new-array {v3, v4, v2, v7, v5}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v0, v9, v2}, Lcom/gmhub/qs/ComposePanelRoot;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    iget-object v2, p0, Lcom/gmhub/qs/ComposePanelRoot$Abi;->provider:Ljava/lang/reflect/Method;

    iget-object v3, p0, Lcom/gmhub/qs/ComposePanelRoot$Abi;->provide:Ljava/lang/reflect/Method;

    iget-object v4, p0, Lcom/gmhub/qs/ComposePanelRoot$Abi;->localStyle:Ljava/lang/Object;

    filled-new-array {v10}, [Ljava/lang/Object;

    move-result-object v5

    invoke-static {v3, v4, v5}, Lcom/gmhub/qs/ComposePanelRoot;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    invoke-static {v8}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    filled-new-array {v3, v0, v7, v4}, [Ljava/lang/Object;

    move-result-object v0

    invoke-static {v2, v9, v0}, Lcom/gmhub/qs/ComposePanelRoot;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Lcom/gmhub/qs/ComposePanelRoot$Abi;->end:Ljava/lang/reflect/Method;

    new-array v2, v8, [Ljava/lang/Object;

    invoke-static {v0, v7, v2}, Lcom/gmhub/qs/ComposePanelRoot;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v7

    if-eqz v7, :cond_4

    iget-object v8, p0, Lcom/gmhub/qs/ComposePanelRoot$Abi;->updateScope:Ljava/lang/reflect/Method;

    iget-object v9, p0, Lcom/gmhub/qs/ComposePanelRoot$Abi;->function2:Ljava/lang/Class;

    new-instance v0, Lcom/gmhub/qs/ComposePanelRoot$Abi$$ExternalSyntheticLambda1;

    move-object v1, p0

    move-object v2, p1

    move-object v3, p2

    move-object v4, p3

    move-object/from16 v5, p4

    move/from16 v6, p6

    invoke-direct/range {v0 .. v6}, Lcom/gmhub/qs/ComposePanelRoot$Abi$$ExternalSyntheticLambda1;-><init>(Lcom/gmhub/qs/ComposePanelRoot$Abi;Ljava/lang/Object;Ljava/lang/Object;Ljava/util/List;Ljava/lang/Object;I)V

    invoke-virtual {p0, v9, v0}, Lcom/gmhub/qs/ComposePanelRoot$Abi;->function(Ljava/lang/Class;Lcom/gmhub/qs/ComposePanelRoot$Callback;)Ljava/lang/Object;

    move-result-object v0

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    invoke-static {v8, v7, v0}, Lcom/gmhub/qs/ComposePanelRoot;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    :cond_4
    return-void

    :cond_5
    :try_start_1
    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "Native QS user context unavailable"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0
    :try_end_1
    .catch Ljava/lang/IllegalAccessException; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    move-exception v0

    new-instance v1, Ljava/lang/IllegalStateException;

    invoke-direct {v1, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method function(Ljava/lang/Class;Lcom/gmhub/qs/ComposePanelRoot$Callback;)Ljava/lang/Object;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Class<",
            "*>;",
            "Lcom/gmhub/qs/ComposePanelRoot$Callback;",
            ")",
            "Ljava/lang/Object;"
        }
    .end annotation

    iget-object p0, p0, Lcom/gmhub/qs/ComposePanelRoot$Abi;->loader:Ljava/lang/ClassLoader;

    filled-new-array {p1}, [Ljava/lang/Class;

    move-result-object v0

    new-instance v1, Lcom/gmhub/qs/ComposePanelRoot$Abi$$ExternalSyntheticLambda2;

    invoke-direct {v1, p1, p2}, Lcom/gmhub/qs/ComposePanelRoot$Abi$$ExternalSyntheticLambda2;-><init>(Ljava/lang/Class;Lcom/gmhub/qs/ComposePanelRoot$Callback;)V

    invoke-static {p0, v0, v1}, Ljava/lang/reflect/Proxy;->newProxyInstance(Ljava/lang/ClassLoader;[Ljava/lang/Class;Ljava/lang/reflect/InvocationHandler;)Ljava/lang/Object;

    move-result-object p0

    return-object p0
.end method

.method synthetic lambda$content$0$com-gmhub-qs-ComposePanelRoot$Abi(Ljava/lang/Object;Ljava/lang/Object;Ljava/util/List;Ljava/lang/Object;I[Ljava/lang/Object;)Ljava/lang/Object;
    .locals 3

    invoke-static {}, Lcom/gmhub/qs/ComposePanelRoot;->access$400()Ljava/lang/reflect/Method;

    move-result-object v0

    const/4 v1, 0x0

    aget-object p6, p6, v1

    invoke-static {p5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p5

    move-object v2, p6

    move-object p6, p5

    move-object p5, v2

    filled-new-array/range {p1 .. p6}, [Ljava/lang/Object;

    move-result-object p1

    const/4 p2, 0x0

    invoke-static {v0, p2, p1}, Lcom/gmhub/qs/ComposePanelRoot;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    iget-object p0, p0, Lcom/gmhub/qs/ComposePanelRoot$Abi;->unit:Ljava/lang/Object;

    return-object p0
.end method

.method synthetic lambda$content$1$com-gmhub-qs-ComposePanelRoot$Abi(Ljava/lang/Object;Ljava/lang/Object;Ljava/util/List;Ljava/lang/Object;I[Ljava/lang/Object;)Ljava/lang/Object;
    .locals 2

    const/4 v0, 0x0

    aget-object p6, p6, v0

    or-int/lit8 p5, p5, 0x1

    move-object v1, p6

    move p6, p5

    move-object p5, v1

    invoke-virtual/range {p0 .. p6}, Lcom/gmhub/qs/ComposePanelRoot$Abi;->content(Ljava/lang/Object;Ljava/lang/Object;Ljava/util/List;Ljava/lang/Object;Ljava/lang/Object;I)V

    iget-object p0, p0, Lcom/gmhub/qs/ComposePanelRoot$Abi;->unit:Ljava/lang/Object;

    return-object p0
.end method
