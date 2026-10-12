vim.pack.add({
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/mason-org/mason.nvim",
  "https://github.com/mason-org/mason-lspconfig.nvim",
  "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
})

require("mason").setup()
require("mason-lspconfig").setup()
require("mason-tool-installer").setup({
  ensure_installed = {
    "lua_ls",
    "vtsls",
    "eslint_d",
    "biome",
    "css-lsp",
    "jsonls",
    "ruby_lsp",
    "standardrb"
  }
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local bufnr = ev.buf
    local map = vim.keymap.set
    local lsp = vim.lsp
    local opts = function(desc)
      return { silent = true, buffer = bufnr, desc = desc }
    end

    map("n", "<localleader>e", vim.diagnostic.open_float, opts("Open diagnostic"))
    map("n", "<localleader>q", ":Trouble diagnostics<cr>", opts("Diagnostics list"))

    map("n", "<localleader>gd", ":Telescope lsp_definitions<cr>", opts("Definition"))
    map("n", "<localleader>gi", ":Telescope lsp_implementations<cr>", opts("Implementation"))
    map("n", "<localleader>gr", ":Telescope lsp_references<cr>", opts("References"))
    map("n", "<C-k>", lsp.buf.signature_help, opts("Signature help"))

    map("n", "<leader>wa", lsp.buf.add_workspace_folder, opts("Add workspace folder"))
    map("n", "<leader>wr", lsp.buf.remove_workspace_folder, opts("Remove workspace folder"))
    map("n", "<localleader>wl", function()
      print(vim.inspect(lsp.buf.list_workspace_folders()))
    end, opts("List workspace folders"))

    map("n", "<localleader>D", lsp.buf.type_definition, opts("Type definition"))
    map("n", "<localleader>rn", lsp.buf.rename, opts("Rename"))
    map("n", "<localleader>ca", lsp.buf.code_action, opts("Code action"))
    map("n", "gr", lsp.buf.references, opts("References (quickfix)"))
    map("n", "<localleader>f", function()
      lsp.buf.format({ async = true })
    end, opts("Format"))
  end,
})
