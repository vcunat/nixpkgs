{stdenv, fetchurl, networkmanager, intltool, pkgconfig, gtkLibs, gnome, libnotify}:

stdenv.mkDerivation {
  name = "networkmanager-applet-0.8.1";

  enableParallelBuilding = true;

  src = fetchurl {
    url = http://ftp.gnome.org/pub/GNOME/sources/network-manager-applet/0.8/network-manager-applet-0.8.1.tar.bz2;
    sha256 = "0rn3mr0v8i3bkfhpvx6bbyhv1i6j6s120pkayq2318bg5ivbk12a";
  };

  buildInputs = [networkmanager intltool pkgconfig networkmanager.buildNativeInputs
   gtkLibs.glib gtkLibs.gtk
   gnome.libglade
   gnome.gnome_keyring
   gnome.GConf
   libnotify
  ];

  meta = {
    description = "gui for networkmanager - requires gnome_keyring and a tray such as trayer";
    homepage = http://projects.gnome.org/NetworkManager/;
    license = "GPLv2";
    maintainers = [stdenv.lib.maintainers.marcweber];
    platforms = stdenv.lib.platforms.linux;
  };
}
