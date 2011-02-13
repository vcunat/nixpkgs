{ stdenv, fetchurl, zlib, libX11, libXext, libXft, freetype, libSM, libICE,
  libXt, libXrender, libXcursor, fontconfig, libuuid, glibc, libXi
# qt gui:
, qt47, kde4
# gtk gui
, gtkLibs, cairo

, makeDesktopItem
, # set of "gtk" "qt" "kde"
  # kde does not work yet
  # qt starts but icons are missing (?)
  # so use gtk for now!
  guiSupport ? [ "gtk" "qt"  /* "kde" */ ]
}:

assert stdenv.isLinux && stdenv.gcc.gcc != null;


let

  libsForGuis = {
      # Debug Dialog Toolkits with opera --full-version (see last line)
      # See: http://www.opera.com/support/usingopera/operaini/
      qt  = [qt47 kde4.kdelibs];                      # "Dialog Toolkit" = 1
      gtk = with gtkLibs; [gtk glib atk pango cairo]; # "Dialog Toolkit" = 2
      kde = [];                                       # "Dialog Toolkit" = 3 (not supported by nixpkgs yet)
  }; in


/* TIp: enable unix like editing shortcuts:
 Settings > Preferences > Advanced > Shortcuts
*/


stdenv.mkDerivation rec {

  name = "opera-11.00";

  builder = ./builder.sh;
  
  src =
    if stdenv.system == "i686-linux" then
      fetchurl {
        url = "http://get.opera.com/pub/opera/linux/1100/opera-11.00-1156.i386.linux.tar.bz2";
        sha256 = "0rdzxnalf1djzm3bwv152fdqjrb20ka7li6y799ral7zyb9mw6lm";
      }
    else if stdenv.system == "x86_64-linux" then
      fetchurl {
        url =  "http://get.opera.com/pub/opera/linux/1100/opera-11.00-1156.x86_64.linux.tar.bz2";
        sha256 = "1j5isxral2frg9zcspcsbyfk6zijr8hz7gpydymwnfkhd59hbrj6";
      }
    else throw "Opera is not supported on ${stdenv.system} (only i686-linux and x86_64 linux are supported)";

  dontStrip = 1;
  
  # `operapluginwrapper' requires libXt. Adding it makes startup faster
  # and omits error messages (on x86).
  libPath =
    let list = [ stdenv.gcc.gcc glibc zlib libX11 libXt libXext libSM libICE
                libXft freetype fontconfig libXrender libXcursor libXi libuuid]
              ++ (stdenv.lib.concatMap (x: builtins.getAttr x libsForGuis) guiSupport);
    in stdenv.lib.makeLibraryPath list
        + ":" + (if stdenv.system == "x86_64-linux" then stdenv.lib.makeSearchPath "lib64" list else "");

  desktopItem = makeDesktopItem {
    name = "Opera";
    exec = "opera";
    icon = "opera";
    comment = "Opera Web Browser";
    desktopName = "Opera";
    genericName = "Web Browser";
    categories = "Application;Network;";
  };

  meta = {
    homepage = http://www.opera.com;
    description = "The Opera web browser";
  };
}
