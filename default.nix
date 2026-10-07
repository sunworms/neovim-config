{pkgs ? null}: let
  inputs = import ./_sources/generated.nix {
    fetchurl = null;
    fetchFromGitHub = null;
    fetchgit = null;
    dockerTools = null;
  };
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
