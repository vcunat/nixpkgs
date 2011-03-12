{stdenv, fetchurl, ncurses, gettext}:

stdenv.mkDerivation rec {
  name = "powertop-1.13";
  src = fetchurl {
    url = "http://www.lesswatts.org/projects/powertop/download/${name}.tar.gz";
    sha256 = "164dqp6msdaxpi2bmvwawasyrf1sfvanlc9ddp97v1wnjh46dj1b";
  };
  patches = [./powertop-1.13.patch];
  buildInputs = [ncurses gettext];
}
