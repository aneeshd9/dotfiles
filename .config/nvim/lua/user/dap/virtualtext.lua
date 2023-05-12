local M = {}

M.setup = function()
  local status_ok, vtext = pcall(require, "nvim-dap-virtual-text")
  if not status_ok then
    return
  end

  vtext.setup()
end

return M
