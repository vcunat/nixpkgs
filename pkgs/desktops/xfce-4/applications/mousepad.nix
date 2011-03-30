{ stdenv, fetchXfce, pkgconfig, intltool, libxfce4util, libxfcegui4, gtk }:

stdenv.mkDerivation rec {
  name = "mousepad-0.2.16";

  src = fetchXfce.app name "0gp7yh8b9w3f1n2la1l8nlqm0ycf0w0qkgcyv9yd51qv9gyr7rc6";

  buildInputs = [ pkgconfig intltool libxfce4util libxfcegui4 gtk ];

  meta = {
    homepage = http://www.xfce.org/projects/mousepad/;
    description = "A simple text editor for Xfce";
    license = "GPLv2+";
  };
}
