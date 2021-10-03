{ fetchurl ? (import ../.. {}).fetchurl
}:

# Some stuff is problematic to fetch due to builtins.fetchurl being broken ATM.

{
  coreutils = fetchurl {
    url = "mirror://gnu/coreutils/coreutils-9.0.tar.xz";
    sha256 = "sha256-zjCs30pBvFuzDdlV6eqnX6IWtOPesIiJ7TJDPHs7l84=";
  };
  gnugrep = fetchurl {
    url = "mirror://gnu/grep/grep-3.7.tar.xz";
    sha256 = "0g42svbc1nq5bamxfj6x7320wli4dlj86padk0hwgbk04hqxl42w";
  };
  gzip = fetchurl {
    url = "mirror://gnu/gzip/gzip-1.11.tar.xz";
    sha256 = "01vrly90rvc98af6rcmrb3gwv1l6pylasvsdka23dffwizb9b6lv";
  };
}
