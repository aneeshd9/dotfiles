local M = {}

local function keymaps()
  local wk = require("which-key")

  wk.register({
    q = {
      name = "session",
      s = { function() require("persistence").load() end, "Restore session" },
      l = { function() require("persistence").load({ last = true }) end, "Restore last session" },
      d = { function() require("persistence").stop() end, "Don't save this session" },
    },
  }, { prefix = "<leader>" })
end

M.setup = function()
  local status_ok, persistence = pcall(require, "persistence")
  if not status_ok then
    return
  end

  persistence.setup({
    options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals" },
  })

  keymaps()
end

return M
