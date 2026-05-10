return {
	"lualine.nvim",
	event = "DeferredUIEnter",
  before = function()
    vim.pack.add({"https://github.com/nvim-lualine/lualine.nvim"})
  end,
	after = function()
		require("lualine").setup({
			options = {
				theme = "base16",
			},
		})
	end,
}
