.class public Lcom/paradox/hub/PanelStyleFragment;
.super Lcom/android/settings/SettingsPreferenceFragment;
.implements Landroidx/preference/Preference$OnPreferenceChangeListener;

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
    .locals 2
    const-string v0, "xml"
    const-string v1, "gm_qs_preferences"
    invoke-static {v0, v1}, Lio/mesalabs/unica/utils/Utils;->getResourceId(Ljava/lang/String;Ljava/lang/String;)I
    move-result v0
    invoke-virtual {p0, v0}, Lcom/android/settings/SettingsPreferenceFragment;->addPreferencesFromResource(I)V
    const-string v0, "gmhub_qs_style"
    invoke-virtual {p0, v0}, Landroidx/preference/PreferenceFragmentCompat;->findPreference(Ljava/lang/CharSequence;)Landroidx/preference/Preference;
    move-result-object v0
    if-eqz v0, :done
    invoke-virtual {v0, p0}, Landroidx/preference/Preference;->setOnPreferenceChangeListener(Landroidx/preference/Preference$OnPreferenceChangeListener;)V
    :done
    invoke-direct {p0}, Lcom/paradox/hub/PanelStyleFragment;->sync()V
    return-void
.end method

.method public onResume()V
    .locals 0
    invoke-super {p0}, Lcom/android/settings/SettingsPreferenceFragment;->onResume()V
    invoke-direct {p0}, Lcom/paradox/hub/PanelStyleFragment;->sync()V
    return-void
.end method

.method private sync()V
    .locals 2
    invoke-virtual {p0}, Landroidx/fragment/app/Fragment;->getContext()Landroid/content/Context;
    move-result-object v0
    const-string v1, "gmhub_qs_style"
    invoke-virtual {p0, v1}, Landroidx/preference/PreferenceFragmentCompat;->findPreference(Ljava/lang/CharSequence;)Landroidx/preference/Preference;
    move-result-object v1
    invoke-static {v0, v1}, Lcom/gmhub/panelstyle/PanelStyleControl;->sync(Landroid/content/Context;Ljava/lang/Object;)V
    return-void
.end method

.method public onPreferenceChange(Landroidx/preference/Preference;Ljava/lang/Object;)Z
    .locals 3
    const/4 v0, 0x0
    if-eqz p1, :done
    invoke-virtual {p1}, Landroidx/preference/Preference;->getKey()Ljava/lang/String;
    move-result-object v1
    const-string v2, "gmhub_qs_style"
    invoke-virtual {v2, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-eqz v1, :done
    invoke-virtual {p0}, Landroidx/fragment/app/Fragment;->getContext()Landroid/content/Context;
    move-result-object v1
    invoke-static {v1, p1, p2}, Lcom/gmhub/panelstyle/PanelStyleControl;->change(Landroid/content/Context;Ljava/lang/Object;Ljava/lang/Object;)Z
    move-result v0
    :done
    return v0
.end method
