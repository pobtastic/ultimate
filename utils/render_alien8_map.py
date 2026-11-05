#!/usr/bin/env python3
# Copyright 2026 Paul Maddern (paul@arcadegeek.co.uk)
"""Render Alien 8's rooms as an OpenSeadragon Deep Zoom image.

Reads the room data from a snapshot, expands the fixtures and objects
the same way #R$CCA7 does, and paints them in isometric world space
with the game's sprites. Writes station-map.dzi plus PNG tiles.
"""
import argparse
import math
import os
import shutil
import sys

from PIL import Image
from skoolkit.snapshot import get_snapshot

SCALE = 2
TILE_SIZE = 512
PAD = 48
# Pitch that makes an east door at #N$C5 sit on the west door at #N$3B
# of the next room (and the same for north/south).
SPAN = 0xC5 - 0x3B
ORIGIN = 0x40
NORTH = 0xC0
UPDATE_ROUTINES = 0xA7EA

ROOM_DATA = 0x6469
ROOM_DATA_END = 0x73C8
ROOM_SIZES = 0x6460
OBJECT_TYPES = 0x73C8
SECOND_TYPES = 0x7408
BLOCK_TYPES = 0x7519
SPRITE_TABLE = 0x7827
SPECIAL_OBJECTS = 0x76E3
SPECIAL_COUNT = 0x24
SPECIAL_SPRITE = 0x60

# North and west wall fixtures hide the objects in the room.
WALL_TYPES = frozenset((0x04, 0x05, 0x06, 0x07, 0x08, 0x09))
WALL_SPRITES = frozenset((0x0D, 0x0E, 0x0F))
# Door fixtures leave a gap in the ground outline (see #R$7519).
DOOR_NORTH = frozenset((0x00,))
DOOR_EAST = frozenset((0x01, 0x0A))
DOOR_SOUTH = frozenset((0x02, 0x0B))
DOOR_WEST = frozenset((0x03,))
TALL_EAST = 0x0A
TALL_SOUTH = 0x0B
DOOR_FLOOR_Z = 0x40
DOOR_TALL_Z = 0x70
DOOR_GAP = (0x70, 0x90)
ROOM_MID = 0x80
# The second part of a robot mouse sits #N$0C lower (see #R$B1E5).
MOUSE_BASE = 0x0B
MOUSE_BASE_Z = 0x0C

def signed_byte(value):
    return value - 256 if value > 127 else value


# #REGl is the x offset, #REGh the y offset (see #R$BF3D).
PIXEL_ADJUSTMENTS = {
    0xBF3D: (0xF0, 0xF7),
    0xBF42: (0xF4, 0xF7),
    0xBF47: (0xF4, 0xF8),
    0xBF4C: (0xF0, 0xF9),
    0xBF51: (0xF4, 0xF9),
    0xBF56: (0xF0, 0xFA),
    0xBF5B: (0xF4, 0xFA),
    0xBF60: (0xF4, 0xFB),
    0xBF65: (0xF8, 0xFB),
    0xBF6A: (0xF4, 0xFC),
    0xBF6F: (0xF0, 0xFD),
    0xBF74: (0xFC, 0xFD),
    0xBF7E: (0xF8, 0xFE),
}

# Near and far arches pick a pair from the flip flag (see #R$BFEA / #R$BFD8).
ARCH_NEAR = {
    False: (0xFA, 0xF9),
    True: (0xF6, 0xFA),
}
ARCH_FAR = {
    False: (0xF0, 0xFB),
    True: (0xF8, 0xFC),
}

# Bright Spectrum inks.
INK = [
    (0, 0, 0),
    (0, 0, 255),
    (255, 0, 0),
    (255, 0, 255),
    (0, 255, 0),
    (0, 255, 255),
    (255, 255, 0),
    (255, 255, 255),
]


def word(mem, addr):
    return mem[addr] | (mem[addr + 1] << 8)


