# This file was auto-generated by cabal2nix. Please do NOT edit manually!

{ cabal, exceptions, hspec, liftedBase, mmorph, monadControl, mtl
, QuickCheck, resourcet, transformers, transformersBase, void
}:

cabal.mkDerivation (self: {
  pname = "conduit";
  version = "1.1.7";
  sha256 = "0xk2his7qbidnzs56xcgnjipbnqmmnh74qy8dfvbznkkqhxdzmz6";
  buildDepends = [
    exceptions liftedBase mmorph monadControl mtl resourcet
    transformers transformersBase void
  ];
  testDepends = [
    exceptions hspec mtl QuickCheck resourcet transformers void
  ];
  doCheck = false;
  meta = {
    homepage = "http://github.com/snoyberg/conduit";
    description = "Streaming data processing library";
    license = self.stdenv.lib.licenses.mit;
    platforms = self.ghc.meta.platforms;
    maintainers = [ self.stdenv.lib.maintainers.andres ];
  };
})
