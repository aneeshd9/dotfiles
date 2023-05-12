local M = {}

local function keymaps()
  local wk = require("which-key")
  wk.register({
    b = {
      p = { "<cmd>BufferLineTogglePin<CR>", "Toggle pin" },
      P = { "<cmd>BufferLineGroupClose ungrouped<CR>", "Delete non-pinned buffers" },
    },
  }, { prefix = "<leader>" })
end

M.setup = function()
  local status_ok, bufferline = pcall(require, "bufferline")
  if not status_ok then
    return
  end

  bufferline.setup({
    options = {
      diagnostics = "nvim_lsp",
      always_show_bufferline = false,
      diagnostics_indicator = function(_, _, diag)
        local icons = require("user.icons").diagnostics
        local ret = (diag.error and icons.Error .. diag.error .. " " or "")
        .. (diag.warning and icons.Warn .. diar.warning or "")
        return vim.trim(ret)
      end,
      groups = {
        items = {
          require('bufferline.groups').builtin.pinned:with({ icon = "" })
        },
      },
      offsets = {
        {
          filetype = "neo-tree",
          text = "Neo-tree",
          highlight = "Directory",
          text_align = "left",
        },
      },
    }
  })

  keymaps()
end

return M
