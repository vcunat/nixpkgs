{ stdenv, fetchurl, fetchpatch, runCommand, zlib, expat, gettext }:

stdenv.mkDerivation rec {
  name = "exiv2-0.26";

  src = fetchurl {
    url = "http://www.exiv2.org/builds/${name}-trunk.tar.gz";
    sha256 = "1yza317qxd8yshvqnay164imm0ks7cvij8y8j86p1gqi1153qpn7";
  };

  patches = [
    (fetchurl rec {
      name = "CVE-2017-9239.patch";
      url = let patchname = "0006-1296-Fix-submitted.patch";
          in "https://src.fedoraproject.org/lookaside/pkgs/exiv2/${patchname}"
          + "/sha512/${sha512}/${patchname}";
      sha512 = "3f9242dbd4bfa9dcdf8c9820243b13dc14990373a800c4ebb6cf7eac5653cfef"
             + "e6f2c47a94fbee4ed24f0d8c2842729d721f6100a2b215e0f663c89bfefe9e32";
     })
    (fetchpatch {
      # many CVEs - see https://github.com/Exiv2/exiv2/pull/120
      url = "https://patch-diff.githubusercontent.com/raw/Exiv2/exiv2/pull/120.patch";
      sha256 = "1szl22xmh12hibzaqf2zi8zl377x841m52x4jm5lziw6j8g81sj8";
      excludes = [ "test/bugfixes-test.sh" ];
    })
  ] ++
  (let
    debian = fetchurl {
      url = http://http.debian.net/debian/pool/main/e/exiv2/exiv2_0.25-4.debian.tar.xz;
      sha256 = "0dp9y0d8pbsys5r4j1xyhn5liv6x0p4gncf90bcgnsp5shipzsr1";
    };
    patches = runCommand "exiv2-debian-patches" {} ''
      mkdir $out
      tar xf ${debian} -C $out --strip-components=2 debian/patches
    '';
  in [
    "${patches}/CVE-2018-10998.patch"
    "${patches}/CVE-2018-11531_1_of_3.patch"
    "${patches}/CVE-2018-11531_2_of_3.patch"
    "${patches}/CVE-2018-11531_3_of_3.patch"
    "${patches}/CVE-2018-12264.patch"
    "${patches}/CVE-2018-12265_prereq.patch"
    "${patches}/CVE-2018-12265.patch"
  ]);

  postPatch = "patchShebangs ./src/svn_version.sh";

  outputs = [ "out" "dev" ];

  nativeBuildInputs = [ gettext ];
  propagatedBuildInputs = [ zlib expat ];

  meta = with stdenv.lib; {
    homepage = http://www.exiv2.org/;
    description = "A library and command-line utility to manage image metadata";
    platforms = platforms.all;
    license = licenses.gpl2;
  };
}
