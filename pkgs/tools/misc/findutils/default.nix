{ stdenv, fetchurl
, coreutils, automake, autoconf
}:

stdenv.mkDerivation rec {
  pname = "findutils";
  version = "20190510";

  src = fetchurl {
    url = "http://deb.debian.org/debian/pool/main/f/findutils/findutils_4.6.0+git+20190510.orig.tar.xz";
    sha256 = "0pdgdy904jm1zh2fzlcg7b4v0lzcn0qjxq6a4kndc1g68nfwj027";
   };

  patches = [ ./no-install-statedir.patch ];

  buildInputs = [ coreutils automake autoconf ]; # bin/updatedb script needs to call sort

  # Since glibc-2.25 the i686 tests hang reliably right after test-sleep.
  doCheck
    =  !stdenv.hostPlatform.isDarwin
    && !(stdenv.hostPlatform.libc == "glibc" && stdenv.hostPlatform.isi686)
    && (stdenv.hostPlatform.libc != "musl")
    && stdenv.hostPlatform == stdenv.buildPlatform;

  outputs = [ "out" "info" ];

  configureFlags = [
    # "sort" need not be on the PATH as a run-time dep, so we need to tell
    # configure where it is. Covers the cross and native case alike.
    "SORT=${coreutils}/bin/sort"
    "--localstatedir=/var/cache"
  ];

  enableParallelBuilding = true;

  meta = {
    homepage = https://www.gnu.org/software/findutils/;
    description = "GNU Find Utilities, the basic directory searching utilities of the GNU operating system";

    longDescription = ''
      The GNU Find Utilities are the basic directory searching
      utilities of the GNU operating system.  These programs are
      typically used in conjunction with other programs to provide
      modular and powerful directory search and file locating
      capabilities to other commands.

      The tools supplied with this package are:

          * find - search for files in a directory hierarchy;
          * locate - list files in databases that match a pattern;
          * updatedb - update a file name database;
          * xargs - build and execute command lines from standard input.
    '';

    platforms = stdenv.lib.platforms.all;

    license = stdenv.lib.licenses.gpl3Plus;
  };
}
