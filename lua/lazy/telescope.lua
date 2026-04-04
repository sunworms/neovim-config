return {
  "telescope.nvim",
  cmd = "Telescope",

  after = function()
    require("telescope").setup()
  end,
  keys = {
    {
      "<leader>ff",
      function()
        require("telescope.builtin").find_files()
      end,
    },
    {
      "<leader>fg",
      function()
        require("telescope.builtin").live_grep()
      end,
    },
    {
      "<leader>fb",
      function()
        require("telescope.builtin").buffers()
      end,
    },
    {
      "<leader>fh",
      function()
        require("telescope.builtin").help_tags()
      end,
    },
  },
}
