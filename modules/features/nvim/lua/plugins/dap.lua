vim.pack.add({ "https://github.com/mfussenegger/nvim-dap" })
vim.pack.add({ "https://github.com/rcarriga/nvim-dap-ui" })
vim.pack.add({ "https://github.com/nvim-neotest/nvim-nio" })

local dap = require("dap")
local dapui = require("dapui")

dapui.setup()

-- Signs
vim.fn.sign_define("DapBreakpoint", { text = "\u{f28d}", texthl = "DiagnosticError" })
vim.fn.sign_define("DapBreakpointCondition", { text = "\u{f059}", texthl = "DiagnosticWarn" })
vim.fn.sign_define("DapLogPoint", { text = "\u{f028}", texthl = "DiagnosticInfo" })
vim.fn.sign_define("DapStopped", { text = "\u{f0da}", texthl = "DiagnosticOk", linehl = "DapStoppedLine" })
vim.fn.sign_define("DapBreakpointRejected", { text = "\u{f05e}", texthl = "DiagnosticError" })

-- Automatically open/close UI
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

-- Keybindings
vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
vim.keymap.set("n", "<leader>dB", function()
  dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "Conditional Breakpoint" })
vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue" })
vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Step Over" })
vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step Into" })
vim.keymap.set("n", "<leader>dO", dap.step_out, { desc = "Step Out" })
vim.keymap.set("n", "<leader>dr", dap.restart, { desc = "Restart" })
vim.keymap.set("n", "<leader>dt", dap.terminate, { desc = "Terminate" })
vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Toggle DAP UI" })
vim.keymap.set({ "n", "v" }, "<leader>de", dapui.eval, { desc = "Eval" })

-- Ruby
dap.adapters.ruby = function(callback, config)
  callback({
    type = "server",
    host = "127.0.0.1",
    port = config.port or 12345,
    executable = {
      command = "bundle",
      args = { "exec", "rdbg", "-n", "--open", "--port", tostring(config.port or 12345), "-c", "--", config.command or "ruby", unpack(config.args or {}) },
    },
  })
end

dap.configurations.ruby = {
  {
    type = "ruby",
    name = "Launch file",
    request = "launch",
    command = "ruby",
    args = { "${file}" },
    port = 38698,
  },
  {
    type = "ruby",
    name = "Run RSpec (current file)",
    request = "launch",
    command = "bundle",
    args = { "exec", "rspec", "${file}" },
    port = 38698,
  },
  {
    type = "ruby",
    name = "Rails server",
    request = "launch",
    command = "bundle",
    args = { "exec", "rails", "server" },
    port = 38698,
  },
}
