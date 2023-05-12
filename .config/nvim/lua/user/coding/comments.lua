local M = {}

M.setup = function()
  local status_ok, minicomment = pcall(require, "mini.comment")
  if not status_ok then
    return
  end

  minicomment.setup({
    hooks = {
      pre = function()
        require("ts_context_commentstring.internal").update_commentstring({})
      end,
    },
  })
end

return M
