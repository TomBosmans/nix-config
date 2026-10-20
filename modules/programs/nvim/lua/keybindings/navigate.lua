local map = vim.keymap.set

map("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end, { desc = "goto next diagnostic" })
map("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end, { desc = "goto prev diagnostic" })
