{
  mkDerivation, lib,
  extra-cmake-modules, kdoctools,
  qtsvg, qtwebkit, kdevelop-pg-qt, karchive, kio, kdelibs4support, ktexteditor
}:

mkDerivation {
  name = "umbrello";
  meta = {
    #license = with lib.licenses; [ FIXME ];
    #maintainers = [ lib.maintainers.TODO ];
  };
  nativeBuildInputs = [ extra-cmake-modules kdoctools ];
  buildInputs = [
    qtsvg qtwebkit kdevelop-pg-qt karchive kio kdelibs4support ktexteditor
    # see log for -- The following OPTIONAL packages have not been found:
  ];
}
