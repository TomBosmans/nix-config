vim.schedule(function()
  vim.pack.add({ "https://github.com/emmanueltouzery/apidocs.nvim" })

  local apidocs = require("apidocs")
  apidocs.setup()

  -- add this to .nvim.lua in your project with the specific docs for that project
  --
  -- apidocs.ensure_install({
  --   "css",
  --   "html",
  --   "http",
  --   "javascript",
  --   "dom",
  --   "ruby~4.0",
  --   "rails~8.1",
  --   "postgresql~18",
  -- })

  vim.keymap.set('n', '<leader>fdd', '<cmd>ApidocsOpen<cr>', { desc = 'Find Docs' })
  vim.keymap.set('n', '<leader>fds', '<cmd>ApidocsSearch<cr>', { desc = 'Search Api Doc' })
end)
