vim.pack.add({
  "https://github.com/nvim-telescope/telescope.nvim",
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/nvim-telescope/telescope-fzf-native.nvim",
  "https://github.com/nvim-telescope/telescope-ui-select.nvim",
  "https://github.com/nvim-telescope/telescope-live-grep-args.nvim",
  "https://github.com/nvim-telescope/telescope-symbols.nvim",
})

local map = vim.keymap.set
map("n", "<leader>ff", ":Telescope find_files <CR>", { desc = "files" })
map("n", "<leader>fg", ":Telescope git_files <CR>", { desc = "git files" })
map("n", "<leader>fb", ":Telescope buffers <CR>", { desc = "buffers" })
map("n", "<leader>fa", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", { desc = "grep" })
map("n", "<leader>gb", ":Telescope git_branches <CR>", { desc = "branches" })
map("n", "<leader>gc", ":Telescope git_commits <CR>", { desc = "commits" })
map("i", "<C-s>", ":Telescope symbols theme=cursor<CR>", { desc = "symbols" })

-- build fzf-native if not already built
local fzf_path = vim.fn.stdpath("data") .. "/site/pack/core/opt/telescope-fzf-native.nvim"
if vim.fn.empty(vim.fn.glob(fzf_path .. "/build/libfzf.so")) == 1 then
  vim.fn.system({ "make", "-C", fzf_path })
end

local telescope = require("telescope")

local lsp_theme = {
  results_title = "",
  preview_title = "",
  theme = "cursor",
  layout_config = { height = 0.3, width = 0.99 },
  border = true,
  show_line = false,
}

telescope.setup({
  defaults = {
    vimgrep_arguments = {
      "rg", "--color=never", "--no-heading", "--with-filename",
      "--line-number", "--column", "--smart-case",
      "--hidden", "--no-ignore",
    },
    mappings = {
      i = {
        ["<C-h>"] = "which_key",
      },
      n = {
        ["<C-h>"] = "which_key",
      },
    },
  },

  pickers = {
    find_files = {
      hidden = true,
      no_ignore = true,
    },
    lsp_references = lsp_theme,
    lsp_definitions = lsp_theme,
    lsp_implementations = lsp_theme,
    lsp_type_definitions = lsp_theme,
    lsp_code_actions = { theme = "cursor" },
    lsp_document_symbols = {},
    lsp_workspace_symbols = {},
    git_branches = { theme = "dropdown", previewer = false },

    buffers = {
      show_all_buffers = true,
      sort_lastused = true,
      theme = "dropdown",
      previewer = false,
      mappings = {
        i = {
          ["<c-d>"] = "delete_buffer",
        },
        n = {
          ["<c-d>"] = "delete_buffer",
        },
      },
    },
  },

  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
    ["ui-select"] = {
      require("telescope.themes").get_cursor({}),
    },
  },
})

telescope.load_extension("fzf")
telescope.load_extension("ui-select")
telescope.load_extension("live_grep_args")
