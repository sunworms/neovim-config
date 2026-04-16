vim.loader.enable()

-- Diable builtins
local vimg = vim.g

local disabled_built_ins = {
	"netrw",
	"netrwPlugin",
	"netrwSettings",
	"netrwFileHandlers",
	"gzip",
	"zip",
	"zipPlugin",
	"tar",
	"tarPlugin",
	"getscript",
	"getscriptPlugin",
	"vimball",
	"vimballPlugin",
	"2html_plugin",
	"logipat",
	"rrhelper",
	"spellfile_plugin",
	"matchit",
	"matchparen",
	"editorconfig",
	"man",
	"osc52",
	"shada",
}

for _, plugin in ipairs(disabled_built_ins) do
	vimg["loaded_" .. plugin] = 1
end

-- Set the leader key to the spacebar
vimg.mapleader = " "
vimg.maplocalleader = " "
vimg.loaded_perl_provider = 0
vimg.loaded_ruby_provider = 0
vimg.loaded_node_provider = 0
vimg.loaded_python3_provider = 0
vimg.clipboard = {
	name = "wl-utils",
	copy = { ["+"] = "wl-copy", ["*"] = "wl-copy" },
	paste = { ["+"] = "wl-paste", ["*"] = "wl-paste" },
	cache_enabled = 1,
}
vimg.vimtex_view_method = "okular"
vimg.vimtex_quickfix_mode = 0

local opt = vim.opt

-- General
opt.mouse = "a"
opt.hidden = true
opt.swapfile = false
opt.updatetime = 500

-- UI
opt.number = true
opt.cursorline = true
opt.signcolumn = "yes"

-- Indentation
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2

-- Autoindent
opt.autoindent = true
opt.smartindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true

-- Split
opt.splitbelow = true
opt.splitright = true

-- No ShaDa
opt.shadafile = "NONE"

vim.keymap.set("n", "<Space>y", '"+y')
vim.keymap.set("v", "<Space>y", '"+y')

vim.keymap.set("n", "<Space>p", '"+p')
vim.keymap.set("v", "<Space>p", '"+p')

vim.o.winborder = "rounded"

local theme_file = vim.fn.expand("~/.cache/matugen/matugen.lua")

local function apply_matugen_theme()
	local ok, err = pcall(dofile, theme_file)
	if not ok then
		vim.cmd.colorscheme("base16-catppuccin-mocha")
	end
end

vim.api.nvim_create_autocmd("UIEnter", {
	once = true,
	callback = apply_matugen_theme,
})

local signal = vim.uv.new_signal()
signal:start(
	"sigusr1",
	vim.schedule_wrap(function()
		package.loaded["lualine"] = nil
		apply_matugen_theme()
		require("lualine").setup({ options = { theme = "base16" } })
	end)
)

local target = vim.fn.argv(0)
local stat = target and vim.uv.fs_stat(target)
if stat and stat.type == "directory" then
	vim.api.nvim_create_autocmd("VimEnter", {
		once = true,
		callback = function()
			require("oil").setup()
		end,
	})
end

require("nvim-treesitter").setup()
vim.api.nvim_create_autocmd("FileType", {
	callback = function(args)
		local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
		if lang and vim.treesitter.language.add(lang) then
			vim.treesitter.start(args.buf, lang)
		end
	end,
})
vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.wo[0][0].foldmethod = "expr"
vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
vim.opt.foldenable = false

require("lz.n").load("lazy")
