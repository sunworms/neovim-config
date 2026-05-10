return {
	"conform.nvim",
	event = "BufWritePre",
  before = function()
    vim.pack.add({"https://github.com/stevearc/conform.nvim"})
  end,
	after = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				go = { "goimports", "gofmt" },
				rust = { "rustfmt" },
				java = { "google-java-format" },
				typst = { "typstyle" },
				tex = { "tex-fmt" },
			},
			format_on_save = { timeout_ms = 500 },
		})
	end,
}
