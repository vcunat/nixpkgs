{ stdenv, fetchurl
, zlib, zlibSupport ? true
, openssl, opensslSupport ? true
, gdbm, gdbmSupport ? true
, ncurses, readline, cursesSupport ? true
, groff, docSupport ? false
, unzip
}:

let
  op = stdenv.lib.optional;
  ops = stdenv.lib.optionals;
in

stdenv.mkDerivation rec {
  version = "1.9.2-rc2";
  
  name = "ruby-${version}";
  
  src = fetchurl {
    # url = ftp://ftp.ruby-lang.org/pub/ruby/1.9/ruby-1.9.2-p136.tar.bz2;
    # md5 = "52958d35d1b437f5d9d225690de94c13";
    url = "ftp://ftp.ruby-lang.org/pub/ruby/1.9/ruby-1.9.2-rc2.zip";
    sha256 = "13310lkfa8szck9nnxg7lp5sfxbm8w3sqw4gfaa2ak24v36z9xrk";
  };

  buildInputs = (ops cursesSupport [ ncurses readline unzip ] )
    ++ (op docSupport groff )
    ++ (op zlibSupport zlib)
    ++ (op opensslSupport openssl)
    ++ (op gdbmSupport gdbm);
    
  configureFlags = ["--enable-shared" "--enable-pthread"];

  installFlags = stdenv.lib.optionalString docSupport "install-doc";

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
}
