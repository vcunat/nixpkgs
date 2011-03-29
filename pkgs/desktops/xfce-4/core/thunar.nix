{ stdenv, fetchurl, pkgconfig, intltool, exo, gtk, libxfce4util
, dbus_glib, libstartup_notification, xfconf, hal, xfce4panel
, gamin }:

stdenv.mkDerivation rec {
  name = "Thunar-1.3.0";

  src = fetchurl {
    url = "mirror://xfce/${name}.tar.bz2";
    sha256 = "02j3dcgk65mig3jmrg740d1swc8sbn3mkkyrca1ijvv1a955345n";
  };

  buildInputs =
    [ pkgconfig intltool exo gtk libxfce4util
      dbus_glib libstartup_notification xfconf xfce4panel gamin
    ];

  propagatedBuildInputs = [ hal ];

  meta = {
    homepage = http://thunar.xfce.org/;
    description = "Xfce file manager";
    license = "GPLv2+";
  };
}
