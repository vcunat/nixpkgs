{ fetchurl, stdenv, ncurses, db4 }:

stdenv.mkDerivation rec {
  name = "nvi-1.81.6";

  enableParallelBuilding = true;

  src = fetchurl {
    url = "http://www.kotnet.org/~skimo/nvi/devel/nvi-1.81.6.tar.bz2";
    sha256 = "0nbbs1inyrqds0ywn3ln5slv54v5zraq7lszkg8nsavv4kivhh9l";
  };

  buildInputs = [ ncurses db4 /* ? */ ];

  configurePhase = ''
    mkdir mybuild
    cd mybuild
    ../dist/configure --prefix=$out --disable-curses
  '';

  installPhase = ''
    ensureDir $out/bin $out/share/vi/catalog
    for a in dutch english french german ru_SU.KOI8-R spanish swedish; do
      cp ../catalog/$a $out/share/vi/catalog
    done
    cp vi $out/bin/vi
    ln -s $out/bin/vi $out/bin/nvi
    ln -s $out/bin/vi $out/bin/ex
    ln -s $out/bin/vi $out/bin/view

    ensureDir $out/share/man/man1
    cp ../docs/vi.man/vi.1 $out/share/man/man1/nvi.1
    ln -s $out/share/man/man1/nvi.1 $out/share/man/man1/vi
    ln -s $out/share/man/man1/nvi.1 $out/share/man/man1/ex
    ln -s $out/share/man/man1/nvi.1 $out/share/man/man1/view
  '';

  meta = {
    homepage = http://www.bostic.com/vi/; # broken, See wikipedia pointing to dev version: http://www.kotnet.org/~skimo/nvi/devel/
    description = "The Berkeley Vi Editor";
    license = "free";
  };
}
