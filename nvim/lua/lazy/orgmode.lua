return {
		"orgmode",
		ft = "org",
		after = function()
        require('orgmode').setup({
            org_agenda_files = '~/Documents/gdrive/org/**/*',
            org_default_notes_file = '~/Documents/gdrive/org/quick_notes.org',
						org_todo_keywords = {'TODO(t)', 'IN PROGRESS(i)', '|', 'DONE(d)'}
        })

        vim.lsp.enable('org')
		end,
}
