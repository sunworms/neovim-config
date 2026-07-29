return {
	"lualine.nvim",
	event = "DeferredUIEnter",
	after = function()
		vim.opt.rtp:append("~/.config/nvim")
		require("lualine").setup({
			options = { theme = "base46-matugen" },
		})
	end,
}
