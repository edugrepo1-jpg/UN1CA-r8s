"""Parse small real ELF32/64 tables; no compiler or Android process is required."""
from pathlib import Path
import importlib.util
import io
import json
import struct
import tempfile
import unittest
import zipfile

ROOT=Path(__file__).resolve().parents[1]
spec=importlib.util.spec_from_file_location("native_index",ROOT/"scripts/internal/native_input_index.py")
index=importlib.util.module_from_spec(spec);spec.loader.exec_module(index)
HAS_ELFTOOLS=importlib.util.find_spec("elftools") is not None


def elf_fixture(bits,unresolved=False,versioned=True):
    order="<"
    def pack(fmt,*values):return struct.pack(order+fmt,*values)
    strings=bytearray(b"\0")
    def string(value):
        offset=len(strings);strings.extend(value.encode()+b"\0");return offset
    libc=string("libc.so");soname=string("libfixture.so")
    foo=string("foo");bar=string("bar");resolver=string("resolver")
    v26=string("LIBC_26");vlibc=string("LIBC");old=string("PORT_1");new=string("PORT_2")
    runpath=string("$ORIGIN/../lib:/system/lib64")
    def symbol(name,binding,kind,section,value):
        if bits==64:return pack("IBBHQQ",name,(binding<<4)|kind,0,section,value,0)
        return pack("IIIBBH",name,value,0,(binding<<4)|kind,0,section)
    symbols=b"".join([symbol(0,0,0,0,0),symbol(foo,1,2,0,0),symbol(bar,2,2,0,0),
                       symbol(foo,1,2,1,0x1000),symbol(foo,1,2,1,0x2000),symbol(resolver,1,10,1,0x3000)])
    need=pack("HHIII",1,2,libc,16,0)+pack("IHHII",0,0,3,v26,16)+pack("IHHII",0,2,4,vlibc,0)
    definitions=pack("HHHHIII",1,0,2,1,0,20,28)+pack("II",old,0)
    definitions+=pack("HHHHIII",1,0,5,1,0,20,0)+pack("II",new,0)
    versions=pack("6H",0,6 if unresolved else 3,4,0x8002,5,1)
    dynamic=b"".join(pack("qQ" if bits==64 else "iI",tag,value)
                     for tag,value in [(1,libc),(14,soname),(29,runpath),(0,0)])
    names=bytearray(b"\0")
    def name(value):offset=len(names);names.extend(value.encode()+b"\0");return offset
    sections=[(0,0,b"",0,0,0,0)]
    sections+=[(name(".shstrtab"),3,b"",0,0,1,0),(name(".dynstr"),3,bytes(strings),0,0,1,0),
               (name(".dynsym"),11,symbols,2,1,8 if bits==64 else 4,24 if bits==64 else 16),
               (name(".dynamic"),6,dynamic,2,0,8 if bits==64 else 4,16 if bits==64 else 8)]
    if versioned:
        sections.extend([(name(".gnu.version"),0x6fffffff,versions,3,0,2,2),
                         (name(".gnu.version_r"),0x6ffffffe,need,2,1,4,0),
                         (name(".gnu.version_d"),0x6ffffffd,definitions,2,2,4,0)])
    sections[1]=(sections[1][0],3,bytes(names),0,0,1,0)
    header_size=64 if bits==64 else 52;entry_size=64 if bits==64 else 40
    data=bytearray(header_size);headers=[]
    for name_id,kind,payload,link,info,align,size in sections:
        while align and len(data)%align:data.append(0)
        offset=len(data);data.extend(payload)
        headers.append((name_id,kind,0,0,offset,len(payload),link,info,align,size))
    while len(data)%8:data.append(0)
    table=len(data)
    for header in headers:data.extend(pack("IIQQQQIIQQ" if bits==64 else "10I",*header))
    ident=b"\x7fELF"+bytes([2 if bits==64 else 1,1,1])+bytes(9)
    values=(ident,3,183 if bits==64 else 40,1,0,0,table,0,header_size,0,0,entry_size,len(sections),1)
    data[:header_size]=pack("16sHHIQQQIHHHHHH" if bits==64 else "16sHHIIIIIHHHHHH",*values)
    return bytes(data)


@unittest.skipUnless(HAS_ELFTOOLS,"pyelftools is required for real ELF parsing")
class NativeIndexTests(unittest.TestCase):
    def test_symbol_versions_and_providers_survive_in_both_architectures(self):
        for bits in [32,64]:
            with self.subTest(bits=bits):
                result=index.index_elf(io.BytesIO(elf_fixture(bits)))
                self.assertEqual(result["bits"],bits)
                self.assertEqual(result["needed"],["libc.so"])
                self.assertEqual(result["soname"],"libfixture.so")
                self.assertEqual(result["runpath"],["$ORIGIN/../lib","/system/lib64"])
                strong,weak=result["imports"]
                self.assertEqual((strong["name"],strong["version"],strong["version_provider"]),("foo","LIBC_26","libc.so"))
                self.assertFalse(strong["version_weak"])
                self.assertEqual(weak["binding"],"STB_WEAK");self.assertEqual(weak["version"],"LIBC");self.assertTrue(weak["version_weak"])
                old,new,ifunc=result["exports"]
                self.assertEqual(old["name"],new["name"])
                self.assertEqual(old["version"],"PORT_1");self.assertTrue(old["version_hidden"]);self.assertFalse(old["default_version"])
                self.assertEqual(new["version"],"PORT_2");self.assertFalse(new["version_hidden"]);self.assertTrue(new["default_version"])
                self.assertEqual(ifunc["name"],"resolver");self.assertNotEqual(ifunc["type"],"STT_FUNC")
    def test_unknown_version_is_an_error_not_an_unversioned_symbol(self):
        for bits in [32,64]:
            with self.assertRaisesRegex(ValueError,"Unresolved GNU symbol version"):
                index.index_elf(io.BytesIO(elf_fixture(bits,unresolved=True)))
    def test_unversioned_binary_remains_supported(self):
        result=index.index_elf(io.BytesIO(elf_fixture(64,versioned=False)))
        self.assertFalse(result["symbol_versions_present"])
        self.assertTrue(all(s["version"] is None for s in result["imports"]+result["exports"]))
    def test_loose_and_apk_embedded_inputs_keep_hashes_and_apex_separation(self):
        with tempfile.TemporaryDirectory() as directory:
            root=Path(directory);raw=elf_fixture(64)
            (root/"libfixture.so").write_bytes(raw)
            with zipfile.ZipFile(root/"app.apk","w") as z:z.writestr("lib/arm64-v8a/libfixture.so",raw)
            (root/"runtime.apex").write_bytes(b"retained separately")
            out=root/"index.json";index.write_index(root,out)
            data=json.loads(out.read_text())
            self.assertEqual(data["schema_version"],2)
            self.assertEqual(len(data["libraries"]),2)
            self.assertEqual(data["libraries"][0]["sha256"],data["libraries"][1]["sha256"])
            self.assertEqual(data["apex_containers"],["runtime.apex"])
            self.assertTrue(any("!/" in entry["path"] for entry in data["libraries"]))

if __name__=="__main__":unittest.main()
