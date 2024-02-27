{
  description = "A nix flake for pennylane-codebook dev environment.";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";

  outputs = { self, nixpkgs, ... }:
  let
  system = "x86_64-linux";
  pkgs = import nixpkgs {
    inherit system;
  };

  fhs = pkgs.buildFHSUserEnv {
    name = "pennylane-codebook-fhs";
    targetPkgs = _: [ pkgs.micromamba ];
    profile = ''
      set -e
      eval "$(micromamba shell hook --shell=posix)"
      micromamba activate pennylane-codebook
      set +e 
    '';   
  };

  in {
    devShells.x86_64-linux.default = fhs.env;
  };
}
