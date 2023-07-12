BUILDDIR = build

OPTIONS  = -d build/html -t

OPTIONS += $(foreach theme,$(THEMES),-T $(theme))
OPTIONS += $(HTML_OPTS)

.PHONY: usage clean aticatac cookie jetpac lunarjetman pssst sabrewulf tranzam
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
	@echo "  underwurlde   build the Underwurlde disassembly"
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
	skool2html.py $(OPTIONS) -D -c Config/GameDir=ultimate/aticatac/dec --var pub=4 -c Config/InitModule=$(SKOOLKIT_HOME)/tools:publish sources/aticatac/aticatac.skool sources/aticatac/aticatac.skool sources/aticatac/aticatac.ref
	skool2html.py $(OPTIONS) -H -c Config/GameDir=ultimate/aticatac --var pub=2 -c Config/InitModule=$(SKOOLKIT_HOME)/tools:publish sources/aticatac/aticatac.skool sources/aticatac/aticatac.skool sources/aticatac/aticatac.ref

.PHONY: cookie
cookie:
	if [ ! -f Cookie.z80 ]; then tap2sna.py @cookie.t2s; fi
	sna2skool.py -H -c sources/cookie/cookie.ctl Cookie.z80 > sources/cookie/cookie.skool
	skool2html.py $(OPTIONS) -D -c Config/GameDir=ultimate/cookie/dec --var pub=4 -c Config/InitModule=$(SKOOLKIT_HOME)/tools:publish sources/cookie/cookie.skool sources/cookie/cookie.skool sources/cookie/cookie.ref
	skool2html.py $(OPTIONS) -H -c Config/GameDir=ultimate/cookie --var pub=2 -c Config/InitModule=$(SKOOLKIT_HOME)/tools:publish sources/cookie/cookie.skool sources/cookie/cookie.skool sources/cookie/cookie.ref

.PHONY: jetpac
jetpac:
	if [ ! -f Jetpac.z80 ]; then tap2sna.py @jetpac.t2s; fi
	sna2skool.py -H -c sources/jetpac/jetpac.ctl Jetpac.z80 > sources/jetpac/jetpac.skool
	skool2html.py $(OPTIONS) -D -c Config/GameDir=ultimate/jetpac/dec --var pub=4 -c Config/InitModule=$(SKOOLKIT_HOME)/tools:publish sources/jetpac/jetpac.skool sources/jetpac/jetpac.skool sources/jetpac/jetpac.ref
	skool2html.py $(OPTIONS) -H -c Config/GameDir=ultimate/jetpac --var pub=2 -c Config/InitModule=$(SKOOLKIT_HOME)/tools:publish sources/jetpac/jetpac.skool sources/jetpac/jetpac.skool sources/jetpac/jetpac.ref

.PHONY: lunarjetman
lunarjetman:
	if [ ! -f LunarJetman.z80 ]; then tap2sna.py @lunarjetman.t2s; fi
	sna2skool.py -H -c sources/lunarjetman/lunarjetman.ctl LunarJetman.z80 > sources/lunarjetman/lunarjetman.skool
	skool2html.py $(OPTIONS) -D -c Config/GameDir=ultimate/lunarjetman/dec --var pub=4 -c Config/InitModule=$(SKOOLKIT_HOME)/tools:publish sources/lunarjetman/lunarjetman.skool sources/lunarjetman/lunarjetman.skool sources/lunarjetman/lunarjetman.ref
	skool2html.py $(OPTIONS) -H -c Config/GameDir=ultimate/lunarjetman --var pub=2 -c Config/InitModule=$(SKOOLKIT_HOME)/tools:publish sources/lunarjetman/lunarjetman.skool sources/lunarjetman/lunarjetman.skool sources/lunarjetman/lunarjetman.ref

.PHONY: pssst
pssst:
	if [ ! -f Pssst.z80 ]; then tap2sna.py @pssst.t2s; fi
	sna2skool.py -H -c sources/pssst/pssst.ctl Pssst.z80 > sources/pssst/pssst.skool
	skool2html.py $(OPTIONS) -D -c Config/GameDir=ultimate/pssst/dec --var pub=4 -c Config/InitModule=$(SKOOLKIT_HOME)/tools:publish sources/pssst/pssst.skool sources/pssst/pssst.skool sources/pssst/pssst.ref
	skool2html.py $(OPTIONS) -H -c Config/GameDir=ultimate/pssst --var pub=2 -c Config/InitModule=$(SKOOLKIT_HOME)/tools:publish sources/pssst/pssst.skool sources/pssst/pssst.skool sources/pssst/pssst.ref

.PHONY: sabrewulf
sabrewulf:
	if [ ! -f SabreWulf.sna ]; then curl -o SabreWulf.sna https://mdfs.net/Software/Spectrum/Games/Sabre.sna; fi
	sna2skool.py -H -c sources/sabrewulf/sabrewulf.ctl SabreWulf.sna > sources/sabrewulf/sabrewulf.skool
	skool2html.py $(OPTIONS) -D -c Config/GameDir=ultimate/sabrewulf/dec --var pub=4 -c Config/InitModule=$(SKOOLKIT_HOME)/tools:publish sources/sabrewulf/sabrewulf.skool sources/sabrewulf/sabrewulf.skool sources/sabrewulf/sabrewulf.ref
	skool2html.py $(OPTIONS) -H -c Config/GameDir=ultimate/sabrewulf --var pub=2 -c Config/InitModule=$(SKOOLKIT_HOME)/tools:publish sources/sabrewulf/sabrewulf.skool sources/sabrewulf/sabrewulf.skool sources/sabrewulf/sabrewulf.ref

.PHONY: tranzam
tranzam:
	if [ ! -f TranzAm.z80 ]; then tap2sna.py @tranzam.t2s; fi
	sna2skool.py -H -c sources/tranzam/tranzam.ctl TranzAm.z80 > sources/tranzam/tranzam.skool
	skool2html.py $(OPTIONS) -D -c Config/GameDir=ultimate/tranzam/dec --var pub=4 -c Config/InitModule=$(SKOOLKIT_HOME)/tools:publish sources/tranzam/tranzam.skool sources/tranzam/tranzam.ref
	skool2html.py $(OPTIONS) -H -c Config/GameDir=ultimate/tranzam --var pub=2 -c Config/InitModule=$(SKOOLKIT_HOME)/tools:publish sources/tranzam/tranzam.skool sources/tranzam/tranzam.ref

.PHONY: underwurlde
underwurlde:
	if [ ! -f Underwurlde.z80 ]; then tap2sna.py @underwurlde.t2s; fi
	sna2skool.py -H -c sources/underwurlde/underwurlde.ctl  Underwurlde.z80 > sources/underwurlde/underwurlde.skool
	skool2html.py $(OPTIONS) -D -c Config/GameDir=ultimate/underwurlde/dec --var pub=4 -c Config/InitModule=$(SKOOLKIT_HOME)/tools:publish sources/underwurlde/underwurlde.skool sources/underwurlde/underwurlde.ref
	skool2html.py $(OPTIONS) -H -c Config/GameDir=ultimate/underwurlde --var pub=2 -c Config/InitModule=$(SKOOLKIT_HOME)/tools:publish sources/underwurlde/underwurlde.skool sources/underwurlde/underwurlde.ref

all : aticatac cookie jetpac lunarjetman pssst sabrewulf tranzam underwurlde
.PHONY : all
