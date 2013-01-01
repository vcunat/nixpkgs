{ v, h, stdenv, fetchXfce, pkgconfig, intltool, gtk, libxfce4util, libxfce4ui
, libwnck, exo, garcon, xfconf, libstartup_notification }:

stdenv.mkDerivation rec {
  name = "xfce4-panel-${v}";
  src = fetchXfce.core name h;

  buildInputs =
    [ pkgconfig intltool gtk libxfce4util exo libwnck
      garcon xfconf libstartup_notification
    ];
  propagatedBuildInputs = [ libxfce4ui ];

  enableParallelBuilding = true;

  meta = {
    homepage = http://www.xfce.org/projects/xfce4-panel;
    description = "Xfce panel";
    license = "GPLv2+";
    platforms = stdenv.lib.platforms.linux;
    maintainers = [ stdenv.lib.maintainers.eelco ];
  };
}
