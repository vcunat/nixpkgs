{ cabal, filepath, haskellSrcExts, syb, transformers, uniplate }:

cabal.mkDerivation (self: {
  pname = "derive";
  version = "2.5.15";
  sha256 = "18r7n6bd3w5347yx6m352r8jbyn6qf2364mdz62891hdv7vqb629";
  isLibrary = true;
  isExecutable = true;
  buildDepends = [
    filepath haskellSrcExts syb transformers uniplate
  ];
  meta = {
    homepage = "http://community.haskell.org/~ndm/derive/";
    description = "A program and library to derive instances for data types";
    license = self.stdenv.lib.licenses.bsd3;
    platforms = self.ghc.meta.platforms;
    maintainers = [ self.stdenv.lib.maintainers.andres ];
  };
})
