{
  pkgs ? null,
}:

let
  inputs = import ./.tack;

  finalPkgs =
    if pkgs != null then
      pkgs
    else
      import inputs.nixpkgs {
        config.allowUnfree = true;
      };

  mnw = import inputs.mnw;
in
import ./default.nix {
  pkgs = finalPkgs;
  inherit mnw;
}
