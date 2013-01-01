{ stdenv, fetchurl, makeWrapper, which

# default dependencies
, bzip2, flac, speex
, libevent, expat, libjpeg
, libpng, libxml2, libxslt
, xdg_utils, yasm, zlib
, libusb1, libexif, pciutils

, python, perl, pkgconfig
, nspr, udev, krb5
, utillinux, alsaLib
, gcc, bison, gperf
, glib, gtk, dbus_glib
, libXScrnSaver, libXcursor, mesa

# optional dependencies
, libgcrypt ? null # gnomeSupport || cupsSupport

# package customization
, channel ? "stable"
, enableSELinux ? false, libselinux ? null
, enableNaCl ? false
, useOpenSSL ? false, nss ? null, openssl ? null
, gnomeSupport ? false, gconf ? null
, gnomeKeyringSupport ? false, libgnome_keyring ? null
, proprietaryCodecs ? true
, cupsSupport ? false
, pulseSupport ? false, pulseaudio ? null
}:

with stdenv.lib;

let
  sourceInfo = builtins.getAttr channel (import ./sources.nix);

  mkGypFlags =
    let
      sanitize = value:
        if value == true then "1"
        else if value == false then "0"
        else "${value}";
      toFlag = key: value: "-D${key}=${sanitize value}";
    in attrs: concatStringsSep " " (attrValues (mapAttrs toFlag attrs));

  gypFlagsUseSystemLibs = {
    use_system_bzip2 = true;
    use_system_flac = true;
    use_system_libevent = true;
    use_system_libexpat = true;
    use_system_libexif = true;
    use_system_libjpeg = true;
    use_system_libpng = true;
    use_system_libusb = true;
    use_system_libxml = true;
    use_system_speex = true;
    use_system_ssl = useOpenSSL;
    use_system_stlport = true;
    use_system_xdg_utils = true;
    use_system_yasm = true;
    use_system_zlib = false; # http://crbug.com/143623

    use_system_harfbuzz = false;
    use_system_icu = false;
    use_system_libwebp = false; # http://crbug.com/133161
    use_system_skia = false;
    use_system_sqlite = false; # http://crbug.com/22208
    use_system_v8 = false;
  };

  defaultDependencies = [
    bzip2 flac speex
    libevent expat libjpeg
    libpng libxml2 libxslt
    xdg_utils yasm zlib
    libusb1 libexif
  ];

  post23 = !versionOlder sourceInfo.version "24.0.0.0";
  post24 = !versionOlder sourceInfo.version "25.0.0.0";

  maybeFixPulseAudioBuild = optional (post23 && pulseSupport) (fetchurl {
    url = http://archrepo.jeago.com/sources/chromium-dev/pulse_audio_fix.patch;
    sha256 = "1w91mirrkqigdhsj892mqxlc0nlv1dsp5shc46w9xf8nl96jxgfb";
  });

in stdenv.mkDerivation rec {
  name = "${packageName}-${version}";
  packageName = "chromium";

  version = sourceInfo.version;

  src = fetchurl {
    url = sourceInfo.url;
    sha256 = sourceInfo.sha256;
  };

  buildInputs = defaultDependencies ++ [
    which makeWrapper
    python perl pkgconfig
    nspr udev
    (if useOpenSSL then openssl else nss)
    utillinux alsaLib
    gcc bison gperf
    krb5
    glib gtk dbus_glib
    libXScrnSaver libXcursor mesa
  ] ++ optional gnomeKeyringSupport libgnome_keyring
    ++ optionals gnomeSupport [ gconf libgcrypt ]
    ++ optional enableSELinux libselinux
    ++ optional cupsSupport libgcrypt
    ++ optional pulseSupport pulseaudio
    ++ optional post24 pciutils;

  opensslPatches = optional useOpenSSL openssl.patches;

  prePatch = "patchShebangs .";

  patches = optional cupsSupport ./cups_allow_deprecated.patch
         ++ optional pulseSupport ./pulseaudio_array_bounds.patch
         ++ maybeFixPulseAudioBuild;

  postPatch = optionalString useOpenSSL ''
    cat $opensslPatches | patch -p1 -d third_party/openssl/openssl
  '';

  gypFlags = mkGypFlags (gypFlagsUseSystemLibs // {
    linux_use_gold_binary = false;
    linux_use_gold_flags = false;
    proprietary_codecs = false;
    use_gnome_keyring = gnomeKeyringSupport;
    use_gconf = gnomeSupport;
    use_gio = gnomeSupport;
    use_pulseaudio = pulseSupport;
    disable_nacl = !enableNaCl;
    use_openssl = useOpenSSL;
    selinux = enableSELinux;
    use_cups = cupsSupport;
  } // optionalAttrs proprietaryCodecs {
    # enable support for the H.264 codec
    proprietary_codecs = true;
    ffmpeg_branding = "Chrome";
  } // optionalAttrs (stdenv.system == "x86_64-linux") {
    target_arch = "x64";
  } // optionalAttrs (stdenv.system == "i686-linux") {
    target_arch = "ia32";
  });

  buildType = "Release";

  enableParallelBuilding = true;

  configurePhase = ''
    python build/gyp_chromium --depth "$(pwd)" ${gypFlags}
  '';

  makeFlags = let
    CC = "${gcc}/bin/gcc";
    CXX = "${gcc}/bin/g++";
  in [
    "CC=${CC}"
    "CXX=${CXX}"
    "CC.host=${CC}"
    "CXX.host=${CXX}"
    "LINK.host=${CXX}"
  ];

  buildFlags = [
    "BUILDTYPE=${buildType}"
    "library=shared_library"
    "chrome"
  ];

  installPhase = ''
    mkdir -vp "$out/libexec/${packageName}"
    cp -v "out/${buildType}/"*.pak "$out/libexec/${packageName}/"
    cp -vR "out/${buildType}/locales" "out/${buildType}/resources" "$out/libexec/${packageName}/"
    cp -v out/${buildType}/libffmpegsumo.so "$out/libexec/${packageName}/"

    cp -v "out/${buildType}/chrome" "$out/libexec/${packageName}/${packageName}"

    mkdir -vp "$out/bin"
    makeWrapper "$out/libexec/${packageName}/${packageName}" "$out/bin/${packageName}"

    mkdir -vp "$out/share/man/man1"
    cp -v "out/${buildType}/chrome.1" "$out/share/man/man1/${packageName}.1"

    for icon_file in chrome/app/theme/chromium/product_logo_*[0-9].png; do
      num_and_suffix="''${icon_file##*logo_}"
      icon_size="''${num_and_suffix%.*}"
      logo_output_path="$out/share/icons/hicolor/''${icon_size}x''${icon_size}/apps"
      mkdir -vp "$logo_output_path"
      cp -v "$icon_file" "$logo_output_path/${packageName}.png"
    done
  '';

  meta = {
    description = "Chromium, an open source web browser";
    homepage = http://www.chromium.org/;
    maintainers = with maintainers; [ goibhniu chaoflow ];
    license = licenses.bsd3;
    platforms = platforms.linux;
  };
}
