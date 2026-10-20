require("core.providers")
require("core.hover")

-- spellcheck
-- vim.opt.spelllang = { 'en', 'nl' }
-- vim.opt.spell = true

-- disable tabline
vim.o.showtabline = 0

-- change split directions
vim.opt.splitright = true
vim.opt.splitbelow = true

-- hide current mode
vim.opt.showmode = false
vim.opt.showcmd = false

-- set termgui colors
vim.opt.termguicolors = true

vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
  end,
})

-- show line numbers, except in terminal
vim.opt.number = true
vim.opt.relativenumber = false
vim.cmd("au TermOpen * setlocal nonumber norelativenumber")

-- highlight cursorline
vim.opt.cursorline = true

-- match os clipboard with nvim
vim.opt.clipboard = { "unnamed", "unnamedplus" }
vim.opt.inccommand = "split"

-- highlight on yank
vim.cmd("au TextYankPost * silent! lua vim.hl.on_yank()")

-- set to auto read when a file is changed from the outside
vim.opt.autoread = true
vim.cmd("au focusgained,bufenter * checktime")

-- no offset when moving up and down.
-- offset when moving left and right.
vim.opt.scrolloff = 0
vim.opt.sidescrolloff = 5

-- always show extra column
vim.opt.signcolumn = "yes"

-- no wrapping
vim.opt.wrap = false

-- Ignore cases, unless starting with cap.
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- disable swapfiles
vim.opt.swapfile = false

-- listchars
vim.opt.list = true
vim.opt.listchars = "space:⋅,tab:>-,eol:↴"

-- statusline
vim.o.ls = 3
vim.o.ch = 0

-- https://github.com/rest-nvim/rest.nvim/issues/417
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "json" },
  callback = function()
    vim.api.nvim_set_option_value("formatprg", "jq", { scope = 'local' })
  end,
})

-- Show all .env.* files with syntax highlights.
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = ".env.*",
  command = "set filetype=sh"
})
