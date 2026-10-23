-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

require('config.delete_particles').setup()

-- Keep a plain :terminal in its own full editor tab as well.
vim.api.nvim_create_autocmd("TermOpen", {
  callback = function(args)
    vim.schedule(function()
      if vim.api.nvim_buf_is_valid(args.buf)
        and vim.api.nvim_get_current_buf() == args.buf
        and vim.bo[args.buf].filetype ~= "snacks_terminal"
        and vim.api.nvim_win_get_config(0).relative == ""
      then
        vim.cmd("tab split")
      end
    end)
  end,
})

-- Follow the directory of the active file, leaving special buffers alone.
vim.api.nvim_create_autocmd({ "BufEnter", "BufFilePost" }, {
  group = vim.api.nvim_create_augroup("follow_file_directory", { clear = true }),
  callback = function(args)
    if vim.bo[args.buf].buftype ~= "" then
      return
    end
    local name = vim.api.nvim_buf_get_name(args.buf)
    if name == "" then
      return
    end
    local dir = vim.fn.fnamemodify(name, ":p:h")
    if vim.fn.isdirectory(dir) == 1 and dir ~= vim.fn.getcwd() then
      vim.api.nvim_set_current_dir(dir)
    end
  end,
})
