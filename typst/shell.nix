let
  inputs = import ../_sources/generated.nix {
    fetchurl = null;
    fetchFromGitHub = null;
    fetchgit = null;
    dockerTools = null;
  };
  pkgs = import inputs.nixpkgs.src {};
  fontsConf = pkgs.makeFontsConf {
    fontDirectories = [
      pkgs.newcomputermodern
      pkgs.liberation_ttf
      pkgs.roboto
      pkgs.font-awesome_7
    ];
  };
in
  pkgs.mkShellNoCC {
    packages = with pkgs; [
      typst
      tinymist
      websocat
      typstyle
    ];

    shellHook = ''
      export SOURCE_DATE_EPOCH=$(date +%s)
      export FONTCONFIG_FILE="${fontsConf}"
    '';
  }
