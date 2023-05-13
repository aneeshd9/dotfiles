local M = {}

function M.setup()
  local status_ok, lspsaga = pcall(require, "lspsaga")
  if not status_ok then
    return
  end

  lspsaga.setup({
    symbol_in_winbar = {
      enable = false,
    },
  })
end

return M
