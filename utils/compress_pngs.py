#!/usr/bin/env python3
# Copyright 2026 Paul Maddern (paul@arcadegeek.co.uk)
"""Compress PNG files under the given directories.

Uses optipng when it is on PATH, otherwise recompresses with zlib
level 9. A file is left as it is when the result is not smaller.

Deep Zoom tile trees (village-map_files, station-map_files,
usa-map_files, town-map_files, world-map_files, planet-map_files)
are skipped: those PNGs are already written compressed, and there are
thousands of them.
"""
import os
import struct
import subprocess
import sys
import zlib


def chunk(tag, data):
    body = tag + data
    return (struct.pack('>I', len(data)) + body +
            struct.pack('>I', zlib.crc32(body) & 0xffffffff))


def recompress_zlib(path):
    data = open(path, 'rb').read()
    if data[:8] != b'\x89PNG\r\n\x1a\n':
        return
    off = 8
    idat = b''
    header = None
    while off < len(data):
        length = struct.unpack('>I', data[off:off + 4])[0]
        tag = data[off + 4:off + 8]
        payload = data[off + 8:off + 8 + length]
        if tag == b'IHDR':
            header = payload
        elif tag == b'IDAT':
            idat += payload
        elif tag == b'IEND':
            break
        off += 12 + length
    if header is None or not idat:
        return
    raw = zlib.decompress(idat)
    out = (b'\x89PNG\r\n\x1a\n' +
           chunk(b'IHDR', header) +
           chunk(b'IDAT', zlib.compress(raw, 9)) +
           chunk(b'IEND', b''))
    if len(out) < len(data):
        tmp = path + '.tmp'
        open(tmp, 'wb').write(out)
        os.replace(tmp, path)


SKIP_DIRS = frozenset(('village-map_files', 'station-map_files',
                       'castle-map_files', 'usa-map_files',
                       'town-map_files', 'world-map_files',
                       'planet-map_files'))


def png_files(roots):
    for root in roots:
        for dirpath, dirnames, filenames in os.walk(root):
            dirnames[:] = [name for name in dirnames
                           if name not in SKIP_DIRS]
            for name in filenames:
                if name.endswith('.png'):
                    yield os.path.join(dirpath, name)


def main(argv):
    roots = argv[1:]
    if not roots:
        sys.exit('Usage: compress_pngs.py DIR...')
    optipng = None
    try:
        subprocess.check_call(['optipng', '-v'],
                              stdout=subprocess.DEVNULL,
                              stderr=subprocess.DEVNULL)
        optipng = 'optipng'
    except (OSError, subprocess.CalledProcessError):
        pass
    for path in png_files(roots):
        if optipng:
            subprocess.check_call([optipng, '-o2', '-quiet', path])
        else:
            recompress_zlib(path)


if __name__ == '__main__':
    main(sys.argv)
