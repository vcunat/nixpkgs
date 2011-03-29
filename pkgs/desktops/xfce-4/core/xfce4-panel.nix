{ stdenv, fetchurl, pkgconfig, intltool, gtk, libxfce4util, libxfce4ui
, libwnck, exo, garcon, xfconf, libstartup_notification }:

stdenv.mkDerivation rec {
  name = "xfce4-panel-4.8.2";

  src = fetchurl {
    url = "mirror://xfce/${name}.tar.bz2";
    sha256 = "0rmvh2inzgb2qixxfmacvvhkqvdmh8qfvxb3csbh5vbrg838hzj9";
  };

  buildInputs =
    [ pkgconfig intltool gtk libxfce4util exo libwnck
      garcon xfconf libstartup_notification
    ];

  propagatedBuildInputs = [ libxfce4ui ];

  meta = {
    homepage = http://www.xfce.org/;
    description = "Xfce panel";
    license = "GPLv2+";
  };
}
