{ cabal, transformers }:

cabal.mkDerivation (self: {
  pname = "monads-tf";
  version = "0.1.0.2";
  sha256 = "0z07z2lfm3l93fx0qhfd98j76d1rksi5llq67l5v09pm8da4jvyb";
  buildDepends = [ transformers ];
  meta = {
    description = "Monad classes, using type families";
    license = self.stdenv.lib.licenses.bsd3;
    platforms = self.ghc.meta.platforms;
    maintainers = [ self.stdenv.lib.maintainers.andres ];
  };
})
