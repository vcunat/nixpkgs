{ stdenv, fetchurl, pkgconfig, intltool, gtk, libxfce4util, libxfce4ui
, libwnck, dbus_glib, xfconf, libglade, xorg }:

stdenv.mkDerivation rec {
  name = "xfce4-session-4.8.1";

  src = fetchurl {
    url = "mirror://xfce/${name}.tar.bz2";
    sha256 = "0adqd1gf48mck8dy7i5xchnl4d331cxg18j09xxx5m3yv1vjmx8x";
  };

  buildInputs =
    [ pkgconfig intltool gtk libxfce4util libxfce4ui libwnck dbus_glib
      xfconf libglade xorg.iceauth
    ];

  meta = {
    homepage = http://www.xfce.org/;
    description = "Session manager for Xfce";
    license = "GPLv2+";
  };
}
