let
  inputs = import ./_sources/generated.nix {
    inherit (builtins) fetchurl;
    fetchgit = null;
    fetchFromGitHub = null;
    dockerTools = null;
  };
  pkgs = import inputs.nixpkgs.src {
    config.allowUnfree = true;
  };
  neovim = import ./. {inherit pkgs;};
in
  pkgs.mkShellNoCC {
    packages = [
      neovim.devMode
    ];
  }
