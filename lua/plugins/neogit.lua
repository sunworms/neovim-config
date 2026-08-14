return {
	"NeogitOrg/neogit",
	cmd = "Neogit",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"sindrets/diffview.nvim",
	},
	config = function()
		require("neogit").setup({})
	end,
	keys = {
		{
			"<leader>gg",
			":Neogit<CR>",
		},
	},
}
