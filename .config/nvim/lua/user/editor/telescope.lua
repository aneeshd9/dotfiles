local M = {}

local function keymaps()
  local wk = require("which-key")
  local utils = require("user.utils")

  wk.register({
    [","] = { "<cmd>Telescope buffers show_all_buffers=true<CR>", "Switch buffer" },
    ["/"] = { utils.telescope("live_grep"), "Grep (root dir)" },
    [":"] = { "<cmd>Telescope command_history<CR>", "Command history" },
    ["<SPACE>"] = { utils.telescope("files"), "Find files (root dir)" },

    f = {
      b = { "<cmd>Telescope buffers<CR>", "Buffers" },
      f = { utils.telescope("files"), "Find files (root dir)" },
      F = { utils.telescope("files", { cwd = false }), "Find files (cwd)" },
      r = { "<cmd>Telescope oldfiles<CR>", "Recent" },
      R = { utils.telescope("oldfiles", { cwd = vim.loop.cwd() }), "Recent (cwd)" },
    },

    g = {
      c = { "<cmd>Telescope git_commits<CR>", "Commits" },
      s = { "<cmd>Telescope git_status<CR>", "Status" },
    },


    C = { utils.telescope("colorscheme", { enable_preview = true }), "Colorscheme" },

    s = {
      a = { "<cmd>Telescope autocommands<CR>", "Auto commands" },
      b = { "<cmd>Telescope current_buffer_fuzzy_find<CR>", "Buffer" },
      c = { "<cmd>Telescope command_history<CR>", "Command history" },
      C = { "<cmd>Telescope commands<CR>", "Commands" },
      d = { "<cmd>Telescope diagnostics bufnr=0<CR>", "Document diagnostics" },
      D = { "<cmd>Telescope diagnostics<CR>", "Workspace diagnostics" },
      g = { utils.telescope("live_grep"), "Grep (root dir)" },
      G = { utils.telescope("live_grep", { cwd = false }), "Grep (cwd)" },
      h = { "<cmd>Telescope help_tags<CR>", "Help pages" },
      H = { "<cmd>Telescope highlights<CR>", "Search highlight groups" },
      k = { "<cmd>Telescope keymaps<CR>", "Keymaps" },
      M = { "<cmd>Telescope man_pages<CR>", "Man pages" },
      m = { "<cmd>Telescope marks<CR>", "Jump to mark" },
      o = { "<cmd>Telescope vim_options<CR>", "Vim options" },
      R = { "<cmd>Telescope resume<CR>", "Resume" },
      w = { utils.telescope("grep_string"), "Word (root dir)" },
      W = { utils.telescope("grep_string", { cwd = false }), "Word (cwd)" },
      s = {
        utils.telescope("lsp_document_symbols", {
          symbols = {
            "Class",
            "Function",
            "Method",
            "Constructor",
            "Interface",
            "Module",
            "Struct",
            "Trait",
            "Field",
            "Property",
          },
        }),
        "Goto symbol",
      },
      S = {
        utils.telescope("lsp_dynamic_workspace_symbols", {
          symbols = {
            "Class",
            "Function",
            "Method",
            "Constructor",
            "Interface",
            "Module",
            "Struct",
            "Trait",
            "Field",
            "Property",
          },
        }),
        "Goto symbol (workspace)",
      },
    },
  }, { prefix = "<leader>" })
end

M.setup = function()
  local status_ok, telescope = pcall(require, "telescope")
  if not status_ok then
    return
  end

  telescope.setup({
    defaults = {
      prompt_prefix = " ",
      selection_caret = " ",
      mappings = {
        i = {
          ["<c-t>"] = function(...)
            return require("trouble.providers.telescope").open_with_trouble(...)
          end,
          ["<a-t>"] = function(...)
            return require("trouble.providers.telescope").open_selected_with_trouble(...)
          end,
          ["<a-i>"] = function()
            Util.telescope("find_files", { no_ignore = true })()
          end,
          ["<a-h>"] = function()
            Util.telescope("find_files", { hidden = true })()
          end,
          ["<C-Down>"] = function(...)
            return require("telescope.actions").cycle_history_next(...)
          end,
          ["<C-Up>"] = function(...)
            return require("telescope.actions").cycle_history_prev(...)
          end,
          ["<C-f>"] = function(...)
            return require("telescope.actions").preview_scrolling_down(...)
          end,
          ["<C-b>"] = function(...)
            return require("telescope.actions").preview_scrolling_up(...)
          end,
        },
        n = {
          ["q"] = function(...)
            return require("telescope.actions").close(...)
          end,
        },
      },
    },
  })

  keymaps()
end

return M
