{ stdenv, fetchurl, pam, glibc }:
   
stdenv.mkDerivation rec {
  name = "shadow-4.1.4.2";
   
  src = fetchurl {
    url = "ftp://pkg-shadow.alioth.debian.org/pub/pkg-shadow/${name}.tar.bz2";
    sha256 = "1449ny7pdnwkavg92wvibapnkgdq5pas38nvl1m5xa37g5m7z64p";
  };

  buildInputs = [ pam ];

  patches = [ ./no-sanitize-env.patch ./su-name.patch ./keep-path.patch
    /* nixos managed /etc[/skel] files are symlinks pointing to /etc/static[/skel]
    * thus useradd will create symlinks ~/.bashrc. This patch fixes it: If a file
    * should be copied to user's home directory and it points to /etc/static
    * the target of the symbolic link is copied instead.
    * This is only one way to fix it. The alternative would be making nixos
    * create files in /etc/skel and keep some state around so that it knows
    * which files it put there so that it can remove them itself. This more
    * complicated approach would pay off if multiple apps woulb be using
    * /etc/skel
    */
    ./etc-copy-etc-satic-target.patch
  ];

  preBuild =
    ''
      substituteInPlace lib/nscd.c --replace /usr/sbin/nscd ${glibc}/sbin/nscd
    '';
  
  meta = {
    homepage = http://pkg-shadow.alioth.debian.org/;
    description = "Suite containing authentication-related tools such as passwd and su";
  };
}
