{ stdenv, fetchurl, pkgconfig, intltool, glib, libxfce4util, dbus_glib }:

stdenv.mkDerivation rec {
  name = "xfconf-4.8.0";

  src = fetchurl {
    url = "mirror://xfce/${name}.tar.bz2";
    sha256 = "0pdqs6nwvh3bcsv6kkrimrmwir1rxw4bpx0zd5x9k3r3h9cxawg0";
  };

  buildInputs = [ pkgconfig intltool glib libxfce4util ];

  propagatedBuildInputs = [ dbus_glib ];

  meta = {
    homepage = http://www.xfce.org/;
    description = "Simple client-server configuration storage and query system for Xfce";
    license = "GPLv2";
  };
}
