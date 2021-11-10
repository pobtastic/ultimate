BUILDDIR = build

OPTIONS  = -d build/html -t

OPTIONS += $(foreach theme,$(THEMES),-T $(theme))
OPTIONS += $(HTML_OPTS)

.PHONY: usage clean aticatac cookie jetpac lunarjetman pssst tranzam
usage:
	@echo "Targets:"
	@echo "  usage         show this help"
	@echo "  aticatac      build the Atic Atac disassembly"
	@echo "  cookie        build the Cookie disassembly"
	@echo "  jetpac        build the Jetpac disassembly"
	@echo "  lunarjetman   build the Lunar Jetman disassembly"
	@echo "  pssst         build the Psssst disassembly"
	@echo "  sabrewulf     build the Sabre Wulf disassembly"
	@echo "  tranzam       build the Tranz Am disassembly"
	@echo ""
	@echo "Variables:"
	@echo "  THEMES     CSS theme(s) to use"
	@echo "  HTML_OPTS  options passed to skool2html.py"

.PHONY: clean
clean:
	-rm -rf $(BUILDDIR)/*

.PHONY: aticatac
aticatac:
	if [ ! -f AticAtac.z80 ]; then tap2sna.py @aticatac.t2s; fi
	sna2skool.py -H -c sources/aticatac/aticatac.ctl AticAtac.z80 > sources/aticatac/aticatac.skool
	skool2html.py $(OPTIONS) -D -c Config/GameDir=ultimate/aticatac/dec -c Config/InitModule=sources:bases sources/aticatac/aticatac.skool sources/aticatac/aticatac.skool sources/aticatac/aticatac.ref
	skool2html.py $(OPTIONS) -H -c Config/GameDir=ultimate/aticatac/hex -c Config/InitModule=sources:bases sources/aticatac/aticatac.skool sources/aticatac/aticatac.skool sources/aticatac/aticatac.ref

.PHONY: cookie
cookie:
	if [ ! -f Cookie.z80 ]; then tap2sna.py @cookie.t2s; fi
	sna2skool.py -H -c sources/cookie/cookie.ctl Cookie.z80 > sources/cookie/cookie.skool
	skool2html.py $(OPTIONS) -D -c Config/GameDir=ultimate/cookie/dec -c Config/InitModule=sources:bases sources/cookie/cookie.skool sources/cookie/cookie.skool sources/cookie/cookie.ref
	skool2html.py $(OPTIONS) -H -c Config/GameDir=ultimate/cookie/hex -c Config/InitModule=sources:bases sources/cookie/cookie.skool sources/cookie/cookie.skool sources/cookie/cookie.ref

.PHONY: jetpac
jetpac:
	if [ ! -f Jetpac.z80 ]; then tap2sna.py @jetpac.t2s; fi
	sna2skool.py -H -c sources/jetpac/jetpac.ctl Jetpac.z80 > sources/jetpac/jetpac.skool
	skool2html.py $(OPTIONS) -D -c Config/GameDir=ultimate/jetpac/dec -c Config/InitModule=sources:bases sources/jetpac/jetpac.skool sources/jetpac/jetpac.skool sources/jetpac/jetpac.ref
	skool2html.py $(OPTIONS) -H -c Config/GameDir=ultimate/jetpac/hex -c Config/InitModule=sources:bases sources/jetpac/jetpac.skool sources/jetpac/jetpac.skool sources/jetpac/jetpac.ref

.PHONY: lunarjetman
lunarjetman:
	if [ ! -f LunarJetman.z80 ]; then tap2sna.py @lunarjetman.t2s; fi
	sna2skool.py -H -c sources/lunarjetman/lunarjetman.ctl LunarJetman.z80 > sources/lunarjetman/lunarjetman.skool
	skool2html.py $(OPTIONS) -D -c Config/GameDir=ultimate/lunarjetman/dec -c Config/InitModule=sources:bases sources/lunarjetman/lunarjetman.skool sources/lunarjetman/lunarjetman.skool sources/lunarjetman/lunarjetman.ref
	skool2html.py $(OPTIONS) -H -c Config/GameDir=ultimate/lunarjetman/hex -c Config/InitModule=sources:bases sources/lunarjetman/lunarjetman.skool sources/lunarjetman/lunarjetman.skool sources/lunarjetman/lunarjetman.ref

.PHONY: pssst
pssst:
	if [ ! -f Pssst.z80 ]; then tap2sna.py @pssst.t2s; fi
	sna2skool.py -H -c sources/pssst/pssst.ctl Pssst.z80 > sources/pssst/pssst.skool
	skool2html.py $(OPTIONS) -D -c Config/GameDir=ultimate/pssst/dec -c Config/InitModule=sources:bases sources/pssst/pssst.skool sources/pssst/pssst.skool sources/pssst/pssst.ref
	skool2html.py $(OPTIONS) -H -c Config/GameDir=ultimate/pssst/hex -c Config/InitModule=sources:bases sources/pssst/pssst.skool sources/pssst/pssst.skool sources/pssst/pssst.ref

.PHONY: sabrewulf
sabrewulf:
	if [ ! -f SabreWulf.z80 ]; then tap2sna.py @sabrewulf.t2s; fi
	sna2skool.py -H -c sources/sabrewulf/sabrewulf.ctl SabreWulf.z80 > sources/sabrewulf/sabrewulf.skool
	skool2html.py $(OPTIONS) -D -c Config/GameDir=ultimate/sabrewulf/dec -c Config/InitModule=sources:bases sources/sabrewulf/sabrewulf.skool sources/sabrewulf/sabrewulf.skool sources/sabrewulf/sabrewulf.ref
	skool2html.py $(OPTIONS) -H -c Config/GameDir=ultimate/sabrewulf/hex -c Config/InitModule=sources:bases sources/sabrewulf/sabrewulf.skool sources/sabrewulf/sabrewulf.skool sources/sabrewulf/sabrewulf.ref

.PHONY: tranzam
tranzam:
	if [ ! -f TranzAm.z80 ]; then tap2sna.py @tranzam.t2s; fi
	sna2skool.py -H -c sources/tranzam/tranzam.ctl TranzAm.z80 > sources/tranzam/tranzam.skool
	skool2html.py $(OPTIONS) -D -c Config/GameDir=ultimate/tranzam/dec -c Config/InitModule=sources:bases sources/tranzam/tranzam.skool sources/tranzam/tranzam.ref
	skool2html.py $(OPTIONS) -H -c Config/GameDir=ultimate/tranzam/hex -c Config/InitModule=sources:bases sources/tranzam/tranzam.skool sources/tranzam/tranzam.ref

all : aticatac cookie jetpac lunarjetman pssst tranzam
.PHONY : all
