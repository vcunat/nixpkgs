{pkgs} :
let
  inherit (pkgs) sourceFromHead stdenv fetchurl;
in
{

  # usage: see mercurial config options
  # tests have been implemented using .bat files :(
  attic = stdenv.mkDerivation {
    name = "hg-attic";
    # REGION AUTO UPDATE: { name="hg-attic"; type="hg"; url="https://bitbucket.org/Bill_Barry/hgattic"; groups = "mercurial-extensions"; }
    src = sourceFromHead "hg-attic-3ba1e5f03971.tar.gz"
                 (fetchurl { url = "http://mawercer.de/~nix/repos/hg-attic-3ba1e5f03971.tar.gz"; sha256 = "cd859362cc76ccef89fe71b5bb877d6279b4fa8435d7457c6aada07dea325045"; });
    # END
    installPhase = "ensureDir $out/hgext; mv * $out/hgext";
  };

  # usage: see mercurial config options
  pbranch = stdenv.mkDerivation {
    name = "pbranch-hg";
    # REGION AUTO UPDATE: { name="hg-pbranch"; type="hg"; url="https://bitbucket.org/parren/hg-pbranch"; groups = "mercurial-extensions"; }
    src = sourceFromHead "hg-pbranch-5769b47df90c.tar.gz"
                 (fetchurl { url = "http://mawercer.de/~nix/repos/hg-pbranch-5769b47df90c.tar.gz"; sha256 = "bed3a5c978f662a0ffc8cac4d58bf0ed929672eda6f10c9be8b705cd000353ab"; });
    # END

    installPhase = "cp -r . $out";
  };

  /* from README:
     TODO:
      Before using hgsubversion, I *strongly* encourage you to run the [...]
      python tests/run.py (nose could be used ?)
  */
  # usage: see mercurial config options
  hgsubversion = 
    let hg =  pkgs.mercurial.override { plain = true; };
    in
    stdenv.mkDerivation {
    buildInputs = [ pkgs.python ];
    # REGION AUTO UPDATE: { name="hg-subversion"; type="hg"; url="https://bitbucket.org/durin42/hgsubversion"; groups = "mercurial-extensions"; }
    src = (fetchurl { url = "http://mawercer.de/~nix/reposhg-subversion-hg-6f0b0a4.tar.bz2"; sha256 = "535b08ee21aa14160434f58626c6ff3c952fecee7c9d408d365bbc4b7fdccb1f"; });
    name = "hg-subversion-hg-6f0b0a4";
    # END

    buildPhase = ":";

    # home required for tests !?
    installPhase = ''
      mkdir home
      export HOME=`pwd`/home
      python setup.py install --prefix=$out
      echo 'running hgsubversion test which takes quite a while'
      PATH=${hg.svnPythonSupport}/bin:$PATH
      PYTHONPATH=$PYTHONPATH${PYTHON:+:}$(toPythonPath ${hg.svnPythonSupport})
      cd tests;
      # get python env from hg:
      eval "$(grep = ${hg}/bin/hg)"
      pwd; ls; python run.py
    '';
  };

  histedit = stdenv.mkDerivation {
    name = "hg-histedit";
    # REGION AUTO UPDATE: { name="hg-histedit"; type="hg"; url="https://MarcWeber@bitbucket.org/durin42/histedit"; groups = "mercurial-extensions"; }
    src = sourceFromHead "hg-histedit-50144f923094.tar.gz"
                 (fetchurl { url = "http://mawercer.de/~nix/repos/hg-histedit-50144f923094.tar.gz"; sha256 = "685cd2a52657d947e0247bea17eb523637032fce0a2854749411240a9a21d860"; });
    # END
    buildInputs = [ pkgs.python ];
    buildPhase = ":";
    installPhase = "python setup.py install --prefix=$out";
  };

  collapse = stdenv.mkDerivation {
    name = "hg-collapse";
    # REGION AUTO UPDATE: { name="hg-collapse"; type="hg"; url="http://bitbucket.org/ccaughie/hgcollapse"; groups = "mercurial-extensions"; }
    src = sourceFromHead "hg-collapse-3a7ad10bb122.tar.gz"
                 (fetchurl { url = "http://mawercer.de/~nix/repos/hg-collapse-3a7ad10bb122.tar.gz"; sha256 = "75eaf2b1ff95b809ff5d958a5d8f195cea50efb65fac59b19e6ed4db8ac67026"; });
    # END
    
    buildInputs = [ pkgs.python ];
    buildPhase = ":";
    installPhase = "ensureDir $out; mv hgext $out";
  };
}
