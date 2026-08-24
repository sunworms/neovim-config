{
  pkgs,
  inputs,
}:
(import inputs.mnw.src).lib.wrap pkgs {
  neovim = pkgs.neovim-unwrapped;
  luaFiles = [
    "${./nvim/init.lua}"
  ];
  plugins = {
    start = with pkgs.vimPlugins; [
      lz-n
      friendly-snippets
      nvim-web-devicons
      base16-nvim
      nvim-treesitter.withAllGrammars
      gitsigns-nvim
    ];
    opt = with pkgs.vimPlugins; [
      yazi-nvim
      fzf-lua
      blink-cmp
      nvim-autopairs
      lualine-nvim
      nvim-lspconfig
      conform-nvim
      neogit
      orgmode
      vimtex
      (typst-preview-nvim.overrideAttrs {
        postPatch = ''
          substituteInPlace lua/typst-preview/config.lua \
          	--replace-fail "['tinymist'] = nil" "['tinymist'] = 'tinymist'" \
          	--replace-fail "['websocat'] = nil" "['websocat'] = 'websocat'"
        '';
      })
    ];

    dev.default = {
      pure = "${./nvim}";
      impure = "/home/sunny/Projects/neovim-config/nvim";
    };
  };

  extraBinPath = with pkgs; [
    lua-language-server
    stylua
  ];
}
