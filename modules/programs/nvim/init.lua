-- INFO: This is preview in 0.12, can be removed once it becomes default
-- WARN: cmdline = 0 does not work with this: https://github.com/folke/noice.nvim/issues/1201
-- require('vim._core.ui2').enable()

vim.g.mapleader = ","
vim.g.maplocalleader = " "

-- open .nvim.lua files in projects
vim.o.exrc = true

require("core")
require("plugins")
require("keybindings")
require("core.folding")
