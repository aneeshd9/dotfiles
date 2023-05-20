local M = {}

M.setup = function()
	local status_ok, mason = pcall(require, "mason-nvim-dap")
	if not status_ok then
		return
	end

	mason.setup({
		automatic_setup = true,
		handler = {},
		ensure_installed = {
			"python",
			"node2",
			"firefox",
			"js",
			"codelldb",
			"javadbg",
			"javatest",
		},
	})
end

return M
