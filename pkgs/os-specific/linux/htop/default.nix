{fetchurl, stdenv, ncurses}:

stdenv.mkDerivation rec {
  name = "htop-0.9";
  src = fetchurl {
    url = "mirror://sourceforge/htop/${name}.tar.gz";
    sha256 = "1zgvwr7giypmxbhvz087d10546dzp47b74nn1v9wqsw8w4w5rrjd";
  };
  buildInputs = [ncurses];
  meta = {
    description = "An interactive process viewer for Linux";
    homepage = "http://htop.sourceforge.net";
    platforms = stdenv.lib.platforms.linux;
  };
}
