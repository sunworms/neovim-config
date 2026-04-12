return {
  "nvim-lspconfig",
  event = "BufReadPost",
  after = function()
    local capabilities = require("blink.cmp").get_lsp_capabilities()

    local langs = { "nix-1", "nix-2", "latex", "typst", "lua", "rust", "go", "java" }
    for _, lang in ipairs(langs) do
      require("lazy.lsp." .. lang)(capabilities)
    end

		vim.diagnostic.config({
			virtual_text = {
				prefix = "●", -- Could be '■', '▎', 'x'
				spacing = 4,
				source = "if_many",
			},
			float = {
				border = "rounded",
			},
			update_in_insert = false,
			severity_sort = true,
		})

		-- Show line diagnostics automatically in a floating window on hover
		vim.api.nvim_create_autocmd("CursorHold", {
			callback = function()
				vim.diagnostic.open_float(nil, {
					focusable = false,
				})
			end,
		})

		vim.api.nvim_create_autocmd("LspAttach", {
			desc = "LSP actions",
			callback = function(event)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = event.buf })
			end,
		})
	end,
}
