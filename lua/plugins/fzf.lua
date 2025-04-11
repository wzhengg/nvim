return {
	"ibhagwan/fzf-lua",
	dependencies = { "echasnovski/mini.icons" },
	opts = function(_, opts)
		local fzf = require("fzf-lua")

		vim.keymap.set("n", "<leader>ff", fzf.files)
		vim.keymap.set("n", "<leader>fg", fzf.grep)
		vim.keymap.set("n", "<leader>fb", fzf.buffers)
		vim.keymap.set("n", "<leader>fh", fzf.helptags)
		vim.keymap.set("n", "<leader>fr", fzf.resume)
	end,
}
