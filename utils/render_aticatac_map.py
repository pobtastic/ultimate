#!/usr/bin/env python3
# Copyright 2026 Paul Maddern (paul@arcadegeek.co.uk)
"""Render Atic Atac's rooms as an OpenSeadragon Deep Zoom image.

The game has no floor table. Five storeys fall out of the doors:
a staircase or trapdoor changes level, a wall door stays put. Each
play area is drawn with the game's own frame and item routines.
Writes castle-map.dzi plus PNG tiles.
"""
import argparse
import math
import os
import shutil
import sys
from collections import defaultdict, deque

import numpy as np
from PIL import Image, ImageDraw
from skoolkit.simulator import Simulator
from skoolkit.snapshot import get_snapshot

SCALE = 2
TILE_SIZE = 512
PAD = 16
PLAY = 192
GAP = 8
CELL = PLAY + GAP

DOOR_START = 0x645D
DOOR_END = 0x755D
ROOM_COUNT = 0x95
PLAYER_ROOM = 0xEA91
START_GAME = 0x7D9A
ENTER_ROOM = 0x9147
AFTER_FRAME = 0x9159
MAIN_LOOP = 0x7DC3
AFTER_ITEMS = 0x7E44

# Stored graphic IDs that join two rooms through a wall.
WALL_DOORS = frozenset((
    0x01, 0x02, 0x03, 0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E,
    0x20, 0x21, 0x22,
))

DELTA = {'N': (0, -1), 'S': (0, 1), 'E': (1, 0), 'W': (-1, 0)}
OPP = {'N': 'S', 'S': 'N', 'E': 'W', 'W': 'E'}
TITLE_H = 20
FLOOR_GAP = 28

# Five storeys, attic at the top. Stair rooms sit on the upper floor.
FLOOR_ROOMS = {
    2: (0x27, 0x2C, 0x2D, 0x2E, 0x2F),
    1: (
        0x1E, 0x1F, 0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26,
        0x28, 0x29, 0x2A, 0x2B, 0x75, 0x76, 0x77, 0x78, 0x79,
        0x7A, 0x7B, 0x7C, 0x7D, 0x7E, 0x7F, 0x80, 0x81, 0x82,
        0x87, 0x88, 0x8B, 0x8C, 0x8D,
    ),
    0: (
        0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
        0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F, 0x10, 0x11,
        0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18, 0x19, 0x1A,
        0x6B, 0x6C, 0x6D, 0x6E, 0x6F, 0x70, 0x71, 0x73, 0x83,
        0x84, 0x85, 0x86, 0x89, 0x8A, 0x8E,
    ),
    -1: (
        0x1B, 0x1C, 0x56, 0x57, 0x58, 0x59, 0x5A, 0x5B, 0x5C,
        0x5D, 0x5E, 0x5F, 0x60, 0x61, 0x62, 0x63, 0x64, 0x65,
        0x66, 0x67, 0x68, 0x69, 0x6A, 0x72,
    ),
    -2: (
        0x1D, 0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37,
        0x38, 0x39, 0x3A, 0x3B, 0x3C, 0x3D, 0x3E, 0x3F, 0x40,
        0x41, 0x42, 0x43, 0x44, 0x45, 0x46, 0x47, 0x48, 0x49,
        0x4A, 0x4B, 0x4C, 0x4D, 0x4E, 0x4F, 0x50, 0x51, 0x52,
        0x53, 0x54, 0x55, 0x74, 0x8F, 0x90, 0x91, 0x92, 0x93,
        0x94,
    ),
}
FLOOR_ORDER = (2, 1, 0, -1, -2)
FLOOR_NAME = {
    2: 'ATTIC',
    1: 'FIRST FLOOR',
    0: 'GROUND FLOOR',
    -1: 'BASEMENT',
    -2: 'CAVERNS',
}

# Upper room, lower room: stairs and trapdoors used to line floors up.
VERTICAL = (
    (0x26, 0x02), (0x2F, 0x20), (0x1A, 0x1B), (0x71, 0x72),
    (0x72, 0x35), (0x1C, 0x1D), (0x27, 0x28), (0x2C, 0x2B),
    (0x2D, 0x75), (0x21, 0x03), (0x29, 0x09), (0x76, 0x84),
    (0x78, 0x8A), (0x8B, 0x6C), (0x8D, 0x6E), (0x03, 0x65),
    (0x15, 0x66), (0x73, 0x74), (0x61, 0x4B), (0x2D, 0x8D),
)

