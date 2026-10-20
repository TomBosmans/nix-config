vim.pack.add({
  "https://github.com/nvim-neotest/neotest",

  -- dependencies
  "https://github.com/nvim-neotest/nvim-nio",
  "https://github.com/antoinemadec/FixCursorHold.nvim",
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/nvim-treesitter/nvim-treesitter",

  -- plugins
  "https://github.com/olimorris/neotest-rspec"
})

require("neotest").setup({
  adapters = {
    require("neotest-rspec")
  },
})

-- Run
vim.keymap.set("n", "<leader>tn", function() require("neotest").run.run() end, { desc = "Run nearest test" })
vim.keymap.set("n", "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, { desc = "Run current file" })
vim.keymap.set("n", "<leader>tl", function() require("neotest").run.run_last() end, { desc = "Run last test" })
vim.keymap.set("n", "<leader>td", function() require("neotest").run.run({ strategy = "dap" }) end, { desc = "Debug nearest test" })
vim.keymap.set("n", "<leader>tD", function() require("neotest").run.run_last({ strategy = "dap" }) end, { desc = "Debug last test" })
vim.keymap.set("n", "<leader>ts", function() require("neotest").run.stop() end, { desc = "Stop nearest test" })
vim.keymap.set("n", "<leader>ta", function() require("neotest").run.attach() end, { desc = "Attach to nearest test" })

-- Output
vim.keymap.set("n", "<leader>to", function() require("neotest").output.open({ enter = true }) end, { desc = "Show test output" })
vim.keymap.set("n", "<leader>tO", function() require("neotest").output_panel.toggle() end, { desc = "Toggle output panel" })

-- Summary
vim.keymap.set("n", "<leader>tS", function() require("neotest").summary.toggle() end, { desc = "Toggle summary" })
vim.keymap.set("n", "<leader>tm", function() require("neotest").summary.run_marked() end, { desc = "Run marked tests" })
vim.keymap.set("n", "<leader>tM", function() require("neotest").summary.clear_marked() end, { desc = "Clear marked tests" })

-- Watch
vim.keymap.set("n", "<leader>tw", function() require("neotest").watch.toggle(vim.fn.expand("%")) end, { desc = "Toggle watch file" })

-- Jump
vim.keymap.set("n", "[n", function() require("neotest").jump.prev({ status = "failed" }) end, { desc = "Previous failed test" })
vim.keymap.set("n", "]n", function() require("neotest").jump.next({ status = "failed" }) end, { desc = "Next failed test" })

vim.keymap.set("n", "<leader>tt", function() require("neotest").summary.toggle() end, { desc = "Open the summary window" })
