local api = vim.api

-- Packer sync on saving plugins.lua
local packer_grp = api.nvim_create_augroup("packer_user_config", { clear = true })
api.nvim_create_autocmd("BufWritePost", {
  pattern = { "plugins.lua" },
  command = "source <afile> | PackerSync",
  group = packer_grp,
})
