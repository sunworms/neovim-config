return {
	{
		"nvim-autopairs",
		event = "InsertEnter",
		after = function()
			require("nvim-autopairs").setup()
		end,
	},
	{
		"nvim-treesitter",
		event = "BufReadPost",
	},
	{
		"gitsigns.nvim",
		event = "BufReadPost",
	},
	{
		"oil-git.nvim",
		dependencies = {
			"oil.nvim",
		},
	},
}
