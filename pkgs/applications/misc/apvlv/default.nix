{stdenv, fetchurl, poppler, gtkLibs, automake, autoconf, libtool, pkgconfig
, sourceFromHead, cmake, djvulibre}:

stdenv.mkDerivation {
  name = "apvlv-git";

  enableParallelBuilding = true;

  # REGION AUTO UPDATE: { name="apvlv"; type="svn"; url="http://apvlv.googlecode.com/svn/trunk"; }
  src = sourceFromHead "apvlv-361.tar.gz"
               (throw "source not not published yet: apvlv");
  # END

  cmakeFlags="-DAPVLV_WITH_UMD=OFF -DSYSCONFDIR=$out";

  buildInputs = [pkgconfig automake autoconf libtool poppler djvulibre
    gtkLibs.gtk gtkLibs.glib cmake
    ];

  meta = {
    description = "poppler based pdf reader with vi like keybindings";
    homepage = "http://code.google.com/p/apvlv/source/checkout";
    license = "";
    maintainers = [stdenv.lib.maintainers.marcweber];
    platforms = stdenv.lib.platforms.linux;
  };
}
