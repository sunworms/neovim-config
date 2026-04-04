return {
	"typst-preview.nvim",
	ft = "typst",
	after = function()
		require("typst-preview.nvim").setup({
			invert_colors = "auto",
			dependencies_bin = {
				["tinymist"] = "tinymist",
				["websocat"] = "websocat",
			},
		})
	end,
}
