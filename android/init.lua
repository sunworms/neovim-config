vim.g.mapleader = ","

require("journal").setup()

vim.opt.number = true
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.updatetime = 500
vim.opt.shadafile = "NONE"

vim.keymap.set("n", "<leader>jj", "<cmd>Today<CR>")
vim.keymap.set("n", "<leader>jt", "<cmd>JournalTodo<CR>")
vim.keymap.set("n", "<leader>jq", "<cmd>JournalQuicknote<CR>")
vim.keymap.set("n", "<leader>jx", "<cmd>JournalToggle<CR>")
vim.keymap.set("n", "<leader>ja", "<cmd>JournalAddTodo<CR>")
vim.keymap.set("n", "<leader>jT", "<cmd>JournalTimestamp<CR>")
vim.keymap.set("n", "<leader>jy", "<cmd>Yesterday<CR>")
vim.keymap.set("n", "<leader>jo", "<cmd>Tomorrow<CR>")
vim.keymap.set("n", "<leader>jg", ":JournalGrep ")
vim.keymap.set("n", "<leader>ju", "<cmd>JournalTodos<CR>")
vim.keymap.set("n", "<leader>jd", "<cmd>JournalDone<CR>")