def pixel_adjustment(mem, sprite, flip_h):
    if sprite == 0x02:
        pair = ARCH_NEAR[flip_h]
        return signed_byte(pair[0]), signed_byte(pair[1])
    if sprite == 0x03:
        pair = ARCH_FAR[flip_h]
        return signed_byte(pair[0]), signed_byte(pair[1])
    handler = word(mem, UPDATE_ROUTINES + sprite * 2)
    target = handler
    if mem[handler] == 0xCD or mem[handler] == 0xC3:
        target = word(mem, handler + 1)
    pair = PIXEL_ADJUSTMENTS.get(handler) or PIXEL_ADJUSTMENTS.get(target)
    if pair is None:
        pair = PIXEL_ADJUSTMENTS[0xBF3D]
    return signed_byte(pair[0]), signed_byte(pair[1])


def room_sizes(mem, size):
    base = ROOM_SIZES + (size % 3) * 3
    return mem[base], mem[base + 1], mem[base + 2]


def read_block_template(mem, addr):
    objects = []
    while mem[addr]:
        objects.append({
            'sprite': mem[addr],
            'x': mem[addr + 1],
            'y': mem[addr + 2],
            'z': mem[addr + 3],
            'flags': mem[addr + 7],
        })
        addr += 8
    return objects


def read_object_template(mem, addr):
    parts = []
    while mem[addr]:
        parts.append({
            'sprite': mem[addr],
            'flags': mem[addr + 4],
        })
        addr += 5
    return parts


def place_xyz(place, offset, floor):
    half_x = 8 if offset & 1 else 0
    half_y = 8 if offset & 2 else 0
    x = ((place & 7) << 4) + half_x + 0x48
    y = (((place >> 3) & 7) << 4) + half_y + 0x48
    z = (((offset + ((place >> 6) & 3) * 12) & 0xFC) + floor)
    return x, y, z


def parse_rooms(mem):
    rooms = {}
    addr = ROOM_DATA
    while addr < ROOM_DATA_END:
        number = mem[addr]
        length = mem[addr + 1]
        if length < 2:
            break
        colour_size = mem[addr + 2]
        body = list(mem[addr + 3:addr + 1 + length])
        fixtures = []
        index = 0
        while index < len(body) and body[index] != 0xFF:
            fixtures.append(body[index])
            index += 1
        groups = []
        if index < len(body) and body[index] == 0xFF:
            index += 1
            while index < len(body):
                typ_count = body[index]
                index += 1
                typ = typ_count >> 3
                count = (typ_count & 7) + 1
                places = []
                for _ in range(count):
                    if index >= len(body):
                        break
                    places.append(body[index])
                    index += 1
                groups.append((typ, places))
        rooms[number] = {
            'colour': (colour_size >> 3) & 7,
            'size': colour_size >> 6,
            'fixtures': fixtures,
            'groups': groups,
        }
        addr += 1 + length
    return rooms


def neighbour(number, side):
    if side == 'E':
        return (number & 0xF0) | ((number + 1) & 0x0F)
    if side == 'W':
        return (number & 0xF0) | ((number - 1) & 0x0F)
    if side == 'N':
        return (number + 0x10) & 0xFF
    return (number - 0x10) & 0xFF


def door_height(fixtures, side):
    kinds = set(fixtures)
    if side == 'N':
        return DOOR_FLOOR_Z if kinds & DOOR_NORTH else None
    if side == 'W':
        return DOOR_FLOOR_Z if kinds & DOOR_WEST else None
    if side == 'E':
        if TALL_EAST in kinds:
            return DOOR_TALL_Z
        if kinds & DOOR_EAST:
            return DOOR_FLOOR_Z
        return None
    if TALL_SOUTH in kinds:
        return DOOR_TALL_Z
    if kinds & DOOR_SOUTH:
        return DOOR_FLOOR_Z
    return None


