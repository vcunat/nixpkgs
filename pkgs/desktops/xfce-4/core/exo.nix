{ stdenv, fetchurl, pkgconfig, intltool, URI, glib, gtk, libxfce4util
, enableHAL ? true, hal, dbus_glib }:

stdenv.mkDerivation rec {
  name = "exo-0.6.0";

  src = fetchurl {
    url = "mirror://xfce/${name}.tar.bz2";
    sha256 = "04py7iw60a3kxqj2szxwbd09bws1vm0n9v9v7006g3jvvlbc0s98";
  };

  buildInputs =
    [ pkgconfig intltool URI glib gtk libxfce4util ] ++
    stdenv.lib.optionals enableHAL [ hal dbus_glib ];

  meta = {
    homepage = http://www.xfce.org/projects/exo;
    description = "Application library for the Xfce desktop environment";
    license = "GPLv2+";
  };
}
