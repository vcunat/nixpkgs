{stdenv, fetchurl, sourceFromHead, qt3, libusb, xorg, gnused, ppp}:

stdenv.mkDerivation {
  name = "umtsmon";

  enableParallelBuilding = true;

  /* cvs version does not build
  # REGION AUTO UPDATE:                                { name = "umtsmon"; type="cvs"; cvsRoot = ":pserver:anonymous@umtsmon.cvs.sourceforge.net:/cvsroot/umtsmon"; module = "umtsmon"; }
  src = sourceFromHead "umtsmon-F_23-32-46.tar.gz"
               (throw "source not not published yet: umtsmon");
  # END
  */
  src = fetchurl {
    url = mirror://sourceforge/umtsmon/umtsmon/umtsmon-0.9/umtsmon-0.9.src.tar.gz;
    sha256 = "0k3iir3i1ch162jsrrq8jnma4wq1q58wa19r9g1hz46w2np6x8ic";
  };

  buildPhase = ''
    qmake
    make clean
    # run original build phase passing -j option:
    unset buildPhase
    buildPhase
  '';

  # umtsmon thinks /nix/store/* is unsafe. so replace lookThroughPath by hardcoded path to ppp and chat
  # could be patched as ewll: usb_modeswitch, (pc)cardctl, su
  patchPhase = ''
    unset patchPhase; patchPhase;
    for prog in chat pppd; do
      sed -i -e "s@lookThroughPath(\"$prog\")@\"${ppp}/sbin/$prog\"@" src/base/Runner.cpp
    done
  '';
  
  buildInputs = [qt3 libusb gnused
    xorg.libX11 xorg.libXext
    ];

  patches = [ ./umtsmon-find-fstat.patch ];

  installPhase = ''
    ensureDir $out/bin
    cp umtsmon $out/bin
  '';

  meta = {
    description = "tool to control and monitor a wireless mobile network card (GPRS, EDGE, WCDMA, UMTS, HSDPA)";
    homepage =  http://umtsmon.sourceforge.net/;
    license = "GPLv2";
    maintainers = [stdenv.lib.maintainers.marcweber];
    platforms = stdenv.lib.platforms.linux;
  };
}
