{pkgs ? null}: let
  inputs = import ./npins;

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
