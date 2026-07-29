return {
	"lualine.nvim",
	event = "DeferredUIEnter",
	after = function()
		require("lualine").setup({
			options = { theme = require("matugen").lualine() },
		})
	end,
}
