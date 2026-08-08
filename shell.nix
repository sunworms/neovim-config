let
  inputs = import ./.tack;
  pkgs = import inputs.nixpkgs {
    config.allowUnfree = true;
  };
  neovim = import ./. {inherit pkgs;};
in
  pkgs.mkShellNoCC {
    packages = [
      neovim.devMode
    ];
  }
