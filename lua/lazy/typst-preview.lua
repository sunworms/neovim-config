return {
	"typst-preview.nvim",
	ft = "typst",
  before = function()
    vim.pack.add({"https://github.com/chomosuke/typst-preview.nvim"})
  end,
	after = function()
		require("typst-preview").setup({
			invert_colors = "auto",
			dependencies_bin = {
				["tinymist"] = "tinymist",
				["websocat"] = "websocat",
			},
		})
	end,
}
