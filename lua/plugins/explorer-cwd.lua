return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          explorer = {
            on_change = function(_, item)
              if not item or not item.file then
                return
              end
              local dir = item.dir and item.file or vim.fn.fnamemodify(item.file, ":h")
              if vim.fn.isdirectory(dir) == 1 and dir ~= vim.fn.getcwd() then
                vim.api.nvim_set_current_dir(dir)
                vim.cmd.redrawstatus()
              end
            end,
          },
        },
      },
    },
  },
}
