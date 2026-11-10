return {
	"mini.statusline",
	event = "DeferredUIEnter",
	before = function()
		vim.cmd.packadd("nvim-web-devicons")
	end,
	after = function()
		require("mini.statusline").setup()
	end,
}
