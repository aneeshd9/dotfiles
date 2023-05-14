vim.g.vimtex_view_method = "zathura"

local wk = require("which-key")
wk.register({
	l = {
		name = "latex",
	},
}, { prefix = "<leader>" })
