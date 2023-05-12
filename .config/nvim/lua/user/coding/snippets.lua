local M = {}

local function keymaps()
  vim.keymap.set(
    "i",
    "<TAB>",
    function()
      return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<TAB>"
    end,
    { expr = true, silent = true }
  )

  vim.keymap.set(
    "s", "<TAB>", function() require("luasnip").jump(1) end
  )

  vim.keymap.set(
    { "s", "i" }, "<S-TAB>", function() require("luasnip").jump(-1) end
  )
end

M.setup = function()
  local status_ok, luasnip = pcall(require, "luasnip")
  if not status_ok then
    return
  end

  require("luasnip.loaders.from_vscode").lazy_load()

  luasnip.setup({
    history = true,
    delete_check_events = "TextChanged",
  })

  keymaps()
end

return M
