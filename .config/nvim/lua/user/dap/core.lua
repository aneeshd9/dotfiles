local M = {}

local function keymaps()
  local wk = require("which-key")

  wk.register({
    d = {
      name = "debug",

      a = {
        name = "adapters",
      },

      B = { function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, "Breakpoint condition" },
      b = { function() require("dap").toggle_breakpoint() end, "Toggle breakpoint" },
      c = { function() require("dap").continue() end, "Continue" },
      C = { function() require("dap").run_to_cursor() end, "Run to cursor" },
      g = { function() require("dap").goto_() end, "Go to line (no execute)"},
      i = { function() require("dap").step_into() end, "Step into" },
      j = { function() require("dap").down() end, "Down" },
      k = { function() require("dap").up() end, "Up" },
      l = { function() require("dap").run_last() end, "Run last" },
      o = { function() require("dap").step_out() end, "Step out" },
      O = { function() require("dap").step_over() end, "Step over" },
      p = { function() require("dap").pause() end, "Pause" },
      r = { function() require("dap").repl.toggle() end, "Toggle REPL" },
      s = { function() require("dap").session() end, "Session" },
      t = { function() require("dap").terminate() end, "Terminate" },
      w = { function() require("dap.ui.widgets").hover() end, "Widgets" },
      u = { function() require("dapui").toggle({ }) end, "Dap UI" },
      e = { function() require("dapui").eval() end, "Eval" },
    },
  }, { prefix = "<leader>" })

  wk.register({
    d = {
      name = "debug",

      e = { function() require("dapui").eval() end, "Eval" },
    }
  }, { mode = "v", prefix = "<leader>" })
end

M.setup = function()
  local status_ok, dap = pcall(require, "dap")
  if not status_ok then
    return
  end

  vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

  local icons = require("user.icons")

  for name, sign in pairs(icons.dap) do
    sign = type(sign) == "table" and sign or { sign }
    vim.fn.sign_define(
      "Dap" .. name,
      { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
    )
  end

  keymaps()
end

return M
