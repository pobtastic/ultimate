# Copyright 2026 Paul Maddern (paul@arcadegeek.co.uk)
BUILDDIR = build

OPTIONS  = -d build/html -t

OPTIONS += $(foreach theme,$(THEMES),-T $(theme))
OPTIONS += $(HTML_OPTS)

.PHONY: usage clean alien8 aticatac bubbler cookie cyberun gunfright jetpac knightlore lunarjetman martianoids nightshade pentagram pssst sabrewulf tranzam underwurlde
usage:
	@echo "Targets:"
	@echo "  usage         show this help"
	@echo "  alien8        build the Alien 8 disassembly"
	@echo "  aticatac      build the Atic Atac disassembly"
	@echo "  bubbler       build the Bubbler disassembly"
	@echo "  cookie        build the Cookie disassembly"
	@echo "  cyberun       build the Cyberun disassembly"
	@echo "  gunfright     build the Gunfright disassembly"
	@echo "  jetpac        build the Jetpac disassembly"
	@echo "  knightlore    build the Knight Lore disassembly"
	@echo "  lunarjetman   build the Lunar Jetman disassembly"
	@echo "  martianoids   build the Martianoids disassembly"
	@echo "  nightshade    build the Nightshade disassembly"
	@echo "  pentagram     build the Pentagram disassembly"
	@echo "  pssst         build the Psssst disassembly"
	@echo "  sabrewulf     build the Sabre Wulf disassembly"
	@echo "  tranzam       build the Tranz Am disassembly"
	@echo "  underwurlde   build the Underwurlde disassembly"
	@echo ""
	@echo "Variables:"
	@echo "  THEMES     CSS theme(s) to use"
	@echo "  HTML_OPTS  options passed to skool2html.py"

