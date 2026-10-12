vim.pack.add({ "https://github.com/folke/which-key.nvim" })

local wk = require("which-key")

wk.setup({
  win = {
    border = "rounded",
  },
})

wk.add({
  { "<leader>c", group = "copy", icon = { icon = "󰆏", color = "yellow" } },
  { "<leader>f", group = "find" },
  { "<leader>fd", group= "Docs", icon = { icon = "󱔗", color = "cyan" } },
  { "<leader>g", group = "Git" },
  { "<leader>gh", group = "Hunk" },
  { "<leader>gd", group = "Diffview" },
  { "<leader>p", group = "Package Managers", icon = { icon = "󰏗", color = "orange" } },
  { "<leader>T", group = "Treesitter", icon = { icon = "󱘎", color = "green" } },
  { "<leader>n", group = "Notifications", icon = { icon = "󰍡", color = "yellow" } },
  { "<leader>r", group = "HTTP", icon = { icon = "󰖟", color = "blue" } },
  { "<leader>t", group = "Test", icon = { icon = "󰙨", color = "green" } },
  { "<leader>x", group = "Trouble", icon = { icon = "", color = "red" } },
  { "]", group = "Next" },
  { "[", group = "Previous" },
  { "t", group = "Tabs" },
  { "<localleader>o", group = "OpenCode", icon = { icon = "󱙺", color = "purple" } },
})
