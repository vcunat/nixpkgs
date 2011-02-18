{ pidgin, stdenv, intltool, fetchurl} :

{

  botSentry = stdenv.mkDerivation {
    name = "pidgin-bot-sentry-1.3.0";
    buildInputs = [pidgin intltool ];
    src = fetchurl {
      url = "mirror://sourceforge/pidgin-bs/bot-sentry/1.3.0/bot-sentry-1.3.0.tar.bz2";
      sha256 = "0dp753dlgy27g6b3qg12zpm49c53gq1z8inj6b6q52jhi8r82mg6";
    };
    meta = {
      description = "Pidgin (libpurple) plugin to prevent Instant Message (IM) spam.";
      longDescription = ''
        Bot Sentry is a Pidgin (libpurple) plugin to prevent Instant Message
        (IM) spam. It allows you to ignore IMs unless the sender is in your
        Buddy List, the sender is in your Allow List, or the sender correctly
        answers a question you have predefined.
      '';
      homepage = http://sourceforge.net/projects/pidgin-bs;
      license = "GPLv3";
      maintainers = [stdenv.lib.maintainers.marcweber];
      platforms = stdenv.lib.platforms.linux;
    };
  };

}
