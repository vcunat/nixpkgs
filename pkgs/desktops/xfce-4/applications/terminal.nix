{ stdenv, fetchXfce
, pkgconfig, ncurses
, intltool, vte
, exo, libxfce4util
, gtk
}:

let version = "0.4.6"; in
stdenv.mkDerivation rec {
  name = "xfce-terminal-${version}";

  src = fetchXfce.app "Terminal-${version}" "0zw9dy072g1cgwfqybr3y9x9afmaw13fqnv9gan58d5zn79mb39s";

  buildInputs = [ pkgconfig intltool exo gtk vte libxfce4util ncurses ];

  meta = {
    homepage = http://www.xfce.org/projects/terminal;
    description = "A modern terminal emulator primarily for the Xfce desktop environment";
    license = "GPLv2+";
  };
}
