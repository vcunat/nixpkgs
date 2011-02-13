args: with args;

let

  # note: this derivation contains a small hack: It contains several PHP
  # versions
  # If the differences get too large this shoud be split into several files
  # At the moment this works fine for me.

  inherit (args.composableDerivation) composableDerivation edf wwf;

  # supported versions see src name below
  versionX = args.stdenv.lib.maybeAttr "version" "5.2.14" args;

in

composableDerivation {} ( fixed : let inherit (fixed.fixed) version; in {

  version = versionX;

  name = "php_configurable-${version}";

  buildInputs = ["flex" "bison" "pkgconfig"];

  flags = {

# much left to do here...

    # SAPI modules:
    
      apxs2 = {
        configureFlags = ["--with-apxs2=${apacheHttpd}/bin/apxs"];
        buildInputs = [apacheHttpd];
      };

      # Extensions

      curl = {
        configureFlags = ["--with-curl=${args.curl}" "--with-curlwrappers"];
        buildInputs = [curl openssl];
      };
      
      zlib = {
        configureFlags = ["--with-zlib=${args.zlib}"];
        buildInputs = [zlib];
      };

      libxml2 = {
        configureFlags = [
          "--with-libxml-dir=${libxml2}"
          "--with-iconv-dir=${libiconv}"
          ];
        buildInputs = [ libxml2 ];
      };
    
      sqlite = {
        configureFlags = ["--with-pdo-sqlite=${sqlite}"];
        buildInputs = [ sqlite ];
      };
    
      postgresql = {
        configureFlags = ["--with-pgsql=${postgresql}"];
        buildInputs = [ postgresql ];
      };
    
      mysql = {
        configureFlags = ["--with-mysql=${mysql}"];
        buildInputs = [ mysql ];
      };

      mysqli = {
        configureFlags = ["--with-mysqli=${mysql}/bin/mysql_config"];
        buildInputs = [ mysql];
      };

      mysqli_embedded = {
        configureFlags = ["--enable-embedded-mysqli"];
        depends = "mysqli";
        assertion = fixed.mysqliSupport;
      };

      pdo_mysql = {
        configureFlags = ["--with-pdo-mysql=${mysql}"];
        buildInputs = [ mysql ];
      };
    
      bcmath = {
        configureFlags = ["--enable-bcmath"];
      };

      gd = {
        configureFlags = ["--with-gd=${args.gd}"];
        buildInputs = [gd libpng libjpeg ];
      };

      soap = {
        configureFlags = ["--enable-soap"];
      };

      sockets = {
        configureFlags = ["--enable-sockets"];
      };

      openssl = {
        configureFlags = ["--with-openssl=${args.openssl}"];
        buildInputs = ["openssl"];
      };

      mbstring = {
        configureFlags = ["--enable-mbstring"];
      };

      /*
         php is build within this derivation in order to add the xdebug lines to the php.ini.
         So both Apache and command line php both use xdebug without having to configure anything.
         Xdebug could be put in its own derivation.
      * /
        meta = {
                description = "debugging support for PHP";
                homepage = http://xdebug.org;
                license = "based on the PHP license - as is";
                };
      */
    };

  cfg = {
    mysqlSupport = getConfig ["php" "mysql"] true;
    mysqliSupport = getConfig ["php" "mysqli"] true;
    pdo_mysqlSupport = getConfig ["php" "pdo_mysql"] true;
    libxml2Support = getConfig ["php" "libxml2"] true;
    apxs2Support = getConfig ["php" "apxs2"] true;
    bcmathSupport = getConfig ["php" "bcmath"] true;
    socketsSupport = getConfig ["php" "sockets"] true;
    curlSupport = getConfig ["php" "curl"] true;
    gettextSupport = getConfig ["php" "gettext"] true;
    postgresqlSupport = getConfig ["php" "postgresql"] true;
    sqliteSupport = getConfig ["php" "sqlite"] true;
    soapSupport = getConfig ["php" "soap"] true;
    zlibSupport = getConfig ["php" "zlib"] true;
    opensslSupport = getConfig ["php" "openssl"] true;
    mbstringSupport = getConfig ["php" "mbstring"] true;
    gdSupport = getConfig ["php" "gd"] true;
  };

  configurePhase = ''
    iniFile=$out/etc/php-recommended.ini
    [[ -z "$libxml2" ]] || export PATH=$PATH:$libxml2/bin
    ./configure --with-config-file-scan-dir=/etc --with-config-file-path=$out/etc --prefix=$out  $configureFlags
    echo configurePhase end
  '';

  installPhase = ''
    unset installPhase; installPhase;
    cp php.ini-${ if builtins.lessThan (builtins.compareVersions version "5.3") 0
        then "recommended" /* < PHP 5.3 */
        else "production" /* >= PHP 5.3 */
    } $iniFile
  '';

   src = args.fetchurl {
     url = "http://nl.php.net/get/php-${version}.tar.bz2/from/this/mirror";
     md5 = if version == "5.3.3" then "21ceeeb232813c10283a5ca1b4c87b48"
          # 5.2.11 does no longer build with current openssl. See http://marc.info/?l=openssl-users&m=124720601103894&w=2
          # else if version == "5.2.11" then "286bf34630f5643c25ebcedfec5e0a09"
          else if version == "5.2.14" then "bfdfc0e62fe437020cc04078269d1414"
          else throw "set md5 sum of php source file" ;
     name = "php-${version}.tar.bz2";
   };

  meta = {
    description = "The PHP language runtime engine";
    homepage = http://www.php.net/;
    license = "PHP-3";
  };

  patches = [./fix.patch];

})
