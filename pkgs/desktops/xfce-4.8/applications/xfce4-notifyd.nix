{ stdenv, fetchXfce, pkgconfig, intltool
, gtk , libxfce4util, libxfce4ui, xfconf }:

stdenv.mkDerivation rec {
  name = "xfce4-notifyd-0.2.2";

  src = fetchXfce.app name "0s4ilc36sl5k5mg5727rmqims1l3dy5pwg6dk93wyjqnqbgnhvmn";

  buildInputs = [ pkgconfig intltool gtk libxfce4util libxfce4ui xfconf ];

  fixupPhase = ''
    rm $out/share/icons/hicolor/icon-theme.cache
    # to be able to run the daemon we need it in PATH
    cp -l $out/lib/xfce4/notifyd/xfce4-notifyd $out/bin
   '';

  meta = {
    homepage = http://goodies.xfce.org/projects/applications/xfce4-notifyd;
    description = "Notification daemon for Xfce";
    license = "GPLv2+";
  };
}
