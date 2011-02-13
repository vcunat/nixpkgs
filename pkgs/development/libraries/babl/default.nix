{ stdenv, fetchurl
, autoconf, automake, libtool, sourceFromHead, glib, pkgconfig
, version ? "0.1.2"
}:

let

  depsByVersion =  {

    "0.1.2" = {
       src = fetchurl {
        url = ftp://ftp.gtk.org/pub/babl/0.1/babl-0.1.2.tar.bz2;
        sha256 = "1de1394f3d49313bd99f2eab5ae7a4ddfd66d27cdaa89aede67b0dd96f43b722";
      };
      buildInputs = [];
    };

    git = {
      # REGION AUTO UPDATE: { name="babl"; type="git"; url="git://git.gnome.org/babl"; groups = "gimp_group"; }
      src = sourceFromHead "babl-cfeaaf62b8d5babef2ab34798fff1e1f64905422.tar.gz"
                   (throw "source not not published yet: babl");
      # END
      buildInputs = [ autoconf automake libtool glib pkgconfig];
      preConfigure = "./autogen.sh";
    };

  };

  deps = stdenv.lib.maybeAttr version (throw "no valid babl version") depsByVersion;

in
        
stdenv.mkDerivation ({

  name = "babl-${version}";

  meta = { 
    description = "Image pixel format conversion library";
    homepage = http://gegl.org/babl/;
    license = "GPL3";
  };
} // deps)
