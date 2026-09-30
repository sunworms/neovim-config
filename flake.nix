{
  description = "Sunny's Neovim config";

  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixos-unstable/nixexprs.tar.zst";
    mnw.url = "github:Gerg-L/mnw";
  };

  outputs = {
    self,
    nixpkgs,
    mnw,
  }: let
    systems = ["x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"];
    forAllSystems = f: nixpkgs.lib.genAttrs systems f;

    pkgsFor = system:
      import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
  in {
    packages = forAllSystems (system: let
      neovim = import ./. {
        pkgs = pkgsFor system;
        inputs = {inherit nixpkgs mnw;};
      };
    in {
      inherit neovim;
      default = neovim;
    });

    devShells = forAllSystems (system: {
      default = (pkgsFor system).mkShellNoCC {
        packages = [self.packages.${system}.neovim.devMode];
      };
    });
  };
}
