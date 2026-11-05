#!/usr/bin/env python3
"""Index exact donor ELF dependencies; APEX containers are retained separately.

Dependencies found here are necessary but do not prove namespace access or
runtime ABI compatibility. GNU symbol versions and runpaths are retained rather
than treating every same-named symbol as ABI-compatible. In particular, an APEX-contained library must not be
reported as missing until its container has also been inspected.
"""
from pathlib import Path
import hashlib
import io
import json
import zipfile


def symbol_versions(elf):
    """Keep definition/requirement namespaces separate and retain the hidden bit."""
    needed, defined = {}, {}
    section = elf.get_section_by_name('.gnu.version_r')
    if section:
        for requirement, auxiliaries in section.iter_versions():
            for auxiliary in auxiliaries:
                index = int(auxiliary['vna_other']) & 0x7fff
                if index <= 1 or index in needed:
                    raise ValueError('Invalid or duplicate GNU version requirement')
                needed[index] = {'name': auxiliary.name, 'provider': requirement.name,
                                 'weak': bool(auxiliary['vna_flags'] & 2)}
    section = elf.get_section_by_name('.gnu.version_d')
    if section:
        for definition, auxiliaries in section.iter_versions():
            index = int(definition['vd_ndx']) & 0x7fff
            names = [auxiliary.name for auxiliary in auxiliaries]
            if not names or index < 1 or index in defined:
                raise ValueError('Invalid or duplicate GNU version definition')
            # Later auxiliaries are parent versions, not aliases of this name.
            defined[index] = {'name': names[0], 'parents': names[1:],
                              'base': bool(definition['vd_flags'] & 1)}
    if set(needed) & set(defined):
        raise ValueError('Conflicting GNU version requirement/definition indices')
    return elf.get_section_by_name('.gnu.version'), needed, defined


def index_elf(stream):
    from elftools.elf.elffile import ELFFile
    elf = ELFFile(stream)
    versions, needed_versions, definitions = symbol_versions(elf)
    result = {'bits': elf.elfclass, 'machine': elf.header['e_machine'],
              'soname': None, 'needed': [], 'imports': [], 'exports': [],
              'runpath': [], 'rpath': [], 'symbol_versions_present': versions is not None,
              'version_requirements': needed_versions, 'version_definitions': definitions}
    dynamic = elf.get_section_by_name('.dynamic')
    if dynamic:
        for tag in dynamic.iter_tags():
            if tag.entry.d_tag == 'DT_NEEDED':
                result['needed'].append(tag.needed)
            elif tag.entry.d_tag == 'DT_SONAME':
                result['soname'] = tag.soname
            elif tag.entry.d_tag == 'DT_RUNPATH':
                result['runpath'].extend(tag.runpath.split(':'))
            elif tag.entry.d_tag == 'DT_RPATH':
                result['rpath'].extend(tag.rpath.split(':'))
    symbols = elf.get_section_by_name('.dynsym')
    result['dynamic_symbols_present'] = symbols is not None
    if symbols:
        if versions is not None and versions.num_symbols() != symbols.num_symbols():
            raise ValueError('GNU version table does not match dynamic symbols')
        for position, symbol in enumerate(symbols.iter_symbols()):
            if not symbol.name:
                continue
            bind = symbol['st_info']['bind']
            entry = {'name': symbol.name, 'binding': bind,
                     'type': symbol['st_info']['type'], 'visibility': symbol['st_other']['visibility'],
                     'version': None, 'version_provider': None, 'version_hidden': False,
                     'version_weak': False}
            if versions is not None:
                version = versions.get_symbol(position)['ndx']
                if isinstance(version, int):
                    index = version & 0x7fff
                    entry['version_hidden'] = bool(version & 0x8000)
                    if index > 1:
                        # COPY relocations may define a symbol whose version is
                        # supplied by a dependency; retain that provider too.
                        if index in needed_versions:
                            info = needed_versions[index]
                            entry.update(version=info['name'], version_provider=info['provider'],
                                         version_weak=info['weak'])
                        elif index in definitions:
                            entry['version'] = definitions[index]['name']
                        else:
                            raise ValueError('Unresolved GNU symbol version index: ' + str(index))
            if symbol['st_shndx'] == 'SHN_UNDEF':
                if bind in {'STB_GLOBAL', 'STB_WEAK'}:
                    result['imports'].append(entry)
            elif bind in {'STB_GLOBAL', 'STB_WEAK', 'STB_GNU_UNIQUE'} and symbol['st_other']['visibility'] in {'STV_DEFAULT', 'STV_PROTECTED'}:
                entry['default_version'] = entry['version'] is not None and not entry['version_hidden']
                result['exports'].append(entry)
    return result


def write_index(root, destination):
    result = {'schema_version': 2, 'scope': 'loose firmware ELFs and APK-embedded libraries; APEX payloads archived separately',
              'libraries': [], 'apex_containers': []}
    for path in sorted(root.rglob('*')):
        if not path.is_file():
            continue
        relative = path.relative_to(root).as_posix()
        with path.open('rb') as stream:
            header = stream.read(4)
            if header == b'\x7fELF':
                stream.seek(0)
                entry = index_elf(stream)
                stream.seek(0)
                entry.update(path=relative, size=path.stat().st_size,
                             sha256=hashlib.file_digest(stream, 'sha256').hexdigest())
                result['libraries'].append(entry)
        if path.suffix in {'.apex', '.capex'}:
            result['apex_containers'].append(relative)
        elif path.suffix == '.apk':
            with zipfile.ZipFile(path) as package:
                for name in package.namelist():
                    if not name.startswith('lib/') or not name.endswith('.so'):
                        continue
                    raw = package.read(name)
                    if raw[:4] == b'\x7fELF':
                        entry = index_elf(io.BytesIO(raw))
                        entry.update(path=relative + '!/' + name, size=len(raw),
                                     sha256=hashlib.sha256(raw).hexdigest())
                        result['libraries'].append(entry)
    destination.write_text(json.dumps(result, separators=(',', ':')) + '\n')
