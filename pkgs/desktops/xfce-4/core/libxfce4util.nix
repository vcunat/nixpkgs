{ stdenv, fetchXfce, pkgconfig, glib, intltool }:

stdenv.mkDerivation rec {
  name = "libxfce4util-4.8.1";

  src = fetchXfce.app name "108clym2drr9fsyy9wdrzsjlwm5qymi9dr47akxjxfazhi7ynakk";

  buildInputs = [ pkgconfig glib intltool ];

  meta = {
    homepage = http://www.xfce.org/;
    description = "Basic utility non-GUI functions for Xfce";
    license = "bsd";
  };
}
