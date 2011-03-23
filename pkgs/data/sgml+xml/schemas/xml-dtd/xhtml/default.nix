{stdenv, fetchurl}:

stdenv.mkDerivation {
  name = "w3c-xhtml-1-20020801";

  src = fetchurl {
    url = http://www.w3.org/TR/xhtml1/xhtml1.tgz;
    sha256 = "0rr0d89i0z75qvjbm8il93bippx09hbmjwy0y2sj44n9np69x3hl";
  };

  buildInputs = [];

  installPhase = ''
    t=$out/xml/dtd/w3c-xhtml
    ensureDir $t
    cp DTD/* $t
    cat >> $t/catalog.xml << EOF
    <?xml version='1.0'?>

    <catalog xmlns="urn:oasis:names:tc:entity:xmlns:xml:catalog">

    <public publicId="-//W3C//DTD XHTML 1.0 Frameset//EN"
            uri="xhtml1-frameset.dtd"/>
    <public publicId="-//W3C//DTD XHTML 1.0 Strict//EN"
            uri="xhtml1-strict.dtd"/>
    <public publicId="-//W3C//DTD XHTML 1.0 Transitional//EN"
            uri="xhtml1-transitional.dtd"/>


    <public publicId="http://www.w3.org/TR/xhtml1/DTD/xhtml-lat1.ent"
            uri="xhtml-lat1.ent"/>
    <public publicId="http://www.w3.org/TR/xhtml1/DTD/xhtml-special.ent"
            uri="xhtml-special.ent"/>
    <public publicId="http://www.w3.org/TR/xhtml1/DTD/xhtml-symbol.ent"
            uri="xhtml-symbol.ent"/>

    </catalog>
    EOF
  '';

  meta = {
    description = "xhtml dtds";
    homepage = http://www.w3.org/TR/xhtml1/dtds.html;
    maintainers = [stdenv.lib.maintainers.marcweber];
    platforms = stdenv.lib.platforms.linux;
  };
}
