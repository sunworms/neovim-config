return {
	"echasnovski/mini.statusline",
	event = "VeryLazy",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("mini.statusline").setup()
	end,
}
