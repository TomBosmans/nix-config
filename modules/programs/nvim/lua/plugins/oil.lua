vim.pack.add({
  "https://github.com/stevearc/oil.nvim",
  "https://github.com/benomahony/oil-git.nvim",
})

require("oil").setup({
  default_file_explorer = true,
  confirmation = {
    border = "rounded",
  },
  view_options = {
    show_hidden = true,
  },
})

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
