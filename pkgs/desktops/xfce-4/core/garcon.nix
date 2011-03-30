{ stdenv, fetchXfce, pkgconfig, intltool, gtk }:

stdenv.mkDerivation rec {
  name = "garcon-0.1.5";

  src = fetchXfce.core name "1xa0nciklqp6iizm7ngx1apfn2raas406r4k75zmn995bmq9bfkz";

  buildInputs = [ pkgconfig intltool gtk ];

  meta = {
    homepage = http://www.xfce.org/;
#TODO
    description = "";
    license = "";
  };
}
