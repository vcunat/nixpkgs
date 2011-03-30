{ stdenv, fetchXfce, pkgconfig, intltool, glib, gst_all, gtk
, libxfce4util, libxfce4ui, xfce4panel, xfconf, makeWrapper }:

let

  # The usual Gstreamer plugins package has a zillion dependencies
  # that we don't need for a simple mixer, so build a minimal package.
  gstPluginsBase = gst_all.gstPluginsBase.override {
    minimalDeps = true;
  };

in

stdenv.mkDerivation rec {
  name = "xfce4-mixer-4.8.0";

  src = fetchXfce.app name "1aqgjxvck6hx26sk3n4n5avhv02vs523mfclcvjb3xnks3yli7wz";

  buildInputs =
    [ pkgconfig intltool glib gst_all.gstreamer gstPluginsBase gtk
      libxfce4util libxfce4ui xfce4panel xfconf makeWrapper
    ];

  postInstall =
    ''
      mkdir -p $out/nix-support
      echo ${gstPluginsBase} > $out/nix-support/propagated-user-env-packages
    '';

  meta = {
    homepage = http://www.xfce.org/projects/xfce4-mixer;
    description = "A volume control application for the Xfce desktop environment";
    license = "GPLv2+";
  };
}
