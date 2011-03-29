{ stdenv, fetchurl, pkgconfig, intltool, gtk, libxfce4util, libxfce4ui
, libwnck, xfconf, libglade, libxfce4menu, xfce4panel, thunar, exo }:

stdenv.mkDerivation rec {
  name = "xfdesktop-4.8.1";

  src = fetchurl {
    url = "mirror://xfce/${name}.tar.bz2";
    sha256 = "1f200xqgj74j52a2szfjrgpa2ni03yc313ss4rzn3izhzawq6r2r";
  };

  buildInputs =
    [ pkgconfig intltool gtk libxfce4util libxfce4ui libwnck xfconf
      libglade libxfce4menu xfce4panel thunar exo
    ];

  meta = {
    homepage = http://www.xfce.org/;
    description = "Xfce desktop manager";
    license = "GPLv2+";
  };
}
