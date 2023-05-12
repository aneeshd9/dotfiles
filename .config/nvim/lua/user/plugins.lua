-- Bootstrap packer
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data").."/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

local packer = require("packer")

-- Configure packer
packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "single" })
    end
  },
  profile = {
    enable = true,
    threshold = 0,
  },
})

-- Install all the plugins
return packer.startup(function(use)
  -- package manager
  use "wbthomason/packer.nvim"

  -- common dependencies
  use "nvim-lua/plenary.nvim"

  -- colors
  use "folke/tokyonight.nvim"
  use "sainnhe/gruvbox-material"

  -- treesitter
  use "nvim-treesitter/nvim-treesitter"
  use "JoosepAlviste/nvim-ts-context-commentstring"

  -- ui
  use "folke/which-key.nvim"
  use "folke/noice.nvim"
  use "MunifTanjim/nui.nvim"
  use "nvim-tree/nvim-web-devicons"
  use "goolord/alpha-nvim"
  use "lukas-reineke/indent-blankline.nvim"
  use "nvim-lualine/lualine.nvim"
  use "akinsho/bufferline.nvim"
  use "stevearc/dressing.nvim"
  use "rcarriga/nvim-notify"

  -- session management
  use "folke/persistence.nvim"

  -- editor
  use "folke/trouble.nvim"
  use "folke/todo-comments.nvim"
  use "RRethy/vim-illuminate"
  use "lewis6991/gitsigns.nvim"
  use "nvim-telescope/telescope.nvim"
  use "nvim-pack/nvim-spectre"
  use "nvim-neo-tree/neo-tree.nvim"

  -- coding
  use "L3MON4D3/LuaSnip"
  use "rafamadriz/friendly-snippets"
  use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-path"
  use "saadparwaiz1/cmp_luasnip"
  use "echasnovski/mini.pairs"
  use "echasnovski/mini.comment"

  -- lsp
  use "neovim/nvim-lspconfig"
  use "williamboman/mason.nvim"
  use "williamboman/mason-lspconfig.nvim"
  use "jose-elias-alvarez/null-ls.nvim"

  -- dap
  use "mfussenegger/nvim-dap"
  use "rcarriga/nvim-dap-ui"
  use "theHamsta/nvim-dap-virtual-text"
  use "jay-babu/mason-nvim-dap.nvim"
  use "jbyuki/one-small-step-for-vimkind"

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    packer.sync()
  end
end)
