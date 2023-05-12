local M = {}

M.setup = function()
  local status_ok, gitsigns = pcall(require, "gitsigns")
  if not status_ok then
    return
  end

  gitsigns.setup({
    signs = {
      add = { text = "▎" },
      change = { text = "▎" },
      delete = { text = "" },
      topdelete = { text = "" },
      changedelete = { text = "▎" },
      untracked = { text = "▎" },
    },
    on_attach = function(buffer)
      local gs = package.loaded.gitsigns
      local wk = require("which-key")

      wk.register({
        ["]h"] = { gs.next_hunk, "Next hunk" },
        ["[h"] = { gs.prev_hunk, "Previous hunk" },
      })

      wk.register({
        g = {
          g = {
            name = "gitsigns",
            h = {
              name = "hunk",
              s = { "<cmd>Gitsigns stage_hunk<CR>", "Stage hunk" },
              r = { "<cmd>Gitsigns reset_hunk<CR>", "Reset hunk" },
              u = { gs.undo_stage_hunk, "Undo stage hunk" },
              p = { gs.preview_hunk, "Preview hunk" },
              b = { function() gs.blame_line({ full = true }) end, "Blame line" },
            },
            b = {
              name = "buffer",
              s = { gs.stage_buffer, "Stage buffer" },
              r = { gs.reset_buffer, "Reset buffer" },
            },
            d = {
              name = "diff",
              d = { gs.diffthis, "Diff this" },
              D = { function() gs.diffthis("~") end, "Diff this ~" },
            },
          },
        },
      }, { mode = "n", prefix = "<leader>" })

      wk.register({
        g = {
          g = {
            name = "gitsigns",
            h = {
              name = "hunk",
              s = { "<cmd>Gitsigns stage_hunk<CR>", "Stage hunk" },
              r = { "<cmd>Gitsigns reset_hunk<CR>", "Reset hunk" },
            },
          },
        },
      }, { mode = "v", prefix = "<leader>" })
    end,
  })
end

return M
