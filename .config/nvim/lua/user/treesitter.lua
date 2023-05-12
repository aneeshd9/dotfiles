local M = {}

M.setup = function()
  local status_ok, treesitter_configs = pcall(require, "nvim-treesitter.configs")
  if not status_ok then
    return
  end

  treesitter_configs.setup({
    ensure_installed = { "bash", "c", "cpp", "html", "javascript", "lua", "python", "java", "tsx", "typescript", "vim" },
    highlight = { enable = true },
    indent = { enable = true },
    context_commentstring = { enable = true, enable_autocmd = false },
  })
end

return M