def room_levels(rooms):
    # A tall door is #N$30 above a floor-level arch. Raise the room
    # beyond it so the two doorways meet (see #R$7557 / #R$758A).
    opposite = {'N': 'S', 'S': 'N', 'E': 'W', 'W': 'E'}
    links = {number: [] for number in rooms}
    for number, room in rooms.items():
        for side in ('N', 'E', 'S', 'W'):
            here = door_height(room['fixtures'], side)
            if here is None:
                continue
            other = neighbour(number, side)
            if other not in rooms:
                continue
            there = door_height(rooms[other]['fixtures'], opposite[side])
            if there is None:
                continue
            links[number].append((other, here - there, here != there))

    levels = {}
    for start in rooms:
        if start in levels:
            continue
        if not any(tall for _other, _delta, tall in links[start]):
            continue
        levels[start] = 0
        stack = [start]
        while stack:
            number = stack.pop()
            for other, delta, tall in links[number]:
                if not tall or other in levels:
                    continue
                levels[other] = levels[number] + delta
                stack.append(other)
    stack = list(levels)
    while stack:
        number = stack.pop()
        for other, delta, _tall in links[number]:
            if other in levels:
                continue
            levels[other] = levels[number] + delta
            stack.append(other)
    for number in rooms:
        if number not in levels:
            levels[number] = 0
    lowest = min(levels.values())
    return {number: value - lowest for number, value in levels.items()}


def expand_room(mem, number, room):
    _size_x, _size_y, floor = room_sizes(mem, room['size'])
    objects = []
    for fixture in room['fixtures']:
        if fixture in WALL_TYPES:
            continue
        template = word(mem, BLOCK_TYPES + fixture * 2)
        for part in read_block_template(mem, template):
            if part['sprite'] in WALL_SPRITES:
                continue
            objects.append(part)
    table = OBJECT_TYPES
    offset = 0
    for typ, places in room['groups']:
        if typ == 0x00:
            if places:
                offset = places[0]
            continue
        if typ == 0x1F:
            table = SECOND_TYPES
            continue
        template = word(mem, table + typ * 2)
        parts = read_object_template(mem, template)
        for place in places:
            x, y, z = place_xyz(place, offset, floor)
            for part in parts:
                if part['sprite'] in WALL_SPRITES:
                    continue
                part_z = z
                if part['sprite'] == MOUSE_BASE:
                    part_z -= MOUSE_BASE_Z
                objects.append({
                    'sprite': part['sprite'],
                    'x': x,
                    'y': y,
                    'z': part_z,
                    'flags': part['flags'],
                })
    return objects


def special_objects(mem, rooms):
    objects = []
    for index in range(SPECIAL_COUNT):
        entry = SPECIAL_OBJECTS + index * 9
        x, y, z, number = mem[entry + 1:entry + 5]
        if number not in rooms:
            continue
        objects.append((number, {
            'sprite': SPECIAL_SPRITE,
            'x': x,
            'y': y,
            'z': z,
            'flags': 0,
        }))
    return objects


def sprite_pixels(mem, sprite, flip_h=False, cache=None):
    key = (sprite, flip_h)
    if cache is not None and key in cache:
        return cache[key]
    ptr = word(mem, SPRITE_TABLE + sprite * 2)
    width = mem[ptr] & 0x0F
    height = mem[ptr + 1]
    if width == 0 or height == 0:
        pixels = None
    else:
        data = ptr + 2
        pixels = []
        for _row in range(height):
            mask_bits = []
            data_bits = []
            for _col in range(width):
                mask = mem[data]
                data += 1
                byte = mem[data]
                data += 1
                for bit in range(8):
                    mask_bits.append(bool(mask & (0x80 >> bit)))
                    data_bits.append(bool(byte & (0x80 >> bit)))
            if flip_h:
                mask_bits.reverse()
                data_bits.reverse()
            pixels.append((mask_bits, data_bits))
        pixels.reverse()
    if cache is not None:
        cache[key] = pixels
    return pixels


def world_xy(number, x, y, max_row):
    col = number & 0x0F
    row = number >> 4
    wx = col * SPAN + (x - ORIGIN)
    wy = (max_row - row) * SPAN + (NORTH - y)
    return wx, wy


def draw_depth(wx, wy, z):
    # On this map east is down-right and south is down-left, so the
    # front of the view is the bottom-right of the page. Draw the
    # back (north-west) first and the front last.
    return (wx + wy, wx - wy, z)


