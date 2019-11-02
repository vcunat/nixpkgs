{
  busybox = import <nix/fetchurl.nix> {
    url = http://tarballs.nixos.org/stdenv-linux/aarch64/c5aabb0d603e2c1ea05f5a93b3be82437f5ebf31/busybox;
    sha256 = "90c2a858c20f0c87650c960e9ee79a131bec4a539bedf9e5baf0b1a52c4b1273";
    executable = true;
  };
  bootstrapTools = import <nix/fetchurl.nix> {
    url = http://tarballs.nixos.org/stdenv-linux/aarch64/c5aabb0d603e2c1ea05f5a93b3be82437f5ebf31/bootstrap-tools.tar.xz;
    sha256 = "d3f1bf2a1495b97f45359d5623bdb1f8eb75db43d3bf2059fc127b210f059358";
  };
}
