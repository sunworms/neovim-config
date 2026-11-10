return {
	"vimtex",
	ft = "tex",
	before = function()
		vim.g.vimtex_view_method = "zathura"
	end,
}
