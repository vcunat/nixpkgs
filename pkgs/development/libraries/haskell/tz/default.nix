# This file was auto-generated by cabal2nix. Please do NOT edit manually!

{ cabal, binary, bindingsPosix, deepseq, HUnit, pkgs_tzdata
, QuickCheck, testFramework, testFrameworkHunit
, testFrameworkQuickcheck2, testFrameworkTh, time, tzdata, vector
}:

cabal.mkDerivation (self: {
  pname = "tz";
  version = "0.0.0.8";
  sha256 = "0rabdqwdj8hx17817zsfsih01agx7n3kja8s0axmm0drq22vlflv";
  buildDepends = [ binary deepseq time tzdata vector ];
  testDepends = [
    bindingsPosix HUnit QuickCheck testFramework testFrameworkHunit
    testFrameworkQuickcheck2 testFrameworkTh time tzdata vector
  ];
  preConfigure = "export TZDIR=${pkgs_tzdata}/share/zoneinfo";
  meta = {
    homepage = "https://github.com/nilcons/haskell-tz";
    description = "Efficient time zone handling";
    license = self.stdenv.lib.licenses.asl20;
    platforms = self.ghc.meta.platforms;
  };
})