def project(wx, wy, z):
    return wx - wy, (wx + wy) // 2 - z


def room_rect(mem, size):
    size_x, size_y, floor = room_sizes(mem, size)
    return (
        ROOM_MID - size_x,
        ROOM_MID + size_x,
        ROOM_MID - size_y,
        ROOM_MID + size_y,
        floor,
    )


def door_sides(fixtures):
    kinds = set(fixtures)
    return {
        'N': bool(kinds & DOOR_NORTH),
        'E': bool(kinds & DOOR_EAST),
        'S': bool(kinds & DOOR_SOUTH),
        'W': bool(kinds & DOOR_WEST),
    }


def split_range(start, end, has_door):
    if not has_door:
        return [(start, end)]
    lo, hi = DOOR_GAP
    parts = []
    if start < lo:
        parts.append((start, min(lo, end)))
    if hi < end:
        parts.append((max(hi, start), end))
    return [(a, b) for a, b in parts if a < b]


def outline_edges(west, east, south, north, doors):
    edges = []
    for x0, x1 in split_range(west, east, doors['S']):
        edges.append(((x0, south), (x1, south)))
    for x0, x1 in split_range(west, east, doors['N']):
        edges.append(((x0, north), (x1, north)))
    for y0, y1 in split_range(south, north, doors['W']):
        edges.append(((west, y0), (west, y1)))
    for y0, y1 in split_range(south, north, doors['E']):
        edges.append(((east, y0), (east, y1)))
    return edges


def line_pixels(x0, y0, x1, y1):
    dx = abs(x1 - x0)
    dy = abs(y1 - y0)
    sx = 1 if x0 < x1 else -1
    sy = 1 if y0 < y1 else -1
    err = dx - dy
    x, y = x0, y0
    while True:
        yield x, y
        if x == x1 and y == y1:
            return
        e2 = err * 2
        if e2 > -dy:
            err -= dy
            x += sx
        if e2 < dx:
            err += dx
            y += sy


def draw_line(image, colour, x0, y0, x1, y1):
    width, height = image.size
    for x, y in line_pixels(x0, y0, x1, y1):
        if 0 <= x < width and 0 <= y < height:
            image.putpixel((x, y), colour)


def blit(image, colour, px, py, pixels):
    if not pixels:
        return
    width, height = image.size
    sprite_h = len(pixels)
    x0 = px
    y0 = py - sprite_h + 1
    for row, (mask_bits, data_bits) in enumerate(pixels):
        iy = y0 + row
        if iy < 0 or iy >= height:
            continue
        for col, cover in enumerate(mask_bits):
            ix = x0 + col
            if ix < 0 or ix >= width:
                continue
            if cover:
                image.putpixel((ix, iy), (0, 0, 0))
            if data_bits[col]:
                image.putpixel((ix, iy), colour)


def outline_segments(mem, rooms, max_row, levels):
    segments = []
    for number, room in rooms.items():
        west, east, south, north, floor = room_rect(mem, room['size'])
        floor += levels[number]
        doors = door_sides(room['fixtures'])
        colour = INK[room['colour']]
        for (x0, y0), (x1, y1) in outline_edges(west, east, south, north,
                                                doors):
            wx0, wy0 = world_xy(number, x0, y0, max_row)
            wx1, wy1 = world_xy(number, x1, y1, max_row)
            sx0, sy0 = project(wx0, wy0, floor)
            sx1, sy1 = project(wx1, wy1, floor)
            segments.append((sx0, sy0, sx1, sy1, colour))
    return segments


