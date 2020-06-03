{ stdenv, fetchurl, autoreconfHook }:

stdenv.mkDerivation rec {
  name = "patchelf-${version}";
  version = "2020-06-03";

  src = stdenv.fetchurlBoot {
    url = "https://github.com/NixOS/patchelf/archive/4aff679d9eaa1a3ec0228901a4e79b57361b4094.tar.gz";
    sha256 = "02mzhi8bjrgc8c9nzkdxavr87lwv1rk9s397rg3rab3dg000idgv";
  };

  # Drop test that fails on musl (?)
  postPatch = stdenv.lib.optionalString stdenv.hostPlatform.isMusl ''
    substituteInPlace tests/Makefile.am \
      --replace "set-rpath-library.sh" ""
  '';

  setupHook = [ ./setup-hook.sh ];

  nativeBuildInputs = [ autoreconfHook ];
  buildInputs = [ ];

  doCheck = false/*stdenv bootstrapping*/ && !stdenv.isDarwin;

  meta = with stdenv.lib; {
    homepage = "https://github.com/NixOS/patchelf/blob/master/README";
    license = licenses.gpl3;
    description = "A small utility to modify the dynamic linker and RPATH of ELF executables";
    maintainers = [ maintainers.eelco ];
    platforms = platforms.all;
  };
}
