{ stdenv, fetchXfce, pkgconfig, intltool, exo, gtk, libxfce4util, libxfce4ui
, libglade, xfconf, xorg, libwnck, libnotify }:

#TODO: optional packages
stdenv.mkDerivation rec {
  name = "xfce4-settings-4.8.1";

  src = fetchXfce.core name "0nhv3x87j0zfa4cb581rxngbbyxk30gwn3hwfk00wp0abi8gmx8d";

  buildInputs =
    [ pkgconfig intltool exo gtk libxfce4util libxfce4ui libglade
      xfconf xorg.libXi xorg.libXcursor libwnck libnotify
    #gtk libxfce4util libxfcegui4 libwnck dbus_glib
      #xfconf libglade xorg.iceauth
    ];

  meta = {
    homepage = http://www.xfce.org/;
    description = "Settings manager for Xfce";
    license = "GPLv2+";
  };
}
