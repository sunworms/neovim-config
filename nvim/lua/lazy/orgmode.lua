return {
	"orgmode",
	event = "DeferredUIEnter",
	after = function()
		require("orgmode").setup({
			org_agenda_files = "~/Documents/gdrive/org/**/*",
			org_default_notes_file = "~/Documents/gdrive/org/quick_notes.org",
			org_todo_keywords = { "TODO(t)", "IN PROGRESS(i)", "|", "DONE(d)" },
		})

		vim.lsp.enable("org")

		local function open_today_journal()
			local journal_dir = vim.fn.expand("~/Documents/gdrive/org/journal")
			local filename = os.date("%Y-%m-%d") .. ".org"
			local filepath = journal_dir .. "/" .. filename

			vim.fn.mkdir(journal_dir, "p")

			if vim.fn.filereadable(filepath) == 0 then
				vim.fn.writefile({
					"#+TITLE: " .. os.date("%Y-%m-%d"),
					"",
				}, filepath)
			end

			vim.cmd("edit " .. vim.fn.fnameescape(filepath))
		end

		vim.keymap.set("n", "<leader>oj", open_today_journal, {
			desc = "Open today's journal",
		})

		vim.keymap.set("n", "<leader>od", function()
			vim.cmd("edit ~/Documents/gdrive/org/todo.org")
		end, {
			desc = "Open TODO file",
		})
	end,
}
