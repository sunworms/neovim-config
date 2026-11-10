return {
	"blink.cmp",
	event = "InsertEnter",
	before = function()
		vim.cmd.packadd("friendly-snippets")
	end,
	after = function()
		require("blink.cmp").setup({
			keymap = { preset = "super-tab" },

			appearance = {
				nerd_font_variant = "mono",
			},

			completion = {
				documentation = { auto_show = false },
			},

			sources = {
				default = { "lsp", "path", "snippets", "buffer", "omni" },
			},

			fuzzy = { implementation = "prefer_rust_with_warning" },
		})
	end,
}
