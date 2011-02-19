# eg hoe requires newer rubygems
# using trunk seems to be less work than removing rubygems from the
# distribution ?
let defaultVersion = "trunk";
    defaultDist = "1.9.2-rc2";
in

{ stdenv, fetchurl
, zlib, zlibSupport ? true
, openssl, opensslSupport ? true
, gdbm, gdbmSupport ? true
, ncurses, readline, cursesSupport ? true
, groff, docSupport ? false
, unzip
, version ? defaultVersion

# svn version:
, autoconf
, sourceFromHead
, ruby19 # default version used for bootstrapping
, bison, flex
}:

let
  op = stdenv.lib.optional;
  ops = stdenv.lib.optionals;

  inherit (stdenv) lib;

  rubyBoot = ruby19.override { version = defaultDist;};

  attrsByVersion = {
    trunk = {
      buildInputs = [ autoconf bison flex ];
      preConfigure = "autoconf -i";
      configureFlags = [ "--with-baseruby=${rubyBoot}/bin/ruby" ];
      name = "ruby-trunk";
      # REGION AUTO UPDATE:   { name="ruby19trunk"; type="svn"; url="http://svn.ruby-lang.org/repos/ruby/trunk"; }
      src = sourceFromHead "ruby19trunk-30894.tar.gz"
                   (throw "source not not published yet: ruby19trunk");
      # END
    };
    "1.9.2-svn" = {
      buildInputs = [ autoconf bison flex ];
      preConfigure = "autoconf -i";
      configureFlags = [ "--with-baseruby=${rubyBoot}/bin/ruby" ];
      name = "ruby-1.9-svn";
      # REGION AUTO UPDATE:   { name="ruby192"; type="svn"; url="http://svn.ruby-lang.org/repos/ruby/branches/ruby_1_9_2"; }
      # END
    };
  }
  // 
  lib.nvs defaultDist {
      version = "1.9.2-rc2";
      name = "ruby-${version}";

      src = fetchurl {
        # url = ftp://ftp.ruby-lang.org/pub/ruby/1.9/ruby-1.9.2-p136.tar.bz2;
        # md5 = "52958d35d1b437f5d9d225690de94c13";
        url = "ftp://ftp.ruby-lang.org/pub/ruby/1.9/ruby-1.9.2-rc2.zip";
        sha256 = "13310lkfa8szck9nnxg7lp5sfxbm8w3sqw4gfaa2ak24v36z9xrk";
      };
   };

in

stdenv.mkDerivation (stdenv.lib.mergeAttrsByFuncDefaultsClean [ {

  enableParallelBuilding = true;

  buildInputs = (ops cursesSupport [ ncurses readline unzip ] )
    ++ (op docSupport groff )
    ++ (op zlibSupport zlib)
    ++ (op opensslSupport openssl)
    ++ (op gdbmSupport gdbm);
    
  configureFlags = ["--enable-shared" "--enable-pthread"];

  installFlags = lib.optionalString docSupport "install-doc";

  postInstall = ''
    ( cd $out/lib/ruby/1.9.1/rubygems; patch -p1 installer.rb < ${ ./1.9-hook.patch }; )
  '';

  meta = {
    license = "Ruby";
    homepage = "http://www.ruby-lang.org/en/";
    description = "The Ruby language";
  };

  passthru = {
    # install ruby libs into "$out/${ruby.libPath}"
    libPath = "lib/ruby-1.9";
  };
} (lib.maybeAttr version (throw "unkown version for ruby-1.9") attrsByVersion) ] )
