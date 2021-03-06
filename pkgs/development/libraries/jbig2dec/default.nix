{ stdenv, fetchurl, fetchpatch }:

stdenv.mkDerivation rec {
  name = "jbig2dec-0.14";

  src = fetchurl {
    url = "https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs922/${name}.tar.gz";
    sha256 = "0k01hp0q4275fj4rbr1gy64svfraw5w7wvwl08yjhvsnpb1rid11";
  };

  meta = {
    homepage = https://www.jbig2dec.com/;
    description = "Decoder implementation of the JBIG2 image compression format";
    license = stdenv.lib.licenses.gpl2Plus;
    platforms = stdenv.lib.platforms.unix;
  };
}
