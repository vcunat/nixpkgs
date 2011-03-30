args: with args;

let

    src_haxe_swflib = {
      # REGION AUTO UPDATE:                                { name = "haxe_swflib"; type="cvs"; cvsRoot = ":pserver:anonymous@cvs.motion-twin.com:/cvsroot"; module = "ocaml/swflib"; groups = "haxe_group"; }
      src = (fetchurl { url = "http://mawercer.de/~nix/repos/haxe_swflib-cvs-F_14-39-27.tar.bz2"; sha256 = "4807ff68044330f5eb512715008fcba955b5bdfcc3b3b13a38f43c1ce599272a"; });
      name = "haxe_swflib-cvs-F_14-39-27";
      # END
    }.src;

    src_haxe_extc = { 
      # REGION AUTO UPDATE:                                { name = "haxe_extc"; type="cvs"; cvsRoot = ":pserver:anonymous@cvs.motion-twin.com:/cvsroot"; module = "ocaml/extc"; groups = "haxe_group"; }
      src = (fetchurl { url = "http://mawercer.de/~nix/repos/haxe_extc-cvs-F_14-42-13.tar.bz2"; sha256 = "8c78c3cdbf25639c34d82a6bb8427df96dab895864fcf1ccfa247c29f6eb001f"; });
      name = "haxe_extc-cvs-F_14-42-13";
      # END
    }.src;

    src_haxe_extlib_dev = { 
      # REGION AUTO UPDATE:                                { name = "haxe_extlib_dev"; type="cvs"; cvsRoot = ":pserver:anonymous@cvs.motion-twin.com:/cvsroot"; module = "ocaml/extlib-dev"; groups = "haxe_group"; }
      src = (fetchurl { url = "http://mawercer.de/~nix/repos/haxe_extlib_dev-cvs-F_14-41-03.tar.bz2"; sha256 = "1c6f28de716479535c71e4472a126b06005c754be91c0740cf45253898ad09ad"; });
      name = "haxe_extlib_dev-cvs-F_14-41-03";
      # END
    }.src;

    src_haxe_xml_light = { 
      # REGION AUTO UPDATE:                                { name = "haxe_xml_light"; type="cvs"; cvsRoot = ":pserver:anonymous@cvs.motion-twin.com:/cvsroot"; module = "ocaml/xml-light"; groups = "haxe_group"; }
      src = (fetchurl { url = "http://mawercer.de/~nix/repos/haxe_xml_light-cvs-F_14-39-25.tar.bz2"; sha256 = "26179f74797f1b8760355578787359e2c6224d3d1ba53cb205336b35abd9ff63"; });
      name = "haxe_xml_light-cvs-F_14-39-25";
      # END
    }.src;

    src_haxe_neko_include = { 
      # REGION AUTO UPDATE:                                { name = "haxe_neko_include"; type="cvs"; cvsRoot = ":pserver:anonymous@cvs.motion-twin.com:/cvsroot"; module = "neko/libs/include/ocaml"; groups = "haxe_group"; }
      src = (fetchurl { url = "http://mawercer.de/~nix/repos/haxe_neko_include-cvs-F_14-40-21.tar.bz2"; sha256 = "5374a0a3a070a250c047905c95fcf326b7798544478790dda8604b03d7d094ea"; });
      name = "haxe_neko_include-cvs-F_14-40-21";
      # END
    }.src;

    src_haxe = {
      # REGION AUTO UPDATE:       { name="haxe-read-only"; type="svn"; url="http://haxe.googlecode.com/svn/trunk"; groups = "haxe_group"; }
      src = (fetchurl { url = "http://mawercer.de/~nix/repos/haxe-read-only-svn-3742.tar.bz2"; sha256 = "94174fe43dca35950c00ab9387e883813bc856646219259af83c80d679cb450f"; });
      name = "haxe-read-only-svn-3742";
      # END
    }.src;


    # the HaXe compiler
    haxe = stdenv.mkDerivation {
      name = "haxe-cvs";

      buildInputs = [ocaml zlib makeWrapper];

      src = src_haxe;

      inherit zlib;

      buildPhase = ''
        set -x
        mkdir -p ocaml/{swflib,extc,extlib-dev,xml-light} neko/libs

        # strange setup. install.ml seems to co the same repo again into haxe directory!
        mkdir haxe
        tar xfj $src --strip-components=1 -C haxe

        t(){ tar xfj $1 -C $2 --strip-components=2; }
        t ${src_haxe_swflib} ocaml/swflib
        t ${src_haxe_extc} ocaml/extc
        t ${src_haxe_extlib_dev} ocaml/extlib-dev
        t ${src_haxe_xml_light} ocaml/xml-light
        t ${src_haxe_neko_include} neko/libs

        sed -e '/download();/d' \
            -e "s@/usr/lib/@''${zlib}/lib/@g" \
            doc/install.ml > install.ml
        
        ocaml install.ml
      '';

      # probably rpath should be set properly
      installPhase = ''
        ensureDir $out/lib/haxe
        cp -r bin $out/bin
        wrapProgram "$out/bin/haxe" \
          --set "LD_LIBRARY_PATH" $zlib/lib \
          --set HAXE_LIBRARY_PATH "''${HAXE_LIBRARY_PATH}''${HAXE_LIBRARY_PATH:-:}:$out/lib/haxe/std:."
        cp -r std $out/lib/haxe/
      '';

      meta = { 
        description = "programming language targeting JavaScript, Flash, NekVM, PHP, C++";
        homepage = http://haxe.org;
        license = ["GPLv2" "BSD2" /*?*/ ];  # -> docs/license.txt
        maintainers = [args.lib.maintainers.marcweber];
        platforms = args.lib.platforms.linux;
      };
    };

    # build a tool found in std/tools/${name} source directory
    # the .hxml files contain a recipe  to cerate a binary.
    tool = { name, description }: stdenv.mkDerivation {

        inherit name;

        src = src_haxe;

        buildPhase = ''
          cd std/tools/${name};
          haxe *.hxml
          ensureDir $out/bin
          mv ${name} $out/bin/
        '';

        buildInputs = [haxe neko];

        dontStrip=1;

        installPhase=":";

        meta = {
          inherit description;
          homepage = http://haxe.org;
          # license = "?"; TODO
          maintainers = [args.lib.maintainers.marcweber];
          platforms = args.lib.platforms.linux;
        };

      };

in

{

  inherit haxe;

  haxelib = tool {
    name = "haxelib";
    description = "haxelib is a HaXe library management tool similar to easyinstall or ruby gems";
  };

}
