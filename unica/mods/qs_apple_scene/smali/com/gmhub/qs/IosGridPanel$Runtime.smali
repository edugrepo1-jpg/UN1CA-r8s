.class final Lcom/gmhub/qs/IosGridPanel$Runtime;
.super Ljava/lang/Object;
.source "IosGridPanel.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/gmhub/qs/IosGridPanel;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "Runtime"
.end annotation


# instance fields
.field final align:Ljava/lang/reflect/Method;

.field final androidView:Ljava/lang/reflect/Method;

.field final box:Ljava/lang/reflect/Method;

.field final boxScope:Ljava/lang/Object;

.field final centerEnd:Ljava/lang/Object;

.field final changed:Ljava/lang/reflect/Method;

.field final changedInt:Ljava/lang/reflect/Method;

.field final composable:Ljava/lang/reflect/Method;

.field final consume:Ljava/lang/reflect/Method;

.field final derived:Ljava/lang/reflect/Method;

.field final disposable:Ljava/lang/Class;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/Class<",
            "*>;"
        }
    .end annotation
.end field

.field final effect:Ljava/lang/reflect/Method;

.field final empty:Ljava/lang/Object;

.field final end:Ljava/lang/reflect/Method;

.field final endReplace:Ljava/lang/reflect/Method;

.field final f1:Ljava/lang/Class;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/Class<",
            "*>;"
        }
    .end annotation
.end field

.field final f2:Ljava/lang/Class;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/Class<",
            "*>;"
        }
    .end annotation
.end field

.field final f3:Ljava/lang/Class;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/Class<",
            "*>;"
        }
    .end annotation
.end field

.field final failed:Ljava/lang/Object;

.field final fillWidth:Ljava/lang/reflect/Method;

.field final getContext:Ljava/lang/reflect/Method;

.field final getUser:Ljava/lang/reflect/Method;

.field final height:Ljava/lang/reflect/Method;

.field final host:Ljava/lang/reflect/Field;

.field final launched:Ljava/lang/reflect/Method;

.field final loader:Ljava/lang/ClassLoader;

.field final localModel:Ljava/lang/Object;

.field final localRail:Ljava/lang/Object;

.field final modifier:Ljava/lang/Object;

.field final policy:Ljava/lang/reflect/Method;

.field final provider:Ljava/lang/reflect/Method;

.field final provides:Ljava/lang/reflect/Method;

.field final remember:Ljava/lang/reflect/Method;

.field final remembered:Ljava/lang/reflect/Method;

.field final replace:Ljava/lang/reflect/Method;

.field final setValue:Ljava/lang/reflect/Method;

.field final start:Ljava/lang/reflect/Method;

.field final state:Ljava/lang/reflect/Method;

.field final topStart:Ljava/lang/Object;

.field final unit:Ljava/lang/Object;

.field final updateScope:Ljava/lang/reflect/Method;

.field final value:Ljava/lang/reflect/Method;

.field final width:Ljava/lang/reflect/Method;


