{ stdenv, fetchXfce, pkgconfig, intltool, gtk, libxfce4util, libxfce4ui }:

stdenv.mkDerivation rec {
  name = "xfce-utils-4.8.1";

  src = fetchXfce.core name "11l6mxy9ml2ji4ymq8mwfh6vjgb70wj7616z991mxilwddmwc17d";

  configureFlags = "--with-xsession-prefix=$(out)/share/xsessions";

  buildInputs = [ pkgconfig intltool gtk libxfce4util libxfce4ui ];

  meta = {
    homepage = http://www.xfce.org/;
    description = "Utilities and scripts for Xfce";
    license = "GPLv2+";
  };
}
