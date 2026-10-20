vim.pack.add({
  "https://github.com/echasnovski/mini.ai",
  "https://github.com/echasnovski/mini.comment",
  "https://github.com/echasnovski/mini.icons",
  "https://github.com/echasnovski/mini.surround",
  "https://github.com/echasnovski/mini.pairs",
  "https://github.com/echasnovski/mini.trailspace",
  "https://github.com/echasnovski/mini.splitjoin",
})

local MiniIcons = require("mini.icons")
MiniIcons.setup({})
MiniIcons.mock_nvim_web_devicons()

require("mini.ai").setup({})
require("mini.comment").setup({})
require("mini.surround").setup({})
require("mini.pairs").setup({})
require("mini.trailspace").setup({})
require("mini.splitjoin").setup({})
