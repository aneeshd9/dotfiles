local M = {}

local function keymaps()
  local wk = require("which-key")
  
  wk.register({
    x = {
      name = "trouble",
      x = { "<cmd>TroubleToggle document_diagnostics<CR>", "Document diagnostics" },
      X = { "<cmd>TroubleToggle workspace_diagnostics<CR>", "Workspace diagnostics" },
      L = { "<cmd>TroubleToggle loclist<CR>", "Location list" },
      Q = { "<cmd>TroubleToggle quickfix<CR>", "Quickfix list" },
    },
  }, { prefix = "<leader>" })

  wk.register({
    ["[q"] = {
      function()
        if require("trouble").is_open() then
          require("trouble").previous({ skip_groups = true, jump = true })
        else
          vim.cmd.cprev()
        end
      end,
      "Previous trouble/quickfix item",
    },
    ["]q"] = {
      function()
        if require("trouble").is_open() then
          require("trouble").next({ skip_groups = true, jump = true })
        else
          vim.cmd.cnext()
        end
      end,
      "Next trouble/quickfix item",
    },
  })
end

M.setup = function()
  local status_ok, trouble = pcall(require, "trouble")
  if not status_ok then
    return
  end

  trouble.setup({
    use_diagnostic_signs = true,
  })

  keymaps()
end

return M
