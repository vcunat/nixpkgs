{stdenv, fetchurl, boost, zlib}:

stdenv.mkDerivation {
  name = "anyterm";

  enableParallelBuilding = true;

  src = fetchurl {
    url = http://anyterm.org/download/anyterm-1.1.29.tbz2;
    sha256 = "0ilqxj50mmm6c216dlg4gwy25kmnwiyz3gcmsb74xjs04b7i0xvf";
  };

  buildInputs = [
    boost # only header files are used 
    zlib
  ];

  patches = ./patch.patch;

  installPhase = ''
    ensureDir $out/bin
    mv build/anytermd $out/bin
  '';

  meta = {
    description = "Access SSH Shell using the browser";
    homepage = http://anyterm.org/index.html;
    license = "GPL";
    maintainers = [stdenv.lib.maintainers.marcweber];
    platforms = stdenv.lib.platforms.linux;
  };
}
