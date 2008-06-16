args : with args; 
rec {
  src = fetchurl {
    url = http://downloads.sourceforge.net/funpidgin/carrier-2.4.2.tar.bz2;
    sha256 = "176mi7gxkvvrmxsd58bi8qgkc209gpnlp21hh3j0dmb9zszyh7kp";
  };

  buildInputs = [gtkspell aspell
    GStreamer startupnotification
    libxml2 openssl nss
    libXScrnSaver ncurses scrnsaverproto 
    libX11 xproto kbproto GConf avahi
    dbus dbus_glib glib python 
    autoconf libtool automake];

  propagatedBuildInputs = [
    pkgconfig gtk perl perlXMLParser gettext
  ];

  configureFlags="--with-nspr-includes=${nss}/include/nspr"
    + " --with-nspr-libs=${nss}/lib --with-nss-includes=${nss}/include/nss"
    + " --with-nss-libs=${nss}/lib --with-ncurses-headers=${ncurses}/include"
    + " --enable-screensaver --disable-meanwhile --disable-nm --disable-tcl";

  preBuild = FullDepEntry (''
    export echo=echo
  '') [];

  /* doConfigure should be specified separately */
  phaseNames = ["doConfigure" "preBuild" "doMakeInstall"];
      
  name = "carrier-" + version;
  meta = {
    description = "Carrier - PidginIM GUI fork with user-friendly development model";
    homepage = http://funpidgin.sf.net; 
  };
}

