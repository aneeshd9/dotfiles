local M = {}

M.setup = function()
  local status_ok, tokyonight = pcall(require, "tokyonight")
  if not status_ok then
    return
  end

  tokyonight.setup({
    style = "moon",
  })

  vim.cmd.colorscheme("tokyonight")
end

return M
