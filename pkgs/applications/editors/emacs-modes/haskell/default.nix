{stdenv, fetchurl, emacs, sourceFromHead}:

stdenv.mkDerivation rec {
  name = "haskell-mode-darcs";

  # REGION AUTO UPDATE: { name="haskellmode-emacs"; type="darcs"; url = "http://code.haskell.org/haskellmode-emacs/"; }
  src = sourceFromHead "haskellmode-emacs-nrmtag1.tar.gz"
               (fetchurl { url = "http://mawercer.de/~nix/repos/haskellmode-emacs-nrmtag1.tar.gz"; sha256 = "cd301e94648be0795acfa792f18b76a4b985f4d6b98e9319ae6ad29d2f8087cc"; });
  # END

  /* is gone:
  name = "haskell-mode-2.8.0";
  src = fetchurl {
    url = "http://projects.haskell.org/haskellmode-emacs/${name}.tar.gz";
    sha256 = "1065g4xy3ca72xhqh6hfxs5j3mls82bli8w5rhz1npzyfwlwhkb1";
  };
  */

  buildInputs = [emacs];

  installPhase = ''
    ensureDir "$out/share/emacs/site-lisp"
    cp *.el *.elc *.hs "$out/share/emacs/site-lisp/"
  '';

  meta = {
    homepage = "http://projects.haskell.org/haskellmode-emacs/";
    description = "Haskell mode package for Emacs";

    platforms = stdenv.lib.platforms.unix;
    maintainers = [ stdenv.lib.maintainers.simons ];
  };
}
