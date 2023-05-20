local M = {}

function M.setup()
	local lspconfig = require("lspconfig")
	local capabilites = require("user.lsp.servers").capabilities()
	lspconfig.sourcekit.setup({
		cmd = { "sourcekit-lsp" },
		root_dir = require("lspconfig.util").root_pattern("Package.swift"),
		filetypes = { "swift" },
		capabilites = capabilites,
		on_attach = function(client, bufnr)
			require("user.lsp.format").on_attach(client, bufnr)
			require("user.lsp.keymaps").on_attach(client, bufnr)
			if client.server_capabilities["documentSymbolProvider"] then
				require("nvim-navic").attach(client, bufnr)
			end
		end,
	})
end

return M
