{ stdenv
, fetchurl
, ffmpeg
, cairo
, pango
, glib
, libXrender
, libXScrnSaver
, libXdamage
, gtk
, nspr
, nss
, fontconfig
, freetype
, alsaLib
, libX11
, GConf
, libXext
, libXt
, atk
, makeWrapper
, unzip
, expat
, zlib
, libjpeg
, bzip2
, libpng
, dbus
, dbus_glib
, patchelf
, cups
, libgcrypt
, libXtst
}:

assert stdenv.system == "i686-linux" || stdenv.system == "x86_64-linux" ;

stdenv.mkDerivation rec {
  name = "chrome-${version}";
  version = "74731";
  src =
    if stdenv.system == "x86_64-linux" then
      fetchurl {
        url = "http://build.chromium.org/f/chromium/continuous/linux64/2011-02-23/75832/chrome-linux.zip";
        sha256 = "020kncysnc48f9gb6cvndmmyl89r96fgmn6lwscmf14bpcpd44jg";
      }
    else if stdenv.system == "i686-linux" then
      fetchurl {
        url = throw "TODO";
        sha256 = "163z2b7c7plf0ys18mj0g5ppkdfw9sr8i089hy2h7l0xscp18s11";
      }
    else throw "Chromium is not supported on this platform.";

  phases = "unpackPhase installPhase";

  buildInputs = [makeWrapper unzip];

  libPath =
    stdenv.lib.makeLibraryPath
       [ GConf alsaLib atk bzip2 cairo cups dbus dbus_glib expat
         ffmpeg fontconfig freetype glib gtk libX11 libXScrnSaver
         libXdamage libXext libXrender libXt libXtst libgcrypt libjpeg
         libpng nspr nss pango stdenv.gcc.gcc zlib stdenv.gcc.libc ];

  installPhase = ''
    ensureDir $out/bin
    ensureDir $out/chrome
    ensureDir $out/lib

    cp -R * $out/chrome
    ln -s $out/chrome/chrome $out/bin/chrome
    ${patchelf}/bin/patchelf --interpreter "$(cat $NIX_GCC/nix-support/dynamic-linker)" --set-rpath ${libPath}:$out/lib:${stdenv.gcc.gcc}/lib64:${stdenv.gcc.gcc}/lib:${libXdamage}/lib $out/chrome/chrome

    ln -s ${nss}/lib/libsmime3.so $out/lib/libsmime3.so.1d
    ln -s ${nss}/lib/libnssutil3.so $out/lib/libnssutil3.so.1d
    ln -s ${nss}/lib/libssl3.so $out/lib/libssl3.so.1d
    ln -s ${nss}/lib/libnss3.so $out/lib/libnss3.so.1d
    ln -s ${nspr}/lib/libnspr4.so $out/lib/libnspr4.so.0d
    ln -s ${nspr}/lib/libplds4.so $out/lib/libplds4.so.0d
    ln -s ${nspr}/lib/libplc4.so $out/lib/libplc4.so.0d
  '';

  meta =  with stdenv.lib; {
    description = "Chromium, an open source web browser";
    homepage = http://www.chromium.org/;
    maintainers = [ maintainers.goibhniu ];
    license = licenses.bsd3;
  };
}
