{ cabal, attoparsec }:

cabal.mkDerivation (self: {
  pname = "attoparsec-binary";
  version = "0.2";
  sha256 = "02vswxsgayw50xli7mbacsjmk1diifzkfgnyfn9ck5mk41dl9rh5";
  buildDepends = [ attoparsec ];
  meta = {
    description = "Binary processing extensions to Attoparsec";
    license = self.stdenv.lib.licenses.bsd3;
    platforms = self.ghc.meta.platforms;
  };
})
