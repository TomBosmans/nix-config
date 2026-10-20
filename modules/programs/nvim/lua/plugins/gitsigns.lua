vim.pack.add({ "https://github.com/lewis6991/gitsigns.nvim" })

require("gitsigns").setup({
  preview_config = {
    border = "rounded",
  },
})

local map = vim.keymap.set
map("n", "<leader>ghr", ":Gitsigns reset_hunk<CR>", { desc = "reset hunk" })
map("n", "<leader>ghR", ":Gitsigns reset_buffer<CR>", { desc = "reset buffer" })
map("n", "<leader>ghb", ":lua require('gitsigns').blame_line({full=true})<CR>", { desc = "blame" })
map("n", "<leader>ghp", ":Gitsigns preview_hunk<CR>", { desc = "preview" })
map("n", "<leader>ghl", ":Gitsigns toggle_linehl<CR>", { desc = "toggle linehl" })
map("n", "]g", ":lua require('gitsigns').next_hunk({navigation_message = false}) <CR>", { desc = "goto next git hunk" })
map("n", "[g", ":lua require('gitsigns').prev_hunk({navigation_message = false}) <CR>", { desc = "goto prev git hunk" })
