local M = {}

local function keymaps()
  local status_ok, wk = pcall(require, "which-key")
  if not status_ok then
    return
  end

  wk.register({
    n = {
      name = "noice",
      l = { function() require("noice").cmd("last") end, "Noice last message" },
      h = { function() require("noice").cmd("history") end, "Noice history" },
      a = { function() require("noice").cmd("all") end, "Noice all" },
      d = { function() require("noice").cmd("dismiss") end, "Noice dismiss" },
    },
  }, { prefix = "<leader>" })
end

M.setup = function()
  local status_ok, noice = pcall(require, "noice")
  if not status_ok then
    return
  end

  noice.setup({
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
      },
    },
    presets = {
      bottom_search = true,
      command_palette = true,
      long_message_to_split = true,
    },
  })

  keymaps()
end

return M
