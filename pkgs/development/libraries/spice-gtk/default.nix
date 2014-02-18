{ stdenv, fetchurl, pkgconfig, gtk, spice_protocol, intltool, celt_0_5_1
, openssl, pulseaudio, pixman, gobjectIntrospection, libjpeg_turbo, zlib
, cyrus_sasl, python, pygtk, autoconf, automake, libtool }:

with stdenv.lib;

stdenv.mkDerivation rec {
  name = "spice-gtk-0.22";

  src = fetchurl {
    url = "http://www.spice-space.org/download/gtk/${name}.tar.bz2";
    sha256 = "0fpsn6qhy9a701lmd4yym6qz6zhpp8xp6vw42al0b4592pcybs85";
  };

  buildInputs = [
    gtk spice_protocol celt_0_5_1 openssl pulseaudio pixman gobjectIntrospection
    libjpeg_turbo zlib cyrus_sasl python pygtk
  ];

  nativeBuildInputs = [ pkgconfig intltool libtool autoconf automake ];

  NIX_CFLAGS_COMPILE = "-fno-stack-protector";

  preConfigure = ''
    substituteInPlace gtk/Makefile.am \
      --replace '=codegendir pygtk-2.0' '=codegendir pygobject-2.0'

    autoreconf -v --force --install
    intltoolize -f
  '';

  configureFlags = [
    "--disable-maintainer-mode"
    "--with-gtk=2.0"
  ];

  dontDisableStatic = true; # Needed by the coroutine test

  enableParallelBuilding = true;

  meta = {
    description = "A GTK+2 and GTK+3 SPICE widget";
    longDescription = ''
      spice-gtk is a GTK+2 and GTK+3 SPICE widget. It features glib-based
      objects for SPICE protocol parsing and a gtk widget for embedding
      the SPICE display into other applications such as virt-manager.
      Python bindings are available too.
    '';

    homepage = http://www.spice-space.org/;
    license = licenses.lgpl21;

    platforms = platforms.linux;
  };
}
