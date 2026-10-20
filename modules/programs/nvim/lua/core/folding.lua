-- Custom statuscolumn function that shows a fold icon in the gutter
-- only on lines where a fold starts. Shows ▶ (highlighted) when
-- the fold is closed, ▽ when open, and a space otherwise.
_G.custom_statuscolumn = function()
  local lnum = vim.v.lnum
  local win = vim.g.statusline_winid
  local fold_icon = " "
  local level = vim.fn.getwininfo(win)[1] and vim.api.nvim_win_call(win, function()
    local l = vim.fn.foldlevel(lnum)
    if l > 0 and l > vim.fn.foldlevel(lnum - 1) then
      if vim.fn.foldclosed(lnum) >= 0 then
        return "closed"
      else
        return "open"
      end
    end
    return ""
  end) or ""
  if level == "closed" then
    fold_icon = "%#CursorLineNr#▶%*"
  elseif level == "open" then
    fold_icon = "▽"
  end
  return "%s%=%l " .. fold_icon .. " "
end

-- Use the custom Lua function to render the status column (signs + line number + fold icon)
vim.o.statuscolumn = "%!v:lua.custom_statuscolumn()"
-- Use treesitter-based expression to determine fold boundaries
vim.o.foldmethod = "expr"
-- Evaluate treesitter fold expressions for each line
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
-- Use virtual text with treesitter highlighting for folded lines (no old-style fold text)
vim.o.foldtext = ""
-- Disable the built-in fold column (we use statuscolumn instead)
vim.o.foldcolumn = "0"
-- Start with all folds open (level 99 means nothing is folded by default)
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99

-- Replace the default fold fill character (dots) with a space
vim.opt.fillchars:append({ fold = " " })

-- Remove background highlight from folded lines
vim.api.nvim_set_hl(0, "Folded", { bg = "NONE" })
