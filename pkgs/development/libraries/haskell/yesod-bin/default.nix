{ cabal, attoparsec, base64Bytestring, blazeBuilder, Cabal, conduit
, conduitExtra, dataDefaultClass, fileEmbed, filepath, fsnotify
, ghcPaths, httpConduit, httpReverseProxy, httpTypes, liftedBase
, network, networkConduit, optparseApplicative, parsec
, projectTemplate, resourcet, shakespeare, shakespeareCss
, shakespeareJs, shakespeareText, split, streamingCommons
, systemFileio, systemFilepath, tar, text, time, transformers
, unixCompat, unorderedContainers, wai, waiExtra, warp, yaml, zlib
}:

cabal.mkDerivation (self: {
  pname = "yesod-bin";
  version = "1.2.9.1";
  sha256 = "0x7r960sq6r3lds0sgjvrp8z6b275iggr0isny0b6rz5ynwd6bcz";
  isLibrary = false;
  isExecutable = true;
  buildDepends = [
    attoparsec base64Bytestring blazeBuilder Cabal conduit conduitExtra
    dataDefaultClass fileEmbed filepath fsnotify ghcPaths httpConduit
    httpReverseProxy httpTypes liftedBase network networkConduit
    optparseApplicative parsec projectTemplate resourcet shakespeare
    shakespeareCss shakespeareJs shakespeareText split streamingCommons
    systemFileio systemFilepath tar text time transformers unixCompat
    unorderedContainers wai waiExtra warp yaml zlib
  ];
  meta = {
    homepage = "http://www.yesodweb.com/";
    description = "The yesod helper executable";
    license = self.stdenv.lib.licenses.mit;
    platforms = self.ghc.meta.platforms;
  };
})
