let
  inputs = import ./.tack;
  pkgs = import inputs.nixpkgs {
    config.allowUnfree = true;
  };
  neovim = import ./legacy.nix { inherit pkgs; };
in
pkgs.mkShellNoCC {
  packages = [
    neovim.devMode
  ];
}
