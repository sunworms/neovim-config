return {
	"nvim-treesitter",
	lazy = false,
	after = function()
		require("nvim-treesitter").install("all")
	end,
}
