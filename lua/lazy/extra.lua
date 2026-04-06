return {
	{
		"nvim-autopairs",
		event = "InsertEnter",
		after = function()
			require("nvim-autopairs").setup()
		end,
	},
	{
		"nvim-treesitter",
		event = "BufReadPost",
		after = function()
			vim.api.nvim_create_autocmd('FileType', {
  		pattern = { '<filetype>' },
  			callback = function() vim.treesitter.start() end,
			})
			vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
			vim.wo[0][0].foldmethod = 'expr'
			vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		end,
	},
}
