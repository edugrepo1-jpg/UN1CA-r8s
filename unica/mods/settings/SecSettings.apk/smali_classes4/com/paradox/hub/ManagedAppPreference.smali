.class public Lcom/paradox/hub/ManagedAppPreference;
.super Landroidx/preference/SwitchPreferenceCompat;
.field private final mPackage:Ljava/lang/String;
.field private final mOwner:Lcom/gmhub/apps/AppsController;

.method public constructor <init>(Landroid/content/Context;Ljava/lang/String;Lcom/gmhub/apps/AppsController;)V
    .locals 1
    invoke-direct {p0, p1}, Landroidx/preference/SwitchPreferenceCompat;-><init>(Landroid/content/Context;)V
    iput-object p2, p0, Lcom/paradox/hub/ManagedAppPreference;->mPackage:Ljava/lang/String;
    iput-object p3, p0, Lcom/paradox/hub/ManagedAppPreference;->mOwner:Lcom/gmhub/apps/AppsController;
    sget v0, Landroid/R$drawable;->sym_def_app_icon:I
    invoke-virtual {p0, v0}, Landroidx/preference/Preference;->setIcon(I)V
    return-void
.end method

.method public onBindViewHolder(Landroidx/preference/PreferenceViewHolder;)V
    .locals 3
    invoke-super {p0, p1}, Landroidx/preference/SwitchPreferenceCompat;->onBindViewHolder(Landroidx/preference/PreferenceViewHolder;)V
    iget-object v0, p0, Lcom/paradox/hub/ManagedAppPreference;->mOwner:Lcom/gmhub/apps/AppsController;
    iget-object v1, p1, Landroidx/recyclerview/widget/RecyclerView$ViewHolder;->itemView:Landroid/view/View;
    iget-object v2, p0, Lcom/paradox/hub/ManagedAppPreference;->mPackage:Ljava/lang/String;
    invoke-virtual {v0, v1, v2}, Lcom/gmhub/apps/AppsController;->bindIcon(Landroid/view/View;Ljava/lang/String;)V
    return-void
.end method
