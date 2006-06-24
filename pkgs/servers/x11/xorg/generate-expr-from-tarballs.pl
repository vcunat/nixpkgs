#! /usr/bin/perl -w

# Typical command to generate the list of tarballs:

# export i="http://mirror.switch.ch/ftp/mirror/X11/pub/X11R7.1/src/everything/"; curl $i | perl -e 'while (<>) { if (/href="([^"]*.bz2)"/) { print "$ENV{'i'}$1\n"; }; }' >list
# export i="http://mirror.switch.ch/ftp/mirror/X11/pub/X11R7.0/src/everything/"; curl $i | perl -e 'while (<>) { if (/href="([^"]*.bz2)"/) { print "$ENV{'i'}$1\n"; }; }' >>list


use strict;

my $tmpDir = "/tmp/xorg-unpack";

my $version = "X11R7"; # will be removed from package names
my $version2 = "X11R7\\.\\d"; # will be removed from package names


my %pkgURLs;
my %pkgHashes;
my %pkgNames;
my %pkgRequires;

my %pcMap;

my %extraAttrs;


$pcMap{"freetype2"} = "freetype";
$pcMap{"fontconfig"} = "fontconfig";
$pcMap{"libpng12"} = "libpng";
$pcMap{"libdrm"} = "libdrm";
$pcMap{"libXaw"} = "libXaw";
$pcMap{"zlib"} = "zlib";
$pcMap{"perl"} = "perl";
$pcMap{"mesa"} = "mesa";


$extraAttrs{"imake"} = " inherit xorgcffiles; x11BuildHook = ./imake.sh; patches = [./imake.patch]; ";


if (-e "cache") {
    open CACHE, "<cache";
    while (<CACHE>) {
        /^(\S+)\s+(\S+)$/ or die;
        $pkgHashes{$1} = $2;
    }
    close CACHE;
}


while (<>) {
    chomp;
    my $tarball = "$_";
    print "\nDOING TARBALL $tarball\n";

    $tarball =~ /\/((?:(?:[A-Za-z0-9]|(?:-[^0-9])|(?:-[0-9]*[a-z]))+))[^\/]*$/;
    die unless defined $1;
    my $pkg = $1;
    $pkg =~ s/-//g;
#    next unless $pkg eq "xorgserverX11R7";
#    print "$pkg\n";
    $pkg =~ s/$version//g if $version ne "";
    $pkgURLs{$pkg} = $tarball;

    $tarball =~ /\/([^\/]*)\.tar\.bz2$/;
    my $pkgName = $1;
    $pkgName =~ s/-$version2//g if $version2 ne "";

    print "  $pkg $pkgName\n";

    if (defined $pkgNames{$pkg}) {
	print "  SKIPPING\n";
	next;
    }

    $pkgNames{$pkg} = $pkgName;

    my $maybeHash = $pkgHashes{$pkg};
    $maybeHash = "" unless defined $maybeHash;
    my ($hash, $path) = `PRINT_PATH=1 QUIET=1 nix-prefetch-url '$tarball' $maybeHash`;
    chomp $hash;
    chomp $path;
    if (!defined $pkgHashes{$pkg}) {
        open CACHE, ">>cache";
        print CACHE "$pkg $hash\n";
        close CACHE;
    }
    $pkgHashes{$pkg} = $hash;

    print "\nunpacking $path\n";
    system "rm -rf '$tmpDir'";
    mkdir $tmpDir, 0700;
    system "cd '$tmpDir' && tar xfj '$path'";
    die "cannot unpack `$path'" if $? != 0;
    print "\n";

    my $provides = `cd '$tmpDir'/* && ls *.pc.in`;
    my @provides2 = split '\n', $provides;
    print "PROVIDES @provides2\n\n";
    foreach my $pc (@provides2) {
        $pc =~ s/.pc.in//;
        die "collission with $pcMap{$pc}" if defined $pcMap{$pc};
        $pcMap{$pc} = $pkg;
    }

    my @requires = ();
    my $file;
    {
        local $/;
        open FOO, "cd '$tmpDir'/* && cat configure.ac |";
        $file = <FOO>;
        close FOO;
    }

    if ($file =~ /XAW_CHECK_XPRINT_SUPPORT/) {
        push @requires, "libXaw";
    }

    if ($file =~ /zlib is required/ || $file =~ /AC_CHECK_LIB\(z\,/) {
        push @requires, "zlib";
    }
    
    if ($file =~ /Perl is required/) {
        push @requires, "perl";
    }

    sub process {
        my $requires = shift;
        foreach my $req (split / /, $1) {
            next if $req eq ">=";
            next if $req =~ /^\$/;
            next if $req =~ /^[0-9]/;
            $req =~ s/\[//g;
            $req =~ s/\]//g;
            next if $req =~ /^\s*$/;
            print "REQUIRE: $req\n";
            push @{$requires}, $req;
        }
    }

    process \@requires, $1 while $file =~ /PKG_CHECK_MODULES\([^,]*,\s*\[?([^\),\]]*)/g;
    process \@requires, $1 while $file =~ /MODULES=\"(.*)\"/g;
    process \@requires, $1 while $file =~ /REQUIRED_LIBS=\"(.*)\"/g;
    process \@requires, $1 while $file =~ /REQUIRES=\"(.*)\"/g;
    process \@requires, $1 while $file =~ /XORG_DRIVER_CHECK_EXT\([^,]*,([^\)]*)\)/g;

    push @requires, "mesa" if $pkg =~ /xorgserver/ or $pkg =~ /xf86videoi810/;
    push @requires, "glproto" if $pkg =~ /xf86videoi810/;
    push @requires, "zlib" if $pkg =~ /xorgserver/;
    
    print "REQUIRES @requires => $pkg\n";
    $pkgRequires{$pkg} = \@requires;

    print "done\n";
}


print "\nWRITE OUT\n";

open OUT, ">default2.nix";

print OUT "";
print OUT <<EOF;
# This is a generated file.  Do not edit!
{ stdenv, fetchurl, pkgconfig, freetype, fontconfig
, expat, libdrm, libpng, zlib, perl, mesa
}:

rec {

EOF


foreach my $pkg (sort (keys %pkgURLs)) {
    print "$pkg\n";

    my %requires = ();
    my $inputs = "";
    foreach my $req (sort @{$pkgRequires{$pkg}}) {
        if (defined $pcMap{$req}) {
            if (!defined $requires{$pcMap{$req}}) {
                $inputs .= "$pcMap{$req} ";
                $requires{$pcMap{$req}} = 1;
            }
        } else {
            print "  NOT FOUND: $req\n";
        }
    }

    my $extraAttrs = $extraAttrs{"$pkg"};
    $extraAttrs = "" unless defined $extraAttrs;
    
    print OUT <<EOF
  $pkg = (stdenv.mkDerivation {
    name = "$pkgNames{$pkg}";
    builder = ./builder.sh;
    src = fetchurl {
      url = $pkgURLs{$pkg};
      md5 = "$pkgHashes{$pkg}";
    };
    buildInputs = [pkgconfig $inputs];$extraAttrs
  }) // {inherit $inputs;};
    
EOF
}

print OUT "}\n";

close OUT;
