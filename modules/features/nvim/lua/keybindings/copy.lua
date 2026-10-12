local map = vim.keymap.set

map("n", "<leader>cr", ":let @+ = expand('%')<CR>", { desc = "relative path" })
map("n", "<leader>ca", ":let @+ = expand('%:p')<CR>", { desc = "absolute path" })
map("n", "<leader>cn", ":let @+ = expand('%:t')<CR>", { desc = "file name" })
