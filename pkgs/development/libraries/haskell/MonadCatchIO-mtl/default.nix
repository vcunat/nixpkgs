{ cabal, extensibleExceptions, MonadCatchIOTransformers }:

cabal.mkDerivation (self: {
  pname = "MonadCatchIO-mtl";
  version = "0.3.1.0";
  sha256 = "0qarf73c8zq8dgvxdiwqybpjfy8gba9vf4k0skiwyk5iphilxhhq";
  buildDepends = [ extensibleExceptions MonadCatchIOTransformers ];
  meta = {
    homepage = "http://darcsden.com/jcpetruzza/MonadCatchIO-mtl";
    description = "Monad-transformer version of the Control.Exception module";
    license = self.stdenv.lib.licenses.bsd3;
    platforms = self.ghc.meta.platforms;
    maintainers = [ self.stdenv.lib.maintainers.andres ];
  };
})
