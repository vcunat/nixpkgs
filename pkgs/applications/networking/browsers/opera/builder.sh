source $stdenv/setup

buildPhase() {
    true
}

installPhase() {
    ensureDir $out
    sed -i "s@/usr/local@$out@g" install
    ./install --unattended --system

    [ -z ${system##*64*} ] && suf=64

    find $out -type f | while read f; do
      echo testing "$f"
      # patch all executables
      if readelf -h "$f" | grep 'EXEC (Executable file)' &> /dev/null; then
        echo "patching $f <<"
        patchelf \
            --set-interpreter "$(cat $NIX_GCC/nix-support/dynamic-linker)" \
            --set-rpath "$libPath" \
            "$f"
      fi
    done

    # patchelf is not enough? Opera only finds libXcursor when usign
    # LD_LIBRARY_PATH (seems to be optional though)
    sed -i "2s@^@\\nexport LD_LIBRARY_PATH=$libPath@" $out/bin/opera 
    
    ensureDir $out/share/applications
    cp $desktopItem/share/applications/* $out/share/applications
}

genericBuild
