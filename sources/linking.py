# Copyright 2023 Paul Maddern
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

from skoolkit.skoolhtml import HtmlWriter
from skoolkit.skoolmacro import parse_r

class UltimateHtmlWriter(HtmlWriter):
	def init(self):
		self._type = 'asm' if self.base == 16 else 'dec/asm'

	def expand_aticatac(self, text, index, cwd):
		# #ATICATACaddress[#anchor][(link text)]
		end, addr_str, address, code_id, anchor, link_text = parse_r(self.fields, text, index)
		if not link_text:
			link_text = "Atic Atac"
		href = self._asm_relpath(cwd, address, code_id, True)
		return end, self.format_link(f"/ultimate/aticatac/{self._type}/{href}", link_text)

	def expand_cookie(self, text, index, cwd):
		# #COOKIEaddress[#anchor][(link text)]
		end, addr_str, address, code_id, anchor, link_text = parse_r(self.fields, text, index)
		if not link_text:
			link_text = "Cookie"
		href = self._asm_relpath(cwd, address, code_id, True)
		return end, self.format_link(f"/ultimate/cookie/{self._type}/{href}", link_text)

	def expand_jetpac(self, text, index, cwd):
		# #JETPACaddress[#anchor][(link text)]
		end, addr_str, address, code_id, anchor, link_text = parse_r(self.fields, text, index)
		if not link_text:
			link_text = "Jetpac"
		href = self._asm_relpath(cwd, address, code_id, True)
		return end, self.format_link(f"/ultimate/jetpac/{self._type}/{href}", link_text)

	def expand_knightlore(self, text, index, cwd):
		# #KNIGHTLOREaddress[#anchor][(link text)]
		end, addr_str, address, code_id, anchor, link_text = parse_r(self.fields, text, index)
		if not link_text:
			link_text = "Knight Lore"
		href = self._asm_relpath(cwd, address, code_id, True)
		return end, self.format_link(f"/ultimate/knightlore/{self._type}/{href}", link_text)

	def expand_lunarjetman(self, text, index, cwd):
		# #LUNARJETMANaddress[#anchor][(link text)]
		end, addr_str, address, code_id, anchor, link_text = parse_r(self.fields, text, index)
		if not link_text:
			link_text = "Lunar Jetman"
		href = self._asm_relpath(cwd, address, code_id, True)
		return end, self.format_link(f"/ultimate/lunarjetman/{self._type}/{href}", link_text)

	def expand_pssst(self, text, index, cwd):
		# #PSSSTaddress[#anchor][(link text)]
		end, addr_str, address, code_id, anchor, link_text = parse_r(self.fields, text, index)
		if not link_text:
			link_text = "Pssst"
		href = self._asm_relpath(cwd, address, code_id, True)
		return end, self.format_link(f"/ultimate/pssst/{self._type}/{href}", link_text)

	def expand_sabrewulf(self, text, index, cwd):
		# #SABREWULFaddress[#anchor][(link text)]
		end, addr_str, address, code_id, anchor, link_text = parse_r(self.fields, text, index)
		if not link_text:
			link_text = "Sabre Wulf"
		href = self._asm_relpath(cwd, address, code_id, True)
		return end, self.format_link(f"/ultimate/sabrewulf/{self._type}/{href}", link_text)

	def expand_tranzam(self, text, index, cwd):
		# #TRANZAMaddress[#anchor][(link text)]
		end, addr_str, address, code_id, anchor, link_text = parse_r(self.fields, text, index)
		if not link_text:
			link_text = "Tranz Am"
		href = self._asm_relpath(cwd, address, code_id, True)
		return end, self.format_link(f"/ultimate/tranzam/{self._type}/{href}", link_text)

	def expand_underwurlde(self, text, index, cwd):
		# #UNDERWURLDEaddress[#anchor][(link text)]
		end, addr_str, address, code_id, anchor, link_text = parse_r(self.fields, text, index)
		if not link_text:
			link_text = "Underwurlde"
		href = self._asm_relpath(cwd, address, code_id, True)
		return end, self.format_link(f"/ultimate/underwurlde/{self._type}/{href}", link_text)
