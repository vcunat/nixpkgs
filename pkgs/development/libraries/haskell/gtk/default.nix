{cabal, cairo, glib, mtl, pango, gtk2hsBuildtools, pkgconfig, gtk, glibc}:

cabal.mkDerivation (self: {
  pname = "gtk";
  version = "0.12.0";
  sha256 = "1rqy0390rahdrlb1ba1hjrygwin8ynxzif5flcici22bg5ixsgs2";
  extraBuildInputs = [pkgconfig gtk2hsBuildtools gtk glibc];
  propagatedBuildInputs = [cairo glib mtl pango];
  meta = {
    homepage = "http://www.haskell.org/gtk2hs/";
    description = "Binding to the Gtk+ graphical user interface library";
    license = self.stdenv.lib.licenses.lgpl21;
    platforms = self.ghc.meta.platforms;
    maintainers = [
      self.stdenv.lib.maintainers.andres
      self.stdenv.lib.maintainers.simons
    ];
  };
})
