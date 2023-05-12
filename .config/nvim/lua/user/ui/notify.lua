local M = {}

local function keymaps()
  local wk = require("which-key")

  wk.register({
    u = {
      name = "dismiss stuff",
      n = { function() require("notify").dismiss({ silent = true, pending = true }) end, "Dismiss all notifications" },
    },
  }, { prefix = "<leader>" })
end

M.setup = function()
  local status_ok, notify = pcall(require, "notify")
  if not status_ok then
    return
  end

  notify.setup({
    timeout = 3000,
    max_height = function()
      return math.floor(vim.o.lines * 0.75)
    end,
    max_width = function()
      return math.floor(vim.o.columns * 0.75)
    end,
  })

  vim.notify = notify

  keymaps()
end

return M
