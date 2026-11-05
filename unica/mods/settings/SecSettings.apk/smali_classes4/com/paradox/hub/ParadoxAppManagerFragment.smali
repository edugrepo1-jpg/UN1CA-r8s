.class public Lcom/paradox/hub/ParadoxAppManagerFragment;
.super Lcom/android/settings/SettingsPreferenceFragment;
.implements Landroidx/preference/Preference$OnPreferenceChangeListener;
.implements Lcom/gmhub/apps/AppsController$Host;

.field private mController:Lcom/gmhub/apps/AppsController;

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

.method private category()Landroidx/preference/PreferenceGroup;
    .locals 1
    const-string v0, "apps_category"
    invoke-virtual {p0, v0}, Landroidx/preference/PreferenceFragmentCompat;->findPreference(Ljava/lang/CharSequence;)Landroidx/preference/Preference;
    move-result-object v0
    check-cast v0, Landroidx/preference/PreferenceGroup;
    return-object v0
.end method

.method public onCreatePreferences(Landroid/os/Bundle;Ljava/lang/String;)V
    .locals 4
    invoke-virtual {p0}, Lcom/paradox/hub/ParadoxAppManagerFragment;->context()Landroid/content/Context;
    move-result-object v0
    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;
    move-result-object v1
    const-string v2, "paradox_app_manager"
    const-string v3, "xml"
    invoke-virtual {v0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;
    move-result-object v0
    invoke-virtual {v1, v2, v3, v0}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I
    move-result v0
    invoke-virtual {p0, v0}, Lcom/android/settings/SettingsPreferenceFragment;->addPreferencesFromResource(I)V
    new-instance v0, Lcom/gmhub/apps/AppsController;
    invoke-direct {v0, p0}, Lcom/gmhub/apps/AppsController;-><init>(Lcom/gmhub/apps/AppsController$Host;)V
    iput-object v0, p0, Lcom/paradox/hub/ParadoxAppManagerFragment;->mController:Lcom/gmhub/apps/AppsController;
    const/4 v0, 0x1
    invoke-virtual {p0, v0}, Landroidx/fragment/app/Fragment;->setHasOptionsMenu(Z)V
    const-string v0, "search_apps_query"
    invoke-virtual {p0, v0}, Landroidx/preference/PreferenceFragmentCompat;->findPreference(Ljava/lang/CharSequence;)Landroidx/preference/Preference;
    move-result-object v0
    invoke-virtual {v0, p0}, Landroidx/preference/Preference;->setOnPreferenceChangeListener(Landroidx/preference/Preference$OnPreferenceChangeListener;)V
    const/4 v1, 0x0
    invoke-virtual {v0, v1}, Landroidx/preference/Preference;->setPersistent(Z)V
    return-void
.end method

.method public clear(Ljava/lang/String;)V
    .locals 3
    invoke-direct {p0}, Lcom/paradox/hub/ParadoxAppManagerFragment;->category()Landroidx/preference/PreferenceGroup;
    move-result-object v0
    invoke-virtual {v0}, Landroidx/preference/PreferenceGroup;->removeAll()V
    invoke-virtual {p1}, Ljava/lang/String;->isEmpty()Z
    move-result v1
    if-nez v1, :done
    new-instance v1, Landroidx/preference/Preference;
    invoke-virtual {p0}, Lcom/paradox/hub/ParadoxAppManagerFragment;->context()Landroid/content/Context;
    move-result-object v2
    invoke-direct {v1, v2}, Landroidx/preference/Preference;-><init>(Landroid/content/Context;)V
    invoke-virtual {v1, p1}, Landroidx/preference/Preference;->setTitle(Ljava/lang/CharSequence;)V
    const/4 v2, 0x0
    invoke-virtual {v1, v2}, Landroidx/preference/Preference;->setSelectable(Z)V
    invoke-virtual {v0, v1}, Landroidx/preference/PreferenceGroup;->addPreference(Landroidx/preference/Preference;)Z
    :done
    return-void
.end method

.method public row(Ljava/lang/String;Ljava/lang/String;ZZLjava/lang/String;)V
    .locals 3
    new-instance v0, Lcom/paradox/hub/ManagedAppPreference;
    invoke-virtual {p0}, Lcom/paradox/hub/ParadoxAppManagerFragment;->context()Landroid/content/Context;
    move-result-object v1
    iget-object v2, p0, Lcom/paradox/hub/ParadoxAppManagerFragment;->mController:Lcom/gmhub/apps/AppsController;
    invoke-direct {v0, v1, p1, v2}, Lcom/paradox/hub/ManagedAppPreference;-><init>(Landroid/content/Context;Ljava/lang/String;Lcom/gmhub/apps/AppsController;)V
    invoke-virtual {v0, p1}, Landroidx/preference/Preference;->setKey(Ljava/lang/String;)V
    invoke-virtual {v0, p2}, Landroidx/preference/Preference;->setTitle(Ljava/lang/CharSequence;)V
    invoke-virtual {v0, p5}, Landroidx/preference/Preference;->setSummary(Ljava/lang/CharSequence;)V
    invoke-virtual {v0, p3}, Landroidx/preference/TwoStatePreference;->setChecked(Z)V
    invoke-virtual {v0, p4}, Landroidx/preference/Preference;->setEnabled(Z)V
    const/4 v1, 0x0
    invoke-virtual {v0, v1}, Landroidx/preference/Preference;->setPersistent(Z)V
    invoke-virtual {v0, p0}, Landroidx/preference/Preference;->setOnPreferenceChangeListener(Landroidx/preference/Preference$OnPreferenceChangeListener;)V
    invoke-direct {p0}, Lcom/paradox/hub/ParadoxAppManagerFragment;->category()Landroidx/preference/PreferenceGroup;
    move-result-object v1
    invoke-virtual {v1, v0}, Landroidx/preference/PreferenceGroup;->addPreference(Landroidx/preference/Preference;)Z
    return-void
.end method

.method public busy(Z)V
    .locals 1
    invoke-direct {p0}, Lcom/paradox/hub/ParadoxAppManagerFragment;->category()Landroidx/preference/PreferenceGroup;
    move-result-object v0
    xor-int/lit8 p1, p1, 0x1
    invoke-virtual {v0, p1}, Landroidx/preference/Preference;->setEnabled(Z)V
    return-void
.end method

.method public onPreferenceChange(Landroidx/preference/Preference;Ljava/lang/Object;)Z
    .locals 3
    iget-object v0, p0, Lcom/paradox/hub/ParadoxAppManagerFragment;->mController:Lcom/gmhub/apps/AppsController;
    invoke-virtual {p1}, Landroidx/preference/Preference;->getKey()Ljava/lang/String;
    move-result-object v1
    const-string v2, "search_apps_query"
    invoke-virtual {v2, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v2
    if-eqz v2, :toggle
    check-cast p2, Ljava/lang/String;
    invoke-virtual {v0, p2}, Lcom/gmhub/apps/AppsController;->search(Ljava/lang/String;)V
    invoke-virtual {p1, p2}, Landroidx/preference/Preference;->setSummary(Ljava/lang/CharSequence;)V
    const/4 v0, 0x1
    return v0
    :toggle
    check-cast p2, Ljava/lang/Boolean;
    invoke-virtual {p2}, Ljava/lang/Boolean;->booleanValue()Z
    move-result v2
    invoke-virtual {v0, v1, v2}, Lcom/gmhub/apps/AppsController;->change(Ljava/lang/String;Z)Z
    move-result v0
    return v0
.end method

.method public onResume()V
    .locals 1
    invoke-super {p0}, Lcom/android/settings/SettingsPreferenceFragment;->onResume()V
    iget-object v0, p0, Lcom/paradox/hub/ParadoxAppManagerFragment;->mController:Lcom/gmhub/apps/AppsController;
    if-eqz v0, :done
    invoke-virtual {v0}, Lcom/gmhub/apps/AppsController;->resume()V
    :done
    return-void
.end method

.method public onPause()V
    .locals 1
    iget-object v0, p0, Lcom/paradox/hub/ParadoxAppManagerFragment;->mController:Lcom/gmhub/apps/AppsController;
    if-eqz v0, :done
    invoke-virtual {v0}, Lcom/gmhub/apps/AppsController;->pause()V
    :done
    invoke-super {p0}, Lcom/android/settings/SettingsPreferenceFragment;->onPause()V
    return-void
.end method

.method public onDestroy()V
    .locals 1
    iget-object v0, p0, Lcom/paradox/hub/ParadoxAppManagerFragment;->mController:Lcom/gmhub/apps/AppsController;
    if-eqz v0, :done
    invoke-virtual {v0}, Lcom/gmhub/apps/AppsController;->close()V
    :done
    invoke-super {p0}, Lcom/android/settings/SettingsPreferenceFragment;->onDestroy()V
    return-void
.end method

.method public onCreateOptionsMenu(Landroid/view/Menu;Landroid/view/MenuInflater;)V
    .locals 1
    invoke-super {p0, p1, p2}, Lcom/android/settings/SettingsPreferenceFragment;->onCreateOptionsMenu(Landroid/view/Menu;Landroid/view/MenuInflater;)V
    iget-object v0, p0, Lcom/paradox/hub/ParadoxAppManagerFragment;->mController:Lcom/gmhub/apps/AppsController;
    invoke-virtual {v0, p1}, Lcom/gmhub/apps/AppsController;->createMenu(Landroid/view/Menu;)V
    return-void
.end method

.method public onPrepareOptionsMenu(Landroid/view/Menu;)V
    .locals 1
    invoke-super {p0, p1}, Lcom/android/settings/SettingsPreferenceFragment;->onPrepareOptionsMenu(Landroid/view/Menu;)V
    iget-object v0, p0, Lcom/paradox/hub/ParadoxAppManagerFragment;->mController:Lcom/gmhub/apps/AppsController;
    invoke-virtual {v0, p1}, Lcom/gmhub/apps/AppsController;->prepareMenu(Landroid/view/Menu;)V
    return-void
.end method

.method public onOptionsItemSelected(Landroid/view/MenuItem;)Z
    .locals 1
    iget-object v0, p0, Lcom/paradox/hub/ParadoxAppManagerFragment;->mController:Lcom/gmhub/apps/AppsController;
    invoke-virtual {v0, p1}, Lcom/gmhub/apps/AppsController;->select(Landroid/view/MenuItem;)Z
    move-result v0
    if-nez v0, :done
    invoke-super {p0, p1}, Lcom/android/settings/SettingsPreferenceFragment;->onOptionsItemSelected(Landroid/view/MenuItem;)Z
    move-result v0
    :done
    return v0
.end method
