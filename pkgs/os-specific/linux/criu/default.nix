{ stdenv, fetchurl, protobuf, protobufc, asciidoc, xmlto, utillinux }:

stdenv.mkDerivation rec {
  name    = "criu-${version}";
  version = "1.3-rc1";

  src = fetchurl {
    url    = "http://download.openvz.org/criu/${name}.tar.bz2";
    sha256 = "00q3kyvaizg5x2zladj0mazmp69c9kg7nvlazcqf0w6bqp0y7sp0";
  };

  enableParallelBuilding = true;
  buildInputs = [ protobuf protobufc asciidoc xmlto ];

  patchPhase = ''
    chmod +w ./scripts/gen-offsets.sh
    substituteInPlace ./scripts/gen-offsets.sh --replace hexdump ${utillinux}/bin/hexdump
    substituteInPlace ./Documentation/Makefile --replace "2>/dev/null" ""
  '';

  configurePhase = "make config PREFIX=$out";
  buildPhase     = "make PREFIX=$out";

  installPhase = ''
    mkdir -p $out/etc/logrotate.d
    make install PREFIX=$out LIBDIR=$out/lib ASCIIDOC=${asciidoc}/bin/asciidoc XMLTO=${xmlto}/bin/xmlto
  '';

  meta = {
    description = "userspace checkpoint/restore for Linux";
    homepage    = "http://criu.org";
    license     = stdenv.lib.licenses.gpl2;
    platforms   = [ "x86_64-linux" ];
    maintainers = [ stdenv.lib.maintainers.thoughtpolice ];
  };
}
