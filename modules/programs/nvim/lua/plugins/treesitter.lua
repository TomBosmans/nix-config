vim.pack.add({
  "https://github.com/nvim-treesitter/nvim-treesitter",
  "https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
})

require("nvim-treesitter-textobjects").setup({
  include_surrounding_whitespace = true,
})

vim.keymap.set({ "x", "o" }, "ac", function()
  require "nvim-treesitter-textobjects.select".select_textobject("@class.outer", "textobjects")
end)

vim.keymap.set({ "x", "o" }, "ic", function()
  require "nvim-treesitter-textobjects.select".select_textobject("@class.inner", "textobjects")
end)

vim.keymap.set({ "n", "x", "o" }, "]c", function()
  require("nvim-treesitter-textobjects.move").goto_next_start("@class.outer", "textobjects")
end)

vim.keymap.set({ "n", "x", "o" }, "[c", function()
  require("nvim-treesitter-textobjects.move").goto_previous_start("@class.outer", "textobjects")
end)


-- treesitter doesn't start on buffers anymore, not sure why this is?
vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    local ok, ts = pcall(require, "nvim-treesitter")
    if not ok or not ts then
      return
    end
    local lang = vim.treesitter.language.get_lang(args.match)
    if lang and vim.list_contains(ts.get_installed(), lang) then
      vim.treesitter.start(args.buf)
    end
  end,
})

require("nvim-treesitter").install({
  "bash",
  "regex",
  "lua",
  "vim",
  "markdown",
  "markdown_inline",
  "ruby",
  "yaml",
  "http",
  "sql",
})

vim.api.nvim_create_autocmd("VimEnter", {
  once = true,
  callback = function()
    vim.cmd("TSUpdate")
  end,
})
