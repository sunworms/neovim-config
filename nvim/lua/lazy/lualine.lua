return {
	"lualine.nvim",
	event = "DeferredUIEnter",
	after = function()
		require("lualine").setup({
			options = {
				theme = "base16",
			},
		})
	end,
}
