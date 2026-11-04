"""Disassemble source-owned SDK adapters with the audited Apktool 3.0.3 API.

The release JAR is shrunk and does not ship baksmali.Main. Use Apktool's
decoder entry point instead of depending on a CLI removed from that JAR.
This is a host development tool; it adds nothing to the phone or ROM boot.
"""
from pathlib import Path
import subprocess
import tempfile
import zipfile

DECODER = '''import java.io.File;
import java.nio.file.*;
import brut.androlib.smali.SmaliDecoder;
import com.android.tools.smali.dexlib2.dexbacked.DexBackedDexFile;
public class DecodeSdkDex {
 public static void main(String[] args) throws Exception {
  SmaliDecoder decoder = new SmaliDecoder(new File(args[0]), false);
  var entries = decoder.mDexContainer.getEntries();
  if(entries.size()!=1) throw new IllegalStateException("Expected one generated DEX");
  DexBackedDexFile dex=(DexBackedDexFile)entries.get("classes.dex");
  if(dex==null || dex.classCount==0) throw new IllegalStateException("Missing generated classes");
  File output=new File(args[1]);
  decoder.decodeFile(dex,output);
  try(var files=Files.walk(output.toPath())) {
   long count=files.filter(p->p.toString().endsWith(".smali")).count();
   if(count!=dex.classCount) throw new IllegalStateException("Incomplete disassembly");
  }
 }
}'''


def disassemble(java, apktool, dex, output):
    java, apktool, dex, output = [Path(p).resolve() for p in (java, apktool, dex, output)]
    if output.exists() and any(output.iterdir()):
        raise ValueError('Disassembly output must be empty')
    for path in [java, apktool, dex]:
        if not path.is_file():
            raise FileNotFoundError(path)
    with zipfile.ZipFile(apktool) as tool:
        if 'brut/androlib/smali/SmaliDecoder.class' not in tool.namelist():
            raise ValueError('Expected audited Apktool SmaliDecoder API')
    if dex.read_bytes()[:4] != b'dex\n':
        raise ValueError('Expected generated standard DEX')
    with tempfile.TemporaryDirectory(prefix='gmhub-decode-sdk-') as directory:
        tmp = Path(directory)
        source = tmp / 'DecodeSdkDex.java'
        source.write_text(DECODER, encoding='utf-8')
        archive = tmp / 'adapter.zip'
        with zipfile.ZipFile(archive, 'w') as bundle:
            bundle.write(dex, 'classes.dex')
        subprocess.run([str(java), '-cp', str(apktool), str(source), str(archive), str(output)], check=True, timeout=90)
