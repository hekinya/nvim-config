local function set_dashboard_colors()
  vim.api.nvim_set_hl(0, "NyaBlue", {
    fg = "#87CEFA",
  })

  vim.api.nvim_set_hl(0, "NyaPink", {
    fg = "#FFB6C1",
  })
end

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = set_dashboard_colors,
})

set_dashboard_colors()
