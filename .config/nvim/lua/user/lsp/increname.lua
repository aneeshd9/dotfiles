local M = {}

function M.setup()
  local status_ok, increname = pcall(require, "inc_rename")
  if not status_ok then
    return
  end

  increname.setup()
end

return M
