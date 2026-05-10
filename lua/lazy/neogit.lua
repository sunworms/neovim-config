return {
	"neogit",
	cmd = "Neogit",
  before = function()
    vim.pack.add({"https://github.com/NeogitOrg/neogit"})
  end,
	after = function()
		require("neogit").setup({})
	end,
	keys = {
		{
			"<leader>gg",
			":Neogit<CR>",
		},
	},
}
