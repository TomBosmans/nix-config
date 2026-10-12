vim.pack.add({
  "https://github.com/folke/noice.nvim",
  "https://github.com/MunifTanjim/nui.nvim",
  "https://github.com/rcarriga/nvim-notify",
})

local map = vim.keymap.set
map("n", "<leader>nd", "<cmd>Noice dismiss<CR>", { desc = "dismiss notifications" })
map("n", "<leader>nh", "<cmd>Noice history<CR>", { desc = "notification history" })
map("n", "<leader>nl", "<cmd>Noice last<CR>", { desc = "last notification" })
map("n", "<leader>ne", "<cmd>Noice errors<CR>", { desc = "errors" })
map("n", "<leader>nt", "<cmd>Noice telescope<CR>", { desc = "telescope" })

require("noice").setup({
  cmdline = {
    enabled = true,
  },
  messages = {
    enabled = true,
  },
  lsp = {
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
  },
  presets = {
    command_palette = true,
    long_message_to_split = true,
    inc_rename = false,
    lsp_doc_border = true,
  },
})
