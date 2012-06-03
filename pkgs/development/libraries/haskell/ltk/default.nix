{ cabal, Cabal, filepath, glib, gtk, mtl, parsec, transformers }:

cabal.mkDerivation (self: {
  pname = "ltk";
  version = "0.12.0.0";
  sha256 = "1hlsfi77yypfnvh1alr3rflbffby9pbmc71m507davr6b09v9w9f";
  buildDepends = [ Cabal filepath glib gtk mtl parsec transformers ];
  patchPhase = ''
    sed -i -e 's|mtl >=1.1.0.2 && <2.1|mtl|' -e 's|transformers >=0.2.2.0 && <0.3|transformers|' ltk.cabal
  '';
  meta = {
    homepage = "http://www.leksah.org";
    description = "Leksah tool kit";
    license = "GPL";
    platforms = self.stdenv.lib.platforms.linux;
    maintainers = [ self.stdenv.lib.maintainers.andres ];
  };
})
