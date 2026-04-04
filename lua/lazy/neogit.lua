return {
    "neogit",
    cmd = "Neogit",
    after = function()
        require("neogit").setup({})
    end,
    keys = {
      {
        "<leader>gg",
        ":Neogit<CR>",
      },
    },
}
