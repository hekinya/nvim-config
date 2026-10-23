return {
  {
    "folke/snacks.nvim",
    opts = function(_, opts)
      local tree = require("snacks.explorer.tree")
      tree.walk = function(self, node, visit, walk_opts)
        local abort = visit(node)
        if abort ~= nil then
          return abort
        end
        local children = vim.tbl_values(node.children)
        table.sort(children, function(a, b)
          if a.dir ~= b.dir then
            return not a.dir
          end
          return a.name < b.name
        end)
        for index, child in ipairs(children) do
          child.last = index == #children
          if child.dir and (child.open or (walk_opts and walk_opts.all)) then
            abort = self:walk(child, visit, walk_opts)
          else
            abort = visit(child)
          end
          if abort then
            return true
          end
        end
        return false
      end
    end,
  },
}
