{stdenv, fetchurl, sourceFromHead, autoconf, automake, libtool, asciidoc,
  libxslt, libxml2, docbook_xml_dtd_45, docbook_xsl}:

stdenv.mkDerivation {
  name = "tinyproxy-git";

  enableParallelBuilding = true;

  # REGION AUTO UPDATE: { name="tinyproxy"; type="git"; url="git://banu.com/tinyproxy.git"; }
  src = sourceFromHead "tinyproxy-8fd3808ad315fcdf84648a2378324cfab21df0c1.tar.gz"
               (fetchurl { url = "http://mawercer.de/~nix/repos/tinyproxy-8fd3808ad315fcdf84648a2378324cfab21df0c1.tar.gz"; sha256 = "8aced719b8eef96d7ed90c06a46f58a6907ef523c305a0db90e1761f6e1b4352"; });
  # END

  buildInputs = [autoconf automake libtool asciidoc libxslt libxml2 docbook_xml_dtd_45 docbook_xsl];

  preConfigure = "./autogen.sh";

  meta = {
    description = "light-weight non caching HTTP proxy daemon";
    homepage = https://banu.com/tinyproxy;
    license = "GPLv2"; # or later
    maintainers = [stdenv.lib.maintainers.marcweber];
    platforms = stdenv.lib.platforms.linux;
  };
}
