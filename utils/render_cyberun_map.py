#!/usr/bin/env python3
# Copyright 2026 Paul Maddern (paul@arcadegeek.co.uk)
"""Render Cyberun's tile map as an OpenSeadragon Deep Zoom image.

Paints the 28 by 96 tiles at #R$61BC and marks the objects from
#R$5E17.
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
TILE_MAP = 0x61BC
COLUMNS = 0x60
ROWS = 0x1C
TERRAIN = 0x5E17
COLUMN_TABLE = 0x5DB6
MAP_TABLE = 0x5C94
OBJECT_MARK = 15

# Tile 0 is blank sky. Other tiles take a colour from their number.
INK = [
    (8, 8, 16),
    (20, 60, 20),
    (40, 100, 40),
    (80, 140, 40),
    (120, 160, 50),
    (40, 80, 120),
    (80, 120, 160),
    (160, 160, 80),
    (180, 100, 40),
    (120, 80, 40),
    (200, 200, 80),
    (60, 140, 100),
    (100, 60, 140),
    (180, 180, 180),
    (255, 220, 80),
    (255, 80, 200),
]


def tile_colour(tile):
    if tile == 0:
        return 0
    return 1 + (tile % 13)


def paint_map(mem, scale=SCALE):
    width = (COLUMNS + PAD * 2) * scale
    height = (ROWS + PAD * 2) * scale
    pixels = np.zeros((height, width), dtype=np.uint8)
    for row in range(ROWS):
        for col in range(COLUMNS):
            tile = mem[TILE_MAP + row * COLUMNS + col]
            x = (col + PAD) * scale
            y = (row + PAD) * scale
            pixels[y:y + scale, x:x + scale] = tile_colour(tile)

    index = 0
    for col in range(COLUMNS):
        count = mem[COLUMN_TABLE + col]
        for _ in range(count):
            kind = mem[MAP_TABLE + index] & 0x3F
            data1 = mem[TERRAIN + index * 2 + 1]
            map_row = data1 & 0x1F
            if 0 <= map_row < ROWS:
                x = (col + PAD) * scale + scale // 4
                y = (map_row + PAD) * scale + scale // 4
                size = max(2, scale // 2)
                colour = OBJECT_MARK if kind else 14
                pixels[y:y + size, x:x + size] = colour
            index += 1
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
        description='Render the Cyberun planet Deep Zoom map.')
    parser.add_argument('snapshot', help='Cyberun Z80/SNA snapshot')
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
    written = write_dzi(image, dests[0], 'planet-map')
    for extra in dests[1:]:
        print('copy', extra, flush=True)
        copy_output(dests[0], extra, 'planet-map')
    print('wrote', written, 'tiles', flush=True)


if __name__ == '__main__':
    main(sys.argv[1:])
