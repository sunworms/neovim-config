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
		"typst-concealer",
		ft = "typst",
		after = function()
			require("typst-concealer").setup({
				enabled_by_default = true,
				conceal_in_normal = false,
			})
		end,
	},
}
