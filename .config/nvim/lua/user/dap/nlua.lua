local M = {}

local function keymaps()
  local wk = require("which-key")

  wk.register({
    d = {
      a = {
        L = { function() require("osv").launch({ port = 8086 }) end, "Adapter lua server" },
        l = { function() require("osv").run_this() end, "Adapter lua" },
      },
    },
  }, { prefix = "<leader>" })
end

M.setup = function()
  local dap = require("dap")

  dap.adapters.nlua = function(callback, config)
    callback({ type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 })
  end

  dap.configurations.lua = {
    {
      type = "nlua",
      request = "attach",
      name = "Attach to running Neovim instance",
    }
  }

  keymaps()
end

return M
