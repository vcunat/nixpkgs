a@{ stdenv, fetchurl, python, pythonPackages, makeWrapper, getConfig, mercurialExtensions
, tk ? null, subversion
, plain ? false # no plugins, used by mercurialExtensions.hgsubversion
# , guiSupport ? false ... see cfg
, ...
}:

/* design notes:
   it may look like being a bad idea making the etc/hgrc depending on
   configuration options because for each configuration a new derivation has to
   be built. However building mercurial is *very* fast and many files can be
   shared by hard links (Maybe a wrapper derivation would be a better idea -
   but also more complex
 */

let

  inherit (stdenv.lib) optional concatLists concatStrings mapAttrsFlatten maybeAttr optionalString;

  cfg = name: default:
    let n = "${name}Support";
    in !plain && (getConfig ["mercurial" n] default || maybeAttr n default a);

  svnPythonSupport = subversion.override { pythonBindings = true; };

  # Usually you put these extensions into your ~/.hgrc.
  # By enabling them they'll be added to the derivation global hgrc so that
  # they "just work"
  # Enable them by adding into your nixpkgs configuration file:
  # mercurial.nameSupport = true;
  packagedExtensions = {
    attic = { # seems to include the functionality of hg shelve extension and be more powerful
      hgrcExt = "hgattic = ${mercurialExtensions.attic}/hgext/attic.py";
    };
    # collaborative patch manager (in the spirit of top-git)
    pbranch = {
      hgrcExt = "pbranch = ${mercurialExtensions.pbranch}/hgext/pbranch.py";
      test = "hg help pbranch &> /dev/null";
    };
    histedit = {
      hgrcExt = "histedit = ${mercurialExtensions.histedit}/lib/python2.6/site-packages/hg_histedit.py";
    };
    # track subversion repositories
    hgsubversion = {
      hgrcExt = "hgsubversion =";
      PYTHONPATH = "$(toPythonPath ${svnPythonSupport}):$(toPythonPath ${mercurialExtensions.hgsubversion})";
      test = ''
        hg help hgsubversion &> /dev/null
      '';
    };
    # patch queue manage (spirit of quilt?)
    mq = {
      hgrcExt = "mq =";
      test = "hg help mq &> /dev/null";
    };
    # convert subversion to mercurial and more (?)
    hgextconvert = {
      hgrcExt = "hgext.convert =";
      PYTHONPATH = "$(toPythonPath ${svnPythonSupport})";
    };
    gui = { # incomplete, see postInstall
      hgrcExt = "hgk=$out/lib/${python.libPrefix}/site-packages/hgext/hgk.py";
    };
    collapse = {
      hgrcExt = "collapse = ${mercurialExtensions.collapse}/hgext/collapse.py";
    };
    # builtin anyway. If you have any reason not to enable them by default tell me.
    graphlog   = { enable = true; hgrcExt = "graphlog ="; };
    transplant = { enable = true; hgrcExt = "transplant ="; };
    record     = { enable = true; hgrcExt = "hgext.record ="; };
  };

  # join hgrc lines and PYTHONPATH lines of selected extensions
  extensions = concatLists (mapAttrsFlatten (n: a: if cfg n (maybeAttr "enable" false a) then [a] else [] ) (packagedExtensions));
  hgrcExts = concatStrings (map (e: if e ? hgrcExt then "\n${e.hgrcExt}" else "") extensions);
  pythonPaths = concatStrings (map (e: if e ? PYTHONPATH then ":${e.PYTHONPATH}" else "") extensions);
  tests = concatStrings (map (e: if e ? test then "\n${e.test}" else "") extensions);

in

stdenv.mkDerivation rec {
  name = "mercurial-1.8.1";
  
  src = fetchurl {
    url = "http://www.selenic.com/mercurial/release/${name}.tar.gz";
    sha256 = "0cdai2y5sjs0k2n53pabac1rzyj2khr41m4z4hr3200vci1s1pps";
  };

  inherit python; # pass it so that the same version can be used in hg2git

  buildInputs = [ python makeWrapper
    pythonPackages.docutils
  ];
  
  makeFlags = "PREFIX=$(out)";
  
  postInstall = 
    ( optionalString (hgrcExts != "") ''
      ensureDir $out/etc/mercurial
      cat >> $out/etc/mercurial/hgrc << EOF
      [extensions]
      ${hgrcExts}
      EOF
    '') +
    ( optionalString (cfg "gui" false) # incomplete, see gui above
    ''
      cp contrib/hgk $out/bin
      # setting HG so that hgk can be run itself as well (not only hg view)
      WRAP_TK=" --set TK_LIBRARY \"${tk}/lib/${tk.libPrefix}\"
                --set HG \"$out/bin/hg\"
                --prefix PATH : \"${tk}/bin\" "
    '') +
    ''
      for i in $(cd $out/bin && ls); do
        wrapProgram $out/bin/$i \
          --prefix PYTHONPATH : "$(toPythonPath $out)${pythonPaths}" \
          $WRAP_TK
      done

      # copy hgweb.cgi to allow use in apache
      ensureDir $out/share/cgi-bin
      cp -v hgweb.cgi $out/share/cgi-bin
      chmod u+x $out/share/cgi-bin/hgweb.cgi
      PATH=$PATH:$out/bin
      echo "verify that extensions are found"
      ${tests}
    '';

  meta = {
    description = "A fast, lightweight SCM system for very large distributed projects";
    homepage = http://www.selenic.com/mercurial/;
    license = "GPLv2";
  };

  passthru = { inherit svnPythonSupport; };

}
