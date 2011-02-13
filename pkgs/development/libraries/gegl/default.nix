{ stdenv, fetchurl, pkgconfig, glib, babl, libpng, cairo, libjpeg, bzip2
, librsvg, pango, gtk, automake, autoconf, sourceFromHead, libtool, ruby, which
, version ? "0.1.2" }:

let

  commonBuildInputs = [ pkgconfig glib libpng cairo libjpeg librsvg pango gtk ];

  depsByVersion =  {

    "0.1.2" = {
       src = fetchurl {
        url = ftp://ftp.gimp.org/pub/gegl/0.1/gegl-0.1.2.tar.bz2;
        sha256 = "04z130hwl09jq06a602a7j70c8mppk81kclncms4lkqc8sdn2kmn";
      };
      buildInputs = commonBuildInputs ++ [babl];
    };
    git = {
      # REGION AUTO UPDATE: { name="gegl"; type="git"; url="git://git.gnome.org/gegl"; groups = "gimp_group"; }
      src = sourceFromHead "gegl-4fed0a26d052d804bc54fb1131313f3d31f19ba4.tar.gz"
                   (throw "source not not published yet: gegl");
      # END
      buildInputs = commonBuildInputs ++ [(babl.override { version = "git"; }) automake bzip2 autoconf libtool ruby which];
      preConfigure = "./autogen.sh";
    };
  };

  deps = stdenv.lib.maybeAttr version (throw "no valid gegl version") depsByVersion;

in
        
stdenv.mkDerivation ({

  name = "gegl-${version}";

  configureFlags = "--disable-docs"; # needs fonts otherwise  don't know how to pass them

  meta = { 
    description = "Graph-based image processing framework";
    homepage = http://www.gegl.org;
    license = "GPL3";
  };

} // deps)
