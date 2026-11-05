#!/usr/bin/env python3
# Copyright 2026 Paul Maddern (paul@arcadegeek.co.uk)
"""Render Nightshade's village as an OpenSeadragon Deep Zoom image.

Reads the 32x32 map and wall strips from a snapshot, paints the
unrotated view at SCALE (the same 4x used by the graphics pages),
and writes village-map.dzi plus PNG tiles.
"""
import argparse
import math
import os
import shutil
import sys

import numpy as np
from PIL import Image
from skoolkit.snapshot import get_snapshot

SCALE = 4
TILE_SIZE = 512
PAD = 16
YOFF = 80

# Bright green, cyan, yellow, white — lowest two bits of the tile.
INK = [
    (0, 255, 0),
    (0, 255, 255),
    (255, 255, 0),
    (255, 255, 255),
]


def word(mem, addr):
    return mem[addr] + 256 * mem[addr + 1]


def bits16(b0, b1):
    return ([(b0 >> (7 - i)) & 1 for i in range(8)] +
            [(b1 >> (7 - i)) & 1 for i in range(8)])


def load_strip(mem, addr):
    height = mem[addr]
    rows = []
    pointer = addr + 1
    for _ in range(height):
        rows.append(bits16(mem[pointer], mem[pointer + 1]))
        pointer += 2
    return rows


def walk_walls(mem, callback, list_addr):
    """Replay Draw Cell With Walls strip positions (no clip)."""
    x, y = 0, 0
    iy = list_addr
    mirror = False
    for _ in range(8):
        callback(x, y, mem[iy], mem[iy + 1], mirror)
        iy += 2
        x += 16
        y -= 8
    y += 8
    mirror = True
    for _ in range(8):
        callback(x, y, mem[iy], mem[iy + 1], mirror)
        iy += 2
        x += 16
        y += 8


def tile_pixels(mem, walls, lists, tile):
    """Scale-1 set pixels (x, y) for one tile in the unrotated view."""
    if tile == 0:
        return []
    colour = 1 + (tile & 3)
    list_addr = lists[tile * 2]
    pixels = []

    def one(x, y, sid, sid_below, mirror):
        for base_y, sid_use in ((y, sid), (y + 64, sid_below)):
            if sid_use >= len(walls):
                continue
            for i, row in enumerate(walls[sid_use]):
                bits = row[::-1] if mirror else row
                py = base_y + i
                for j, bit in enumerate(bits):
                    if bit:
                        pixels.append((x + j, py, colour))

    walk_walls(mem, one, list_addr)
    return pixels


def paint_map(mem, scale=SCALE):
    walls = [load_strip(mem, word(mem, 0x6E36 + i * 2))
             for i in range(0x34)]
    lists = [word(mem, 0x62A4 + i * 2) for i in range(0x24 * 2)]
    village = mem[0x5E04:0x5E04 + 1024]
    prototypes = [tile_pixels(mem, walls, lists, t) for t in range(0x24)]

    cells = []
    minx, miny, maxx, maxy = 10 ** 9, 10 ** 9, -10 ** 9, -10 ** 9
    for row in range(32):
        for col in range(32):
            tile = village[row * 32 + col]
            proto = prototypes[tile]
            if not proto:
                continue
            ox = 128 * (col + row)
            oy = YOFF + 64 * (row - col + 31)
            cells.append((ox, oy, proto))
            for px, py, _colour in proto:
                x, y = ox + px, oy + py
                if x < minx:
                    minx = x
                if x > maxx:
                    maxx = x
                if y < miny:
                    miny = y
                if y > maxy:
                    maxy = y

    minx -= PAD
    miny -= PAD
    width = (maxx - minx + 1 + PAD) * scale
    height = (maxy - miny + 1 + PAD) * scale
    pixels = np.zeros((height, width), dtype=np.uint8)
    # Far (small row-col) first so nearer cells paint over.
    cells.sort(key=lambda cell: (cell[1], cell[0]))
    for ox, oy, proto in cells:
        for px, py, colour in proto:
            x = (ox + px - minx) * scale
            y = (oy + py - miny) * scale
            pixels[y:y + scale, x:x + scale] = colour
    return pixels


