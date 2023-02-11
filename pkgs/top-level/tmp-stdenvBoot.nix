{...}@args:
let
  jobs = import ./release.nix args;
in {
  inherit (jobs.stdenvBootstrapTools.aarch64-linux) dist test;
}

