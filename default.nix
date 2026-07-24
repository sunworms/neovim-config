{
  pkgs,
  inputs,
}:
inputs.mnw.lib.wrap pkgs {
  neovim = pkgs.neovim-unwrapped;
  luaFiles = [
    "${./nvim/init.lua}"
  ];
  plugins = {
    start = with pkgs.vimPlugins; [
      lz-n
      friendly-snippets
      nvim-web-devicons
      (pkgs.vimUtils.buildVimPlugin {
        pname = "base46";
        version = "dirty";
        src = inputs.base46;
        doCheck = false;
      })
      oil-nvim
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
      impure = "/home/sunny/Documents/neovim-config/nvim";
    };
  };

  extraBinPath = with pkgs; [
    lua-language-server
    stylua
    fzf
  ];
}
