{ stdenv, fetchurl, db4, glibc, openssl, cyrus_sasl, perl
, coreutils, findutils, gnused, gnugrep
}:

assert stdenv.isLinux;

stdenv.mkDerivation {
  name = "postfix-2.8.0";
  
  src = fetchurl {
    url = http://de.postfix.org/ftpmirror/official/postfix-2.8.0.tar.gz;
    sha256 = "1v9pma99lgmikh46bv70kaphrqq4pqzw9nixhsq93m9f3rh48v2b";
  };

  installTargets = ["non-interactive-package"];
  
  installFlags = [" install_root=$out "];

  enableParallelBuilding = true;
  
  preInstall = ''
    sed -e '/^PATH=/d' -i postfix-install
  '';
  
  postInstall = ''
    ensureDir $out
    mv ut/$out/* $out/

    mkdir $out/share/postfix/conf
    cp conf/* $out/share/postfix/conf
    sed -e 's@PATH=.*@PATH=${coreutils}/bin:${findutils}/bin:${gnused}/bin:${gnugrep}/bin:$out/sbin@' -i $out/share/postfix/conf/post-install
    sed -e '2aPATH=${coreutils}/bin:${findutils}/bin:${gnused}/bin:${gnugrep}/bin:$out/sbin' -i $out/share/postfix/conf/postfix-script
    chmod a+x $out/share/postfix/conf/{postfix-script,post-install}
  '';

  preBuild = ''
    export daemon_directory=$out/libexec/postfix
    export command_directory=$out/sbin
    export queue_directory=/var/spool/postfix
    export sendmail_path=$out/bin/sendmail
    export mailq_path=$out/bin/mailq
    export newaliases_path=$out/bin/newaliases
    export html_directory=$out/share/postfix/doc/html
    export manpage_directory=$out/share/man
    export sample_directory=$out/share/postfix/doc/samples
    export readme_directory=$out/share/postfix/doc

    make makefiles CCARGS='-DUSE_TLS -DUSE_SASL_AUTH -DUSE_CYRUS_SASL -DHAS_DB -I${cyrus_sasl}/include/sasl' AUXLIBS='-lssl -lcrypto -lsasl2 -ldb'
  '';

  buildInputs = [db4 openssl cyrus_sasl perl];
  
  patches = [./postfix-2.2.9-db.patch ./postfix-2.2.9-lib.patch];
  
  inherit glibc;
}
