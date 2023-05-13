local M = {}

function M.setup()
  local status_ok, nls = pcall(require, "null-ls")
  if not status_ok then
    return
  end

  nls.setup({
    root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
    sources = {
      nls.builtins.formatting.shfmt,
      nls.builtins.formatting.stylua,
    },
  })
end

return M
