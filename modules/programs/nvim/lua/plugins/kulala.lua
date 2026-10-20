vim.pack.add({ "https://github.com/mistweaverco/kulala.nvim" })

require("kulala").setup({
  global_keymaps = false,
  global_keymaps_prefix = "<leader>r",
  kulala_keymaps_prefix = "",
})

local map = vim.keymap.set
map("n", "<leader>rs", ":lua require('kulala').run()<CR>", { desc = "send request" })
map("n", "<leader>ra", ":lua require('kulala').run_all()<CR>", { desc = "send all requests" })
map("n", "<leader>rb", ":lua require('kulala').scratchpad()<CR>", { desc = "scratchpad" })
map("n", "<leader>re", ":lua require('kulala').set_selected_env()<CR>", { desc = "select env" })