# Bright / dim Spectrum inks.
PALETTE = [
    (0, 0, 0), (0, 0, 205), (205, 0, 0), (205, 0, 205),
    (0, 205, 0), (0, 205, 205), (205, 205, 0), (205, 205, 205),
    (0, 0, 0), (0, 0, 255), (255, 0, 0), (255, 0, 255),
    (0, 255, 0), (0, 255, 255), (255, 255, 0), (255, 255, 255),
]

HEX_FONT = {
    '0': (0x7, 0x5, 0x5, 0x5, 0x7),
    '1': (0x2, 0x6, 0x2, 0x2, 0x7),
    '2': (0x7, 0x1, 0x7, 0x4, 0x7),
    '3': (0x7, 0x1, 0x7, 0x1, 0x7),
    '4': (0x5, 0x5, 0x7, 0x1, 0x1),
    '5': (0x7, 0x4, 0x7, 0x1, 0x7),
    '6': (0x7, 0x4, 0x7, 0x5, 0x7),
    '7': (0x7, 0x1, 0x1, 0x1, 0x1),
    '8': (0x7, 0x5, 0x7, 0x5, 0x7),
    '9': (0x7, 0x5, 0x7, 0x1, 0x7),
    'A': (0x7, 0x5, 0x7, 0x5, 0x5),
    'B': (0x6, 0x5, 0x6, 0x5, 0x6),
    'C': (0x7, 0x4, 0x4, 0x4, 0x7),
    'D': (0x6, 0x5, 0x5, 0x5, 0x6),
    'E': (0x7, 0x4, 0x6, 0x4, 0x7),
    'F': (0x7, 0x4, 0x6, 0x4, 0x4),
}


def wall_side(x, y):
    if x <= 24:
        return 'W'
    if x >= 152:
        return 'E'
    if y <= 40:
        return 'N'
    if y >= 168:
        return 'S'
    if x <= 48 and 70 <= y <= 150:
        return 'W'
    if x >= 120 and 70 <= y <= 150:
        return 'E'
    if y <= 80 and 40 <= x <= 120:
        return 'N'
    if y >= 140 and 40 <= x <= 120:
        return 'S'
    return None


def parse_doors(mem):
    doors = []
    addr = DOOR_START
    while addr < DOOR_END:
        g1, r1, x1, y1 = mem[addr], mem[addr + 1], mem[addr + 3], mem[addr + 4]
        g2, r2, x2, y2 = (mem[addr + 8], mem[addr + 9],
                          mem[addr + 11], mem[addr + 12])
        doors.append({
            'addr': addr,
            'a': {'gid': g1, 'room': r1, 'x': x1, 'y': y1,
                  'side': wall_side(x1, y1)},
            'b': {'gid': g2, 'room': r2, 'x': x2, 'y': y2,
                  'side': wall_side(x2, y2)},
        })
        addr += 16
    return doors


def room_floor(room):
    for floor, rooms in FLOOR_ROOMS.items():
        if room in rooms:
            return floor
    return None


def floor_edges(doors):
    adj = defaultdict(list)
    for door in doors:
        a, b = door['a'], door['b']
        if a['gid'] not in WALL_DOORS and b['gid'] not in WALL_DOORS:
            continue
        if room_floor(a['room']) != room_floor(b['room']):
            continue
        sa, sb = a['side'], b['side']
        if sa and sb == OPP.get(sa):
            dx, dy = DELTA[sa]
            adj[a['room']].append((b['room'], dx, dy))
            adj[b['room']].append((a['room'], -dx, -dy))
        elif sa and not sb:
            dx, dy = DELTA[sa]
            adj[a['room']].append((b['room'], dx, dy))
            adj[b['room']].append((a['room'], -dx, -dy))
        elif sb and not sa:
            dx, dy = DELTA[sb]
            adj[b['room']].append((a['room'], dx, dy))
            adj[a['room']].append((b['room'], -dx, -dy))
    return adj


