return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      local theme = require("lualine.themes.auto")
      local pink = "#FFB6C1"
      theme.visual.a.bg = pink
      theme.visual.a.fg = "#1A1B26"
      theme.visual.b.fg = pink
      opts.options.theme = theme

      local modes = {
        Normal = theme.normal,
        Insert = theme.insert,
        Visual = theme.visual,
        Replace = theme.replace,
        Command = theme.command,
        Terminal = theme.terminal,
      }
      for name, palette in pairs(modes) do
        vim.api.nvim_set_hl(0, "Mode" .. name .. "Cursor", {
          bg = palette.a.bg,
          fg = palette.a.fg,
        })
      end

      vim.opt.guicursor = table.concat({
        "n-sm:block-ModeNormalCursor",
        "v-ve:block-ModeVisualCursor",
        "i:ver25-ModeInsertCursor",
        "c-ci-cr:ver15-ModeCommandCursor",
        "r-o:hor20-ModeReplaceCursor",
        "t:block-ModeTerminalCursor",
      }, ",")
    end,
  },
}
