return {
	"vimtex",
	ft = "tex",
	after = function()
		vim.g.vimtex_view_method = "zathura"
	end,
}
