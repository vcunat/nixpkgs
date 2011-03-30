{ stdenv, fetchXfce, pkgconfig, intltool, gtk, libxfce4util, xfconf
, libglade, libstartup_notification }:

stdenv.mkDerivation rec {
  name = "libxfcegui4-4.8.1";

  src = fetchXfce.core name "0hr4h6a9p6w3qw1976p8v9c9pwhd9zhrjlbaph0p7nyz7j1836ih";

  # By default, libxfcegui4 tries to install into libglade's prefix.
  # Install into our own prefix instead.
  preConfigure =
    ''
      configureFlags="--with-libglade-module-path=$out/lib/libglade/2.0"
    '';

  buildInputs =
    [ pkgconfig intltool gtk libxfce4util xfconf libglade
      libstartup_notification
    ];

  meta = {
    homepage = http://www.xfce.org/;
    description = "Basic GUI library for Xfce";
    license = "LGPLv2+";
  };
}
