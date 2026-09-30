{
  pkgs ? null,
  inputs ? import ./inputs.nix,
}: let
  finalPkgs =
    if pkgs != null
    then pkgs
    else
      import inputs.nixpkgs {
        config.allowUnfree = true;
      };
in
  import ./package.nix {
    pkgs = finalPkgs;
    inherit inputs;
  }
