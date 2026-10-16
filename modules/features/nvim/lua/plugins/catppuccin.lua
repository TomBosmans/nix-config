vim.pack.add({ "https://github.com/catppuccin/nvim" })

require("catppuccin").setup({
  flavour = "macchiato",
  dim_inactive = {
    enabled = true,
  },
  integrations = {
    dadbod_ui = true,
    diffview = true,
    lsp_trouble = true,
    lualine = true,
    mason = true,
    neotest = true,
    noice = true,
    notify = true,
    which_key = true,
  },
})

vim.cmd.colorscheme("catppuccin")
