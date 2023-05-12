local M = {}

local function globalkeys(wk)
  local normal_maps = {
    b = {
      name = "buffers",
      d = { "<cmd>bdelete<CR>", "Delete buffer" },
      ["<TAB>"] = { "<cmd>bnext<CR>", "Next tab" },
      ["<S-TAB>"]  = { "<cmd>bprevious<CR>", "Previous tab" },
    },
    g = {
      name = "git",
    },
    f = {
      name = "find",
    },
  }

  local normal_opts = { mode = "n", prefix = "<leader>" }

  wk.register(normal_maps, normal_opts)
end

M.setup = function()
  local status_ok, wk = pcall(require, "which-key")
  if not status_ok then
    return
  end

  wk.setup()

  globalkeys(wk)
end

return M
