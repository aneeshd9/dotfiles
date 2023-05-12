local M = {}

M.setup = function()
  local status_ok, ibl = pcall(require, "indent_blankline")
  if not status_ok then
    return
  end

  ibl.setup({
    char = "│",
    filetype_exclude = { "help", "alpha", "neo-tree", "Trouble", "packer", "mason" },
    show_trailing_blankline_indent = false,
    show_current_context = false,
  })
end
