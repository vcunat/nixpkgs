{
  busybox = import <nix/fetchurl.nix> {
    url = https://lblasc-nix-dev.s3-eu-west-1.amazonaws.com/0zaxybl83qf0qc8bd3qb6z084jx94xv0-stdenv-bootstrap-tools/on-server/busybox;
    sha256 = "1jyhi0irfgd8c8hwck3ym2qn8v29s3jm6a3cfilvilxjcblhzngx";
    executable = true;
  };

  bootstrapTools = import <nix/fetchurl.nix> {
    url = https://lblasc-nix-dev.s3-eu-west-1.amazonaws.com/0zaxybl83qf0qc8bd3qb6z084jx94xv0-stdenv-bootstrap-tools/on-server/bootstrap-tools.tar.xz;
    sha256 = "0pgl58xh0rbmcpvwwbd9z3jy1d957v0pvqxgj7w3m551d9d9d83p";
  };
}
