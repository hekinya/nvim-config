-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Open a terminal for the directory currently selected in Explorer.
local function terminal_here(focus)
  local opts = { cwd = vim.fn.getcwd() }
  if focus then
    Snacks.terminal.focus(nil, opts)
  else
    Snacks.terminal(nil, opts)
  end
end

vim.keymap.set("n", "<leader>ft", function() terminal_here(false) end, { desc = "Terminal (Current Directory)" })
vim.keymap.set("n", "<leader>fT", function() terminal_here(false) end, { desc = "Terminal (Current Directory)" })
vim.keymap.set({ "n", "t" }, "<C-/>", function() terminal_here(true) end, { desc = "Terminal (Current Directory)" })
vim.keymap.set({ "n", "t" }, "<C-_>", function() terminal_here(true) end, { desc = "Terminal (Current Directory)" })
