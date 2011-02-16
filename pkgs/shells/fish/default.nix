{stdenv, fetchurl, xsel, ncurses, gettext}:

stdenv.mkDerivation {
  name = "fish-1.23.1";

  enableParallelBuilding = true;

  configureFlags = "--with-xsel=${xsel}/bin/xsel";

  src = fetchurl {
    url = "http://fishshell.com/files/1.23.1/fish-1.23.1.tar.bz2";
    sha256 = "14qzccgf286hkrpy5y9xskjcvzb5r1p0kmmb7ycibhr6499xd8qy";
  };

  # hacky: force reading /etc/fish/config.fish so that nixos can set path.
  # using --synconfdir=/etc does not work because fish wants to put files there
  preBuild = ''
    sed -i 's@SYSCONFDIR@"/etc"@g' fish.c
  '';

  buildInputs = [
    ncurses
    # bc
    gettext
    # htmlview ?
    xsel
  ];

  meta = {
    description = "fish is the Friendly Interactive SHell";
    homepage = "http://fishshell.com/";
    license = "GPLv2";
    maintainers = [stdenv.lib.maintainers.marcweber];
    platforms = stdenv.lib.platforms.linux;
  };
}
