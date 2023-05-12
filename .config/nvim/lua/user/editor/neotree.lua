local M = {}

local function keymaps()
  local wk = require("which-key")
  local utils = require("user.utils")

  wk.register({
    f = {
      e = {
        function() require("neo-tree.command").execute({ toggle = true, dir = utils.get_root() }) end,
        "Explorer (root dir)",
      },
      E = {
        function() require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() }) end,
        "Explorer (cwd)",
      },
    },
  }, { prefix = "<leader>" })
end

M.setup = function()
  local status_ok, neotree = pcall(require, "neo-tree")
  if not status_ok then
    return
  end

  neotree.setup({
    filesystem = {
      bind_to_cwd = false,
      follow_current_file = true,
      use_libuv_file_watcher = true,
    },
    window = {
      mappings = {
        ["<space>"] = "none",
      },
    },
    default_component_configs = {
      indent = {
        with_expanders = true,
        expander_collapsed = "",
        expander_expanded = "",
        expander_highlight = "NeoTreeExpander",
      },
    },
  })

  keymaps()
end

return M
