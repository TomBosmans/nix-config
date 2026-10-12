vim.pack.add({
  "https://github.com/nvim-lualine/lualine.nvim",
})

require("lualine").setup({
  options = {
    theme = "auto",
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = {
      winbar = {
        "rest_nvim_result",
        "http",
      },
    },
  },
  winbar = {
    lualine_c = {
      {
        "filetype",
        icon_only = true,
        color = { bg = "#24273a" },
      },
      {
        "filename",
        padding = 0,
        file_status = true,
        newfile_status = false,
        color = { bg = "#24273a" },
        symbols = {
          modified = "󰳻",
          readonly = "",
          unnamed = "[No Name]",
          newfile = "[New]",
        },
      },
    },
  },
  inactive_winbar = {
    lualine_c = {
      {
        "filetype",
        icon_only = true,
      },
      {
        "filename",
        file_status = true,
        newfile_status = false,
        padding = 0,
        symbols = {
          modified = "󰳻",
          readonly = "",
          unnamed = "[No Name]",
          newfile = "[New]",
        },
      },
    },
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch" },
    lualine_c = { "diff", "diagnostics" },
    lualine_x = {
      { function()
          return " "
        end,
        color = function()
          local status = require("sidekick.status").get()
          if status then
            return status.kind == "Error" and "DiagnosticError" or status.busy and "DiagnosticWarn" or "Special"
          end
        end,
        cond = function()
          local status = require("sidekick.status")
          return status.get() ~= nil
        end,
      },
      {
        function()
          local status = require("sidekick.status").cli()
          return " " .. (#status > 1 and #status or "")
        end,
        cond = function()
          return #require("sidekick.status").cli() > 0
        end,
        color = function()
          return "Special"
        end,
      }, "lsp_status", },
    lualine_y = { "progress" },
    lualine_z = { "tabs" },
  },
  extensions = { "oil" },
})
