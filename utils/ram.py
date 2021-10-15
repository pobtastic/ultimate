# Copyright 2021 Paul Maddern
#
# This program is free software: you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free Software
# Foundation, either version 3 of the License, or (at your option) any later
# version.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
# details.
#
# You should have received a copy of the GNU General Public License along with
# this program. If not, see <http://www.gnu.org/licenses/>.

def rrd(snapshot, start, end):
	reg_a = 0x00
	for addr in range(start, end):
		reg_hl = snapshot[addr]
		a1 = reg_a & 0xF0
		a2 = reg_a & 0x0F
		b1 = (reg_hl & 0xF0) >> 4
		b2 = reg_hl & 0x0F
		byte = (a2 << 4) + b1
		snapshot[addr] = byte
		reg_a = a1 + b2

def decrypt_aticatac(snapshot):
	rrd(snapshot, 0x5FFF, 0xDBFF)

def decrypt_lunarjetman(snapshot):
	rrd(snapshot, 0x7FFF, 0xFBFF)
