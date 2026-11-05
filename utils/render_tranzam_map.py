#!/usr/bin/env python3
# Copyright 2026 Paul Maddern (paul@arcadegeek.co.uk)
"""Render Tranz Am's USA map as an OpenSeadragon Deep Zoom image.

Reads the map points and sprites from a snapshot, paints the daytime
view at SCALE, and writes usa-map.dzi plus PNG tiles.
"""
import argparse
import math
import os
import shutil
import sys

import numpy as np
from PIL import Image
from skoolkit import ROM48, read_bin_file
from skoolkit.snapshot import get_snapshot

SCALE = 2
UNIT = 4
TILE_SIZE = 512
PAD = 40
MAP_W = 0x1800
MAP_H = 0x0C00
POINTS = 0x7811
POINTS_END = 0x7CD6
SPRITES = 0x7F06
DAY_ATTR = 0x6BE6
NAMES = 0x722F
START_X = 0x0C40
START_Y = 0x0640
CUP_Y = 0x60
CUP_Y0 = 0x20
CUP_Y1 = 0x9F

INK = [
    (0, 0, 0), (0, 0, 255), (255, 0, 0), (255, 0, 255),
    (0, 255, 0), (0, 255, 255), (255, 255, 0), (255, 255, 255),
]
PAPER = (255, 255, 0)
CUP = (255, 0, 255)
RANGE_DOT = (180, 80, 180)


def load_sprite(mem, sprite_id):
    addr = mem[SPRITES + (sprite_id - 1) * 2] + 256 * mem[
        SPRITES + (sprite_id - 1) * 2 + 1]
    height = mem[addr]
    rows = []
    pointer = addr + 1
    for _ in range(height):
        bits = (mem[pointer] << 8) | mem[pointer + 1]
        rows.append(bits)
        pointer += 2
    return rows


def load_font():
    rom = read_bin_file(ROM48)
    glyphs = {}
    for code in range(32, 128):
        base = 0x3D00 + (code - 32) * 8
        glyphs[code] = rom[base:base + 8]
    return glyphs


def parse_names(mem):
    names = []
    addr = NAMES
    for _ in range(26):
        chars = []
        while True:
            byte = mem[addr]
            addr += 1
            chars.append(chr(byte & 0x7F))
            if byte & 0x80:
                break
        names.append(''.join(chars))
    return names


def parse_points(mem):
    points = []
    addr = POINTS
    while addr < POINTS_END:
        points.append((mem[addr], mem[addr + 1], mem[addr + 2]))
        addr += 3
    return points


def to_pixel(x_units, y_units):
    return (
        PAD + x_units // UNIT,
        PAD + (MAP_H - y_units) // UNIT,
    )


def blit_sprite(pixels, rows, colour, cx, cy):
    # First stored line is the base; the game draws upward (#R$7170).
    height, width = pixels.shape[:2]
    ox = cx - 8
    for row, bits in enumerate(rows):
        py = cy - 1 - row
        if py < 0 or py >= height:
            continue
        for col in range(16):
            if bits & (0x8000 >> col):
                px = ox + col
                if 0 <= px < width:
                    pixels[py, px] = colour


def fill_rect(pixels, colour, x, y, w, h):
    height, width = pixels.shape[:2]
    x0 = max(0, x)
    y0 = max(0, y)
    x1 = min(width, x + w)
    y1 = min(height, y + h)
    if x1 > x0 and y1 > y0:
        pixels[y0:y1, x0:x1] = colour


def blit_text(pixels, font, colour, x, y, text):
    height, width = pixels.shape[:2]
    for index, char in enumerate(text):
        glyph = font.get(ord(char), font[32])
        for row, bits in enumerate(glyph):
            py = y + row
            if py < 0 or py >= height:
                continue
            for col in range(8):
                if bits & (0x80 >> col):
                    px = x + index * 8 + col
                    if 0 <= px < width:
                        pixels[py, px] = colour


def blit_label(pixels, font, x, y, text):
    fill_rect(pixels, PAPER, x - 1, y - 1, len(text) * 8 + 2, 10)
    blit_text(pixels, font, (0, 0, 0), x, y, text)


