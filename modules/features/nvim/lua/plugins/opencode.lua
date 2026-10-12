vim.pack.add({ "https://github.com/nickjvandyke/opencode.nvim" })

vim.g.opencode_opts = {
  prompts = {
    ask = { prompt = "", ask = true, submit = true },
    diagnostics = { prompt = "Explain @diagnostics", submit = true },
    diff = { prompt = "Review the following git diff for correctness and readability: @diff", submit = true },
    document = { prompt = "Add comments documenting @this", submit = true },
    explain = { prompt = "Explain @this and its context", submit = true },
    fix = { prompt = "Fix @diagnostics", submit = true },
    implement = { prompt = "Implement @this", submit = true },
    optimize = { prompt = "Optimize @this for performance and readability", submit = true },
    review = { prompt = "Review @this for correctness and readability", submit = true },
    test = { prompt = "Add tests for @this", submit = true },
  },
}

vim.o.autoread = true -- Required for `opts.events.reload`

-- Opencode keymaps (<localleader>o prefix)
vim.keymap.set({ "n", "x" }, "<localleader>oa", function() require("opencode").ask("@this: ", { submit = true }) end,
  { desc = "Ask opencode" })
vim.keymap.set({ "n", "x" }, "<localleader>os", function() require("opencode").select() end,
  { desc = "Execute opencode action" })
vim.keymap.set({ "n", "t" }, "<localleader>ot", function() require("opencode").toggle() end,
  { desc = "Toggle opencode" })
vim.keymap.set("n", "<localleader>oS", function() require("opencode").select_server() end,
  { desc = "Select opencode server" })

vim.keymap.set({ "n", "x" }, "go", function() return require("opencode").operator("@this ") end,
  { desc = "Add range to opencode", expr = true })
vim.keymap.set("n", "goo", function() return require("opencode").operator("@this ") .. "_" end,
  { desc = "Add line to opencode", expr = true })

vim.keymap.set("n", "<localleader>ou", function() require("opencode").command("session.half.page.up") end,
  { desc = "Scroll opencode up" })
vim.keymap.set("n", "<localleader>od", function() require("opencode").command("session.half.page.down") end,
  { desc = "Scroll opencode down" })
