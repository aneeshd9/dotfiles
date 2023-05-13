local M = {}

M.diagnostics_active = true

function M.show_diagnostics()
	return M.diagnostics_active
end

function M.toggle_diagnostics()
	M.diagnostics_active = not M.diagnostics_active
	if M.diagnostics_active then
		vim.diagnostic.show()
	else
		vim.diagnostic.hide()
	end
end

return M
