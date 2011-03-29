{ stdenv, fetchurl
, pkgconfig, ncurses
, intltool, vte
, exo, libxfce4util
, gtk
}:

stdenv.mkDerivation rec {
  name = "xfce-terminal-0.4.6";

  src = fetchurl {
    url = "mirror://xfce/apps/terminal/0.4/Terminal-0.4.6.tar.bz2";
    sha256 = "0zw9dy072g1cgwfqybr3y9x9afmaw13fqnv9gan58d5zn79mb39s";
  };

  buildInputs = [ pkgconfig intltool exo gtk vte libxfce4util ncurses ];

  meta = {
    homepage = http://www.xfce.org/projects/terminal;
    description = "A modern terminal emulator primarily for the Xfce desktop environment";
    license = "GPLv2+";
  };
}