def object_ink(mem, sprite_id):
    if 1 <= sprite_id <= 15:
        return INK[mem[DAY_ATTR + sprite_id] & 7]
    return INK[0]


def paint_map(mem, scale=SCALE):
    sprites = {sid: load_sprite(mem, sid) for sid in range(1, 0x22)}
    font = load_font()
    names = parse_names(mem)
    points = parse_points(mem)
    pw = PAD * 2 + MAP_W // UNIT
    ph = PAD * 2 + MAP_H // UNIT
    pixels = np.zeros((ph, pw, 3), dtype=np.uint8)
    pixels[:, :] = PAPER

    # Cup Y is chosen each round; mark the band and sit the cup in
    # the middle of it.
    for x, _y, sid in points:
        if sid not in (0x20, 0x60):
            continue
        x0, y1 = to_pixel(x * 0x20, CUP_Y0 * 0x10)
        _x1, y0 = to_pixel(x * 0x20, CUP_Y1 * 0x10)
        for py in range(y0, y1 + 1, 3):
            if 0 <= py < ph and 0 <= x0 < pw:
                pixels[py, x0] = RANGE_DOT

    places = []
    for x, y, sid in points:
        if sid & 0x40:
            px, py = to_pixel(x * 0x20, y * 0x10)
            blit_sprite(pixels, sprites[7], object_ink(mem, 7), px, py)
            places.append((px, py, names[sid & 0x3F].strip()))
            continue
        if sid in (0x20, 0x60):
            px, py = to_pixel(x * 0x20, CUP_Y * 0x10)
            blit_sprite(pixels, sprites[0x20], CUP, px, py)
            continue
        px, py = to_pixel(x * 0x20, y * 0x10)
        rows = sprites.get(sid)
        if rows:
            blit_sprite(pixels, rows, object_ink(mem, sid), px, py)

    for px, py, name in places:
        blit_label(pixels, font, px - len(name) * 4, py - 26, name)

    sx, sy = to_pixel(START_X, START_Y)
    blit_sprite(pixels, sprites[0x10], (255, 0, 0), sx, sy)
    blit_label(pixels, font, sx - 20, sy + 2, 'START')

    if scale != 1:
        pixels = np.repeat(np.repeat(pixels, scale, axis=0), scale, axis=1)
    return pixels


def write_dzi(image, dest, tile_size=TILE_SIZE):
    width, height = image.size
    max_level = math.ceil(math.log2(max(width, height)))
    name = 'usa-map'
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
    for name in ('usa-map.dzi', 'usa-map_files'):
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
    leftover = os.path.join(dest, 'usa-map.png')
    if os.path.isfile(leftover):
        os.remove(leftover)


def main(argv):
    parser = argparse.ArgumentParser(
        description='Render the Tranz Am USA Deep Zoom map.')
    parser.add_argument('snapshot', help='Tranz Am Z80/SNA snapshot')
    parser.add_argument('dest', nargs='+',
                        help='HTML images directory (repeat to copy)')
    parser.add_argument('--scale', type=int, default=SCALE)
    parser.add_argument('--preview', help='Write a downscaled PNG as well')
    args = parser.parse_args(argv)

    print('snapshot', args.snapshot, flush=True)
    mem = get_snapshot(args.snapshot)
    print('paint scale', args.scale, flush=True)
    pixels = paint_map(mem, scale=args.scale)
    print('image', pixels.shape[1], 'x', pixels.shape[0], flush=True)
    image = Image.fromarray(pixels, mode='RGB')
    dests = [os.path.abspath(path) for path in args.dest]
    os.makedirs(dests[0], exist_ok=True)
    leftover = os.path.join(dests[0], 'usa-map.png')
    if os.path.isfile(leftover):
        os.remove(leftover)
    print('tiles', dests[0], flush=True)
    written = write_dzi(image, dests[0])
    for extra in dests[1:]:
        print('copy', extra, flush=True)
        copy_output(dests[0], extra)
    if args.preview:
        preview = image.resize(
            (image.size[0] // 2, image.size[1] // 2),
            Image.Resampling.NEAREST,
        )
        preview.save(args.preview)
        print('preview', args.preview, flush=True)
    print('wrote', written, 'tiles', flush=True)


if __name__ == '__main__':
    main(sys.argv[1:])
