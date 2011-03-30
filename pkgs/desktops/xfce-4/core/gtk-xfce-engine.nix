{ stdenv, fetchXfce, pkgconfig, intltool, gtk }:

stdenv.mkDerivation rec {
  name = "gtk-xfce-engine-2.8.1";

  src = fetchXfce.core name "05z63cbgbb4ldpdra4bpd37knwny2k9anjw9hrm5rvfdfhnsbc3w";

  buildInputs = [ pkgconfig intltool gtk ];

  meta = {
    homepage = http://www.xfce.org/;
    description = "GTK+ theme engine for Xfce";
    license = "GPLv2+";
  };
}
