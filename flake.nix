{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    mnw.url = "github:Gerg-L/mnw";
  };

  outputs =
    {
      nixpkgs,
      mnw,
      self,
      ...
    }:
    let
      lib = nixpkgs.lib;
      supportedSystems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];

      forAllSystems =
        function: lib.genAttrs supportedSystems (system: function nixpkgs.legacyPackages.${system});
    in
    {
      packages = forAllSystems (pkgs: {
        default = mnw.lib.wrap pkgs {
          neovim = pkgs.neovim-unwrapped;
          initLua = builtins.readFile ./init.lua;
          plugins = {
            start = with pkgs.vimPlugins; [
              lz-n
              plenary-nvim
              friendly-snippets
              nvim-web-devicons
              base16-nvim
              oil-nvim
            ];
            opt = with pkgs.vimPlugins; [
              telescope-nvim
              blink-cmp
              nvim-autopairs
              lualine-nvim
              nvim-lspconfig
              conform-nvim
              neogit
              nvim-treesitter.withAllGrammars
              (typst-preview-nvim.overrideAttrs {
                postPatch = ''
                  substituteInPlace lua/typst-preview/config.lua \
                    --replace-fail "['tinymist'] = nil" "['tinymist'] = 'tinymist'" \
                    --replace-fail "['websocat'] = nil" "['websocat'] = 'websocat'"
                '';
              })
            ];

            dev.myconfig = {
              pure = ./.;
              impure = "/' .. vim.uv.cwd()  .. '/neovim-config";
            };
          };
        };

        dev = self.packages.${pkgs.stdenv.hostPlatform.system}.default.devMode;
      });

      devShells = forAllSystems (pkgs: {
        default = pkgs.mkShellNoCC {
          packages = lib.singleton self.packages.${pkgs.stdenv.hostPlatform.system}.default;
        };
      });
    };
}
