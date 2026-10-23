return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_c, 1, {
        function()
          return "󰉋 " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":~")
        end,
        color = { fg = "#87CEFA" },
      })
    end,
  },
  {
    "folke/noice.nvim",
    opts = { routes = { { filter = { event = "msg_show", kind = "shell_out" }, view = "split" } } },
  },
}
