{ stdenv, fetchurl, php, autoconf, automake }:

stdenv.mkDerivation {
  name = "php-xdebug-2.1.0";

  src = fetchurl {
    url = "http://www.xdebug.org/files/xdebug-2.1.0.tgz";
    sha256 = "17833mzci7a1jgcjlbzx0cl8gjag85xdpap12mj9a1kj0m6xc3bk";
  };

  buildInputs = [ php autoconf automake ];

  configurePhase = ''
    phpize
    ./configure --prefix=$out
  '';

  buildPhase = ''
    make && make test
  '';

  installPhase = ''
    ensureDir $out/lib/xdebug
    cp modules/xdebug.so $out/lib
    cp LICENSE $out/lib/xdebug
  '';

  meta = {
    description = "PHP debugger and profiler extension";
    homepage = http://xdebug.org/;
    license = "xdebug"; # based on PHP-3
    maintainers = [ stdenv.lib.maintainers.marcweber ];
    platforms = stdenv.lib.platforms.linux;
  };
}