def paint_map(mem, scale=SCALE):
    rooms = parse_rooms(mem)
    if not rooms:
        raise SystemExit('no rooms found in the snapshot')
    max_row = max(number >> 4 for number in rooms)
    levels = room_levels(rooms)
    cache = {}
    drawn = []
    for number, room in rooms.items():
        colour = INK[room['colour']]
        deck = levels[number]
        for obj in expand_room(mem, number, room):
            z = obj['z'] + deck
            wx, wy = world_xy(number, obj['x'], obj['y'], max_row)
            sx, sy = project(wx, wy, z)
            flip_h = bool(obj['flags'] & 0x40)
            adj_x, adj_y = pixel_adjustment(mem, obj['sprite'], flip_h)
            sx += adj_x
            sy -= adj_y
            depth = draw_depth(wx, wy, z)
            drawn.append((sx, sy, depth, colour, obj))
    for number, obj in special_objects(mem, rooms):
        z = obj['z'] + levels[number]
        wx, wy = world_xy(number, obj['x'], obj['y'], max_row)
        sx, sy = project(wx, wy, z)
        flip_h = bool(obj['flags'] & 0x40)
        adj_x, adj_y = pixel_adjustment(mem, obj['sprite'], flip_h)
        sx += adj_x
        sy -= adj_y
        depth = draw_depth(wx, wy, z)
        drawn.append((sx, sy, depth, INK[rooms[number]['colour']], obj))

    drawn.sort(key=lambda item: item[2])
    outlines = outline_segments(mem, rooms, max_row, levels)
    sizes = []
    for sx, sy, _depth, _colour, obj in drawn:
        pixels = sprite_pixels(mem, obj['sprite'], bool(obj['flags'] & 0x40),
                               cache)
        if not pixels:
            continue
        width = len(pixels[0][0])
        height = len(pixels)
        sizes.append((sx, sy - height + 1, sx + width, sy + 1))
    for sx0, sy0, sx1, sy1, _colour in outlines:
        sizes.append((
            min(sx0, sx1),
            min(sy0, sy1),
            max(sx0, sx1) + 1,
            max(sy0, sy1) + 1,
        ))
    if not sizes:
        raise SystemExit('no sprites to draw')
    minx = min(box[0] for box in sizes) - PAD
    miny = min(box[1] for box in sizes) - PAD
    maxx = max(box[2] for box in sizes) + PAD
    maxy = max(box[3] for box in sizes) + PAD
    image = Image.new('RGB', (maxx - minx, maxy - miny), (0, 0, 0))
    for sx0, sy0, sx1, sy1, colour in outlines:
        draw_line(image, colour, sx0 - minx, sy0 - miny, sx1 - minx,
                  sy1 - miny)
    for sx, sy, _depth, colour, obj in drawn:
        pixels = sprite_pixels(mem, obj['sprite'], bool(obj['flags'] & 0x40),
                               cache)
        blit(image, colour, sx - minx, sy - miny, pixels)
    if scale == 1:
        return image
    width, height = image.size
    return image.resize((width * scale, height * scale), Image.Resampling.NEAREST)


def write_dzi(image, dest, tile_size=TILE_SIZE):
    width, height = image.size
    max_level = math.ceil(math.log2(max(width, height)))
    name = 'station-map'
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
    for name in ('station-map.dzi', 'station-map_files'):
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
    leftover = os.path.join(dest, 'station-map.png')
    if os.path.isfile(leftover):
        os.remove(leftover)


def main(argv):
    parser = argparse.ArgumentParser(
        description='Render the Alien 8 station Deep Zoom map.')
    parser.add_argument('snapshot', help='Alien 8 Z80/SNA snapshot')
    parser.add_argument('dest', nargs='+',
                        help='HTML images directory (repeat to copy)')
    parser.add_argument('--scale', type=int, default=SCALE)
    parser.add_argument('--png', help='Also write a single preview PNG')
    args = parser.parse_args(argv)

    print('snapshot', args.snapshot, flush=True)
    mem = get_snapshot(args.snapshot)
    print('paint scale', args.scale, flush=True)
    image = paint_map(mem, scale=args.scale)
    print('image', image.size[0], 'x', image.size[1], flush=True)
    if args.png:
        image.save(args.png, format='PNG', compress_level=6)
        print('png', args.png, flush=True)
    dests = [os.path.abspath(path) for path in args.dest]
    os.makedirs(dests[0], exist_ok=True)
    leftover = os.path.join(dests[0], 'station-map.png')
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
