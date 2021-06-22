{ stdenvNoCC, fetchgit, lib }:

stdenvNoCC.mkDerivation rec {
  pname = "firmware-linux-nonfree";
  version = "2021-05-11-amdgpu";

  src = fetchgit {
    url = "https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git";
    rev = "refs/tags/" + lib.replaceStrings ["-"] [""] version;
    sha256 = "015hajf3mq8dv2hw5wsyvi34zdqiwxp9p5dwdp8nrk4r9z5ysqxw";
  };

  # Use older amdgpu firmware due to crashes #126771
  postPatch = let
    version_prev = "2021-03-15";
    src_prev = fetchgit {
      url = "https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git";
      rev = "refs/tags/" + lib.replaceStrings ["-"] [""] version_prev;
      sha256 = "sha256-BnYqveVFJk/tVYgYuggXgYGcUCZT9iPkCQIi48FOTWc=";
    };
  in ''
    rm -r amdgpu/
    cp -r '${src_prev}/amdgpu' ./amdgpu
  '';

  installFlags = [ "DESTDIR=$(out)" ];

  # Firmware blobs do not need fixing and should not be modified
  dontFixup = true;

  outputHashMode = "recursive";
  outputHashAlgo = "sha256";
  outputHash = "0q2kl61jwj81zd2bwh3m7adphf6fbjpfmb8wqc6i5xipn22a0h0j";

  meta = with lib; {
    description = "Binary firmware collection packaged by kernel.org";
    homepage = "https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git";
    license = licenses.unfreeRedistributableFirmware;
    platforms = platforms.linux;
    maintainers = with maintainers; [ fpletz ];
    priority = 6; # give precedence to kernel firmware
  };

  passthru = { inherit version; };
}
