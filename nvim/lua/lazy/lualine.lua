return {
	"lualine.nvim",
	event = "DeferredUIEnter",
	after = function()
		require("lualine").setup({
			options = { theme = vim.fn.expand("~/.config/nvim/lua/lualine/themes/base46-matugen.lua") },
		})
	end,
}
