return {
	"oil.nvim",
	cmd = "Oil",
	after = function()
		require("oil").setup({
			view_options = {
				show_hidden = true,
			},
		})
		vim.api.nvim_create_autocmd("VimEnter", {
			callback = function()
				local arg = vim.fn.argv(0)
				if arg == "" then
					return
				end
				if vim.fn.isdirectory(arg) == 1 then
					vim.cmd("Oil " .. vim.fn.fnameescape(arg))
				end
			end,
		})
	end,
	keys = {
		{
			"<leader>-",
			mode = { "n", "v" },
			"<cmd>Oil<cr>",
			desc = "Open Oil at the current file",
		},
	},
}
