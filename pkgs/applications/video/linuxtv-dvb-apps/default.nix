{stdenv, fetchurl, perl}:

stdenv.mkDerivation {

  name = "linuxtv-dvb-apps-1.1.1-rev1207-4";

  # referenced here: http://www.mythtv.org/wiki/Dvb-apps but all sources are down
  # using debian snapshots

  src = fetchurl {
    url = http://ftp.de.debian.org/debian/pool/main/l/linuxtv-dvb-apps/linuxtv-dvb-apps_1.1.1+rev1207.orig.tar.gz;
    md5 = "7d094078d46c11d2ec92efc3fac337f0";
  };

  preConfigure = ''
    makeFlags=prefix=$out
  '';

  buildInputs = [perl];

  meta = {
    description = "dvb tools for linux known as dvbutils or dvbapps"; # not same as dvbutils on sourceforge!
    homepage = http://linuxtv.org; # currently down but google visited the page several days ago
    license = "GPLv2";
    maintainers = [stdenv.lib.maintainers.marcweber];
    platforms = stdenv.lib.platforms.linux;
  };
}
