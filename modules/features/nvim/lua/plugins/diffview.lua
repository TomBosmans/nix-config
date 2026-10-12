vim.pack.add({ "https://github.com/sindrets/diffview.nvim" })

require("diffview").setup({})

local map = vim.keymap.set
map("n", "<leader>gdo", ":DiffviewOpen <CR>", { desc = "open" })
map("n", "<leader>gdh", ":DiffviewFileHistory % <CR>", { desc = "history" })
map("n", "<leader>gdc", ":DiffviewClose <CR>", { desc = "close" })
