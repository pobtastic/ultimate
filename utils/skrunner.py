import art
import sys
import os

ULTIMATE_HOME = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

ATICATAC_SKOOL = '{}/sources/aticatac/aticatac.skool'.format(ULTIMATE_HOME)
COOKIE_SKOOL = '{}/sources/cookie/cookie.skool'.format(ULTIMATE_HOME)
JETPAC_SKOOL = '{}/sources/jetpac/jetpac.skool'.format(ULTIMATE_HOME)
KNIGHTLORE_SKOOL = '{}/sources/knightlore/knightlore.skool'.format(ULTIMATE_HOME)
LUNARJETMAN_SKOOL = '{}/sources/lunarjetman/lunarjetman.skool'.format(ULTIMATE_HOME)
PSSST_SKOOL = '{}/sources/pssst/pssst.skool'.format(ULTIMATE_HOME)
SABREWULF_SKOOL = '{}/sources/sabrewulf/sabrewulf.skool'.format(ULTIMATE_HOME)
TRANZAM_SKOOL = '{}/sources/tranzam/tranzam.skool'.format(ULTIMATE_HOME)
UNDERWURLDE_SKOOL = '{}/sources/underwurlde/underwurlde.skool'.format(ULTIMATE_HOME)

SKOOLKIT_HOME = os.environ.get('SKOOLKIT_HOME')
SKOOLKIT_TOOLS = "{}/tools".format(SKOOLKIT_HOME)
if SKOOLKIT_HOME:
    if not os.path.isdir(SKOOLKIT_HOME):
        sys.stderr.write('SKOOLKIT_HOME={}: directory not found\n'.format(SKOOLKIT_HOME))
        sys.exit(1)
    sys.path.insert(0, SKOOLKIT_HOME)
    from skoolkit import skool2asm, skool2html, sna2skool, tap2sna
else:
    try:
        from skoolkit import skool2asm, skool2html, sna2skool, tap2sna
    except ImportError:
        sys.stderr.write('Error: SKOOLKIT_HOME is not set, and SkoolKit is not installed\n')
        sys.exit(1)

sys.stderr.write("Found SkoolKit in {}\n".format(skool2html.PACKAGE_DIR))

def run_skool2asm():
    skool2asm.main(sys.argv[1:] + [ATICATAC_SKOOL])
    skool2asm.main(sys.argv[1:] + [COOKIE_SKOOL])
    skool2asm.main(sys.argv[1:] + [JETPAC_SKOOL])
    skool2asm.main(sys.argv[1:] + [KNIGHTLORE_SKOOL])
    skool2asm.main(sys.argv[1:] + [LUNARJETMAN_SKOOL])
    skool2asm.main(sys.argv[1:] + [PSSST_SKOOL])
    skool2asm.main(sys.argv[1:] + [SABREWULF_SKOOL])
    skool2asm.main(sys.argv[1:] + [TRANZAM_SKOOL])
    skool2asm.main(sys.argv[1:] + [UNDERWURLDE_SKOOL])

def run_skool2html():
    options = '-c Config/InitModule={}:publish -d {}/build/html'.format(SKOOLKIT_TOOLS, ULTIMATE_HOME)

    art.tprint("ATIC ATAC")
    hex = '-H -c Config/GameDir=ultimate/aticatac --var pub=2'
    dec = '-D -c Config/GameDir=ultimate/aticatac/dec --var pub=4'
    skool2html.main(options.split() + hex.split() + sys.argv[1:] + [ATICATAC_SKOOL])
    skool2html.main(options.split() + dec.split() + sys.argv[1:] + [ATICATAC_SKOOL])

    art.tprint("COOKIE")
    hex = '-H -c Config/GameDir=ultimate/cookie --var pub=2'
    dec = '-D -c Config/GameDir=ultimate/cookie/dec --var pub=4'
    skool2html.main(options.split() + hex.split() + sys.argv[1:] + [COOKIE_SKOOL])
    skool2html.main(options.split() + dec.split() + sys.argv[1:] + [COOKIE_SKOOL])

    art.tprint("JETPAC")
    hex = '-H -c Config/GameDir=ultimate/jetpac --var pub=2'
    dec = '-D -c Config/GameDir=ultimate/jetpac/dec --var pub=4'
    skool2html.main(options.split() + hex.split() + sys.argv[1:] + [JETPAC_SKOOL])
    skool2html.main(options.split() + dec.split() + sys.argv[1:] + [JETPAC_SKOOL])

    art.tprint("KNIGHT LORE")
    hex = '-H -c Config/GameDir=ultimate/knightlore --var pub=2'
    dec = '-D -c Config/GameDir=ultimate/knightlore/dec --var pub=4'
    skool2html.main(options.split() + hex.split() + sys.argv[1:] + [KNIGHTLORE_SKOOL])
    skool2html.main(options.split() + dec.split() + sys.argv[1:] + [KNIGHTLORE_SKOOL])

    art.tprint("LUNAR JETMAN")
    hex = '-H -c Config/GameDir=ultimate/lunarjetman --var pub=2'
    dec = '-D -c Config/GameDir=ultimate/lunarjetman/dec --var pub=4'
    skool2html.main(options.split() + hex.split() + sys.argv[1:] + [LUNARJETMAN_SKOOL])
    skool2html.main(options.split() + dec.split() + sys.argv[1:] + [LUNARJETMAN_SKOOL])

    art.tprint("PSSST")
    hex = '-H -c Config/GameDir=ultimate/pssst --var pub=2'
    dec = '-D -c Config/GameDir=ultimate/pssst/dec --var pub=4'
    skool2html.main(options.split() + hex.split() + sys.argv[1:] + [PSSST_SKOOL])
    skool2html.main(options.split() + dec.split() + sys.argv[1:] + [PSSST_SKOOL])

    art.tprint("SABRE WULF")
    hex = '-H -c Config/GameDir=ultimate/sabrewulf --var pub=2'
    dec = '-D -c Config/GameDir=ultimate/sabrewulf/dec --var pub=4'
    skool2html.main(options.split() + hex.split() + sys.argv[1:] + [SABREWULF_SKOOL])
    skool2html.main(options.split() + dec.split() + sys.argv[1:] + [SABREWULF_SKOOL])

    art.tprint("TRANZ AM")
    hex = '-H -c Config/GameDir=ultimate/tranzam --var pub=2'
    dec = '-D -c Config/GameDir=ultimate/tranzam/dec --var pub=4'
    skool2html.main(options.split() + hex.split() + sys.argv[1:] + [TRANZAM_SKOOL])
    skool2html.main(options.split() + dec.split() + sys.argv[1:] + [TRANZAM_SKOOL])

    art.tprint("UNDERWURLDE")
    hex = '-H -c Config/GameDir=ultimate/underwurlde --var pub=2'
    dec = '-D -c Config/GameDir=ultimate/underwurlde/dec --var pub=4'
    skool2html.main(options.split() + hex.split() + sys.argv[1:] + [UNDERWURLDE_SKOOL])
    skool2html.main(options.split() + dec.split() + sys.argv[1:] + [UNDERWURLDE_SKOOL])
