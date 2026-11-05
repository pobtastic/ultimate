#!/usr/bin/env python3
# Copyright 2026 Paul Maddern (paul@arcadegeek.co.uk)
"""Render Martianoids' world as an OpenSeadragon Deep Zoom image.

Paints the 49x49 used cells of the map at #R$C515 from above. The
high nibble is the type the cell started as.
"""
import argparse
import math
import os
import shutil
import sys

import numpy as np
from PIL import Image
from skoolkit.snapshot import get_snapshot

SCALE = 8
TILE_SIZE = 512
PAD = 2
MAP = 0xC515
USED = 0x31
STRIDE = 0x40

# Type 0 empty, then the fifteen templates at #R$97C0.
INK = [
    (16, 16, 24),
    (220, 40, 40),
    (0, 220, 220),
    (255, 220, 0),
    (180, 0, 255),
    (200, 80, 255),
    (40, 200, 80),
    (255, 80, 80),
    (240, 240, 240),
    (0, 180, 255),
    (120, 120, 140),
    (160, 160, 180),
    (255, 255, 255),
    (255, 200, 80),
    (80, 255, 255),
    (80, 255, 120),
]


def cell_type(byte):
    current = byte & 0x0F
    initial = byte >> 4
    return current if current else initial


def paint_map(mem, scale=SCALE):
    width = (USED + PAD * 2) * scale
    height = (USED + PAD * 2) * scale
    pixels = np.zeros((height, width), dtype=np.uint8)
    for row in range(USED):
        for col in range(USED):
            typ = cell_type(mem[MAP + row * STRIDE + col])
            x = (col + PAD) * scale
            y = (row + PAD) * scale
            pixels[y:y + scale, x:x + scale] = typ
    # Sector lines every 16 cells.
    line = 4
    for i in range(4):
        pos = (i * 16 + PAD) * scale
        pixels[pos:pos + 1, PAD * scale:(USED + PAD) * scale] = line
        pixels[PAD * scale:(USED + PAD) * scale, pos:pos + 1] = line
    return pixels


def palette_image(arr):
    image = Image.fromarray(arr, mode='P')
    palette = []
    for red, green, blue in INK:
        palette.extend((red, green, blue))
    palette.extend([0] * (768 - len(palette)))
    image.putpalette(palette)
    return image


def write_dzi(image, dest, name, tile_size=TILE_SIZE):
    width, height = image.size
    max_level = math.ceil(math.log2(max(width, height)))
    files_dir = os.path.join(dest, name + '_files')
    if os.path.isdir(files_dir):
        shutil.rmtree(files_dir)
    with open(os.path.join(dest, name + '.dzi'), 'w') as handle:
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
                    tx * tile_size, ty * tile_size,
                    min((tx + 1) * tile_size, lw),
                    min((ty + 1) * tile_size, lh),
                )
                level_img.crop(box).save(
                    os.path.join(level_dir, '%d_%d.png' % (tx, ty)),
                    format='PNG', compress_level=6,
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


def copy_output(src, dest, name):
    os.makedirs(dest, exist_ok=True)
    for item in (name + '.dzi', name + '_files'):
        source = os.path.join(src, item)
        target = os.path.join(dest, item)
        if os.path.isdir(target):
            shutil.rmtree(target)
        elif os.path.isfile(target):
            os.remove(target)
        if os.path.isdir(source):
            shutil.copytree(source, target)
        else:
            shutil.copy2(source, target)


def main(argv):
    parser = argparse.ArgumentParser(
        description='Render the Martianoids world Deep Zoom map.')
    parser.add_argument('snapshot', help='Martianoids Z80/SNA snapshot')
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
    print('tiles', dests[0], flush=True)
    written = write_dzi(image, dests[0], 'world-map')
    for extra in dests[1:]:
        print('copy', extra, flush=True)
        copy_output(dests[0], extra, 'world-map')
    print('wrote', written, 'tiles', flush=True)


if __name__ == '__main__':
    main(sys.argv[1:])
