local blue = "#87CEFA"
local pink = "#FFB6C1"

-- NYANYA：天蓝色
local nya = {
  "███╗   ██╗██╗   ██╗ █████╗ ███╗   ██╗██╗   ██╗ █████╗ ",
  "████╗  ██║╚██╗ ██╔╝██╔══██╗████╗  ██║╚██╗ ██╔╝██╔══██╗",
  "██╔██╗ ██║ ╚████╔╝ ███████║██╔██╗ ██║ ╚████╔╝ ███████║",
  "██║╚██╗██║  ╚██╔╝  ██╔══██║██║╚██╗██║  ╚██╔╝  ██╔══██║",
  "██║ ╚████║   ██║   ██║  ██║██║ ╚████║   ██║   ██║  ██║",
  "╚═╝  ╚═══╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═══╝   ╚═╝   ╚═╝  ╚═╝",
}

-- VIM：浅粉色
local vim_art = {
  "██╗   ██╗██╗███╗   ███╗",
  "██║   ██║██║████╗ ████║",
  "██║   ██║██║██╔████╔██║",
  "╚██╗ ██╔╝██║██║╚██╔╝██║",
  " ╚████╔╝ ██║██║ ╚═╝ ██║",
  "  ╚═══╝  ╚═╝╚═╝     ╚═╝",
}

local function setup_colors()
  vim.api.nvim_set_hl(0, "NyaBlue", {
    fg = blue,
    bold = true,
  })

  vim.api.nvim_set_hl(0, "NyaPink", {
    fg = pink,
    bold = true,
  })
end

-- 每一行作为一个 section，
-- 每个 section 包含两个独立着色的文本片段
local sections = {}

for i = 1, #nya do
  sections[#sections + 1] = {
    text = {
      { nya[i], hl = "NyaBlue" },
      { "  " .. vim_art[i], hl = "NyaPink" },
    },
    align = "center",
    padding = 0,
  }
end

-- 保留原来的启动菜单
sections[#sections + 1] = {
  section = "keys",
  gap = 1,
  padding = 2,
}

-- 保留启动耗时信息
sections[#sections + 1] = {
  section = "startup",
}

return {
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        width = 90,
        preset = {
          header = "",
        },
        sections = sections,
      },
    },
    init = function()
      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = setup_colors,
      })

      setup_colors()
    end,
  },
}