def nearest_free(occupied, x, y):
    if (x, y) not in occupied:
        return (x, y)
    for dist in range(1, 24):
        for dx in range(-dist, dist + 1):
            for dy in range(-dist, dist + 1):
                if abs(dx) + abs(dy) != dist:
                    continue
                cell = (x + dx, y + dy)
                if cell not in occupied:
                    return cell
    return (x + 2, y)


def layout_floor(rooms, adj, seeds):
    rooms = set(rooms)
    pos = {}
    occupied = {}
    queue = deque()
    for room, cell in seeds:
        if room not in rooms or room in pos:
            continue
        cell = nearest_free(occupied, *cell)
        pos[room] = cell
        occupied[cell] = room
        queue.append(room)
    if not pos and rooms:
        start = min(rooms)
        pos[start] = (0, 0)
        occupied[(0, 0)] = start
        queue.append(start)
    while queue:
        room = queue.popleft()
        x, y = pos[room]
        for neighbour, dx, dy in adj[room]:
            if neighbour not in rooms or neighbour in pos:
                continue
            cell = nearest_free(occupied, x + dx, y + dy)
            pos[neighbour] = cell
            occupied[cell] = neighbour
            queue.append(neighbour)
    for room in rooms:
        if room in pos:
            continue
        if pos:
            mx = max(p[0] for p in pos.values()) + 2
        else:
            mx = 0
        cell = nearest_free(occupied, mx, 0)
        pos[room] = cell
        occupied[cell] = room
    if not pos:
        return {}
    ox = min(p[0] for p in pos.values())
    oy = min(p[1] for p in pos.values())
    return {room: (x - ox, y - oy) for room, (x, y) in pos.items()}


def layout_rooms(doors):
    adj = floor_edges(doors)
    placed = {}
    layouts = {}
    # Ground first, then up and down so stairs share a cell.
    for floor in (0, 1, 2, -1, -2):
        seeds = []
        if floor == 0:
            seeds.append((0, (0, 0)))
        for upper, lower in VERTICAL:
            if room_floor(upper) == floor and lower in placed:
                seeds.append((upper, placed[lower]))
            if room_floor(lower) == floor and upper in placed:
                seeds.append((lower, placed[upper]))
        pos = layout_floor(FLOOR_ROOMS[floor], adj, seeds)
        layouts[floor] = pos
        placed.update(pos)
    return layouts


def plot_text(pixels, colour, cx, cy, text):
    width = 4 * len(text) - 1
    x0 = cx - width // 2
    y0 = cy - 2
    rows, cols = pixels.shape[:2]
    for index, char in enumerate(text):
        glyph = HEX_FONT.get(char)
        if glyph is None:
            continue
        for row, bits in enumerate(glyph):
            for col in range(3):
                if bits & (4 >> col):
                    px = x0 + index * 4 + col
                    py = y0 + row
                    if 0 <= px < cols and 0 <= py < rows:
                        pixels[py, px] = colour


def play_area(memory):
    pixels = np.zeros((PLAY, PLAY, 3), dtype=np.uint8)
    for cy in range(24):
        for cx in range(24):
            attr = memory[0x5800 + cy * 32 + cx]
            bright = 8 if attr & 0x40 else 0
            ink = PALETTE[(attr & 7) + bright]
            paper = PALETTE[((attr >> 3) & 7) + bright]
            for py in range(8):
                y = cy * 8 + py
                addr = (0x4000 + ((y & 0xC0) << 5) + ((y & 7) << 8)
                        + ((y & 0x38) << 2) + cx)
                byte = memory[addr]
                for bit in range(8):
                    pixels[y, cx * 8 + bit] = (
                        ink if byte & (0x80 >> bit) else paper)
    return pixels


def prepare_simulator(mem):
    memory = list(mem)
    memory[0x5C78] = 0x34
    memory[0x5C79] = 0x02
    memory[0x5CB0] = 0xE9
    sim = Simulator(memory, registers={'SP': 0x5E00})
    sim.run(start=START_GAME, stop=ENTER_ROOM)
    return sim


def draw_room(sim, room):
    sim.memory[PLAYER_ROOM] = room
    sim.run(start=ENTER_ROOM, stop=AFTER_FRAME)
    sim.run(start=MAIN_LOOP, stop=AFTER_ITEMS)
    return play_area(sim.memory)


