{stdenv, fetchurl, p7zip, coreutils, gnugrep}:

let
  version = "110.72";

  # gentoo is using these files:
  sources = map fetchurl [
    { url = "http://smlnj.cs.uchicago.edu/dist/working/${version}/config.tgz"; sha256 = "0x99sgrpg6r8prsbnxg54zwnbd74kx35h2hxr9145c9yclgmidf7"; }
    { url = "http://smlnj.cs.uchicago.edu/dist/working/${version}/cm.tgz"; sha256 = "0bfs4mk1xvbz5qm8wk1ncb6c0x3dzkkwxgf7b9q150lmr13y97gx"; }
    { url = "http://smlnj.cs.uchicago.edu/dist/working/${version}/compiler.tgz"; sha256 = "0pxi012mj7yda9wsvlgq5ij80ypgcyhi9rarnc3dgirrrz2378hp"; }
    { url = "http://smlnj.cs.uchicago.edu/dist/working/${version}/runtime.tgz"; sha256 = "0z2m55f69snz4wp1530lhhnsqk8hjzbr4iqp1pqfj6pnc45wd8kv"; }
    { url = "http://smlnj.cs.uchicago.edu/dist/working/${version}/system.tgz"; sha256 = "0nxjj00381ql1yas9a57ggzykk11sfzg2wcfhlskia1zvivwmjri"; }
    { url = "http://smlnj.cs.uchicago.edu/dist/working/${version}/MLRISC.tgz"; sha256 = "13ns0sjlq7qizm4ycsix4yacnif5bkp0qci9zcnqmhdhrbs01hwx"; }
    { url = "http://smlnj.cs.uchicago.edu/dist/working/${version}/smlnj-lib.tgz"; sha256 = "0sv385axq0wjc9qx5410imk1b05lw3mwyaj3a5his2i4c8n1vq4a"; }
    { url = "http://smlnj.cs.uchicago.edu/dist/working/${version}/ckit.tgz"; sha256 = "13dmx0bv57xmh5qza0pdqfjzlq6cdfj3yplaqbgwfw3aisp22glj"; }
    { url = "http://smlnj.cs.uchicago.edu/dist/working/${version}/nlffi.tgz"; sha256 = "1dhfns546skynfy1k31q4ac0mdw2ci84b6pb8bvs6p7yzvdk3sm5"; }
    { url = "http://smlnj.cs.uchicago.edu/dist/working/${version}/cml.tgz"; sha256 = "08qi5wbfac74z4wx0rcw7r92l6jvrz5j5rfb8q4rck5vi0v25yay"; }
    { url = "http://smlnj.cs.uchicago.edu/dist/working/${version}/eXene.tgz"; sha256 = "0gzcyy1h0rh9n89yijnxqv0wg01a39rn80zm9xzayaal6sv8rs4f"; }
    { url = "http://smlnj.cs.uchicago.edu/dist/working/${version}/ml-lex.tgz"; sha256 = "0pjpxirrcczjrk1lb721argq10n00ah08w9rij09vqcdcmlca1fm"; }
    { url = "http://smlnj.cs.uchicago.edu/dist/working/${version}/ml-yacc.tgz"; sha256 = "0gir4nch67b2pbcnlc3jygrjh7vwsvir212r332w46my1d954rgp"; }
    { url = "http://smlnj.cs.uchicago.edu/dist/working/${version}/ml-burg.tgz"; sha256 = "026kjmaf14j968phsxlk1lcc3n3zl7rlzllxkagj3janzma50rqm"; }
    { url = "http://smlnj.cs.uchicago.edu/dist/working/${version}/ml-lpt.tgz"; sha256 = "0q8fpr2hvcr040n6iwaa3z7a8d4ivjm4nvsnizry7bjc854khdfd"; }
    { url = "http://smlnj.cs.uchicago.edu/dist/working/${version}/pgraph.tgz"; sha256 = "0ykw80ji3i3h4cx57fbk73w5izgrvchriyg1cgp3a743bv41ifr4"; }
    { url = "http://smlnj.cs.uchicago.edu/dist/working/${version}/trace-debug-profile.tgz"; sha256 = "1fh4v402iham9mhxwr5m8hr4ll70qr1d6p7f7vpp3bpy14sdf4in"; }
    { url = "http://smlnj.cs.uchicago.edu/dist/working/${version}/heap2asm.tgz"; sha256 = "0p2mj0gxhdxkm39s2viwmn1db5fvzyibygvglaqcrdn04n0pqdbj"; }
    { url = "http://smlnj.cs.uchicago.edu/dist/working/${version}/smlnj-c.tgz"; sha256 = "15nykiv6j2id59smh50d95ciayh1bd92fznpjp3y6fx5zs6qlz8i"; }
  ];

  binSources =
      let x86 = fetchurl { url = http://smlnj.cs.uchicago.edu/dist/working/110.72/boot.x86-unix.tgz; sha256 = "0mz6rz5118ly9d7675aw5v4vanrzpaa36jjr76jwdy771wwmnifi"; };
      in {
        "x86_64-linux" = x86;
        "i686-linux" = x86; 
      };
  binSource = stdenv.lib.maybeAttr stdenv.system (throw "no binary smlnj") binSources;

in stdenv.mkDerivation {

  name = "smlnj-and-libs-${version}";

  srcsOther = sources;
  srcConfig = builtins.head sources;
  inherit binSource;

  # code partially taken from gentoo ebuild
  unpackPhase = ''
    set -x

    for s in $srcsOther $binSource; do
      b=$(basename "$s")
      # while copying drop hash
      cp $s ''${b#*-}
    done

    unpackFile ''${srcConfig}
    rm config/*.bat
    echo SRCARCHIVEURL="file:/$TMP" > config/srcarchiveurl
    mkdir base
    ./config/unpack $TMP runtime heap2asm || die
  '';

  buildInputs = [p7zip coreutils
  gnugrep # <- used for assertion only
  ];

  buildPhase = ''
    set -x
    uname -s
    sed -i '/PATH=/d' config/_arch-n-opsys base/runtime/config/gen-posix-names.sh # don't set PATH to /bin:/usr/bin
    # assertion: PATH=/bin:/usr/bin may cause failure in remaining scripts. So have a look at those!
    ! grep -ri PATH=/bin:/usr/bin . 
    SMLNJ_HOME="$TMP" ./config/install.sh
  '';

  installPhase = ''
    ensureDir $out
    cp -r --target-directory=$out bin lib 

    for file in "''${out}"/bin/{*,.*}; do
         [[ -f ''${file} ]] && sed "2iSMLNJ_HOME=$out/" -i ''${file}
    #	 [[ -f ''${file} ]] && sed "s:''${WORKDIR}:$out:" -i ''${file}
    done

    # bootstrap heap2asm to build heap2asm as executable
    (
      cd heap2asm
      ./build
      heap=heap2asm.x86-linux
      cat >> ../bin/heap2asm << EOF
    #!/bin/sh
    $out/bin/sml @SMLload=`pwd`/$heap "\$@"
    EOF
      chmod +x ../bin/heap2asm
      PATH=$PATH:../bin
      heap2exec $heap $out/bin/heap2asm 
    )

  '';

  meta = {
    description = "smlnj";
    homepage = http://www.smlnj.org;
    license = "BSD";
    maintainers = [stdenv.lib.maintainers.marcweber];
    platforms = ["i686-linux"]; # there is no boot for x86_64-linux
  };
}
