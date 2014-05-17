{ cabal, attoparsec, blazeBuilder, deepseq, dlist, hashable, HUnit
, mtl, QuickCheck, scientific, syb, testFramework
, testFrameworkHunit, testFrameworkQuickcheck2, text, time
, unorderedContainers, vector
}:

cabal.mkDerivation (self: {
  pname = "aeson";
  version = "0.7.0.4";
  sha256 = "009grccll41mkf7rarpcrn06l8vc0q0y8l4j9nbdfcl89153rj2k";
  buildDepends = [
    attoparsec blazeBuilder deepseq dlist hashable mtl scientific syb
    text time unorderedContainers vector
  ];
  testDepends = [
    attoparsec HUnit QuickCheck testFramework testFrameworkHunit
    testFrameworkQuickcheck2 text time unorderedContainers vector
  ];
  patchPhase = ''
    sed -i -e 's|scientific >=.*,|scientific,|' aeson.cabal
  '';
  meta = {
    homepage = "https://github.com/bos/aeson";
    description = "Fast JSON parsing and encoding";
    license = self.stdenv.lib.licenses.bsd3;
    platforms = self.ghc.meta.platforms;
    maintainers = [ self.stdenv.lib.maintainers.andres ];
  };
})
