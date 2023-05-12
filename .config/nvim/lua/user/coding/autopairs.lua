local M = {}

M.setup = function ()
  local status_ok, minipairs = pcall(require, "mini.pairs")
  if not status_ok then
    return
  end

  minipairs.setup()
end

return M
