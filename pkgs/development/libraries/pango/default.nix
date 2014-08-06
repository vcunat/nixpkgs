{ stdenv, fetchurl, pkgconfig, x11, glib, cairo, libpng, harfbuzz
, fontconfig, freetype, libintlOrEmpty, gobjectIntrospection
}:

let
  ver_maj = "1.36";
  ver_min = "3";
in
stdenv.mkDerivation rec {
  name = "pango-${ver_maj}.${ver_min}";

  src = fetchurl {
    url = "mirror://gnome/sources/pango/${ver_maj}/${name}.tar.xz";
    sha256 = "08jxv9m5dfnwkl8nvy3fsk7mydardqv48va80zasjjpr2wly6j5d";
  };

  buildInputs = with stdenv.lib;
    optional (!stdenv.isDarwin) gobjectIntrospection # build problems of itself and flex
    ++ optionals stdenv.isDarwin [ gettext fontconfig ];
  nativeBuildInputs = [ pkgconfig ];

  propagatedBuildInputs = [ x11 glib cairo libpng fontconfig freetype harfbuzz ] ++ libintlOrEmpty;

  enableParallelBuilding = true;

  #doCheck = true; # testiter fails to find fontconfig configuration
  # jww (2014-05-05): The tests currently fail on Darwin:
  #
  # ERROR:testiter.c:139:iter_char_test: assertion failed: (extents.width == x1 - x0)
  # .../bin/sh: line 5: 14823 Abort trap: 6 srcdir=. PANGO_RC_FILE=./pangorc ${dir}$tst
  # FAIL: testiter
  
  postInstall = "rm -rf $out/share/gtk-doc";

  meta = {
    description = "A library for laying out and rendering of text, with an emphasis on internationalization";

    longDescription = ''
      Pango is a library for laying out and rendering of text, with an
      emphasis on internationalization.  Pango can be used anywhere
      that text layout is needed, though most of the work on Pango so
      far has been done in the context of the GTK+ widget toolkit.
      Pango forms the core of text and font handling for GTK+-2.x.
    '';

    homepage = http://www.pango.org/;
    license = stdenv.lib.licenses.lgpl2Plus;

    maintainers = with stdenv.lib.maintainers; [ raskin urkud ];
    hydraPlatforms = stdenv.lib.platforms.linux ++ stdenv.lib.platforms.darwin;
  };
}
