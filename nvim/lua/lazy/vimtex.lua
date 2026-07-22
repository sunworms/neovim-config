return {
	"vimtex",
	ft = "tex",
	after = function()
		vim.g.vimtex_view_general_viewer = "qpdfview"
		vim.g.vimtex_view_general_options = "--unique @pdf#src:@tex:@line:@col"
	end,
}
