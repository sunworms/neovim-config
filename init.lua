-- Set the leader key to the spacebar
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt

-- General
opt.mouse = "a"
opt.clipboard = "unnamedplus"
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

vim.o.winborder = "rounded"

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
}

for _, plugin in ipairs(disabled_built_ins) do
	vim.g["loaded_" .. plugin] = 1
end

local theme_file = os.getenv("HOME") .. "/.cache/matugen/matugen.lua"

local function apply_matugen_theme()
	package.loaded[theme_file] = nil
	local colors = dofile(theme_file)
	require("base16-colorscheme").setup(colors)
end

if vim.fn.filereadable(theme_file) == 1 then
	apply_matugen_theme()
else
	vim.cmd("colorscheme base16-catppuccin-mocha")
end

local signal = vim.uv.new_signal()
signal:start(
	"sigusr1",
	vim.schedule_wrap(function()
		package.loaded["theme_file"] = nil
		package.loaded["lualine"] = nil
		apply_matugen_theme()
		require("lualine").setup({ options = { theme = "base16" } })
	end)
)

require("oil").setup()
require("lz.n").load("lazy")
