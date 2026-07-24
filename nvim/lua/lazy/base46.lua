return {
	"base46",
	event = "DeferredUIEnter",
	after = function()
		local function apply_transparency()
			local groups = {
				"Normal",
				"NormalNC",
				"NormalFloat",
				"FloatBorder",
				"SignColumn",
				"EndOfBuffer",
				"LineNr",
				"CursorLineNr",
				"VertSplit",
				"WinSeparator",
				"Pmenu",
				"TabLine",
				"TabLineFill",
				"StatusLine",
				"StatusLineNC",
			}
			for _, group in ipairs(groups) do
				vim.api.nvim_set_hl(0, group, { bg = "none", ctermbg = "none" })
			end
		end

		vim.api.nvim_create_autocmd("ColorScheme", {
			callback = apply_transparency,
		})

		local uv = vim.uv or vim.loop
		local home = vim.fn.expand("~")
		local dms_dir = home .. "/.config/nvim"
		local dms_colors = dms_dir .. "/colors/dms.lua"

		local function exists(path)
			return uv.fs_stat(path) ~= nil
		end

		local has_dms = exists(dms_colors)

		local colorscheme_name = "base46-catppuccin"

		if has_dms then
			vim.opt.rtp:append(dms_dir)
			colorscheme_name = "dms"
		end

		local ok = pcall(vim.cmd.colorscheme, colorscheme_name)
		if not ok then
			vim.cmd.colorscheme("base46-catppuccin")
		end
	end,
}
