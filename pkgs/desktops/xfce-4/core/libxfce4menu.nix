{ stdenv, fetchurl, pkgconfig, glib, intltool, gtk, libxfce4util }:

stdenv.mkDerivation rec {
  name = "libxfce4menu-4.6.2";

  src = fetchurl {
    url = "mirror://xfce/${name}.tar.bz2";
    sha256 = "0qjijsln08wn79sy9xm8dqj802rx63wvdr7nqi0z5mhqfgjjndb2";
  };

  buildInputs = [ pkgconfig glib intltool gtk libxfce4util ];

  meta = {
    homepage = http://www.xfce.org/;
    description = "Xfce menu support library";
    license = "LGPLv2+";
  };
}
