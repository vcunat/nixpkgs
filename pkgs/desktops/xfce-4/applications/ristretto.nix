{ stdenv, fetchurl, pkgconfig, intltool, libexif, gtk, thunar
, exo, dbus_glib, libxfce4util, libxfce4ui, xfconf }:

stdenv.mkDerivation rec {
  name = "ristretto-0.0.93";

  src = fetchurl {
    url = "http://www.xfce.org/archive/src/apps/ristretto/0.0/${name}.tar.bz2";
    sha256 = "1zrc4q6619nvzlqhcg1qg48cvfcxfyy3fb7f5cpps1nq58lbyk0h";
  };

  buildInputs =
    [ pkgconfig intltool libexif gtk thunar exo dbus_glib
      libxfce4util libxfce4ui xfconf
    ];

  NIX_LDFLAGS = "-lX11";

  meta = {
    homepage = http://goodies.xfce.org/projects/applications/ristretto;
    description = "A fast and lightweight picture-viewer for the Xfce desktop environment";
    license = "GPLv2+";
  };
}
