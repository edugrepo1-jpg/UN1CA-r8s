.class public Lcom/paradox/hub/ParadoxThermalFragment;
.super Lcom/android/settings/SettingsPreferenceFragment;

.method public constructor <init>()V
    .locals 0
    invoke-direct {p0}, Lcom/android/settings/SettingsPreferenceFragment;-><init>()V
    return-void
.end method

.method public getMetricsCategory()I
    .locals 1
    const/4 v0, 0x0
    return v0
.end method

.method public onCreatePreferences(Landroid/os/Bundle;Ljava/lang/String;)V
    .locals 4
    invoke-virtual {p0}, Landroidx/fragment/app/Fragment;->getContext()Landroid/content/Context;
    move-result-object v0
    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;
    move-result-object v1
    const-string v2, "paradox_thermal_preferences"
    const-string v3, "xml"
    invoke-virtual {v0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;
    move-result-object v0
    invoke-virtual {v1, v2, v3, v0}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I
    move-result v0
    invoke-virtual {p0, v0}, Lcom/android/settings/SettingsPreferenceFragment;->addPreferencesFromResource(I)V
    return-void
.end method

.method public onResume()V
    .locals 2
    invoke-super {p0}, Lcom/android/settings/SettingsPreferenceFragment;->onResume()V
    invoke-virtual {p0}, Landroidx/fragment/app/Fragment;->getView()Landroid/view/View;
    move-result-object v0
    const/4 v1, 0x1
    invoke-static {v0, v1}, Lcom/gmhub/monitor/ThermalPanel;->setActive(Landroid/view/View;Z)V
    return-void
.end method

.method public onPause()V
    .locals 2
    invoke-virtual {p0}, Landroidx/fragment/app/Fragment;->getView()Landroid/view/View;
    move-result-object v0
    const/4 v1, 0x0
    invoke-static {v0, v1}, Lcom/gmhub/monitor/ThermalPanel;->setActive(Landroid/view/View;Z)V
    invoke-super {p0}, Lcom/android/settings/SettingsPreferenceFragment;->onPause()V
    return-void
.end method
