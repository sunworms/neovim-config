{
  pkgs,
  inputs,
}:
(import inputs.mnw).lib.wrap pkgs {
  neovim = pkgs.neovim-unwrapped;
  luaFiles = [
    "${./nvim/init.lua}"
  ];
  plugins = {
    start = with pkgs.vimPlugins; [
      lz-n
      friendly-snippets
      nvim-web-devicons
    ];
    opt = with pkgs.vimPlugins; [
      nvim-treesitter.withAllGrammars
      gitsigns-nvim
      yazi-nvim
      fzf-lua
      blink-cmp
      nvim-autopairs
      nvim-lspconfig
      conform-nvim
      mini-statusline
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
