{ stdenv, lib, fetchurl
, config
, zlib, bzip2, ncurses, libpng, flex, bison, libX11, libICE, xproto
, freetype, t1lib, gd, libXaw, icu, ghostscript, ed, libXt, libXpm, libXmu, libXext
, xextproto, perl, libSM, ruby, expat, curl, libjpeg, python, fontconfig, pkgconfig
, poppler, libpaper, graphite2, lesstif, zziplib, harfbuzz, texinfo, potrace, gmp, mpfr
, xpdf, cairo, pixman, xorg
, makeWrapper
}:


let
  withSystemLibs = map (libname: "--with-system-${libname}");

  common = {
    year = "2015";
    src = fetchurl {
      url = ftp://tug.org/historic/systems/texlive/2015/texlive-20150521-source.tar.xz;
      sha256 = "ed9bcd7bdce899c3c27c16a8c5c3017c4f09e1d7fd097038351b72497e9d4669";
    };

    configureFlags = [
      "--with-banner-add=/NixOS.org"
      "--disable-missing" "--disable-native-texlive-build"
      "--enable-shared" # "--enable-cxx-runtime-hack" # static runtime
      "--enable-tex-synctex"
      "-C" # use configure cache to speed up
    ]
      ++ withSystemLibs [
      # see "from TL tree" vs. "Using installed"  in configure output
      "zziplib" "xpdf" "poppler" "mpfr" "gmp"
      "pixman" "potrace" "gd" "freetype2" "libpng" "libpaper" "zlib"
        # beware: xpdf means to use stuff from poppler :-/
    ];

    removeBundledLibs = ''
      rm -r libs/{cairo,freetype2,gd,gmp,graphite2,harfbuzz,icu,libpaper,libpng} \
        libs/{mpfr,pixman,poppler,potrace,xpdf,zlib,zziplib}
    '';
    preConfigure = common.removeBundledLibs + ''
      mkdir Work
      cd Work
    '' + lib.optionalString stdenv.isDarwin ''
      export DYLD_LIBRARY_PATH="${poppler}/lib"
    '';
    configureScript = "../configure";

    # clean broken links to stuff not built
    cleanBrokenLinks = ''
      for f in "$out"/bin/*; do
        if [[ ! -x "$f" ]]; then rm "$f"; fi
      done
    '';

    buildInputs = [
      pkgconfig
      /*teckit*/ zziplib poppler mpfr gmp
      pixman potrace gd freetype libpng libpaper zlib
      perl
    ];
  };
