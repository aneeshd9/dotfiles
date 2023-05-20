local M = {}

local function keymaps()
	local wk = require("which-key")
	wk.register({
		b = {
			d = {
				function()
					require("mini.bufremove").delete(0, false)
				end,
				"Delete buffer",
			},
			D = {
				function()
					require("mini.bufremove").delete(0, true)
				end,
				"Delete buffer (force)",
			},
		},
	}, { prefix = "<leader>" })
end

function M.setup()
	local status_ok, bufrm = pcall(require, "mini.bufremove")
	if not status_ok then
		return
	end

	bufrm.setup()

	keymaps()
end

return M
