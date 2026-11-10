-- Not lazy. Parser updates after a plugin update are handled by the PackChanged hook in init.lua.
return {
	"nvim-treesitter",
	lazy = false,
	after = function()
		require("nvim-treesitter").install("all")
	end,
}
