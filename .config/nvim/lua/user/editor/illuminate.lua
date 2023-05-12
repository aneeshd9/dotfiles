local M = {}

local function keymaps()
  local wk = require("which-key")
  
  wk.register({
    ["]]"] = { "<cmd>lua require(\"illuminate\")[\"goto_next_reference\"](false)<CR>", "Next reference (illuminate)" },
    ["[["] = { "<cmd>lua require(\"illuminate\")[\"goto_prev_reference\"](false)<CR>", "Next reference (illuminate)" },
  })
end

M.setup = function()
  local status_ok, illuminate = pcall(require, "illuminate")
  if not status_ok then
    return
  end

  illuminate.configure({
    delay = 200,
  })

  keymaps()
end

return M
