{ stdenv, fetchurl, pkgconfig, intltool, gtk, dbus_glib, xfconf
, libxfce4ui, libxfce4util, libnotify, xfce4panel }:

stdenv.mkDerivation rec {
  name = "xfce4-power-manager-1.0.10";

  src = fetchurl {
    url = "http://www.xfce.org/archive/src/apps/xfce4-power-manager/1.0/${name}.tar.bz2";
    sha256 = "1w120k1sl4s459ijaxkqkba6g1p2sqrf9paljv05wj0wz12bpr40";
  };

  buildInputs =
    [ pkgconfig intltool gtk dbus_glib xfconf libxfce4ui libxfce4util
      libnotify xfce4panel
    ];

  meta = {
    homepage = http://goodies.xfce.org/projects/applications/xfce4-power-manager;
    description = "A power manager for the Xfce Desktop Environment";
    license = "GPLv2+";
  };
}
