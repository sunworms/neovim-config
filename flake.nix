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
    {
      packages.x86_64-linux =
        let
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
        in
        {
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

          dev = self.packages.x86_64-linux.default.devMode;
        };
    };
}
