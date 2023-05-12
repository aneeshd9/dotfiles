local M = {}

local function keymaps()
  local wk = require("which-key")

  wk.register({
    ["]t"] = { function() require("todo-comments").jump_next() end, "Next todo comment" },
    ["[t"] = { function() require("todo-comments").jump_prev() end, "Previous todo comment" }
  })

  wk.register({
    x = {
      t = { "<cmd>TodoTrouble<CR>", "Todos (trouble)" },
      T = { "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<CR>", "Todo/Fix/Fixme (trouble)" },
    },
    s = {
      name = "search",
      t = { "<cmd>TodoTelescope<CR>", "Todos" },
      T = { "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<CR>", "Todo/Fix/Fixme" },
    },
  }, { prefix = "<leader>" })
end

M.setup = function()
  local status_ok, todo = pcall(require, "todo-comments")
  if not status_ok then
    return
  end

  todo.setup()

  keymaps()
end

return M
