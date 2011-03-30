{ stdenv, fetchXfce, pkgconfig, intltool, gtk, dbus_glib, xfconf
, libxfce4ui, libxfce4util, libnotify, xfce4panel }:

stdenv.mkDerivation rec {
  name = "xfce4-power-manager-1.0.10";

  src = fetchXfce.core name "1w120k1sl4s459ijaxkqkba6g1p2sqrf9paljv05wj0wz12bpr40";

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
