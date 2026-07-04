{
  outputs =
    { self, ... }@args:
    let
      inputs = (import ./.tack) {
        overrides = args.tackOverrides or { };
      };
      lib = inputs.nixpkgs.lib;
      supportedSystems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];

      forAllSystems =
        function: lib.genAttrs supportedSystems (system: function inputs.nixpkgs.legacyPackages.${system});
    in
    {
      packages = forAllSystems (pkgs: {
        default = inputs.mnw.lib.wrap pkgs {
          neovim = pkgs.neovim-unwrapped;
          luaFiles = [
            ./nvim/init.lua
          ];
          plugins = {
            start = with pkgs.vimPlugins; [
              lz-n
              friendly-snippets
              nvim-web-devicons
              base16-nvim
              oil-nvim
              vimtex
              nvim-treesitter.withAllGrammars
            ];
            opt = with pkgs.vimPlugins; [
              fzf-lua
              blink-cmp
              nvim-autopairs
              lualine-nvim
              nvim-lspconfig
              conform-nvim
              neogit
              (typst-preview-nvim.overrideAttrs {
                postPatch = ''
                  substituteInPlace lua/typst-preview/config.lua \
                    --replace-fail "['tinymist'] = nil" "['tinymist'] = 'tinymist'" \
                    --replace-fail "['websocat'] = nil" "['websocat'] = 'websocat'"
                '';
              })
            ];

            dev.default = {
              pure = ./nvim;
              impure = "/home/sunny/Documents/neovim-config/nvim";
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
