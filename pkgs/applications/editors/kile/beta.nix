{ stdenv, fetchurl, cmake, qt4, kdelibs
, automoc4, perl, shared_mime_info, gettext
}:

stdenv.mkDerivation rec {
  name = "kile-2.1b5";

  src = fetchurl {
    url = "mirror://sourceforge/kile/${name}.tar.bz2";
    sha256 = "1smjk12vg940s1k6mpnm2xgckl5ip443rbkmiv0qbpwswfibl0m2";
  };

  buildInputs = [ cmake qt4 kdelibs automoc4 perl shared_mime_info gettext ];

  meta = {
    description = "An integrated LaTeX editor for KDE";
    homepage = http://kile.sourceforge.net;
    license = "GPLv2";
  };
}
