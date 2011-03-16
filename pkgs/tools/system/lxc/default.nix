{stdenv, fetchurl, libcap}:

stdenv.mkDerivation rec{
  name = "lxc-0.7.4";

  src = fetchurl {
    url = "mirror://sourceforge/lxc/${name}.tar.gz";
    sha256 = "1xpf82wzkc50civjv67ighcjpwd6g96xdyd9kainclm088m7n8x8";
  };

  patchPhase = ''
    sed -i -e '/ldconfig/d' src/lxc/Makefile.in
  '';

  configureFlags = [ "--localstatedir=/var" ];

  buildInputs = [ libcap ];

  meta = {
    homepage = http://lxc.sourceforge.net;
    description = "lxc Linux Containers userland tools";
    license = "LGPLv2.1+";
    platforms = stdenv.lib.platforms.linux;
  };
}