in rec { # un-indented

inherit (common) cleanBrokenLinks year;

dvisvgm = stdenv.mkDerivation {
  name = "texlive-dvisvgm.bin-${year}";

  inherit (common) src;

  buildInputs = [ pkgconfig core/*kpathsea*/ ghostscript zlib freetype potrace ];

  preConfigure = "cd texk/dvisvgm";

  configureFlags = common.configureFlags
    ++ [ "--with-system-kpathsea" "--with-system-libgs" ];

  enableParallelBuilding = true;
};

dvipng = stdenv.mkDerivation {
  name = "texlive-dvipng.bin-${year}";

  inherit (common) src;

  buildInputs = [ pkgconfig core/*kpathsea*/ zlib libpng freetype gd ghostscript makeWrapper ];

  preConfigure = "cd texk/dvipng";

  configureFlags = common.configureFlags
    ++ [ "--with-system-kpathsea" "--with-gs=yes" "--disable-debug" ];

  enableParallelBuilding = true;

  # I didn't manage to hardcode gs location by configureFlags
  postInstall = ''
    wrapProgram "$out/bin/dvipng" --prefix PATH : '${ghostscript}/bin'
  '';
};

bibtexu = bibtex8;
bibtex8 = stdenv.mkDerivation {
  name = "texlive-bibtex-x.bin-${year}";

  inherit (common) src;

  buildInputs = [ pkgconfig core/*kpathsea*/ icu ];

  preConfigure = "cd texk/bibtex-x";

  configureFlags = common.configureFlags
    ++ [ "--with-system-kpathsea" "--with-system-icu" ];

  enableParallelBuilding = true;
};

inherit (core-big) metafont metapost luatex xetex;
core-big = stdenv.mkDerivation {
  name = "texlive-core-big.bin-${year}";

  inherit (common) src;

  buildInputs = common.buildInputs ++ [ core cairo harfbuzz icu graphite2 ];

  configureFlags = common.configureFlags
    ++ withSystemLibs [ "kpathsea" "ptexenc" "cairo" "harfbuzz" "icu" "graphite2" ]
    ++ map (prog: "--disable-${prog}") # don't build things we already have
      [ "tex" "ptex" "eptex" "uptex" "euptex" "aleph" "pdftex"
        "web-progs" "synctex"
      ];

  configureScript = ":";

  postConfigure = ''
    mkdir ./Work && cd ./Work
    for path in libs/{teckit,lua52,luajit} texk/web2c; do
      (
        mkdir -p "$path" && cd "$path"
        "../../../$path/configure" $configureFlags
      )
    done
  '';

  preBuild = "cd texk/web2c";
  enableParallelBuilding = true;

  # now distribute stuff into outputs, roughly as upstream TL
  # (uninteresting stuff remains in $out, typically duplicates from `core`)
  outputs = [ "out" "metafont" "metapost" "luatex" "xetex" ];
  postInstall = ''
    for output in $outputs; do
      mkdir -p "''${!output}/bin"
    done

    mv "$out/bin"/{inimf,mf,mf-nowin} "$metafont/bin/"
    mv "$out/bin"/{*tomp,mfplain,*mpost} "$metapost/bin/"
    mv "$out/bin"/{luatex,luajittex,texlua*} "$luatex/bin/"
    mv "$out/bin"/xetex "$xetex/bin/"
  '' + ''
    cd ../../libs/lua52
    make install
    cd ../luajit
    make install
    mkdir -p "$luatex/lib"
    mv "$out"/lib/libtexlua*.so* "$luatex/lib/"

    for prog in "$luatex"/bin/*; do
      patchelf --set-rpath $(patchelf --print-rpath "$prog" | sed "s@$out@$luatex@g") "$prog"
    done
  '';
};

core = stdenv.mkDerivation {
  name = "texlive-bin-${year}";

  inherit (common) src buildInputs preConfigure configureScript;

  outputs = [ "out" "doc" ];

  configureFlags = common.configureFlags
    ++ [ "--without-x" ] # disable xdvik and xpdfopen
    ++ map (what: "--disable-${what}") [
      "dvisvgm" "dvipng" # ghostscript dependency
      "luatex" "luajittex" "mp" "pmp" "upmp" "mf" # cairo would bring in X and more
      "xetex" "bibtexu" "bibtex8" "bibtex-x" # ICU isn't small
    ]
    ++ [ "--without-system-harfbuzz" "--without-system-icu" ] # bogus configure

    ++ lib.optionals stdenv.isDarwin [
    # TODO: We should be able to fix these tests
    "--disable-devnag"
  ];

  ## doMainBuild
  /*
    sed -e 's@\<env ruby@${ruby}/bin/ruby@' -i $(grep 'env ruby' -rl . )
    sed -e 's@\<env perl@${perl}/bin/perl@' -i $(grep 'env perl' -rl . )
    sed -e 's@\<env python@${python}/bin/python@' -i $(grep 'env python' -rl . )
  */

  enableParallelBuilding = true;

  doCheck = false; # triptest fails, likely due to missing TEXMF tree
  preCheck = "patchShebangs ../texk/web2c";

  installTargets = [ "install" "texlinks" ];

  # TODO: perhaps improve texmf.cnf search locations
  postInstall = /* the perl modules are useful; take the rest from pkgs */ ''
    mv "$out/share/texmf-dist/web2c/texmf.cnf" .
    rm -r "$out/share/texmf-dist"
    mkdir -p "$out"/share/texmf-dist/{web2c,scripts/texlive/TeXLive}
    mv ./texmf.cnf "$out/share/texmf-dist/web2c/"
    cp ../texk/tests/TeXLive/*.pm "$out/share/texmf-dist/scripts/texlive/TeXLive/"
  '' + /* doc location identical with individual TeX pkgs */ ''
    mkdir -p "$doc/doc"
    mv "$out"/share/{man,info} "$doc"/doc
  '' + cleanBrokenLinks
    + stdenv.lib.optionalString stdenv.isDarwin ''
    for prog in $out/bin/*; do
      wrapProgram "$prog" --prefix DYLD_LIBRARY_PATH : "${poppler}/lib"
    done
  '';

  setupHook = ./setup-hook.sh; # TODO: maybe texmf-nix -> texmf (and all references)
  passthru = { inherit year; };

  meta = with stdenv.lib; {
    description = "Basic binaries for TeX Live";
    homepage    = http://www.tug.org/texlive;
    license     = stdenv.lib.licenses.gpl2;
    maintainers = with maintainers; [ vcunat lovek323 raskin jwiegley ];
    platforms   = platforms.all;
  };
};

} # un-indented

