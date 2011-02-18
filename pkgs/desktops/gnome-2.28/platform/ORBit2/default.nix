{stdenv, fetchurl, pkgconfig, glib, libIDL}:

stdenv.mkDerivation {
  name = "ORBit2-2.14.17";

  enableParallelBuilding = false;

  /* I got this when running it the first time ?!
      l,/nix/store/i9ph8j5x30rmy8m9vj17iw4addzryfkq-glib-2.27.93/lib
      gcc: libname-server-2.a: No such file or directory
      make[5]: *** [orbit-name-server-2] Error 1
      make[5]: Leaving directory `/tmp/nix-build-ih14nzyr7bvfcqiydbc0626fkg8l94dc-ORBit2-2.14.17.drv-0/ORBit2-2.14.17/src/services/name'
      make[4]: *** [all] Error 2
      make[4]: Leaving directory `/tmp/nix-build-ih14nzyr7bvfcqiydbc0626fkg8l94dc-ORBit2-2.14.17.drv-0/ORBit2-2.14.17/src/services/name'
      make[3]: *** [all-recursive] Error 1
      make[3]: Leaving directory `/tmp/nix-build-ih14nzyr7bvfcqiydbc0626fkg8l94dc-ORBit2-2.14.17.drv-0/ORBit2-2.14.17/src/services'
      make[2]: *** [all-recursive] Error 1
      make[2]: Leaving directory `/tmp/nix-build-ih14nzyr7bvfcqiydbc0626fkg8l94dc-ORBit2-2.14.17.drv-0/ORBit2-2.14.17/src'
      make[1]: *** [all-recursive] Error 1
      make[1]: Leaving directory `/tmp/nix-build-ih14nzyr7bvfcqiydbc0626fkg8l94dc-ORBit2-2.14.17.drv-0/ORBit2-2.14.17'
      make: *** [all] Error 2
      make: INTERNAL: Exiting with 5 jobserver tokens available; should be 4!
  */
  
  src = fetchurl {
    url = mirror://gnome/sources/ORBit2/2.14/ORBit2-2.14.17.tar.bz2;
    sha256 = "0k4px2f949ac7vmj7b155g1rpf7pmvl48sbnkjhlg4wgcwzwxgv2";
  };
  
  buildInputs = [ pkgconfig ];
  propagatedBuildInputs = [ glib libIDL ];
}
