{stdenv, fetchurl, zlib, giflib, libungif, pkgconfig, libjpeg, libtiff, libpng, jasper, cyrus_sasl}:

stdenv.mkDerivation {

  name = "ziproxy-3.2.0";

  enableParallelBuilding = true;

  src = fetchurl {
    url = mirror://sourceforge/ziproxy/ziproxy/ziproxy-3.2.0/ziproxy-3.2.0.tar.bz2;
    sha256 = "0zp8pn9s0675gawgiw41w9m7h83bayyzfyxc7994xqk96737xdmj";
  };

  buildInputs = [zlib giflib libungif pkgconfig libjpeg libtiff libpng jasper cyrus_sasl];

  meta = {
    description = "forwarding (non-caching) compressing HTTP proxy server";
    homepage = http://ziproxy.sourceforge.net/;
    license = "GPLv2";
    maintainers = [stdenv.lib.maintainers.marcweber];
    platforms = stdenv.lib.platforms.linux;
  };
}
