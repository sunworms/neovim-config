{
  description = "Sunny's Neovim config";

  outputs = {self, ...} @ args: let
    inputs = (import ./.tack) {
      overrides = args.tackOverrides or {};
    };
    lib = inputs.nixpkgs.lib;
    supportedSystems = [
      "x86_64-linux"
      "aarch64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];
    forAllSystems = function: lib.genAttrs supportedSystems (system: function inputs.nixpkgs.legacyPackages.${system});
    mnw = inputs.mnw;
  in {
    packages = forAllSystems (pkgs: {
      default = import ./default.nix {
        inherit pkgs mnw;
      };
    });
    devShells = forAllSystems (pkgs: {
      default = pkgs.mkShellNoCC {
        packages = lib.singleton self.packages.${pkgs.stdenv.hostPlatform.system}.default.devMode;
      };
    });
  };
}
