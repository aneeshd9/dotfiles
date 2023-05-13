local M = {}

function M.setup()
	local status_ok, barbecue = pcall(require, "barbecue")
	if not status_ok then
		return
	end

	barbecue.setup({
		attach_navic = false,
		create_autocmd = false,
	})

	vim.api.nvim_create_autocmd({
		"WinScrolled",
		"BufWinEnter",
		"CursorHold",
		"InsertLeave",
		"BufModifiedSet",
		"LspAttach",
	}, {
		group = vim.api.nvim_create_augroup("barbecue.updater", {}),
		callback = function()
			require("barbecue.ui").update()
		end,
	})
end

return M
