{ stdenv, fetchurl, pkgconfig, dbus, libnih }:

stdenv.mkDerivation rec {
  name = "upstart-1.0";
  
  src = fetchurl {
    url = http://launchpad.net/upstart/1.x/1.0/+download/upstart-1.0.tar.gz;
    sha256 = "05n608vcb6184ncaw40b6frjyyr9w7apkbnwrh334jf9hz5ypp8f";
  };

  buildInputs = [ pkgconfig dbus libnih ];
  
  NIX_CFLAGS_COMPILE =
    ''
      -DSHELL="${stdenv.shell}"
      -DCONFFILE="/etc/init.conf"
      -DCONFDIR="/etc/init"
      -DPATH="/no-path"
    '';

  # The interface version prevents NixOS from switching to an
  # incompatible Upstart at runtime.  (Switching across reboots is
  # fine, of course.)  It should be increased whenever Upstart changes
  # in a backwards-incompatible way.  If the interface version of two
  # Upstart builds is the same, then we can switch between them at
  # runtime; otherwise we can't and we need to reboot.
  passthru.interfaceVersion = 2;

  postInstall = ''
    t=$out/etc/bash_completion.d
    ensureDir $t
    mv contrib/bash_completion/upstart $t
    sed -i 's@\<have\> \([^ ]\+\)@type -p \1 \&>/dev/null@' $t/upstart
  '';

  meta = {
    homepage = "http://upstart.ubuntu.com/";
    description = "An event-based replacement for the /sbin/init daemon";
  };
}
