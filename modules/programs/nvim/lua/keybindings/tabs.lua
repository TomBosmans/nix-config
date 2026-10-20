local map = vim.keymap.set

map("n", "tn", ":tabnew <CR>", { desc = "new" })
map("n", "tc", ":tabclose <CR>", { desc = "close" })
map("n", "ts", ":tab split <CR>", { desc = "split" })

map("n", "t1", "1gt<CR>", { desc = "goto tab 1" })
map("n", "t2", "2gt<CR>", { desc = "goto tab 2" })
map("n", "t3", "3gt<CR>", { desc = "goto tab 3" })
map("n", "t4", "4gt<CR>", { desc = "goto tab 4" })
map("n", "t5", "5gt<CR>", { desc = "goto tab 5" })
map("n", "t6", "6gt<CR>", { desc = "goto tab 6" })
map("n", "t7", "7gt<CR>", { desc = "goto tab 7" })
map("n", "t8", "8gt<CR>", { desc = "goto tab 8" })
map("n", "t9", "9gt<CR>", { desc = "goto tab 9" })