def canvas_size(layouts):
    sizes = {}
    for floor in FLOOR_ORDER:
        pos = layouts[floor]
        sizes[floor] = (
            max(p[0] for p in pos.values()) + 1,
            max(p[1] for p in pos.values()) + 1,
        )
    width = max(w for w, _h in sizes.values())
    pw = width * CELL + PAD * 2
    origins = {}
    y = PAD
    for floor in FLOOR_ORDER:
        origins[floor] = y + TITLE_H
        _w, h = sizes[floor]
        y += TITLE_H + h * CELL + FLOOR_GAP
    return pw, y + PAD, origins


def simulate_rooms(mem):
    doors = parse_doors(mem)
    layouts = layout_rooms(doors)
    pw, ph, origins = canvas_size(layouts)
    print('simulate rooms', ROOM_COUNT, flush=True)
    sim = prepare_simulator(mem)
    rooms = []
    for floor in FLOOR_ORDER:
        pos = layouts[floor]
        top = origins[floor]
        for room, (gx, gy) in pos.items():
            room_px = draw_room(sim, room)
            plot_text(
                room_px, (255, 255, 255),
                PLAY // 2, PLAY - 10,
                '%02X' % room,
            )
            rooms.append((PAD + gx * CELL, top + gy * CELL, room_px))
        print('  floor', FLOOR_NAME[floor], len(pos), 'rooms', flush=True)
    del sim
    titles = [
        (PAD, origins[floor] - TITLE_H + 4, FLOOR_NAME[floor])
        for floor in FLOOR_ORDER
    ]
    return rooms, titles, pw, ph


def blit(dst, src, dx, dy):
    dh, dw = dst.shape[:2]
    sh, sw = src.shape[:2]
    x0 = max(0, dx)
    y0 = max(0, dy)
    x1 = min(dw, dx + sw)
    y1 = min(dh, dy + sh)
    if x0 >= x1 or y0 >= y1:
        return
    sx = x0 - dx
    sy = y0 - dy
    dst[y0:y1, x0:x1] = src[sy:sy + (y1 - y0), sx:sx + (x1 - x0)]


def scale_room(pixels, scale):
    if scale == 1:
        return pixels
    return np.repeat(np.repeat(pixels, scale, axis=0), scale, axis=1)


def write_max_level(rooms, titles, width, height, level_dir, scale,
                    tile_size):
    placed = [
        (x * scale, y * scale, scale_room(pixels, scale))
        for x, y, pixels in rooms
    ]
    cols = math.ceil(width / tile_size)
    rows = math.ceil(height / tile_size)
    written = 0
    for ty in range(rows):
        for tx in range(cols):
            ox = tx * tile_size
            oy = ty * tile_size
            tw = min(tile_size, width - ox)
            th = min(tile_size, height - oy)
            tile = np.zeros((th, tw, 3), dtype=np.uint8)
            for rx, ry, pixels in placed:
                blit(tile, pixels, rx - ox, ry - oy)
            image = Image.fromarray(tile, mode='RGB')
            draw = ImageDraw.Draw(image)
            for tx0, ty0, name in titles:
                draw.text(
                    (tx0 * scale - ox, ty0 * scale - oy),
                    name,
                    fill=(255, 255, 0),
                )
            image.save(
                os.path.join(level_dir, '%d_%d.png' % (tx, ty)),
                format='PNG',
                compress_level=6,
            )
            written += 1
    del placed
    return written, cols * rows


