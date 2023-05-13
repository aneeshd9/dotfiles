local M = {}

local opts = {
	servers = {
		clangd = {},
		lua_ls = {
			settings = {
				Lua = {
					workspace = {
						checkThirdParty = false,
					},
					completion = {
						callSnippet = "Replace",
					},
				},
			},
		},
	},
	setup = {},
	config = {
		diagnostics = {
			underline = true,
			update_in_insert = false,
			virtual_text = {
				spacing = 4,
				source = "if_many",
				prefix = "●",
			},
			severity_sort = true,
			-- virtual_text = {
			-- 	severity = {
			-- 		min = vim.diagnostic.severity.WARN,
			-- 	},
			-- },
			float = {
				focusable = true,
				style = "minimal",
				border = "rounded",
				source = "always",
				header = "",
				prefix = "",
			},
		},
	},
}

function M.on_attach(on_attach)
	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(args)
			local bufnr = args.buf
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			on_attach(client, bufnr)
		end,
	})
end

function M.capabilities()
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities.textDocument.foldingRange = {
		dynamicRegistration = false,
		lineFoldingOnly = true,
	}
	return require("cmp_nvim_lsp").default_capabilities(capabilities)
end

function M.setup()
	-- local icons = require("user.icons")
	-- local signs = {
	-- 	{ name = "DiagnosticSignError", text = icons.diagnostics.Error },
	-- 	{ name = "DiagnosticSignWarn", text = icons.diagnostics.Warning },
	-- 	{ name = "DiagnosticSignHint", text = icons.diagnostics.Hint },
	-- 	{ name = "DiagnosticSignInfo", text = icons.diagnostics.Info },
	-- }
	-- for _, sign in ipairs(signs) do
	-- 	vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
	-- end

	for name, icon in pairs(require("user.icons").diagnostics) do
		name = "DiagnosticSign" .. name
		vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
	end

	if
		type(opts.config.diagnostics.virtual_text) == "table"
		and opts.config.diagnostics.virtual_text.prefix == "icons"
	then
		opts.config.diagnostics.virtual_text.prefix = vim.fn.has("nvim-0.10.0") == 0 and "●"
			or function(diagnostic)
				local icons = require("user.icons").diagnostics
				for d, icon in pairs(icons) do
					if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
						return icon
					end
				end
			end
	end

	vim.diagnostic.config(opts.config.diagnostics)

	M.on_attach(function(client, bufnr)
		-- Add on attach stuff here
		require("user.lsp.format").on_attach(client, bufnr)
		require("user.lsp.keymaps").on_attach(client, bufnr)

		if client.server_capabilities["documentSymbolProvider"] then
			require("nvim-navic").attach(client, bufnr)
		end
	end)

	local servers = opts.servers
	local capabilities = M.capabilities()

	local function setup(server)
		local server_opts = vim.tbl_deep_extend("force", {
			capabilities = capabilities,
		}, servers[server] or {})

		if opts.setup[server] then
			if opts.setup[server](server, server_opts) then
				return
			end
		elseif opts.setup["*"] then
			if opts.setup["*"](server, server_opts) then
				return
			end
		end
		require("lspconfig")[server].setup(server_opts)
	end

	local has_mason, mlsp = pcall(require, "mason-lspconfig")
	local all_mlsp_servers = {}
	if has_mason then
		all_mlsp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
	end

	local ensure_installed = {}
	for server, server_opts in pairs(servers) do
		if server_opts then
			server_opts = server_opts == true and {} or server_opts
			if server_opts.mason == false or not vim.tbl_contains(all_mlsp_servers, server) then
				setup(server)
			else
				ensure_installed[#ensure_installed + 1] = server
			end
		end
	end

	if has_mason then
		mlsp.setup({ ensure_installed = ensure_installed })
		mlsp.setup_handlers({ setup })
	end
end

return M