def palette_image(arr):
    image = Image.fromarray(arr, mode='P')
    palette = [0, 0, 0]
    for red, green, blue in INK:
        palette.extend((red, green, blue))
    palette.extend([0] * (768 - len(palette)))
    image.putpalette(palette)
    return image


def write_dzi(image, dest, tile_size=TILE_SIZE):
    width, height = image.size
    max_level = math.ceil(math.log2(max(width, height)))
    name = 'village-map'
    files_dir = os.path.join(dest, name + '_files')
    if os.path.isdir(files_dir):
        shutil.rmtree(files_dir)
    dzi_path = os.path.join(dest, name + '.dzi')
    with open(dzi_path, 'w') as handle:
        handle.write(
            '<?xml version="1.0" encoding="UTF-8"?>\n'
            '<Image xmlns="http://schemas.microsoft.com/deepzoom/2008"\n'
            '       Format="png" Overlap="0" TileSize="%d">\n'
            '  <Size Width="%d" Height="%d"/>\n'
            '</Image>\n' % (tile_size, width, height)
        )

    level_img = image
    lw, lh = width, height
    written = 0
    for level in range(max_level, -1, -1):
        level_dir = os.path.join(files_dir, str(level))
        os.makedirs(level_dir, exist_ok=True)
        cols = math.ceil(lw / tile_size)
        rows = math.ceil(lh / tile_size)
        for ty in range(rows):
            for tx in range(cols):
                box = (
                    tx * tile_size,
                    ty * tile_size,
                    min((tx + 1) * tile_size, lw),
                    min((ty + 1) * tile_size, lh),
                )
                tile = level_img.crop(box)
                tile.save(
                    os.path.join(level_dir, '%d_%d.png' % (tx, ty)),
                    format='PNG',
                    compress_level=6,
                )
                written += 1
        print('  level %d %dx%d (%d tiles)' % (level, lw, lh, cols * rows),
              flush=True)
        if level == 0:
            break
        lw = math.ceil(lw / 2)
        lh = math.ceil(lh / 2)
        level_img = level_img.resize((lw, lh), Image.Resampling.NEAREST)
    return written


def copy_output(src, dest):
    os.makedirs(dest, exist_ok=True)
    for name in ('village-map.dzi', 'village-map_files'):
        source = os.path.join(src, name)
        target = os.path.join(dest, name)
        if os.path.isdir(target):
            shutil.rmtree(target)
        elif os.path.isfile(target):
            os.remove(target)
        if os.path.isdir(source):
            shutil.copytree(source, target)
        else:
            shutil.copy2(source, target)
    leftover = os.path.join(dest, 'village-map.png')
    if os.path.isfile(leftover):
        os.remove(leftover)


def main(argv):
    parser = argparse.ArgumentParser(
        description='Render the Nightshade village Deep Zoom map.')
    parser.add_argument('snapshot', help='Nightshade Z80/SNA snapshot')
    parser.add_argument('dest', nargs='+',
                        help='HTML images directory (repeat to copy)')
    parser.add_argument('--scale', type=int, default=SCALE)
    args = parser.parse_args(argv)

    print('snapshot', args.snapshot, flush=True)
    mem = get_snapshot(args.snapshot)
    print('paint scale', args.scale, flush=True)
    pixels = paint_map(mem, scale=args.scale)
    print('image', pixels.shape[1], 'x', pixels.shape[0], flush=True)
    image = palette_image(pixels)
    dests = [os.path.abspath(path) for path in args.dest]
    os.makedirs(dests[0], exist_ok=True)
    leftover = os.path.join(dests[0], 'village-map.png')
    if os.path.isfile(leftover):
        os.remove(leftover)
    print('tiles', dests[0], flush=True)
    written = write_dzi(image, dests[0])
    for extra in dests[1:]:
        print('copy', extra, flush=True)
        copy_output(dests[0], extra)
    print('wrote', written, 'tiles', flush=True)


if __name__ == '__main__':
    main(sys.argv[1:])
