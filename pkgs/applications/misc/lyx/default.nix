# I haven't put much effort into this expressions .. so some optional depencencies may be missing - Marc
{ fetchurl, stdenv, texLive, python, makeWrapper
, libX11, qt
}:

stdenv.mkDerivation rec {
  version = "1.6.9";
  name = "lyx-${version}";

  src = fetchurl {
    url = "ftp://ftp.lyx.org/pub/lyx/stable/1.6.x/${name}.tar.bz2";
    sha256 = "02bpb70n3f3ykgbrkv100c4zvi9r4bsmia9bqpjmnf6vb0n61cy5";
  };

  buildInputs = [texLive qt python makeWrapper];

  meta = {
    description = "WYSIWYM frontend for LaTeX, DocBook, etc.";
    homepage = "http://www.lyx.org";
    license = "GPL2";
    maintainers = [ stdenv.lib.maintainers.neznalek ];
    platforms = stdenv.lib.platforms.linux;
  };
}
