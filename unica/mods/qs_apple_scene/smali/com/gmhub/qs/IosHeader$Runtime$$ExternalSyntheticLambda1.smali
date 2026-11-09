.class public final synthetic Lcom/gmhub/qs/IosHeader$Runtime$$ExternalSyntheticLambda1;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/lang/reflect/InvocationHandler;


# instance fields
.field public final synthetic f$0:Ljava/lang/Class;

.field public final synthetic f$1:Lcom/gmhub/qs/IosHeader$Callback;


# direct methods
.method public synthetic constructor <init>(Ljava/lang/Class;Lcom/gmhub/qs/IosHeader$Callback;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/gmhub/qs/IosHeader$Runtime$$ExternalSyntheticLambda1;->f$0:Ljava/lang/Class;

    iput-object p2, p0, Lcom/gmhub/qs/IosHeader$Runtime$$ExternalSyntheticLambda1;->f$1:Lcom/gmhub/qs/IosHeader$Callback;

    return-void
.end method


# virtual methods
.method public final invoke(Ljava/lang/Object;Ljava/lang/reflect/Method;[Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    iget-object v0, p0, Lcom/gmhub/qs/IosHeader$Runtime$$ExternalSyntheticLambda1;->f$0:Ljava/lang/Class;

    iget-object p0, p0, Lcom/gmhub/qs/IosHeader$Runtime$$ExternalSyntheticLambda1;->f$1:Lcom/gmhub/qs/IosHeader$Callback;

    invoke-static {v0, p0, p1, p2, p3}, Lcom/gmhub/qs/IosHeader$Runtime;->lambda$function$0(Ljava/lang/Class;Lcom/gmhub/qs/IosHeader$Callback;Ljava/lang/Object;Ljava/lang/reflect/Method;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    return-object p0
.end method
