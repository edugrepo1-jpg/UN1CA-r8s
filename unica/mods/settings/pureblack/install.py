"""Keep native theme persistence/Monet; append only owned Pure Black priority."""
from pathlib import Path
import argparse
import importlib.util

OWNER="Lcom/android/systemui/theme/ThemeOverlayApplier$$ExternalSyntheticLambda0;"
HOOK="Lcom/gmhub/theme/PureBlackPolicy;->append(Ljava/lang/Object;Ljava/lang/Object;I)V"
BUILD="    invoke-virtual {v1}, Landroid/content/om/OverlayManagerTransaction$Builder;->build()Landroid/content/om/OverlayManagerTransaction;"
USER="    iget v4, p0, "+OWNER+"->f$3:I"


def patch(text):
    if text.count(HOOK)==1:
        if "    .locals 14" not in text or "    move v13, v4" not in text:raise ValueError("Incomplete native theme hook")
        return text
    if HOOK in text:raise ValueError("Duplicate native theme hook")
    start=text.index(".method public final run()V");end=text.index(".end method",start)
    body=text[start:end]
    if body.count("    .locals 13")!=1 or body.count(USER)!=1 or body.count(BUILD)!=1:
        raise ValueError("Samsung theme callback contract changed")
    before="    iget-object v2, v0, Lcom/android/systemui/theme/ThemeOverlayApplier;->mOverlayManager:Landroid/content/om/OverlayManager;"
    if body.count(before)!=1 or body.index(before)>body.index(BUILD):raise ValueError("Native theme commit changed")
    body=body.replace("    .locals 13","    .locals 14",1).replace(USER,USER+"\n\n    move v13, v4",1)
    body=body.replace(BUILD,"    invoke-static {v2, v1, v13}, "+HOOK+"\n\n"+BUILD,1)
    return text[:start]+body+text[end:]


def install(decoded):
    module=Path(__file__).resolve().parent;settings=module.parent
    spec=importlib.util.spec_from_file_location("verify_theme",module/"verify.py")
    verifier=importlib.util.module_from_spec(spec);spec.loader.exec_module(verifier);verifier.verify(settings)
    candidates=list(decoded.glob("smali*/com/android/systemui/theme/ThemeOverlayApplier$$ExternalSyntheticLambda0.smali"))
    if len(candidates)!=1:raise ValueError("Expected one native theme callback")
    target=candidates[0];updated=patch(target.read_text(encoding="utf8"))
    policy=settings/"SecSettings.apk/smali_classes4/com/gmhub/theme/PureBlackPolicy.smali"
    source=policy.read_text(encoding="utf8")
    definitions=list(decoded.glob("smali*/com/gmhub/theme/PureBlackPolicy.smali"))
    if len(definitions)>1:raise ValueError("Duplicate Pure Black policy class")
    destination=definitions[0] if definitions else None
    # Native directory is .../com/android/systemui/theme; preserve that DEX.
    if not definitions:
        dex=next(parent for parent in target.parents if parent.name.startswith("smali"))
        destination=dex/"com/gmhub/theme/PureBlackPolicy.smali"
    destination.parent.mkdir(parents=True,exist_ok=True)
    destination.write_text(source,encoding="utf8",newline="\n")
    target.write_text(updated,encoding="utf8",newline="\n")
    return {"theme_callback":target.relative_to(decoded).as_posix(),"monet_preserved":True,"per_user":True}


if __name__=="__main__":
    parser=argparse.ArgumentParser();parser.add_argument("decoded",type=Path);args=parser.parse_args();print(install(args.decoded))
