return {
	{
		"nvim-autopairs",
		event = "InsertEnter",
    before = function()
      vim.pack.add({"https://github.com/windwp/nvim-autopairs"})
    end,
		after = function()
			require("nvim-autopairs").setup()
		end,
	},
}