# direct methods
.method constructor <init>(Ljava/lang/ClassLoader;)V
    .locals 18
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/ReflectiveOperationException;
        }
    .end annotation

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    new-instance v2, Ljava/lang/Object;

    invoke-direct {v2}, Ljava/lang/Object;-><init>()V

    iput-object v2, v0, Lcom/gmhub/qs/IosGridPanel$Runtime;->failed:Ljava/lang/Object;

    iput-object v1, v0, Lcom/gmhub/qs/IosGridPanel$Runtime;->loader:Ljava/lang/ClassLoader;

    const-string v2, "androidx.compose.runtime.Composer"

    invoke-static {v1, v2}, Lcom/gmhub/qs/IosGridPanel;->access$000(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v6

    const-string v2, "androidx.compose.ui.Modifier"

    invoke-static {v1, v2}, Lcom/gmhub/qs/IosGridPanel;->access$000(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v3

    const-string v2, "androidx.compose.ui.Alignment"

    invoke-static {v1, v2}, Lcom/gmhub/qs/IosGridPanel;->access$000(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v4

    const-string v2, "kotlin.jvm.functions.Function1"

    invoke-static {v1, v2}, Lcom/gmhub/qs/IosGridPanel;->access$000(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v2

    iput-object v2, v0, Lcom/gmhub/qs/IosGridPanel$Runtime;->f1:Ljava/lang/Class;

    const-string v5, "kotlin.jvm.functions.Function2"

    invoke-static {v1, v5}, Lcom/gmhub/qs/IosGridPanel;->access$000(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v11

    iput-object v11, v0, Lcom/gmhub/qs/IosGridPanel$Runtime;->f2:Ljava/lang/Class;

    const-string v5, "kotlin.jvm.functions.Function3"

    invoke-static {v1, v5}, Lcom/gmhub/qs/IosGridPanel;->access$000(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v5

    iput-object v5, v0, Lcom/gmhub/qs/IosGridPanel$Runtime;->f3:Ljava/lang/Class;

    sget-object v7, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    filled-new-array {v7}, [Ljava/lang/Class;

    move-result-object v7

    const-string v8, "startRestartGroup"

    invoke-static {v6, v8, v7}, Lcom/gmhub/qs/IosGridPanel;->access$100(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v7

    iput-object v7, v0, Lcom/gmhub/qs/IosGridPanel$Runtime;->start:Ljava/lang/reflect/Method;

    const/4 v12, 0x0

    new-array v7, v12, [Ljava/lang/Class;

    const-string v8, "endRestartGroup"

    invoke-static {v6, v8, v7}, Lcom/gmhub/qs/IosGridPanel;->access$100(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v7

    iput-object v7, v0, Lcom/gmhub/qs/IosGridPanel$Runtime;->end:Ljava/lang/reflect/Method;

    sget-object v7, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    filled-new-array {v7}, [Ljava/lang/Class;

    move-result-object v7

    const-string v8, "startReplaceGroup"

    invoke-static {v6, v8, v7}, Lcom/gmhub/qs/IosGridPanel;->access$100(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v7

    iput-object v7, v0, Lcom/gmhub/qs/IosGridPanel$Runtime;->replace:Ljava/lang/reflect/Method;

    const-string v7, "endReplaceGroup"

    new-array v8, v12, [Ljava/lang/Class;

    invoke-static {v6, v7, v8}, Lcom/gmhub/qs/IosGridPanel;->access$100(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v7

    iput-object v7, v0, Lcom/gmhub/qs/IosGridPanel$Runtime;->endReplace:Ljava/lang/reflect/Method;

    const-string v7, "androidx.compose.runtime.CompositionLocal"

    invoke-static {v1, v7}, Lcom/gmhub/qs/IosGridPanel;->access$000(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v7

    filled-new-array {v7}, [Ljava/lang/Class;

    move-result-object v7

    const-string v8, "consume"

    invoke-static {v6, v8, v7}, Lcom/gmhub/qs/IosGridPanel;->access$100(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v7

    iput-object v7, v0, Lcom/gmhub/qs/IosGridPanel$Runtime;->consume:Ljava/lang/reflect/Method;

    const-class v7, Ljava/lang/Object;

    filled-new-array {v7}, [Ljava/lang/Class;

    move-result-object v7

    const-string v8, "changedInstance"

    invoke-static {v6, v8, v7}, Lcom/gmhub/qs/IosGridPanel;->access$100(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v7

    iput-object v7, v0, Lcom/gmhub/qs/IosGridPanel$Runtime;->changed:Ljava/lang/reflect/Method;

    sget-object v7, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    filled-new-array {v7}, [Ljava/lang/Class;

    move-result-object v7

    const-string v8, "changed"

    invoke-static {v6, v8, v7}, Lcom/gmhub/qs/IosGridPanel;->access$100(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v7

    iput-object v7, v0, Lcom/gmhub/qs/IosGridPanel$Runtime;->changedInt:Ljava/lang/reflect/Method;

    const-string v7, "rememberedValue"

    new-array v8, v12, [Ljava/lang/Class;

    invoke-static {v6, v7, v8}, Lcom/gmhub/qs/IosGridPanel;->access$100(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v7

    iput-object v7, v0, Lcom/gmhub/qs/IosGridPanel$Runtime;->remembered:Ljava/lang/reflect/Method;

    const-class v7, Ljava/lang/Object;

    filled-new-array {v7}, [Ljava/lang/Class;

    move-result-object v7

    const-string v8, "updateRememberedValue"

    invoke-static {v6, v8, v7}, Lcom/gmhub/qs/IosGridPanel;->access$100(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v7

    iput-object v7, v0, Lcom/gmhub/qs/IosGridPanel$Runtime;->remember:Ljava/lang/reflect/Method;

    const-string v7, "androidx.compose.runtime.Composer$Companion"

    invoke-static {v1, v7}, Lcom/gmhub/qs/IosGridPanel;->access$000(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v7

    const-string v8, "getEmpty"

    new-array v9, v12, [Ljava/lang/Class;

    invoke-static {v7, v8, v9}, Lcom/gmhub/qs/IosGridPanel;->access$100(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v7

    const-string v8, "Companion"

    invoke-static {v6, v8}, Lcom/gmhub/qs/IosGridPanel;->access$200(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v9

    const/4 v13, 0x0

    invoke-virtual {v9, v13}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v9

    invoke-virtual {v7, v9, v13}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v7

    iput-object v7, v0, Lcom/gmhub/qs/IosGridPanel$Runtime;->empty:Ljava/lang/Object;

    const-string v7, "androidx.compose.runtime.ScopeUpdateScope"

    invoke-static {v1, v7}, Lcom/gmhub/qs/IosGridPanel;->access$000(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v7

    const-string v9, "updateScope"

    filled-new-array {v11}, [Ljava/lang/Class;

    move-result-object v10

    invoke-static {v7, v9, v10}, Lcom/gmhub/qs/IosGridPanel;->access$100(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v7

    iput-object v7, v0, Lcom/gmhub/qs/IosGridPanel$Runtime;->updateScope:Ljava/lang/reflect/Method;

    const-string v7, "kotlin.Unit"

    invoke-static {v1, v7}, Lcom/gmhub/qs/IosGridPanel;->access$000(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v7

    const-string v14, "INSTANCE"

    invoke-static {v7, v14}, Lcom/gmhub/qs/IosGridPanel;->access$200(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v7

    invoke-virtual {v7, v13}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v7

    iput-object v7, v0, Lcom/gmhub/qs/IosGridPanel$Runtime;->unit:Ljava/lang/Object;

    invoke-static {v3, v8}, Lcom/gmhub/qs/IosGridPanel;->access$200(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v7

    invoke-virtual {v7, v13}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v7

    iput-object v7, v0, Lcom/gmhub/qs/IosGridPanel$Runtime;->modifier:Ljava/lang/Object;

    const-string v7, "com.android.systemui.samsung.quicksetting.ui.SecQuickSettingSceneKt"

    invoke-static {v1, v7}, Lcom/gmhub/qs/IosGridPanel;->access$000(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v7

    const-string v8, "LocalViewModel"

    invoke-static {v7, v8}, Lcom/gmhub/qs/IosGridPanel;->access$200(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v7

    invoke-virtual {v7, v13}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v7

    iput-object v7, v0, Lcom/gmhub/qs/IosGridPanel$Runtime;->localModel:Ljava/lang/Object;

    const-string v7, "com.android.systemui.samsung.quicksetting.ui.panel.QuickSettingSceneViewModel"

    invoke-static {v1, v7}, Lcom/gmhub/qs/IosGridPanel;->access$000(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v7

    const-string v8, "qsHost"

    invoke-static {v7, v8}, Lcom/gmhub/qs/IosGridPanel;->access$200(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v7

    iput-object v7, v0, Lcom/gmhub/qs/IosGridPanel$Runtime;->host:Ljava/lang/reflect/Field;

    const-string v7, "com.android.systemui.qs.QSHost"

    invoke-static {v1, v7}, Lcom/gmhub/qs/IosGridPanel;->access$000(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v8

    const-string v9, "getUserContext"

    new-array v10, v12, [Ljava/lang/Class;

    invoke-static {v8, v9, v10}, Lcom/gmhub/qs/IosGridPanel;->access$100(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v8

    iput-object v8, v0, Lcom/gmhub/qs/IosGridPanel$Runtime;->getContext:Ljava/lang/reflect/Method;

    invoke-static {v1, v7}, Lcom/gmhub/qs/IosGridPanel;->access$000(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v7

    const-string v8, "getUserId"

    new-array v9, v12, [Ljava/lang/Class;

    invoke-static {v7, v8, v9}, Lcom/gmhub/qs/IosGridPanel;->access$100(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v7

    iput-object v7, v0, Lcom/gmhub/qs/IosGridPanel$Runtime;->getUser:Ljava/lang/reflect/Method;

    const-string v7, "androidx.compose.runtime.DisposableEffectResult"

    invoke-static {v1, v7}, Lcom/gmhub/qs/IosGridPanel;->access$000(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v7

    iput-object v7, v0, Lcom/gmhub/qs/IosGridPanel$Runtime;->disposable:Ljava/lang/Class;

    const-string v15, "androidx.compose.runtime.EffectsKt"

    invoke-static {v1, v15}, Lcom/gmhub/qs/IosGridPanel;->access$000(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v7

    const-class v8, Ljava/lang/Object;

    filled-new-array {v8, v2, v6}, [Ljava/lang/Class;

    move-result-object v8

    const-string v9, "DisposableEffect"

    invoke-static {v7, v9, v8}, Lcom/gmhub/qs/IosGridPanel;->access$100(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v7

    iput-object v7, v0, Lcom/gmhub/qs/IosGridPanel$Runtime;->effect:Ljava/lang/reflect/Method;

    const-string v7, "androidx.compose.runtime.CompositionLocalKt"

    invoke-static {v1, v7}, Lcom/gmhub/qs/IosGridPanel;->access$000(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v8

    const-string v9, "kotlin.jvm.functions.Function0"

    invoke-static {v1, v9}, Lcom/gmhub/qs/IosGridPanel;->access$000(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v10

    filled-new-array {v10}, [Ljava/lang/Class;

    move-result-object v10

    const-string v12, "compositionLocalOf$default"

    invoke-static {v8, v12, v10}, Lcom/gmhub/qs/IosGridPanel;->access$100(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v8

    invoke-static {v1, v9}, Lcom/gmhub/qs/IosGridPanel;->access$000(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v10

    new-instance v12, Lcom/gmhub/qs/IosGridPanel$Runtime$$ExternalSyntheticLambda2;

    invoke-direct {v12}, Lcom/gmhub/qs/IosGridPanel$Runtime$$ExternalSyntheticLambda2;-><init>()V

    invoke-virtual {v0, v10, v12}, Lcom/gmhub/qs/IosGridPanel$Runtime;->fn(Ljava/lang/Class;Lcom/gmhub/qs/IosGridPanel$Callback;)Ljava/lang/Object;

    move-result-object v10

    filled-new-array {v10}, [Ljava/lang/Object;

    move-result-object v10

    invoke-virtual {v8, v13, v10}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v8

    iput-object v8, v0, Lcom/gmhub/qs/IosGridPanel$Runtime;->localRail:Ljava/lang/Object;

    invoke-static {v1, v7}, Lcom/gmhub/qs/IosGridPanel;->access$000(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v7

    const-string v8, "androidx.compose.runtime.ProvidedValue"

    invoke-static {v1, v8}, Lcom/gmhub/qs/IosGridPanel;->access$000(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v8

    sget-object v10, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    filled-new-array {v8, v11, v6, v10}, [Ljava/lang/Class;

    move-result-object v8

    const-string v10, "CompositionLocalProvider"

    invoke-static {v7, v10, v8}, Lcom/gmhub/qs/IosGridPanel;->access$100(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v7

    iput-object v7, v0, Lcom/gmhub/qs/IosGridPanel$Runtime;->provider:Ljava/lang/reflect/Method;

    const-string v7, "androidx.compose.runtime.ProvidableCompositionLocal"

    invoke-static {v1, v7}, Lcom/gmhub/qs/IosGridPanel;->access$000(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v7

    const-class v8, Ljava/lang/Object;

    filled-new-array {v8}, [Ljava/lang/Class;

    move-result-object v8

    const-string v10, "provides"

    invoke-static {v7, v10, v8}, Lcom/gmhub/qs/IosGridPanel;->access$100(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v7

    iput-object v7, v0, Lcom/gmhub/qs/IosGridPanel$Runtime;->provides:Ljava/lang/reflect/Method;

    const-string v7, "androidx.compose.foundation.layout.BoxWithConstraintsKt"

    invoke-static {v1, v7}, Lcom/gmhub/qs/IosGridPanel;->access$000(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v10

    sget-object v7, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    sget-object v8, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    filled-new-array/range {v3 .. v8}, [Ljava/lang/Class;

    move-result-object v5

    move-object v12, v4

    const-string v4, "BoxWithConstraints"

    invoke-static {v10, v4, v5}, Lcom/gmhub/qs/IosGridPanel;->access$100(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v4

    iput-object v4, v0, Lcom/gmhub/qs/IosGridPanel$Runtime;->box:Ljava/lang/reflect/Method;

    const-string v4, "androidx.compose.runtime.internal.ComposableLambdaKt"

    invoke-static {v1, v4}, Lcom/gmhub/qs/IosGridPanel;->access$000(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v4

    sget-object v5, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    sget-object v7, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    const-class v8, Ljava/lang/Object;

    sget-object v10, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    filled-new-array {v5, v7, v8, v6, v10}, [Ljava/lang/Class;

    move-result-object v5

    const-string v7, "rememberComposableLambda"

    invoke-static {v4, v7, v5}, Lcom/gmhub/qs/IosGridPanel;->access$100(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v4

    iput-object v4, v0, Lcom/gmhub/qs/IosGridPanel$Runtime;->composable:Ljava/lang/reflect/Method;

    const-string v4, "androidx.compose.ui.viewinterop.AndroidView_androidKt"

    invoke-static {v1, v4}, Lcom/gmhub/qs/IosGridPanel;->access$000(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v4

    move-object v5, v9

    sget-object v9, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    sget-object v10, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    move-object v7, v5

    move-object v5, v2

    move-object v8, v6

    move-object v6, v2

    move-object/from16 v16, v7

    move-object v7, v2

    move-object/from16 v17, v3

    move-object v3, v2

    move-object v2, v4

    move-object/from16 v4, v17

    move-object/from16 v17, v16

    filled-new-array/range {v3 .. v10}, [Ljava/lang/Class;

    move-result-object v3

    move-object v6, v8

    const-string v5, "AndroidView"

    invoke-static {v2, v5, v3}, Lcom/gmhub/qs/IosGridPanel;->access$100(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v2

    iput-object v2, v0, Lcom/gmhub/qs/IosGridPanel$Runtime;->androidView:Ljava/lang/reflect/Method;

    const-string v2, "androidx.compose.foundation.layout.SizeKt"

    invoke-static {v1, v2}, Lcom/gmhub/qs/IosGridPanel;->access$000(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v2

    sget-object v3, Ljava/lang/Float;->TYPE:Ljava/lang/Class;

    filled-new-array {v4, v3}, [Ljava/lang/Class;

    move-result-object v3

    const-string v5, "fillMaxWidth"

    invoke-static {v2, v5, v3}, Lcom/gmhub/qs/IosGridPanel;->access$100(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v3

    iput-object v3, v0, Lcom/gmhub/qs/IosGridPanel$Runtime;->fillWidth:Ljava/lang/reflect/Method;

    sget-object v3, Ljava/lang/Float;->TYPE:Ljava/lang/Class;

    filled-new-array {v4, v3}, [Ljava/lang/Class;

    move-result-object v3

    const-string v5, "width-3ABfNKs"

    invoke-static {v2, v5, v3}, Lcom/gmhub/qs/IosGridPanel;->access$100(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v3

    iput-object v3, v0, Lcom/gmhub/qs/IosGridPanel$Runtime;->width:Ljava/lang/reflect/Method;

    sget-object v3, Ljava/lang/Float;->TYPE:Ljava/lang/Class;

    filled-new-array {v4, v3}, [Ljava/lang/Class;

    move-result-object v3

    const-string v5, "height-3ABfNKs"

    invoke-static {v2, v5, v3}, Lcom/gmhub/qs/IosGridPanel;->access$100(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v2

    iput-object v2, v0, Lcom/gmhub/qs/IosGridPanel$Runtime;->height:Ljava/lang/reflect/Method;

    const-string v2, "androidx.compose.foundation.layout.BoxScopeInstance"

    invoke-static {v1, v2}, Lcom/gmhub/qs/IosGridPanel;->access$000(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v2

    invoke-static {v2, v14}, Lcom/gmhub/qs/IosGridPanel;->access$200(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v3

    invoke-virtual {v3, v13}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    iput-object v3, v0, Lcom/gmhub/qs/IosGridPanel$Runtime;->boxScope:Ljava/lang/Object;

    const-string v3, "align"

    filled-new-array {v4, v12}, [Ljava/lang/Class;

    move-result-object v4

    invoke-static {v2, v3, v4}, Lcom/gmhub/qs/IosGridPanel;->access$100(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v2

    iput-object v2, v0, Lcom/gmhub/qs/IosGridPanel$Runtime;->align:Ljava/lang/reflect/Method;

    const-string v2, "androidx.compose.ui.Alignment$Companion"

    invoke-static {v1, v2}, Lcom/gmhub/qs/IosGridPanel;->access$000(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v2

    const-string v3, "TopStart"

    invoke-static {v2, v3}, Lcom/gmhub/qs/IosGridPanel;->access$200(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v3

    invoke-virtual {v3, v13}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    iput-object v3, v0, Lcom/gmhub/qs/IosGridPanel$Runtime;->topStart:Ljava/lang/Object;

    const-string v3, "CenterEnd"

    invoke-static {v2, v3}, Lcom/gmhub/qs/IosGridPanel;->access$200(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v2

    invoke-virtual {v2, v13}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    iput-object v2, v0, Lcom/gmhub/qs/IosGridPanel$Runtime;->centerEnd:Ljava/lang/Object;

    const-string v2, "androidx.compose.runtime.State"

    invoke-static {v1, v2}, Lcom/gmhub/qs/IosGridPanel;->access$000(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v2

    const-string v3, "getValue"

    const/4 v4, 0x0

    new-array v5, v4, [Ljava/lang/Class;

    invoke-static {v2, v3, v5}, Lcom/gmhub/qs/IosGridPanel;->access$100(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v2

    iput-object v2, v0, Lcom/gmhub/qs/IosGridPanel$Runtime;->value:Ljava/lang/reflect/Method;

    const-string v2, "androidx.compose.runtime.MutableState"

    invoke-static {v1, v2}, Lcom/gmhub/qs/IosGridPanel;->access$000(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v2

    const-class v3, Ljava/lang/Object;

    filled-new-array {v3}, [Ljava/lang/Class;

    move-result-object v3

    const-string v4, "setValue"

    invoke-static {v2, v4, v3}, Lcom/gmhub/qs/IosGridPanel;->access$100(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v2

    iput-object v2, v0, Lcom/gmhub/qs/IosGridPanel$Runtime;->setValue:Ljava/lang/reflect/Method;

    const-string v2, "androidx.compose.runtime.SnapshotStateKt"

    invoke-static {v1, v2}, Lcom/gmhub/qs/IosGridPanel;->access$000(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v3

    const-class v4, Ljava/lang/Object;

    filled-new-array {v4}, [Ljava/lang/Class;

    move-result-object v4

    const-string v5, "mutableStateOf$default"

    invoke-static {v3, v5, v4}, Lcom/gmhub/qs/IosGridPanel;->access$100(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v3

    iput-object v3, v0, Lcom/gmhub/qs/IosGridPanel$Runtime;->state:Ljava/lang/reflect/Method;

    invoke-static {v1, v2}, Lcom/gmhub/qs/IosGridPanel;->access$000(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v3

    const-string v4, "structuralEqualityPolicy"

    const/4 v5, 0x0

    new-array v5, v5, [Ljava/lang/Class;

    invoke-static {v3, v4, v5}, Lcom/gmhub/qs/IosGridPanel;->access$100(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v3

    iput-object v3, v0, Lcom/gmhub/qs/IosGridPanel$Runtime;->policy:Ljava/lang/reflect/Method;

    invoke-static {v1, v2}, Lcom/gmhub/qs/IosGridPanel;->access$000(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v2

    const-string v3, "androidx.compose.runtime.SnapshotMutationPolicy"

    invoke-static {v1, v3}, Lcom/gmhub/qs/IosGridPanel;->access$000(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v3

    move-object/from16 v5, v17

    invoke-static {v1, v5}, Lcom/gmhub/qs/IosGridPanel;->access$000(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v4

    filled-new-array {v3, v4}, [Ljava/lang/Class;

    move-result-object v3

    const-string v4, "derivedStateOf"

    invoke-static {v2, v4, v3}, Lcom/gmhub/qs/IosGridPanel;->access$100(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v2

    iput-object v2, v0, Lcom/gmhub/qs/IosGridPanel$Runtime;->derived:Ljava/lang/reflect/Method;

    invoke-static {v1, v15}, Lcom/gmhub/qs/IosGridPanel;->access$000(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v1

    const-class v2, Ljava/lang/Object;

    filled-new-array {v6, v2, v11}, [Ljava/lang/Class;

    move-result-object v2

    const-string v3, "LaunchedEffect"

    invoke-static {v1, v3, v2}, Lcom/gmhub/qs/IosGridPanel;->access$100(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    iput-object v1, v0, Lcom/gmhub/qs/IosGridPanel$Runtime;->launched:Ljava/lang/reflect/Method;

    return-void
.end method

.method static synthetic lambda$fn$0(Lcom/gmhub/qs/IosGridPanel$Callback;Ljava/lang/Object;Ljava/lang/reflect/Method;[Ljava/lang/Object;)Ljava/lang/Object;
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Throwable;
        }
    .end annotation

    invoke-virtual {p2}, Ljava/lang/reflect/Method;->getDeclaringClass()Ljava/lang/Class;

    move-result-object v0

    const-class v1, Ljava/lang/Object;

    const/4 v2, 0x0

    if-ne v0, v1, :cond_3

    invoke-virtual {p2}, Ljava/lang/reflect/Method;->getName()Ljava/lang/String;

    move-result-object p0

    const-string v0, "equals"

    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p0

    if-eqz p0, :cond_1

    aget-object p0, p3, v2

    if-ne p1, p0, :cond_0

    const/4 v2, 0x1

    :cond_0
    invoke-static {v2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object p0

    return-object p0

    :cond_1
    invoke-virtual {p2}, Ljava/lang/reflect/Method;->getName()Ljava/lang/String;

    move-result-object p0

    const-string p2, "hashCode"

    invoke-virtual {p0, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p0

    if-eqz p0, :cond_2

    invoke-static {p1}, Ljava/lang/System;->identityHashCode(Ljava/lang/Object;)I

    move-result p0

    invoke-static {p0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p0

    return-object p0

    :cond_2
    const-string p0, "GMHubNativePages"

    return-object p0

    :cond_3
    if-nez p3, :cond_4

    new-array p3, v2, [Ljava/lang/Object;

    :cond_4
    invoke-interface {p0, p3}, Lcom/gmhub/qs/IosGridPanel$Callback;->invoke([Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    return-object p0
.end method

.method static synthetic lambda$new$0([Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    sget-object p0, Ljava/lang/Boolean;->FALSE:Ljava/lang/Boolean;

    return-object p0
.end method


# virtual methods
.method fn(Ljava/lang/Class;Lcom/gmhub/qs/IosGridPanel$Callback;)Ljava/lang/Object;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Class<",
            "*>;",
            "Lcom/gmhub/qs/IosGridPanel$Callback;",
            ")",
            "Ljava/lang/Object;"
        }
    .end annotation

    iget-object p0, p0, Lcom/gmhub/qs/IosGridPanel$Runtime;->loader:Ljava/lang/ClassLoader;

    filled-new-array {p1}, [Ljava/lang/Class;

    move-result-object p1

    new-instance v0, Lcom/gmhub/qs/IosGridPanel$Runtime$$ExternalSyntheticLambda0;

    invoke-direct {v0, p2}, Lcom/gmhub/qs/IosGridPanel$Runtime$$ExternalSyntheticLambda0;-><init>(Lcom/gmhub/qs/IosGridPanel$Callback;)V

    invoke-static {p0, p1, v0}, Ljava/lang/reflect/Proxy;->newProxyInstance(Ljava/lang/ClassLoader;[Ljava/lang/Class;Ljava/lang/reflect/InvocationHandler;)Ljava/lang/Object;

    move-result-object p0

    return-object p0
.end method

.method synthetic lambda$render$0$com-gmhub-qs-IosGridPanel$Runtime(Ljava/lang/Object;Lcom/gmhub/qs/IosGridPanel$Session;Lcom/gmhub/qs/NativePageNavigation$Request;[Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    if-nez p1, :cond_0

    iget-object p0, p0, Lcom/gmhub/qs/IosGridPanel$Runtime;->unit:Ljava/lang/Object;

    return-object p0

    :cond_0
    iget-object p1, p2, Lcom/gmhub/qs/IosGridPanel$Session;->navigation:Lcom/gmhub/qs/NativePageNavigation;

    const/4 p2, 0x1

    aget-object p2, p4, p2

    iget-object p0, p0, Lcom/gmhub/qs/IosGridPanel$Runtime;->unit:Ljava/lang/Object;

    invoke-virtual {p1, p3, p2, p0}, Lcom/gmhub/qs/NativePageNavigation;->animate(Lcom/gmhub/qs/NativePageNavigation$Request;Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    return-object p0
.end method

.method synthetic lambda$render$1$com-gmhub-qs-IosGridPanel$Runtime([Ljava/lang/Object;Lcom/gmhub/qs/NativePageNavigation$Pages;Lcom/gmhub/qs/IosGridPanel$Session;[Ljava/lang/Object;)Ljava/lang/Object;
    .locals 11

    invoke-virtual {p1}, [Ljava/lang/Object;->clone()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, [Ljava/lang/Object;

    const/4 v0, 0x1

    aget-object v1, p4, v0

    const/16 v2, 0xb

    aput-object v1, p1, v2

    const/4 v1, 0x0

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v8

    const/16 v1, 0xc

    aput-object v8, p1, v1

    invoke-static {}, Lcom/gmhub/qs/IosGridPanel;->access$400()Ljava/lang/reflect/Method;

    move-result-object v1

    const/4 v10, 0x0

    invoke-static {v1, v10, p1}, Lcom/gmhub/qs/IosGridPanel;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    iget p1, p2, Lcom/gmhub/qs/NativePageNavigation$Pages;->count:I

    if-lez p1, :cond_0

    iget-object p1, p0, Lcom/gmhub/qs/IosGridPanel$Runtime;->align:Ljava/lang/reflect/Method;

    iget-object v1, p0, Lcom/gmhub/qs/IosGridPanel$Runtime;->boxScope:Ljava/lang/Object;

    iget-object v2, p0, Lcom/gmhub/qs/IosGridPanel$Runtime;->modifier:Ljava/lang/Object;

    iget-object v3, p0, Lcom/gmhub/qs/IosGridPanel$Runtime;->centerEnd:Ljava/lang/Object;

    filled-new-array {v2, v3}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {p1, v1, v2}, Lcom/gmhub/qs/IosGridPanel;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    iget-object v1, p0, Lcom/gmhub/qs/IosGridPanel$Runtime;->width:Ljava/lang/reflect/Method;

    const/high16 v2, 0x42400000    # 48.0f

    invoke-static {v2}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v3

    filled-new-array {p1, v3}, [Ljava/lang/Object;

    move-result-object p1

    invoke-static {v1, v10, p1}, Lcom/gmhub/qs/IosGridPanel;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    iget v1, p2, Lcom/gmhub/qs/NativePageNavigation$Pages;->count:I

    int-to-float v1, v1

    mul-float/2addr v1, v2

    iget v2, p2, Lcom/gmhub/qs/NativePageNavigation$Pages;->viewport:I

    int-to-float v2, v2

    iget-object v3, p3, Lcom/gmhub/qs/IosGridPanel$Session;->context:Landroid/content/Context;

    invoke-virtual {v3}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v3

    invoke-virtual {v3}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v3

    iget v3, v3, Landroid/util/DisplayMetrics;->density:F

    div-float/2addr v2, v3

    invoke-static {v1, v2}, Ljava/lang/Math;->min(FF)F

    move-result v1

    iget-object v2, p0, Lcom/gmhub/qs/IosGridPanel$Runtime;->height:Ljava/lang/reflect/Method;

    const/high16 v3, 0x3f800000    # 1.0f

    invoke-static {v3, v1}, Ljava/lang/Math;->max(FF)F

    move-result v1

    invoke-static {v1}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v1

    filled-new-array {p1, v1}, [Ljava/lang/Object;

    move-result-object p1

    invoke-static {v2, v10, p1}, Lcom/gmhub/qs/IosGridPanel;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    iget-object p1, p0, Lcom/gmhub/qs/IosGridPanel$Runtime;->f1:Ljava/lang/Class;

    new-instance v1, Lcom/gmhub/qs/IosGridPanel$Runtime$$ExternalSyntheticLambda1;

    invoke-direct {v1, p0, p3, p2}, Lcom/gmhub/qs/IosGridPanel$Runtime$$ExternalSyntheticLambda1;-><init>(Lcom/gmhub/qs/IosGridPanel$Runtime;Lcom/gmhub/qs/IosGridPanel$Session;Lcom/gmhub/qs/NativePageNavigation$Pages;)V

    invoke-virtual {p0, p1, v1}, Lcom/gmhub/qs/IosGridPanel$Runtime;->fn(Ljava/lang/Class;Lcom/gmhub/qs/IosGridPanel$Callback;)Ljava/lang/Object;

    move-result-object v6

    iget-object p1, p0, Lcom/gmhub/qs/IosGridPanel$Runtime;->androidView:Ljava/lang/reflect/Method;

    iget-object v2, p3, Lcom/gmhub/qs/IosGridPanel$Session;->factory:Ljava/lang/Object;

    iget-object v5, p3, Lcom/gmhub/qs/IosGridPanel$Session;->release:Ljava/lang/Object;

    aget-object v7, p4, v0

    const/4 v4, 0x0

    move-object v9, v8

    filled-new-array/range {v2 .. v9}, [Ljava/lang/Object;

    move-result-object p2

    invoke-static {p1, v10, p2}, Lcom/gmhub/qs/IosGridPanel;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    :cond_0
    iget-object p0, p0, Lcom/gmhub/qs/IosGridPanel$Runtime;->unit:Ljava/lang/Object;

    return-object p0
.end method

.method synthetic lambda$render$2$com-gmhub-qs-IosGridPanel$Runtime(Lcom/gmhub/qs/IosGridPanel$Session;Lcom/gmhub/qs/NativePageNavigation$Pages;[Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    const/4 v0, 0x0

    aget-object p3, p3, v0

    check-cast p3, Lcom/gmhub/qs/IosGridPanel$RailView;

    invoke-virtual {p3, p1, p2}, Lcom/gmhub/qs/IosGridPanel$RailView;->bind(Lcom/gmhub/qs/IosGridPanel$Session;Lcom/gmhub/qs/NativePageNavigation$Pages;)V

    iget-object p0, p0, Lcom/gmhub/qs/IosGridPanel$Runtime;->unit:Ljava/lang/Object;

    return-object p0
.end method

.method synthetic lambda$render$3$com-gmhub-qs-IosGridPanel$Runtime(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;
    .locals 10

    iget-object v0, p0, Lcom/gmhub/qs/IosGridPanel$Runtime;->box:Ljava/lang/reflect/Method;

    iget-object v1, p0, Lcom/gmhub/qs/IosGridPanel$Runtime;->fillWidth:Ljava/lang/reflect/Method;

    iget-object v2, p0, Lcom/gmhub/qs/IosGridPanel$Runtime;->modifier:Ljava/lang/Object;

    const/high16 v3, 0x3f800000    # 1.0f

    invoke-static {v3}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v3

    filled-new-array {v2, v3}, [Ljava/lang/Object;

    move-result-object v2

    const/4 v3, 0x0

    invoke-static {v1, v3, v2}, Lcom/gmhub/qs/IosGridPanel;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    iget-object v5, p0, Lcom/gmhub/qs/IosGridPanel$Runtime;->topStart:Ljava/lang/Object;

    const/4 v1, 0x0

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v8

    aget-object v7, p2, v1

    move-object v9, v8

    move-object v6, p1

    filled-new-array/range {v4 .. v9}, [Ljava/lang/Object;

    move-result-object p1

    invoke-static {v0, v3, p1}, Lcom/gmhub/qs/IosGridPanel;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    iget-object p0, p0, Lcom/gmhub/qs/IosGridPanel$Runtime;->unit:Ljava/lang/Object;

    return-object p0
.end method

.method synthetic lambda$render$4$com-gmhub-qs-IosGridPanel$Runtime([Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;
    .locals 2

    invoke-virtual {p1}, [Ljava/lang/Object;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Ljava/lang/Object;

    const/4 v1, 0x0

    aget-object p2, p2, v1

    const/16 v1, 0xb

    aput-object p2, v0, v1

    const/16 p2, 0xc

    aget-object p1, p1, p2

    check-cast p1, Ljava/lang/Number;

    invoke-virtual {p1}, Ljava/lang/Number;->intValue()I

    move-result p1

    or-int/lit8 p1, p1, 0x1

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p1

    aput-object p1, v0, p2

    invoke-static {v0}, Lcom/gmhub/qs/IosGridPanel;->content([Ljava/lang/Object;)V

    iget-object p0, p0, Lcom/gmhub/qs/IosGridPanel$Runtime;->unit:Ljava/lang/Object;

    return-object p0
.end method

.method render([Ljava/lang/Object;)V
    .locals 12

    iget-object v0, p0, Lcom/gmhub/qs/IosGridPanel$Runtime;->start:Ljava/lang/reflect/Method;

    const/16 v1, 0xb

    aget-object v2, p1, v1

    const v3, 0x474d5301

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v0, v2, v3}, Lcom/gmhub/qs/IosGridPanel;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    invoke-static {v2}, Lcom/gmhub/qs/ComposePanelRoot;->iosPhone(Ljava/lang/Object;)Z

    move-result v0

    iget-object v3, p0, Lcom/gmhub/qs/IosGridPanel$Runtime;->replace:Ljava/lang/reflect/Method;

    if-eqz v0, :cond_0

    const v4, 0x474d5303

    goto :goto_0

    :cond_0
    const v4, 0x474d5302

    :goto_0
    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    filled-new-array {v4}, [Ljava/lang/Object;

    move-result-object v4

    invoke-static {v3, v2, v4}, Lcom/gmhub/qs/IosGridPanel;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    const/4 v3, 0x0

    const/4 v4, 0x0

    if-nez v0, :cond_1

    invoke-virtual {p1}, [Ljava/lang/Object;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Ljava/lang/Object;

    aput-object v2, v0, v1

    invoke-static {}, Lcom/gmhub/qs/IosGridPanel;->access$400()Ljava/lang/reflect/Method;

    move-result-object v1

    invoke-static {v1, v3, v0}, Lcom/gmhub/qs/IosGridPanel;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-object v7, p0

    goto/16 :goto_6

    :cond_1
    iget-object v0, p0, Lcom/gmhub/qs/IosGridPanel$Runtime;->consume:Ljava/lang/reflect/Method;

    iget-object v5, p0, Lcom/gmhub/qs/IosGridPanel$Runtime;->localModel:Ljava/lang/Object;

    filled-new-array {v5}, [Ljava/lang/Object;

    move-result-object v5

    invoke-static {v0, v2, v5}, Lcom/gmhub/qs/IosGridPanel;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v8

    iget-object v0, p0, Lcom/gmhub/qs/IosGridPanel$Runtime;->replace:Ljava/lang/reflect/Method;

    const v5, 0x474d5304

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    filled-new-array {v5}, [Ljava/lang/Object;

    move-result-object v5

    invoke-static {v0, v2, v5}, Lcom/gmhub/qs/IosGridPanel;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Lcom/gmhub/qs/IosGridPanel$Runtime;->changed:Ljava/lang/reflect/Method;

    filled-new-array {v8}, [Ljava/lang/Object;

    move-result-object v5

    invoke-static {v0, v2, v5}, Lcom/gmhub/qs/IosGridPanel;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Boolean;

    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    iget-object v5, p0, Lcom/gmhub/qs/IosGridPanel$Runtime;->changed:Ljava/lang/reflect/Method;

    const/4 v6, 0x4

    aget-object v7, p1, v6

    filled-new-array {v7}, [Ljava/lang/Object;

    move-result-object v7

    invoke-static {v5, v2, v7}, Lcom/gmhub/qs/IosGridPanel;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/Boolean;

    invoke-virtual {v5}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v5

    or-int/2addr v0, v5

    iget-object v5, p0, Lcom/gmhub/qs/IosGridPanel$Runtime;->changed:Ljava/lang/reflect/Method;

    const/4 v7, 0x5

    aget-object v9, p1, v7

    filled-new-array {v9}, [Ljava/lang/Object;

    move-result-object v9

    invoke-static {v5, v2, v9}, Lcom/gmhub/qs/IosGridPanel;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/Boolean;

    invoke-virtual {v5}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v5

    or-int/2addr v0, v5

    :try_start_0
    iget-object v5, p0, Lcom/gmhub/qs/IosGridPanel$Runtime;->host:Ljava/lang/reflect/Field;

    invoke-virtual {v5, v8}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v5
    :try_end_0
    .catch Ljava/lang/IllegalAccessException; {:try_start_0 .. :try_end_0} :catch_2

    iget-object v9, p0, Lcom/gmhub/qs/IosGridPanel$Runtime;->changedInt:Ljava/lang/reflect/Method;

    iget-object v10, p0, Lcom/gmhub/qs/IosGridPanel$Runtime;->getUser:Ljava/lang/reflect/Method;

    new-array v11, v4, [Ljava/lang/Object;

    invoke-static {v10, v5, v11}, Lcom/gmhub/qs/IosGridPanel;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/Number;

    invoke-virtual {v5}, Ljava/lang/Number;->intValue()I

    move-result v5

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    filled-new-array {v5}, [Ljava/lang/Object;

    move-result-object v5

    invoke-static {v9, v2, v5}, Lcom/gmhub/qs/IosGridPanel;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/Boolean;

    invoke-virtual {v5}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v5

    or-int/2addr v0, v5

    iget-object v5, p0, Lcom/gmhub/qs/IosGridPanel$Runtime;->remembered:Ljava/lang/reflect/Method;

    new-array v9, v4, [Ljava/lang/Object;

    invoke-static {v5, v2, v9}, Lcom/gmhub/qs/IosGridPanel;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v5

    if-nez v0, :cond_3

    iget-object v0, p0, Lcom/gmhub/qs/IosGridPanel$Runtime;->empty:Ljava/lang/Object;

    if-ne v5, v0, :cond_2

    goto :goto_1

    :cond_2
    move-object v7, p0

    goto :goto_4

    :cond_3
    :goto_1
    move v0, v6

    :try_start_1
    new-instance v6, Lcom/gmhub/qs/IosGridPanel$Session;

    aget-object v9, p1, v0

    aget-object v10, p1, v7

    iget-object v0, p0, Lcom/gmhub/qs/IosGridPanel$Runtime;->getContext:Ljava/lang/reflect/Method;

    iget-object v5, p0, Lcom/gmhub/qs/IosGridPanel$Runtime;->host:Ljava/lang/reflect/Field;

    invoke-virtual {v5, v8}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v5

    new-array v7, v4, [Ljava/lang/Object;

    invoke-static {v0, v5, v7}, Lcom/gmhub/qs/IosGridPanel;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    move-object v11, v0

    check-cast v11, Landroid/content/Context;
    :try_end_1
    .catch Ljava/lang/ReflectiveOperationException; {:try_start_1 .. :try_end_1} :catch_1
    .catch Ljava/lang/IllegalStateException; {:try_start_1 .. :try_end_1} :catch_1

    move-object v7, p0

    :try_start_2
    invoke-direct/range {v6 .. v11}, Lcom/gmhub/qs/IosGridPanel$Session;-><init>(Lcom/gmhub/qs/IosGridPanel$Runtime;Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;Landroid/content/Context;)V
    :try_end_2
    .catch Ljava/lang/ReflectiveOperationException; {:try_start_2 .. :try_end_2} :catch_0
    .catch Ljava/lang/IllegalStateException; {:try_start_2 .. :try_end_2} :catch_0

    move-object v5, v6

    goto :goto_3

    :catch_0
    move-exception v0

    goto :goto_2

    :catch_1
    move-exception v0

    move-object v7, p0

    :goto_2
    move-object p0, v0

    const-string v0, "GMHubQs"

    const-string v5, "Native page binding unavailable"

    invoke-static {v0, v5, p0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    iget-object p0, v7, Lcom/gmhub/qs/IosGridPanel$Runtime;->failed:Ljava/lang/Object;

    move-object v5, p0

    :goto_3
    iget-object p0, v7, Lcom/gmhub/qs/IosGridPanel$Runtime;->remember:Ljava/lang/reflect/Method;

    filled-new-array {v5}, [Ljava/lang/Object;

    move-result-object v0

    invoke-static {p0, v2, v0}, Lcom/gmhub/qs/IosGridPanel;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    :goto_4
    iget-object p0, v7, Lcom/gmhub/qs/IosGridPanel$Runtime;->endReplace:Ljava/lang/reflect/Method;

    new-array v0, v4, [Ljava/lang/Object;

    invoke-static {p0, v2, v0}, Lcom/gmhub/qs/IosGridPanel;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    iget-object p0, v7, Lcom/gmhub/qs/IosGridPanel$Runtime;->failed:Ljava/lang/Object;

    if-ne v5, p0, :cond_4

    invoke-virtual {p1}, [Ljava/lang/Object;->clone()Ljava/lang/Object;

    move-result-object p0

    check-cast p0, [Ljava/lang/Object;

    aput-object v2, p0, v1

    invoke-static {}, Lcom/gmhub/qs/IosGridPanel;->access$400()Ljava/lang/reflect/Method;

    move-result-object v0

    invoke-static {v0, v3, p0}, Lcom/gmhub/qs/IosGridPanel;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    goto/16 :goto_6

    :cond_4
    check-cast v5, Lcom/gmhub/qs/IosGridPanel$Session;

    iget-object p0, v7, Lcom/gmhub/qs/IosGridPanel$Runtime;->effect:Ljava/lang/reflect/Method;

    iget-object v0, v5, Lcom/gmhub/qs/IosGridPanel$Session;->effect:Ljava/lang/Object;

    filled-new-array {v5, v0, v2}, [Ljava/lang/Object;

    move-result-object v0

    invoke-static {p0, v3, v0}, Lcom/gmhub/qs/IosGridPanel;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    iget-object p0, v7, Lcom/gmhub/qs/IosGridPanel$Runtime;->value:Ljava/lang/reflect/Method;

    iget-object v0, v5, Lcom/gmhub/qs/IosGridPanel$Session;->pages:Ljava/lang/Object;

    new-array v1, v4, [Ljava/lang/Object;

    invoke-static {p0, v0, v1}, Lcom/gmhub/qs/IosGridPanel;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Lcom/gmhub/qs/NativePageNavigation$Pages;

    iget-object v0, v7, Lcom/gmhub/qs/IosGridPanel$Runtime;->value:Ljava/lang/reflect/Method;

    iget-object v1, v5, Lcom/gmhub/qs/IosGridPanel$Session;->request:Ljava/lang/Object;

    new-array v6, v4, [Ljava/lang/Object;

    invoke-static {v0, v1, v6}, Lcom/gmhub/qs/IosGridPanel;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/gmhub/qs/NativePageNavigation$Request;

    iget-object v1, v5, Lcom/gmhub/qs/IosGridPanel$Session;->navigation:Lcom/gmhub/qs/NativePageNavigation;

    invoke-virtual {v1, v0}, Lcom/gmhub/qs/NativePageNavigation;->accepts(Lcom/gmhub/qs/NativePageNavigation$Request;)Z

    move-result v1

    if-eqz v1, :cond_5

    move-object v1, v0

    goto :goto_5

    :cond_5
    move-object v1, v3

    :goto_5
    iget-object v6, v7, Lcom/gmhub/qs/IosGridPanel$Runtime;->launched:Ljava/lang/reflect/Method;

    iget-object v8, v7, Lcom/gmhub/qs/IosGridPanel$Runtime;->f2:Ljava/lang/Class;

    new-instance v9, Lcom/gmhub/qs/IosGridPanel$Runtime$$ExternalSyntheticLambda3;

    invoke-direct {v9, v7, v1, v5, v0}, Lcom/gmhub/qs/IosGridPanel$Runtime$$ExternalSyntheticLambda3;-><init>(Lcom/gmhub/qs/IosGridPanel$Runtime;Ljava/lang/Object;Lcom/gmhub/qs/IosGridPanel$Session;Lcom/gmhub/qs/NativePageNavigation$Request;)V

    invoke-virtual {v7, v8, v9}, Lcom/gmhub/qs/IosGridPanel$Runtime;->fn(Ljava/lang/Class;Lcom/gmhub/qs/IosGridPanel$Callback;)Ljava/lang/Object;

    move-result-object v0

    filled-new-array {v2, v1, v0}, [Ljava/lang/Object;

    move-result-object v0

    invoke-static {v6, v3, v0}, Lcom/gmhub/qs/IosGridPanel;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, v7, Lcom/gmhub/qs/IosGridPanel$Runtime;->f3:Ljava/lang/Class;

    new-instance v1, Lcom/gmhub/qs/IosGridPanel$Runtime$$ExternalSyntheticLambda4;

    invoke-direct {v1, v7, p1, p0, v5}, Lcom/gmhub/qs/IosGridPanel$Runtime$$ExternalSyntheticLambda4;-><init>(Lcom/gmhub/qs/IosGridPanel$Runtime;[Ljava/lang/Object;Lcom/gmhub/qs/NativePageNavigation$Pages;Lcom/gmhub/qs/IosGridPanel$Session;)V

    invoke-virtual {v7, v0, v1}, Lcom/gmhub/qs/IosGridPanel$Runtime;->fn(Ljava/lang/Class;Lcom/gmhub/qs/IosGridPanel$Callback;)Ljava/lang/Object;

    move-result-object p0

    iget-object v0, v7, Lcom/gmhub/qs/IosGridPanel$Runtime;->composable:Ljava/lang/reflect/Method;

    const v1, 0x474d5305

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const/4 v5, 0x1

    invoke-static {v5}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v6

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v8

    filled-new-array {v1, v6, p0, v2, v8}, [Ljava/lang/Object;

    move-result-object p0

    invoke-static {v0, v3, p0}, Lcom/gmhub/qs/IosGridPanel;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    iget-object v0, v7, Lcom/gmhub/qs/IosGridPanel$Runtime;->composable:Ljava/lang/reflect/Method;

    const v1, 0x474d5306

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-static {v5}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v5

    iget-object v6, v7, Lcom/gmhub/qs/IosGridPanel$Runtime;->f2:Ljava/lang/Class;

    new-instance v8, Lcom/gmhub/qs/IosGridPanel$Runtime$$ExternalSyntheticLambda5;

    invoke-direct {v8, v7, p0}, Lcom/gmhub/qs/IosGridPanel$Runtime$$ExternalSyntheticLambda5;-><init>(Lcom/gmhub/qs/IosGridPanel$Runtime;Ljava/lang/Object;)V

    invoke-virtual {v7, v6, v8}, Lcom/gmhub/qs/IosGridPanel$Runtime;->fn(Ljava/lang/Class;Lcom/gmhub/qs/IosGridPanel$Callback;)Ljava/lang/Object;

    move-result-object p0

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    filled-new-array {v1, v5, p0, v2, v6}, [Ljava/lang/Object;

    move-result-object p0

    invoke-static {v0, v3, p0}, Lcom/gmhub/qs/IosGridPanel;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    iget-object v0, v7, Lcom/gmhub/qs/IosGridPanel$Runtime;->provider:Ljava/lang/reflect/Method;

    iget-object v1, v7, Lcom/gmhub/qs/IosGridPanel$Runtime;->provides:Ljava/lang/reflect/Method;

    iget-object v5, v7, Lcom/gmhub/qs/IosGridPanel$Runtime;->localRail:Ljava/lang/Object;

    sget-object v6, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    filled-new-array {v6}, [Ljava/lang/Object;

    move-result-object v6

    invoke-static {v1, v5, v6}, Lcom/gmhub/qs/IosGridPanel;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    filled-new-array {v1, p0, v2, v5}, [Ljava/lang/Object;

    move-result-object p0

    invoke-static {v0, v3, p0}, Lcom/gmhub/qs/IosGridPanel;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    :goto_6
    iget-object p0, v7, Lcom/gmhub/qs/IosGridPanel$Runtime;->endReplace:Ljava/lang/reflect/Method;

    new-array v0, v4, [Ljava/lang/Object;

    invoke-static {p0, v2, v0}, Lcom/gmhub/qs/IosGridPanel;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    iget-object p0, v7, Lcom/gmhub/qs/IosGridPanel$Runtime;->end:Ljava/lang/reflect/Method;

    new-array v0, v4, [Ljava/lang/Object;

    invoke-static {p0, v2, v0}, Lcom/gmhub/qs/IosGridPanel;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    if-eqz p0, :cond_6

    iget-object v0, v7, Lcom/gmhub/qs/IosGridPanel$Runtime;->updateScope:Ljava/lang/reflect/Method;

    iget-object v1, v7, Lcom/gmhub/qs/IosGridPanel$Runtime;->f2:Ljava/lang/Class;

    new-instance v2, Lcom/gmhub/qs/IosGridPanel$Runtime$$ExternalSyntheticLambda6;

    invoke-direct {v2, v7, p1}, Lcom/gmhub/qs/IosGridPanel$Runtime$$ExternalSyntheticLambda6;-><init>(Lcom/gmhub/qs/IosGridPanel$Runtime;[Ljava/lang/Object;)V

    invoke-virtual {v7, v1, v2}, Lcom/gmhub/qs/IosGridPanel$Runtime;->fn(Ljava/lang/Class;Lcom/gmhub/qs/IosGridPanel$Callback;)Ljava/lang/Object;

    move-result-object p1

    filled-new-array {p1}, [Ljava/lang/Object;

    move-result-object p1

    invoke-static {v0, p0, p1}, Lcom/gmhub/qs/IosGridPanel;->access$300(Ljava/lang/reflect/Method;Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    :cond_6
    return-void

    :catch_2
    move-exception v0

    move-object p0, v0

    new-instance p1, Ljava/lang/IllegalStateException;

    invoke-direct {p1, p0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/Throwable;)V

    throw p1
.end method
