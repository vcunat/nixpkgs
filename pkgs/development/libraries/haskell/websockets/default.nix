{ cabal, attoparsec, base64Bytestring, binary, blazeBuilder
, caseInsensitive, entropy, HUnit, ioStreams, mtl, network
, QuickCheck, random, SHA, testFramework, testFrameworkHunit
, testFrameworkQuickcheck2, text
}:

cabal.mkDerivation (self: {
  pname = "websockets";
  version = "0.8.2.2";
  sha256 = "16q4znki5f4133cgwcs8wqgx6ljl8x59khrsdsi646nclb3lyl0a";
  buildDepends = [
    attoparsec base64Bytestring binary blazeBuilder caseInsensitive
    entropy ioStreams mtl network random SHA text
  ];
  testDepends = [
    attoparsec base64Bytestring binary blazeBuilder caseInsensitive
    entropy HUnit ioStreams mtl network QuickCheck random SHA
    testFramework testFrameworkHunit testFrameworkQuickcheck2 text
  ];
  meta = {
    homepage = "http://jaspervdj.be/websockets";
    description = "A sensible and clean way to write WebSocket-capable servers in Haskell";
    license = self.stdenv.lib.licenses.bsd3;
    platforms = self.ghc.meta.platforms;
    maintainers = [ self.stdenv.lib.maintainers.ocharles ];
  };
})