def write_lower_level(files_dir, parent, level, lw, lh, plw, plh, tile_size):
    level_dir = os.path.join(files_dir, str(level))
    parent_dir = os.path.join(files_dir, str(parent))
    os.makedirs(level_dir, exist_ok=True)
    cols = math.ceil(lw / tile_size)
    rows = math.ceil(lh / tile_size)
    written = 0
    for ty in range(rows):
        for tx in range(cols):
            ox = tx * tile_size
            oy = ty * tile_size
            tw = min(tile_size, lw - ox)
            th = min(tile_size, lh - oy)
            sx, sy = ox * 2, oy * 2
            sw, sh = min(tw * 2, plw - sx), min(th * 2, plh - sy)
            source = Image.new('RGB', (sw, sh))
            ptx0, pty0 = sx // tile_size, sy // tile_size
            ptx1 = (sx + sw - 1) // tile_size
            pty1 = (sy + sh - 1) // tile_size
            for pty in range(pty0, pty1 + 1):
                for ptx in range(ptx0, ptx1 + 1):
                    parent_tile = Image.open(
                        os.path.join(parent_dir, '%d_%d.png' % (ptx, pty)))
                    source.paste(
                        parent_tile,
                        (ptx * tile_size - sx, pty * tile_size - sy),
                    )
            source.resize((tw, th), Image.Resampling.NEAREST).save(
                os.path.join(level_dir, '%d_%d.png' % (tx, ty)),
                format='PNG',
                compress_level=6,
            )
            written += 1
    return written, cols * rows


def write_dzi(rooms, titles, pw, ph, dest, scale=SCALE, tile_size=TILE_SIZE):
    width, height = pw * scale, ph * scale
    max_level = math.ceil(math.log2(max(width, height)))
    name = 'castle-map'
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

    lw, lh = width, height
    level_dir = os.path.join(files_dir, str(max_level))
    os.makedirs(level_dir, exist_ok=True)
    written, tiles = write_max_level(
        rooms, titles, lw, lh, level_dir, scale, tile_size)
    print('  level %d %dx%d (%d tiles)' % (max_level, lw, lh, tiles),
          flush=True)
    for level in range(max_level - 1, -1, -1):
        plw, plh = lw, lh
        lw = math.ceil(lw / 2)
        lh = math.ceil(lh / 2)
        count, tiles = write_lower_level(
            files_dir, level + 1, level, lw, lh, plw, plh, tile_size)
        written += count
        print('  level %d %dx%d (%d tiles)' % (level, lw, lh, tiles),
              flush=True)
    return written


def write_preview(rooms, titles, pw, ph, path, scale):
    half = max(1, scale // 2)
    width, height = pw * half, ph * half
    pixels = np.zeros((height, width, 3), dtype=np.uint8)
    for x, y, room_px in rooms:
        blit(pixels, scale_room(room_px, half), x * half, y * half)
    image = Image.fromarray(pixels, mode='RGB')
    draw = ImageDraw.Draw(image)
    for tx0, ty0, name in titles:
        draw.text((tx0 * half, ty0 * half), name, fill=(255, 255, 0))
    image.save(path)


def copy_output(src, dest):
    os.makedirs(dest, exist_ok=True)
    for name in ('castle-map.dzi', 'castle-map_files'):
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
    leftover = os.path.join(dest, 'castle-map.png')
    if os.path.isfile(leftover):
        os.remove(leftover)


def main(argv):
    parser = argparse.ArgumentParser(
        description='Render the Atic Atac castle Deep Zoom map.')
    parser.add_argument('snapshot', help='Atic Atac Z80/SNA snapshot')
    parser.add_argument('dest', nargs='+',
                        help='HTML images directory (repeat to copy)')
    parser.add_argument('--scale', type=int, default=SCALE)
    parser.add_argument('--preview', help='Write a downscaled PNG as well')
    args = parser.parse_args(argv)

    print('snapshot', args.snapshot, flush=True)
    mem = get_snapshot(args.snapshot)
    print('paint scale', args.scale, flush=True)
    rooms, titles, pw, ph = simulate_rooms(mem)
    print('image', pw * args.scale, 'x', ph * args.scale, flush=True)
    dests = [os.path.abspath(path) for path in args.dest]
    os.makedirs(dests[0], exist_ok=True)
    leftover = os.path.join(dests[0], 'castle-map.png')
    if os.path.isfile(leftover):
        os.remove(leftover)
    print('tiles', dests[0], flush=True)
    written = write_dzi(rooms, titles, pw, ph, dests[0], scale=args.scale)
    for extra in dests[1:]:
        print('copy', extra, flush=True)
        copy_output(dests[0], extra)
    if args.preview:
        write_preview(rooms, titles, pw, ph, args.preview, args.scale)
        print('preview', args.preview, flush=True)
    print('wrote', written, 'tiles', flush=True)


if __name__ == '__main__':
    main(sys.argv[1:])
