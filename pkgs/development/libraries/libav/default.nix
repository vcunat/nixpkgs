{ stdenv, fetchurl, pkgconfig, yasm, bzip2, zlib
, mp3Support    ? true,   lame      ? null
, speexSupport  ? true,   speex     ? null
, theoraSupport ? true,   libtheora ? null
, vorbisSupport ? true,   libvorbis ? null
, vpxSupport    ? false,  libvpx    ? null
, x264Support   ? false,  x264      ? null
, xvidSupport   ? true,   xvidcore  ? null
, faacSupport   ? false,  faac      ? null
, vaapiSupport  ? false,  libva     ? null # ToDo: it has huge closure
, vdpauSupport  ? true,   libvdpau  ? null
, freetypeSupport ? true, freetype  ? null # it's small and almost everywhere
, SDL # only for avplay in $tools, adds nontrivial closure to it
}:

with { inherit (stdenv.lib) optional; };

/* ToDo:
    - more deps, inspiration: http://packages.ubuntu.com/raring/libav-tools
    - maybe do some more splitting into outputs
*/

let derivSrc = rec { # derivSrc is exported and re-used by expressions for older versions
  name = "libav-9.6";

  src = fetchurl {
    url = "http://libav.org/releases/${name}.tar.xz";
    sha256 = "118wx8p12lh57yzx5vss32almfa0w3gaxwa0ljcz3xvy4xf1nm03";
  };

  configureFlags =
    assert stdenv.lib.all (x: x!=null) buildInputs;
  [
    "--enable-gpl" # for `swscale', can only be used in GPLd packages
    #"--enable-postproc" # it's now a separate package in upstream
    "--enable-swscale"
    "--disable-avserver" # upstream says it's in a bad state
    "--enable-avplay"
    "--enable-shared"
    "--enable-runtime-cpudetect"
  ]
    ++ optional mp3Support "--enable-libmp3lame"
    ++ optional speexSupport "--enable-libspeex"
    ++ optional theoraSupport "--enable-libtheora"
    ++ optional vorbisSupport "--enable-libvorbis"
    ++ optional vpxSupport "--enable-libvpx"
    ++ optional x264Support "--enable-libx264"
    ++ optional xvidSupport "--enable-libxvid"
    ++ optional faacSupport "--enable-libfaac --enable-nonfree"
    ++ optional vaapiSupport "--enable-vaapi"
    ++ optional vdpauSupport "--enable-vdpau"
    ++ optional freetypeSupport "--enable-libfreetype"
    ;

  buildInputs = [ pkgconfig lame yasm zlib bzip2 SDL ]
    ++ optional mp3Support lame
    ++ optional speexSupport speex
    ++ optional theoraSupport libtheora
    ++ optional vorbisSupport libvorbis
    ++ optional vpxSupport libvpx
    ++ optional x264Support x264
    ++ optional xvidSupport xvidcore
    ++ optional faacSupport faac
    ++ optional vaapiSupport libva
    ++ optional vdpauSupport libvdpau
    ++ optional freetypeSupport freetype
    ;

  enableParallelBuilding = true;

  outputs = [ "out" "tools" ];

  postInstall = ''
    mkdir -p "$tools/bin"
    mv "$out/bin/avplay" "$tools/bin"
    cp -s "$out"/bin/* "$tools/bin/"
  '';

  doInstallCheck = true;
  installCheckTarget = "check"; # tests need to be run *after* installation

  crossAttrs = {
    dontSetConfigureCross = true;
    configureFlags = configureFlags ++ [
      "--cross-prefix=${stdenv.cross.config}-"
      "--enable-cross-compile"
      "--target_os=linux"
      "--arch=${stdenv.cross.arch}"
      ];
  };

  passthru = { inherit derivSrc; };

  meta = {
    homepage = http://libav.org/;
    description = "A complete, cross-platform solution to record, convert and stream audio and video (fork of ffmpeg)";
    license = "GPLv2+";
  };
};
in stdenv.mkDerivation derivSrc

