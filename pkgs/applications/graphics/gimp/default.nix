{ pkgs
, version ? "2.7.1"
}:

let

  p = if version == "git" then pkgs else pkgs;


  commonBuildInputs = [
    p.pkgconfig p.gtkLibs.gtk p.freetype p.fontconfig
    p.gnome.libart_lgpl p.libtiff p.libjpeg p.libpng p.libexif p.zlib p.perl
    p.perlXMLParser p.python p.pygtk p.gettext p.intltool
  ];

  inherit (p) stdenv fetchurl sourceFromHead;

  depsByVersion =  {

    "2.6.10" = {
      src = fetchurl {
        url = "ftp://ftp.gtk.org/pub/gimp/v2.6/gimp-${version}.tar.bz2";
        sha256 = "18dhgicc3f04q0js521kq9w3gq8yqawpf6vdb7m14f9vh380hvcv";
      };
      buildInputs = commonBuildInputs ++ [ p.babl p.gegl ];
    };

    "2.7.1" = {
      src = fetchurl {
        url = "ftp://ftp.gimp.org/pub/gimp/v2.7/gimp-${version}.tar.bz2";
        md5 = "4932a0a1645ecd5b23ea6155ddda013d";
      };
      buildInputs = commonBuildInputs ++ [ p.babl p.gegl ];
    };

    "git" = {
      buildInputs = commonBuildInputs ++ [
        ( p.babl.override { version = "git"; } )
        ( p.gegl.override { version = "git"; } )
        p.autoconf p.automake p.gnome.gtkdoc p.libxslt p.libtool
      ];
      preConfigure = "./autogen.sh";
      # REGION AUTO UPDATE: { name="gimp"; type="git"; url="git://git.gnome.org/gimp"; groups = "gimp"; }
      src = sourceFromHead "gimp-70574877d3dd78c477a60302e395a31de20df750.tar.gz"
                   (fetchurl { url = "http://mawercer.de/~nix/repos/gimp-706900c4f6e9d669b7c8be2065decf49a9898620.tar.gz"; sha256 = "0579312d484b2fc827de56cfd4e1ef7c55d7c6d3752af70fc293d37da7a96e86"; });
      # END

      # plugins want to find the header files. Adding the includes to
      # NIX_CFLAGS_COMPILE is faster than patching them all ..
      # postInstall = ''
      #   ensureDir $out/nix-support
      #   echo "NIX_CFLAGS_COMPILE=\"\$NIX_CFLAGS_COMPILE -I ''${out}/include/gimp-2.0\"" >> $out/nix-support/setup-hook
      # '';
      };
  };

  deps = stdenv.lib.maybeAttr version (throw "no valid gimp version") depsByVersion;

in

stdenv.mkDerivation (rec {
  
  name = "gimp-${version}";
  
  passthru = { inherit (p) gtkLibs; inherit (p.gtkLibs) gtk; }; # used by gimp plugins

  configureFlags = [ "--disable-print" ];

  enableParallelBuilding = false; # compilation fails (git version of 2011-01)

  # "screenshot" needs this.
  NIX_LDFLAGS = "-rpath ${p.xlibs.libX11}/lib";

  meta = {
    description = "The GNU Image Manipulation Program";
    homepage = http://www.gimp.org/;
    license = "GPL";
  };
} // deps)
