{ cabal, hspec, HUnit, pathPieces, text, vector }:

cabal.mkDerivation (self: {
  pname = "yesod-routes";
  version = "1.2.0.6";
  sha256 = "0hd2f2w9pb865fn9qijh3j73sc1x7gzd4c0q5mgjy9lh9hd4kzix";
  buildDepends = [ pathPieces text vector ];
  testDepends = [ hspec HUnit pathPieces text ];
  meta = {
    homepage = "http://www.yesodweb.com/";
    description = "Efficient routing for Yesod";
    license = self.stdenv.lib.licenses.mit;
    platforms = self.ghc.meta.platforms;
    maintainers = [ self.stdenv.lib.maintainers.andres ];
  };
})
