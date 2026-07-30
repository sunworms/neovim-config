return {
	"yazi.nvim",
	cmd = "Yazi",
	after = function()
		require("yazi").setup({
			open_for_directories = true,
			keymaps = {
				show_help = "<f1>",
			},
		})
	end,
	keys = {
		{
			"<leader>-",
			mode = { "n", "v" },
			"<cmd>Yazi<cr>",
			desc = "Open yazi at the current file",
		},
		{
			"<leader>cw",
			"<cmd>Yazi cwd<cr>",
			desc = "Open the file manager in nvim's working directory",
		},
		{
			"<c-up>",
			"<cmd>Yazi toggle<cr>",
			desc = "Resume the last yazi session",
		},
	},
}
