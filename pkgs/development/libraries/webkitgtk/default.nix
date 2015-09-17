{ stdenv, fetchurl, perl, python, ruby, bison, gperf, cmake
, pkgconfig, gettext, gobjectIntrospection
, gtk2, gtk3, wayland, libwebp, enchant
, libxml2, libsoup, libsecret, libxslt, harfbuzz, libpthreadstubs
, enableGeoLocation ? true, geoclue2, sqlite
, gst-plugins-base
}:

assert enableGeoLocation -> geoclue2 != null;

with stdenv.lib;
stdenv.mkDerivation rec {
  name = "webkitgtk-${version}";
  version = "2.8.5";

  meta = {
    description = "Web content rendering engine, GTK+ port";
    homepage = "http://webkitgtk.org/";
    license = licenses.bsd2;
    platforms = platforms.linux;
    maintainers = with maintainers; [ iyzsong koral ];
  };

  preConfigure = "patchShebangs Tools";

  src = fetchurl {
    url = "http://webkitgtk.org/releases/${name}.tar.xz";
    sha256 = "082dw0d8jxvsapx30ypmy5h2srzfzi42c3zr9pbkzx1m959hq7rx";
  };

  patches = [ ./finding-harfbuzz-icu.patch ];

  cmakeFlags = [ "-DPORT=GTK" ];

  # XXX: WebKit2 missing include path for gst-plugins-base.
  # Filled: https://bugs.webkit.org/show_bug.cgi?id=148894
  NIX_CFLAGS_COMPILE = "-I${gst-plugins-base}/include/gstreamer-1.0";

  nativeBuildInputs = [
    cmake perl python ruby bison gperf sqlite
    pkgconfig gettext gobjectIntrospection
  ];

  buildInputs = [
    gtk2 wayland libwebp enchant
    libxml2 libsecret libxslt harfbuzz libpthreadstubs
    gst-plugins-base
  ] ++ optional enableGeoLocation geoclue2;

  propagatedBuildInputs = [
    libsoup gtk3
  ];

  enableParallelBuilding = true; # build problems on Hydra
}
