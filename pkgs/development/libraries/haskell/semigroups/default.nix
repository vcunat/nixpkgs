# This file was auto-generated by cabal2nix. Please do NOT edit manually!

{ cabal, hashable, nats, text, unorderedContainers }:

cabal.mkDerivation (self: {
  pname = "semigroups";
  version = "0.15.2";
  sha256 = "1lh06d0mwivzbfjg635r3m39qcpyjvnwni7mspz96qb3zcm0c5kp";
  buildDepends = [ hashable nats text unorderedContainers ];
  meta = {
    homepage = "http://github.com/ekmett/semigroups/";
    description = "Anything that associates";
    license = self.stdenv.lib.licenses.bsd3;
    platforms = self.ghc.meta.platforms;
    maintainers = [ self.stdenv.lib.maintainers.andres ];
  };
})
