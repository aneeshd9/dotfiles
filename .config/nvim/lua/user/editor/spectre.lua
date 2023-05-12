local M = {}

local function keymaps()
  local wk = require("which-key")

  wk.register({
    s = {
      r = { function() require("spectre").open() end, "Replace in files (spectre)" },
    },
  }, { prefix = "<leader>" })
end

M.setup = function()
  local status_ok, spectre = pcall(require, "spectre")
  if not status_ok then
    return
  end

  spectre.setup()

  keymaps()
end

return M
