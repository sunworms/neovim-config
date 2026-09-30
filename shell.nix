let
  inputs = import ./inputs.nix;
  pkgs = import inputs.nixpkgs {
    config.allowUnfree = true;
  };
  neovim = import ./. {inherit pkgs inputs;};
in
  pkgs.mkShellNoCC {
    packages = [neovim.devMode];
  }