.PHONY: clean
clean:
	-rm -rf $(BUILDDIR)/*

.PHONY: alien8
alien8:
	if [ ! -f Alien8.z80 ]; then tap2sna.py @alien8.t2s; fi
	sna2skool.py -H --ini ListRefs=2 -c sources/alien8/alien8.ctl Alien8.z80 > sources/alien8/alien8.skool
	skool2html.py $(OPTIONS) -D -c Config/GameDir=ultimate/alien8/dec --var pub=4 -c Config/InitModule=$(SKOOLKIT_HOME)/tools:publish sources/alien8/alien8.skool sources/alien8/alien8.ref
	skool2html.py $(OPTIONS) -H -c Config/GameDir=ultimate/alien8 --var pub=2 -c Config/InitModule=$(SKOOLKIT_HOME)/tools:publish sources/alien8/alien8.skool sources/alien8/alien8.ref
	python3 utils/compress_pngs.py $(BUILDDIR)/html/ultimate/alien8
	python3 utils/render_alien8_map.py Alien8.z80 \
	  $(BUILDDIR)/html/ultimate/alien8/images \
	  $(BUILDDIR)/html/ultimate/alien8/dec/images

.PHONY: aticatac
aticatac:
	if [ ! -f AticAtac.z80 ]; then tap2sna.py @aticatac.t2s; fi
	sna2skool.py -H --ini ListRefs=2 -c sources/aticatac/aticatac.ctl AticAtac.z80 > sources/aticatac/aticatac.skool
	skool2html.py $(OPTIONS) -D -c Config/GameDir=ultimate/aticatac/dec --var pub=4 -c Config/InitModule=$(SKOOLKIT_HOME)/tools:publish sources/aticatac/aticatac.skool sources/aticatac/aticatac.skool sources/aticatac/aticatac.ref
	skool2html.py $(OPTIONS) -H -c Config/GameDir=ultimate/aticatac --var pub=2 -c Config/InitModule=$(SKOOLKIT_HOME)/tools:publish sources/aticatac/aticatac.skool sources/aticatac/aticatac.skool sources/aticatac/aticatac.ref
	python3 utils/compress_pngs.py $(BUILDDIR)/html/ultimate/aticatac
	python3 utils/render_aticatac_map.py AticAtac.z80 \
	  $(BUILDDIR)/html/ultimate/aticatac/images \
	  $(BUILDDIR)/html/ultimate/aticatac/dec/images

.PHONY: bubbler
bubbler:
	if [ ! -f Bubbler.z80 ]; then tap2sna.py @bubbler.t2s; fi
	sna2skool.py -H --ini ListRefs=2 -c sources/bubbler/bubbler.ctl Bubbler.z80 > sources/bubbler/bubbler.skool
	skool2html.py $(OPTIONS) -D -c Config/GameDir=ultimate/bubbler/dec --var pub=4 -c Config/InitModule=$(SKOOLKIT_HOME)/tools:publish sources/bubbler/bubbler.skool sources/bubbler/bubbler.ref
	skool2html.py $(OPTIONS) -H -c Config/GameDir=ultimate/bubbler --var pub=2 -c Config/InitModule=$(SKOOLKIT_HOME)/tools:publish sources/bubbler/bubbler.skool sources/bubbler/bubbler.ref
	python3 utils/compress_pngs.py $(BUILDDIR)/html/ultimate/bubbler

.PHONY: cookie
cookie:
	if [ ! -f Cookie.z80 ]; then tap2sna.py @cookie.t2s; fi
	sna2skool.py -H --ini ListRefs=2 -c sources/cookie/cookie.ctl Cookie.z80 > sources/cookie/cookie.skool
	skool2html.py $(OPTIONS) -D -c Config/GameDir=ultimate/cookie/dec --var pub=4 -c Config/InitModule=$(SKOOLKIT_HOME)/tools:publish sources/cookie/cookie.skool sources/cookie/cookie.skool sources/cookie/cookie.ref
	skool2html.py $(OPTIONS) -H -c Config/GameDir=ultimate/cookie --var pub=2 -c Config/InitModule=$(SKOOLKIT_HOME)/tools:publish sources/cookie/cookie.skool sources/cookie/cookie.skool sources/cookie/cookie.ref
	python3 utils/compress_pngs.py $(BUILDDIR)/html/ultimate/cookie

.PHONY: cyberun
cyberun:
	if [ ! -f Cyberun.z80 ]; then tap2sna.py @cyberun.t2s; fi
	if [ ! -f CyberunLoader.z80 ]; then tap2sna.py @cyberun-loader.t2s; fi
	sna2skool.py -H --ini ListRefs=2 -c sources/cyberun/cyberun.ctl Cyberun.z80 > sources/cyberun/cyberun.skool
	sna2skool.py -H --ini ListRefs=2 -c sources/cyberun/loader.ctl CyberunLoader.z80 > sources/cyberun/loader.skool
	skool2html.py $(OPTIONS) -D -c Config/GameDir=ultimate/cyberun/dec --var pub=4 -c Config/InitModule=$(SKOOLKIT_HOME)/tools:publish sources/cyberun/cyberun.skool sources/cyberun/cyberun.ref
	skool2html.py $(OPTIONS) -H -c Config/GameDir=ultimate/cyberun --var pub=2 -c Config/InitModule=$(SKOOLKIT_HOME)/tools:publish sources/cyberun/cyberun.skool sources/cyberun/cyberun.ref
	python3 utils/compress_pngs.py $(BUILDDIR)/html/ultimate/cyberun
	python3 utils/render_cyberun_map.py Cyberun.z80 \
	  $(BUILDDIR)/html/ultimate/cyberun/images \
	  $(BUILDDIR)/html/ultimate/cyberun/dec/images

.PHONY: gunfright
gunfright:
	if [ ! -f Gunfright.z80 ]; then tap2sna.py @gunfright.t2s; fi
	sna2skool.py -H --ini ListRefs=2 -c sources/gunfright/gunfright.ctl Gunfright.z80 > sources/gunfright/gunfright.skool
	skool2html.py $(OPTIONS) -D -c Config/GameDir=ultimate/gunfright/dec --var pub=4 -c Config/InitModule=$(SKOOLKIT_HOME)/tools:publish sources/gunfright/gunfright.skool sources/gunfright/gunfright.ref
	skool2html.py $(OPTIONS) -H -c Config/GameDir=ultimate/gunfright --var pub=2 -c Config/InitModule=$(SKOOLKIT_HOME)/tools:publish sources/gunfright/gunfright.skool sources/gunfright/gunfright.ref
	python3 utils/compress_pngs.py $(BUILDDIR)/html/ultimate/gunfright
	python3 utils/render_gunfright_map.py Gunfright.z80 \
	  $(BUILDDIR)/html/ultimate/gunfright/images \
	  $(BUILDDIR)/html/ultimate/gunfright/dec/images

.PHONY: jetpac
jetpac:
	if [ ! -f Jetpac.z80 ]; then tap2sna.py @jetpac.t2s; fi
	sna2skool.py -H --ini ListRefs=2 -c sources/jetpac/jetpac.ctl Jetpac.z80 > sources/jetpac/jetpac.skool
	skool2html.py $(OPTIONS) -D -c Config/GameDir=ultimate/jetpac/dec --var pub=4 -c Config/InitModule=$(SKOOLKIT_HOME)/tools:publish sources/jetpac/jetpac.skool sources/jetpac/jetpac.skool sources/jetpac/jetpac.ref
	skool2html.py $(OPTIONS) -H -c Config/GameDir=ultimate/jetpac --var pub=2 -c Config/InitModule=$(SKOOLKIT_HOME)/tools:publish sources/jetpac/jetpac.skool sources/jetpac/jetpac.skool sources/jetpac/jetpac.ref
	python3 utils/compress_pngs.py $(BUILDDIR)/html/ultimate/jetpac

.PHONY: knightlore
knightlore:
	if [ ! -f KnightLore.z80 ]; then tap2sna.py @knightlore.t2s; fi
	sna2skool.py -H --ini ListRefs=2 -c sources/knightlore/knightlore.ctl KnightLore.z80 > sources/knightlore/knightlore.skool
	skool2html.py $(OPTIONS) -D -c Config/GameDir=ultimate/knightlore/dec --var pub=4 -c Config/InitModule=$(SKOOLKIT_HOME)/tools:publish sources/knightlore/knightlore.skool sources/knightlore/knightlore.ref
	skool2html.py $(OPTIONS) -H -c Config/GameDir=ultimate/knightlore --var pub=2 -c Config/InitModule=$(SKOOLKIT_HOME)/tools:publish sources/knightlore/knightlore.skool sources/knightlore/knightlore.ref
	python3 utils/compress_pngs.py $(BUILDDIR)/html/ultimate/knightlore

.PHONY: lunarjetman
lunarjetman:
	if [ ! -f LunarJetman.z80 ]; then tap2sna.py @lunarjetman.t2s; fi
	sna2skool.py -H --ini ListRefs=2 -c sources/lunarjetman/lunarjetman.ctl LunarJetman.z80 > sources/lunarjetman/lunarjetman.skool
	skool2html.py $(OPTIONS) -D -c Config/GameDir=ultimate/lunarjetman/dec --var pub=4 -c Config/InitModule=$(SKOOLKIT_HOME)/tools:publish sources/lunarjetman/lunarjetman.skool sources/lunarjetman/lunarjetman.skool sources/lunarjetman/lunarjetman.ref
	skool2html.py $(OPTIONS) -H -c Config/GameDir=ultimate/lunarjetman --var pub=2 -c Config/InitModule=$(SKOOLKIT_HOME)/tools:publish sources/lunarjetman/lunarjetman.skool sources/lunarjetman/lunarjetman.skool sources/lunarjetman/lunarjetman.ref
	python3 utils/compress_pngs.py $(BUILDDIR)/html/ultimate/lunarjetman

.PHONY: martianoids
martianoids:
	if [ ! -f Martianoids.z80 ]; then tap2sna.py @martianoids.t2s; fi
	sna2skool.py -H --ini ListRefs=2 -c sources/martianoids/martianoids.ctl Martianoids.z80 > sources/martianoids/martianoids.skool
	skool2html.py $(OPTIONS) -D -c Config/GameDir=ultimate/martianoids/dec --var pub=4 -c Config/InitModule=$(SKOOLKIT_HOME)/tools:publish sources/martianoids/martianoids.skool sources/martianoids/martianoids.ref
	skool2html.py $(OPTIONS) -H -c Config/GameDir=ultimate/martianoids --var pub=2 -c Config/InitModule=$(SKOOLKIT_HOME)/tools:publish sources/martianoids/martianoids.skool sources/martianoids/martianoids.ref
	python3 utils/compress_pngs.py $(BUILDDIR)/html/ultimate/martianoids
	python3 utils/render_martianoids_map.py Martianoids.z80 \
	  $(BUILDDIR)/html/ultimate/martianoids/images \
	  $(BUILDDIR)/html/ultimate/martianoids/dec/images

.PHONY: nightshade
nightshade:
	if [ ! -f Nightshade.z80 ]; then tap2sna.py @nightshade.t2s; fi
	sna2skool.py -H --ini ListRefs=2 -c sources/nightshade/nightshade.ctl Nightshade.z80 > sources/nightshade/nightshade.skool
	skool2html.py $(OPTIONS) -D -c Config/GameDir=ultimate/nightshade/dec --var pub=4 -c Config/InitModule=$(SKOOLKIT_HOME)/tools:publish sources/nightshade/nightshade.skool sources/nightshade/nightshade.ref
	skool2html.py $(OPTIONS) -H -c Config/GameDir=ultimate/nightshade --var pub=2 -c Config/InitModule=$(SKOOLKIT_HOME)/tools:publish sources/nightshade/nightshade.skool sources/nightshade/nightshade.ref
	python3 utils/compress_pngs.py $(BUILDDIR)/html/ultimate/nightshade
	python3 utils/render_nightshade_map.py Nightshade.z80 \
	  $(BUILDDIR)/html/ultimate/nightshade/images \
	  $(BUILDDIR)/html/ultimate/nightshade/dec/images

.PHONY: pentagram
pentagram:
	if [ ! -f Pentagram.z80 ]; then tap2sna.py @pentagram.t2s; fi
	sna2skool.py -H --ini ListRefs=2 -c sources/pentagram/pentagram.ctl Pentagram.z80 > sources/pentagram/pentagram.skool
	skool2html.py $(OPTIONS) -D -c Config/GameDir=ultimate/pentagram/dec --var pub=4 -c Config/InitModule=$(SKOOLKIT_HOME)/tools:publish sources/pentagram/pentagram.skool sources/pentagram/pentagram.ref
	skool2html.py $(OPTIONS) -H -c Config/GameDir=ultimate/pentagram --var pub=2 -c Config/InitModule=$(SKOOLKIT_HOME)/tools:publish sources/pentagram/pentagram.skool sources/pentagram/pentagram.ref
	python3 utils/compress_pngs.py $(BUILDDIR)/html/ultimate/pentagram

.PHONY: pssst
pssst:
	if [ ! -f Pssst.z80 ]; then tap2sna.py @pssst.t2s; fi
	sna2skool.py -H --ini ListRefs=2 -c sources/pssst/pssst.ctl Pssst.z80 > sources/pssst/pssst.skool
	skool2html.py $(OPTIONS) -D -c Config/GameDir=ultimate/pssst/dec --var pub=4 -c Config/InitModule=$(SKOOLKIT_HOME)/tools:publish sources/pssst/pssst.skool sources/pssst/pssst.skool sources/pssst/pssst.ref
	skool2html.py $(OPTIONS) -H -c Config/GameDir=ultimate/pssst --var pub=2 -c Config/InitModule=$(SKOOLKIT_HOME)/tools:publish sources/pssst/pssst.skool sources/pssst/pssst.skool sources/pssst/pssst.ref
	python3 utils/compress_pngs.py $(BUILDDIR)/html/ultimate/pssst

.PHONY: sabrewulf
sabrewulf:
	if [ ! -f SabreWulf.sna ]; then curl -sS -o SabreWulf.sna https://mdfs.net/Software/Spectrum/Games/Sabre.sna; fi
	sna2skool.py -H --ini ListRefs=2 -c sources/sabrewulf/sabrewulf.ctl SabreWulf.sna > sources/sabrewulf/sabrewulf.skool
	skool2html.py $(OPTIONS) -D -c Config/GameDir=ultimate/sabrewulf/dec --var pub=4 -c Config/InitModule=$(SKOOLKIT_HOME)/tools:publish sources/sabrewulf/sabrewulf.skool sources/sabrewulf/sabrewulf.skool sources/sabrewulf/sabrewulf.ref
	skool2html.py $(OPTIONS) -H -c Config/GameDir=ultimate/sabrewulf --var pub=2 -c Config/InitModule=$(SKOOLKIT_HOME)/tools:publish sources/sabrewulf/sabrewulf.skool sources/sabrewulf/sabrewulf.skool sources/sabrewulf/sabrewulf.ref
	python3 utils/compress_pngs.py $(BUILDDIR)/html/ultimate/sabrewulf

.PHONY: tranzam
tranzam:
	if [ ! -f TranzAm.z80 ]; then tap2sna.py @tranzam.t2s; fi
	sna2skool.py -H --ini ListRefs=2 -c sources/tranzam/tranzam.ctl TranzAm.z80 > sources/tranzam/tranzam.skool
	skool2html.py $(OPTIONS) -D -c Config/GameDir=ultimate/tranzam/dec --var pub=4 -c Config/InitModule=$(SKOOLKIT_HOME)/tools:publish sources/tranzam/tranzam.skool sources/tranzam/tranzam.ref
	skool2html.py $(OPTIONS) -H -c Config/GameDir=ultimate/tranzam --var pub=2 -c Config/InitModule=$(SKOOLKIT_HOME)/tools:publish sources/tranzam/tranzam.skool sources/tranzam/tranzam.ref
	python3 utils/compress_pngs.py $(BUILDDIR)/html/ultimate/tranzam
	python3 utils/render_tranzam_map.py TranzAm.z80 \
	  $(BUILDDIR)/html/ultimate/tranzam/images \
	  $(BUILDDIR)/html/ultimate/tranzam/dec/images

.PHONY: underwurlde
underwurlde:
	if [ ! -f Underwurlde.z80 ]; then tap2sna.py @underwurlde.t2s; fi
	sna2skool.py -H --ini ListRefs=2 -c sources/underwurlde/underwurlde.ctl  Underwurlde.z80 > sources/underwurlde/underwurlde.skool
	skool2html.py $(OPTIONS) -D -c Config/GameDir=ultimate/underwurlde/dec --var pub=4 -c Config/InitModule=$(SKOOLKIT_HOME)/tools:publish sources/underwurlde/underwurlde.skool sources/underwurlde/underwurlde.ref
	skool2html.py $(OPTIONS) -H -c Config/GameDir=ultimate/underwurlde --var pub=2 -c Config/InitModule=$(SKOOLKIT_HOME)/tools:publish sources/underwurlde/underwurlde.skool sources/underwurlde/underwurlde.ref
	python3 utils/compress_pngs.py $(BUILDDIR)/html/ultimate/underwurlde

all : alien8 aticatac bubbler cookie cyberun gunfright jetpac knightlore lunarjetman martianoids nightshade pentagram pssst sabrewulf tranzam underwurlde
.PHONY : all
