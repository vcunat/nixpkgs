{ stdenv, fetchurl, perl, curl, bzip2, openssl ? null
, flex, bison
, pkgconfig, boehmgc
, storeDir ? "/nix/store"
, stateDir ? "/nix/var"
}:

stdenv.mkDerivation rec {
  name = "nix-1.0pre24122";

  src = fetchurl {
    url = "http://hydra.nixos.org/build/667798/download/4/${name}.tar.bz2";
    sha256 = "0rz9radz4452bp3sy9yzcawn9yz5z4nyng43a0zrsa5v72cv695f";
  };

  buildNativeInputs = [ perl pkgconfig ];
  buildInputs = [ curl openssl boehmgc
    flex bison /* only required because of arbitrary-strings-as-names patch */
  ];

  configureFlags =
    ''
      --with-store-dir=${storeDir} --localstatedir=${stateDir}
      --with-bzip2=${bzip2}
      --disable-init-state
      CFLAGS=-O3 CXXFLAGS=-O3
    '';

  crossAttrs = {
    configureFlags =
      ''
        --with-store-dir=${storeDir} --localstatedir=${stateDir}
        --with-bzip2=${bzip2.hostDrv}
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
