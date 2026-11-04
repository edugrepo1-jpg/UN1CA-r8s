.class public final Lcom/paradox/hub/ParadoxBluetoothVolume;
.super Ljava/lang/Object;

# Same persistent property consumed by AOSP AVRCP, not a Secure-settings alias.
.method public static isDisabled()Z
    .locals 2
    :try_start
    const-string v0, "persist.bluetooth.disableabsvol"
    const/4 v1, 0x0
    invoke-static {v0, v1}, Landroid/os/SystemProperties;->getBoolean(Ljava/lang/String;Z)Z
    move-result v0
    :try_end
    .catch Ljava/lang/RuntimeException; {:try_start .. :try_end} :failed
    return v0
    :failed
    move-exception v0
    const/4 v0, 0x0
    return v0
.end method

.method public static setDisabled(Z)Z
    .locals 2
    :try_start
    const-string v0, "persist.bluetooth.disableabsvol"
    if-eqz p0, :enabled
    const-string v1, "true"
    goto :write
    :enabled
    const-string v1, "false"
    :write
    invoke-static {v0, v1}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V
    const/4 v1, 0x0
    invoke-static {v0, v1}, Landroid/os/SystemProperties;->getBoolean(Ljava/lang/String;Z)Z
    move-result v0
    if-ne v0, p0, :rejected
    :try_end
    .catch Ljava/lang/RuntimeException; {:try_start .. :try_end} :failed
    const/4 v0, 0x1
    return v0
    :failed
    move-exception v0
    :rejected
    const/4 v0, 0x0
    return v0
.end method
