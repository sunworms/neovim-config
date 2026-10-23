{
  outputs = {...} @ args: let
    inputs = (import ./.tack) {overrides = args.tackOverrides or {};};

    inherit (inputs.nixpkgs) lib;
    inherit (lib.attrsets) mapAttrs zipAttrsWith;
    inherit (lib.lists) foldl';
    inherit (lib.systems) flakeExposed;

    mapSystems = systems: f:
      systems
      |> map (s: f s |> mapAttrs (_: v: {${s} = v;}))
      |> zipAttrsWith (_: foldl' (a: b: a // b) {});
  in
    mapSystems flakeExposed (system: let
      pkgs = inputs.nixpkgs.legacyPackages.${system};
    in {
      packages.default = import ./package.nix {inherit pkgs inputs;};
      devShells.default = pkgs.mkShell {
        packages = [
          (import ./package.nix {inherit pkgs inputs;}).devMode
        ];
      };
    })
    // {
      nixConfig = {
        experimental-features = ["nix-command" "flakes" "pipe-operators"];
      };
    };
}
