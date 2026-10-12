vim.pack.add({ "https://github.com/tpope/vim-fugitive" })

local map = vim.keymap.set
map("n", "<leader>ga", ":Git <CR>", { desc = "manage" })
map("n", "<leader>gl", ":Git log <CR>", { desc = "log" })
map("n", "<leader>gp", ":Git pull <CR>", { desc = "pull" })
map("n", "<leader>gP", ":Git push origin HEAD --force-with-lease <CR>", { desc = "push" })
map("n", "<leader>gf", ":Git fetch <CR>", { desc = "fetch" })
map("n", "<leader>gr", ":Git rebase --interactive <CR>", { desc = "rebase", silent = false })
map("n", "<leader>gR", ":Git reset HEAD~ <CR>", { desc = "reset" })
