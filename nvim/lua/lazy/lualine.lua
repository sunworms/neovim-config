return {
	"lualine.nvim",
	event = "DeferredUIEnter",
	after = function()
		require("lualine").setup({
			options = { theme = require("matugen").lualine() },
		})
		vim.api.nvim_create_autocmd("User", {
			pattern = "MatugenReloaded",
			callback = function()
				require("lualine").setup({
					options = { theme = require("matugen").lualine() },
				})
			end,
		})
	end,
}
