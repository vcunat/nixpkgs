#! /bin/sh

export NIX_DEBUG=1

. $stdenv/setup

export NIX_CFLAGS_COMPILE="-v $NIX_CFLAGS_COMPILE"

mkdir $out
mkdir $out/bin

cat > hello.c <<EOF
#include <stdio.h>

int main(int argc, char * * argv)
{
    printf("Hello World!\n");
    return 0;
}
EOF

gcc hello.c -o $out/bin/hello

$out/bin/hello

cat > hello2.cc <<EOF
#include <iostream>

int main(int argc, char * * argv)
{
    std::cout << "Hello World!\n";
    std::cout << VALUE << std::endl;
    return 0;
}
EOF

g++ hello2.cc -o $out/bin/hello2 -DVALUE="1 + 2 * 3"

$out/bin/hello2

ld -v