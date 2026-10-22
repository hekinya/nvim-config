local M = {}
local ns = vim.api.nvim_create_namespace("delete_particles")
local attached = {}
local active = {}
local glyphs = { "·", "✦", "⋆", "•" }

local function stop(buf)
  local timer = active[buf]
  if timer then
    timer:stop()
    timer:close()
    active[buf] = nil
  end
  if vim.api.nvim_buf_is_valid(buf) then
    vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)
  end
end

local function burst(buf, row, col)
  if not vim.api.nvim_buf_is_valid(buf) or vim.fn.bufwinid(buf) == -1 then
    return
  end
  stop(buf)
  local particles = {}
  for i = 1, 10 do
    local angle = (i / 10) * math.pi * 2 + (math.random() - 0.5) * 0.45
    particles[i] = { dx = math.cos(angle), dy = math.sin(angle), glyph = glyphs[math.random(#glyphs)] }
  end
  local frame = 0
  local timer = vim.uv.new_timer()
  active[buf] = timer
  timer:start(0, 35, vim.schedule_wrap(function()
    if not vim.api.nvim_buf_is_valid(buf) then
      stop(buf)
      return
    end
    vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)
    frame = frame + 1
    if frame > 7 then
      stop(buf)
      return
    end
    local lines = vim.api.nvim_buf_line_count(buf)
    for i, p in ipairs(particles) do
      local y = row + math.floor(p.dy * frame * 0.55 + 0.5)
      if y >= 0 and y < lines then
        local line = vim.api.nvim_buf_get_lines(buf, y, y + 1, false)[1]
        local x = math.max(0, math.min(#line, col + math.floor(p.dx * frame * 1.2 + 0.5)))
        vim.api.nvim_buf_set_extmark(buf, ns, y, x, {
          virt_text = { { p.glyph, i % 2 == 0 and "DeleteParticleBlue" or "DeleteParticleWhite" } },
          virt_text_pos = "overlay",
          priority = 200,
        })
      end
    end
  end))
end

local function attach(buf)
  if attached[buf] or vim.bo[buf].buftype ~= "" then
    return
  end
  attached[buf] = true
  vim.api.nvim_buf_attach(buf, false, {
    on_bytes = function(_, changed_buf, _, row, col, _, old_end_row, old_end_col, _, new_end_row, new_end_col)
      if old_end_row > new_end_row or (old_end_row == new_end_row and old_end_col > new_end_col) then
        vim.schedule(function()
          burst(changed_buf, row, col)
        end)
      end
    end,
    on_detach = function(_, detached_buf)
      attached[detached_buf] = nil
      stop(detached_buf)
    end,
  })
end

function M.setup()
  local function colors()
    vim.api.nvim_set_hl(0, "DeleteParticleWhite", { fg = "#FFFFFF" })
    vim.api.nvim_set_hl(0, "DeleteParticleBlue", { fg = "#87CEFA" })
  end
  colors()
  vim.api.nvim_create_autocmd("ColorScheme", { callback = colors })
  vim.api.nvim_create_autocmd("BufEnter", { callback = function(args) attach(args.buf) end })
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) then
      attach(buf)
    end
  end
end

return M
