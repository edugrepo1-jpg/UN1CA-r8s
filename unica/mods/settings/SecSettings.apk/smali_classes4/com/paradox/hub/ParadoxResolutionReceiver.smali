.class public Lcom/paradox/hub/ParadoxResolutionReceiver;
.super Landroid/content/BroadcastReceiver;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    return-void
.end method


# virtual methods
.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 0
    # Compatibility entry point only. WindowManager persists explicit user changes.
    # Replaying shell writes on USER_PRESENT or clearing overrides on shutdown can
    # undo native settings and distort biometric coordinates during unlock.
    return-void
.end method
