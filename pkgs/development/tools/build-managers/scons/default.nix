{stdenv, fetchurl, python, makeWrapper}:

let
  name = "scons";
  version = "2.0.1";
in

stdenv.mkDerivation {
  name = "${name}-${version}";

  src = fetchurl {
    url = "mirror://sourceforge/scons/${name}-${version}.tar.gz";
    sha256 = "0qk74nrnm9qlijrq6gmy8cyhjgp0gis4zx44divnr8n487d5308a";
  };

  buildInputs = [python makeWrapper];

  preConfigure = ''
    for i in "script/"*; do
     substituteInPlace $i --replace "/usr/bin/env python" "${python}/bin/python"
    done
  '';
  buildPhase = "python setup.py install --prefix=$out --install-data=$out/share --install-lib=$(toPythonPath $out) --symlink-scons -O1";
  installPhase = "for n in $out/bin/*-${version}; do wrapProgram $n --suffix PYTHONPATH ':' \"$(toPythonPath $out)\"; done";

  meta = {
    homepage = "http://scons.org/";
    description = "An improved, cross-platform substitute for Make";
    license = "MIT";
    longDescription =
    '' SCons is an Open Source software construction tool. Think of
       SCons as an improved, cross-platform substitute for the classic
       Make utility with integrated functionality similar to
       autoconf/automake and compiler caches such as ccache. In short,
       SCons is an easier, more reliable and faster way to build
       software.
    '';
    platforms = stdenv.lib.platforms.all;
    maintainers = [ stdenv.lib.maintainers.simons ];
  };

  patches = [
    # http://www.scons.org/doc/HTML/scons-user/x1741.html
    # Some packages already override env the way shown in docs:
    #    env = Environment(ENV = {'PATH' : os.environ['PATH']})
    # or env = Environment(ENV = os.environ)
    # for those who don't yet (eg v8) is this patch.
    # The default PATH is not useful on NixOS anyway.
    ./path-from-env.patch
  ];
}
