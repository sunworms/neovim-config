vim.loader.enable()

-- Diable builtins
local vg = vim.g

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
	vg["loaded_" .. plugin] = 1
end

-- Set the leader key to the spacebar
vg.mapleader = " "
vg.maplocalleader = " "
vg.loaded_perl_provider = 0
vg.loaded_ruby_provider = 0
vg.loaded_node_provider = 0
vg.loaded_python3_provider = 0
vg.clipboard = {
	name = "wl-utils",
	copy = { ["+"] = "wl-copy", ["*"] = "wl-copy" },
	paste = { ["+"] = "wl-paste", ["*"] = "wl-paste" },
	cache_enabled = 1,
}

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

-- Wrap Lines
opt.whichwrap:append("<,>,h,l,[,]")

local key = vim.keymap

key.set("n", "<Space>y", '"+y')
key.set("v", "<Space>y", '"+y')

key.set("n", "<Space>p", '"+p')
key.set("v", "<Space>p", '"+p')

vim.o.winborder = "rounded"

local function apply_transparency()
	local groups = {
		"Normal",
		"NormalNC",
		"NormalFloat",
		"FloatBorder",
		"SignColumn",
		"EndOfBuffer",
		"LineNr",
		"CursorLineNr",
		"VertSplit",
		"WinSeparator",
		"Pmenu",
		"TabLine",
		"TabLineFill",
		"StatusLine",
		"StatusLineNC",
	}
	for _, group in ipairs(groups) do
		vim.api.nvim_set_hl(0, group, { bg = "none", ctermbg = "none" })
	end
end

vim.api.nvim_create_autocmd("ColorScheme", {
	callback = apply_transparency,
})

apply_transparency()

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

vim.api.nvim_create_autocmd("FileType", {
	callback = function(args)
		local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
		if lang and vim.treesitter.language.add(lang) then
			vim.treesitter.start(args.buf, lang)
			vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
			vim.wo[0][0].foldmethod = "expr"
			vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		end
	end,
})
vim.api.nvim_create_autocmd("FileType", {
	pattern = "tex",
	callback = function()
		vim.treesitter.stop()
	end,
})
opt.foldenable = false

require("lz.n").load("lazy")
