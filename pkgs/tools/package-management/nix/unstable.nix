{ stdenv, fetchurl, perl, curl, bzip2, openssl ? null
, flex, bison
, pkgconfig, boehmgc
, storeDir ? "/nix/store"
, stateDir ? "/nix/var"
}:

stdenv.mkDerivation rec {
  name = "nix-1.0pre26015";

  src = fetchurl {
    url = "http://hydra.nixos.org/build/920246/download/4/${name}.tar.bz2";
    sha256 = "d2c9caa8573689de4e95eecaf9829d4b672ea3cb9bdfa825dac0ab0dbffb3c70";
  };

  buildNativeInputs = [ perl pkgconfig ];
<<<<<<< HEAD
  buildInputs = [ curl openssl boehmgc
    flex bison /* only required because of arbitrary-strings-as-names patch */
  ];
=======
  buildInputs = [ curl openssl boehmgc ];
>>>>>>> nix2/deepfun-cleanup

  configureFlags =
    ''
      --with-store-dir=${storeDir} --localstatedir=${stateDir}
      --with-bzip2=${bzip2} --with-sqlite=${sqlite}
      --disable-init-state
      --enable-gc
      CFLAGS=-O3 CXXFLAGS=-O3
    '';

  crossAttrs = {
    configureFlags =
      ''
        --with-store-dir=${storeDir} --localstatedir=${stateDir}
        --with-bzip2=${bzip2.hostDrv} --with-sqlite=${sqlite.hostDrv}
        --disable-init-state
        CFLAGS=-O3 CXXFLAGS=-O3
      '';
    doCheck = false;
  };

  doCheck = true;

  patches = [ ./allow-strings-in-names2.patch ];

  meta = {
    description = "The Nix Deployment System";
    homepage = http://nixos.org/;
    license = "LGPLv2+";
  };
}
