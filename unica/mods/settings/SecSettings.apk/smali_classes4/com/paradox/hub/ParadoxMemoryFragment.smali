.class public Lcom/paradox/hub/ParadoxMemoryFragment;
.super Lcom/android/settings/SettingsPreferenceFragment;
.implements Lcom/gmhub/monitor/ResourceController$Host;
.field private mController:Lcom/gmhub/monitor/ResourceController;

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

.method public context()Landroid/content/Context;
    .locals 1
    invoke-virtual {p0}, Landroidx/fragment/app/Fragment;->getContext()Landroid/content/Context;
    move-result-object v0
    return-object v0
.end method

.method public onCreatePreferences(Landroid/os/Bundle;Ljava/lang/String;)V
    .locals 4
    invoke-virtual {p0}, Lcom/paradox/hub/ParadoxMemoryFragment;->context()Landroid/content/Context;
    move-result-object v0
    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;
    move-result-object v1
    const-string v2, "paradox_memory_preferences"
    const-string v3, "xml"
    invoke-virtual {v0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;
    move-result-object v0
    invoke-virtual {v1, v2, v3, v0}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I
    move-result v0
    invoke-virtual {p0, v0}, Lcom/android/settings/SettingsPreferenceFragment;->addPreferencesFromResource(I)V
    new-instance v0, Lcom/gmhub/monitor/ResourceController;
    const/4 v1, 0x0
    invoke-direct {v0, p0, v1}, Lcom/gmhub/monitor/ResourceController;-><init>(Lcom/gmhub/monitor/ResourceController$Host;Z)V
    iput-object v0, p0, Lcom/paradox/hub/ParadoxMemoryFragment;->mController:Lcom/gmhub/monitor/ResourceController;
    return-void
.end method

.method public row(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    invoke-virtual {p0, p1}, Landroidx/preference/PreferenceFragmentCompat;->findPreference(Ljava/lang/CharSequence;)Landroidx/preference/Preference;
    move-result-object v0
    if-eqz v0, :done
    invoke-virtual {v0, p2}, Landroidx/preference/Preference;->setTitle(Ljava/lang/CharSequence;)V
    invoke-virtual {v0, p3}, Landroidx/preference/Preference;->setSummary(Ljava/lang/CharSequence;)V
    :done
    return-void
.end method

.method public onResume()V
    .locals 1
    invoke-super {p0}, Lcom/android/settings/SettingsPreferenceFragment;->onResume()V
    iget-object v0, p0, Lcom/paradox/hub/ParadoxMemoryFragment;->mController:Lcom/gmhub/monitor/ResourceController;
    if-eqz v0, :done
    invoke-virtual {v0}, Lcom/gmhub/monitor/ResourceController;->resume()V
    :done
    return-void
.end method

.method public onPause()V
    .locals 1
    iget-object v0, p0, Lcom/paradox/hub/ParadoxMemoryFragment;->mController:Lcom/gmhub/monitor/ResourceController;
    if-eqz v0, :done
    invoke-virtual {v0}, Lcom/gmhub/monitor/ResourceController;->pause()V
    :done
    invoke-super {p0}, Lcom/android/settings/SettingsPreferenceFragment;->onPause()V
    return-void
.end method

.method public onDestroy()V
    .locals 1
    iget-object v0, p0, Lcom/paradox/hub/ParadoxMemoryFragment;->mController:Lcom/gmhub/monitor/ResourceController;
    if-eqz v0, :done
    invoke-virtual {v0}, Lcom/gmhub/monitor/ResourceController;->close()V
    :done
    invoke-super {p0}, Lcom/android/settings/SettingsPreferenceFragment;->onDestroy()V
    return-void
.end method
