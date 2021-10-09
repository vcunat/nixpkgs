{ fetchurl ? (import ../.. {}).fetchurl
}:

# Some stuff is problematic to fetch due to builtins.fetchurl being broken ATM.
# Typically it's updates from staging branch of packages involved in stdenv bootstrapping.

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
  python =
    let
      sourceVersion = {
        major = "3";
        minor = "9";
        patch = "7";
        suffix = "";
      };
      sha256 = "0mrwbsdrdfrj8k1ap0cm6pw8h0rrhxivg6b338fh804cwqb5c57q";
      version = with sourceVersion; "${major}.${minor}.${patch}${suffix}";
    in
      fetchurl {
        url = with sourceVersion; "https://www.python.org/ftp/python/${major}.${minor}.${patch}/Python-${version}.tar.xz";
        inherit sha256;
      };
}
