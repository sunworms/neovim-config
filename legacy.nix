let
  inputs = import ./.tack;
  system = builtins.currentSystem or "x86_64-linux";
  pkgs = import inputs.nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };
  mnw = import inputs.mnw;
in
import ./default.nix { inherit pkgs mnw; }
