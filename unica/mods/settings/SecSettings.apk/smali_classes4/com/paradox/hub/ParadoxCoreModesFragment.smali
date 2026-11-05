.class public Lcom/paradox/hub/ParadoxCoreModesFragment;
.super Lcom/android/settings/SettingsPreferenceFragment;
.implements Landroidx/preference/Preference$OnPreferenceChangeListener;
.implements Lcom/gmhub/profiles/ProfileController$Host;
.field private mController:Lcom/gmhub/profiles/ProfileController;

.method public static getModeLabel(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;
    .locals 1
    invoke-static {p0, p1}, Lcom/gmhub/profiles/ProfileController;->label(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;
    move-result-object v0
    return-object v0
.end method

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
    invoke-virtual {p0}, Lcom/paradox/hub/ParadoxCoreModesFragment;->context()Landroid/content/Context;
    move-result-object v0
    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;
    move-result-object v1
    const-string v2, "paradox_core_modes"
    const-string v3, "xml"
    invoke-virtual {v0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;
    move-result-object v0
    invoke-virtual {v1, v2, v3, v0}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I
    move-result v0
    invoke-virtual {p0, v0}, Lcom/android/settings/SettingsPreferenceFragment;->addPreferencesFromResource(I)V
    new-instance v0, Lcom/gmhub/profiles/ProfileController;
    invoke-direct {v0, p0}, Lcom/gmhub/profiles/ProfileController;-><init>(Lcom/gmhub/profiles/ProfileController$Host;)V
    iput-object v0, p0, Lcom/paradox/hub/ParadoxCoreModesFragment;->mController:Lcom/gmhub/profiles/ProfileController;
    const-string v0, "paradox_core_mode"
    invoke-virtual {p0, v0}, Landroidx/preference/PreferenceFragmentCompat;->findPreference(Ljava/lang/CharSequence;)Landroidx/preference/Preference;
    move-result-object v0
    invoke-virtual {v0, p0}, Landroidx/preference/Preference;->setOnPreferenceChangeListener(Landroidx/preference/Preference$OnPreferenceChangeListener;)V
    const/4 v1, 0x0
    invoke-virtual {v0, v1}, Landroidx/preference/Preference;->setPersistent(Z)V
    return-void
.end method

.method public show(Ljava/lang/String;Ljava/lang/String;Z)V
    .locals 2
    const-string v0, "paradox_core_mode"
    invoke-virtual {p0, v0}, Landroidx/preference/PreferenceFragmentCompat;->findPreference(Ljava/lang/CharSequence;)Landroidx/preference/Preference;
    move-result-object v0
    check-cast v0, Landroidx/preference/ListPreference;
    invoke-virtual {v0, p1}, Landroidx/preference/ListPreference;->setValue(Ljava/lang/String;)V
    invoke-virtual {v0, p2}, Landroidx/preference/Preference;->setSummary(Ljava/lang/CharSequence;)V
    invoke-virtual {v0, p3}, Landroidx/preference/Preference;->setEnabled(Z)V
    const-string v1, "paradox_core_restore"
    invoke-virtual {p0, v1}, Landroidx/preference/PreferenceFragmentCompat;->findPreference(Ljava/lang/CharSequence;)Landroidx/preference/Preference;
    move-result-object v0
    invoke-virtual {v0, p3}, Landroidx/preference/Preference;->setEnabled(Z)V
    return-void
.end method

.method public onPreferenceChange(Landroidx/preference/Preference;Ljava/lang/Object;)Z
    .locals 1
    check-cast p2, Ljava/lang/String;
    iget-object v0, p0, Lcom/paradox/hub/ParadoxCoreModesFragment;->mController:Lcom/gmhub/profiles/ProfileController;
    invoke-virtual {v0, p2}, Lcom/gmhub/profiles/ProfileController;->select(Ljava/lang/String;)Z
    move-result v0
    return v0
.end method

.method public onPreferenceTreeClick(Landroidx/preference/Preference;)Z
    .locals 2
    invoke-virtual {p1}, Landroidx/preference/Preference;->getKey()Ljava/lang/String;
    move-result-object v0
    const-string v1, "paradox_core_restore"
    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v0
    if-eqz v0, :other
    iget-object v0, p0, Lcom/paradox/hub/ParadoxCoreModesFragment;->mController:Lcom/gmhub/profiles/ProfileController;
    invoke-virtual {v0}, Lcom/gmhub/profiles/ProfileController;->restore()V
    const/4 v0, 0x1
    return v0
    :other
    invoke-super {p0, p1}, Lcom/android/settings/SettingsPreferenceFragment;->onPreferenceTreeClick(Landroidx/preference/Preference;)Z
    move-result v0
    return v0
.end method

.method public onResume()V
    .locals 1
    invoke-super {p0}, Lcom/android/settings/SettingsPreferenceFragment;->onResume()V
    iget-object v0, p0, Lcom/paradox/hub/ParadoxCoreModesFragment;->mController:Lcom/gmhub/profiles/ProfileController;
    if-eqz v0, :done
    invoke-virtual {v0}, Lcom/gmhub/profiles/ProfileController;->resume()V
    :done
    return-void
.end method

.method public onPause()V
    .locals 1
    iget-object v0, p0, Lcom/paradox/hub/ParadoxCoreModesFragment;->mController:Lcom/gmhub/profiles/ProfileController;
    if-eqz v0, :done
    invoke-virtual {v0}, Lcom/gmhub/profiles/ProfileController;->pause()V
    :done
    invoke-super {p0}, Lcom/android/settings/SettingsPreferenceFragment;->onPause()V
    return-void
.end method

.method public onDestroy()V
    .locals 1
    iget-object v0, p0, Lcom/paradox/hub/ParadoxCoreModesFragment;->mController:Lcom/gmhub/profiles/ProfileController;
    if-eqz v0, :done
    invoke-virtual {v0}, Lcom/gmhub/profiles/ProfileController;->close()V
    :done
    invoke-super {p0}, Lcom/android/settings/SettingsPreferenceFragment;->onDestroy()V
    return-void
.end method
