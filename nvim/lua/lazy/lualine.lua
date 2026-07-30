return {
	"lualine.nvim",
	event = "DeferredUIEnter",
	after = function()
		local uv = vim.uv or vim.loop
		local function exists(path)
			return uv.fs_stat(path) ~= nil
		end

		local colors = vim.fn.expand("~/.config/nvim/lua/lualine/themes/base46-matugen.lua")

		local has_colors = exists(colors)

		if has_colors then
			vim.opt.rtp:append("~/.config/nvim")
			require("lualine").setup({
				options = { theme = "base46-matugen" },
			})
		else
			require("lualine").setup({
				options = { theme = "base46-catppuccin" },
			})
		end
	end,
}
