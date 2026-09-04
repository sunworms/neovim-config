let
  inputs = import ./_sources/generated.nix {
    fetchurl = null;
    fetchFromGitHub = null;
    fetchgit = null;
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
