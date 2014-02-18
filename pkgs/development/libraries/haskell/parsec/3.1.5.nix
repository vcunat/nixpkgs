{ cabal, mtl, text }:

cabal.mkDerivation (self: {
  pname = "parsec";
  version = "3.1.5";
  sha256 = "1f1wg4qxp1ss2160sa3vbqff18fabwhqjkyfj4sgyfmwf9fj8wn5";
  buildDepends = [ mtl text ];
  jailbreak = true;
  meta = {
    homepage = "http://www.cs.uu.nl/~daan/parsec.html";
    description = "Monadic parser combinators";
    license = self.stdenv.lib.licenses.bsd3;
    platforms = self.ghc.meta.platforms;
    maintainers = [ self.stdenv.lib.maintainers.andres ];
  };
})
