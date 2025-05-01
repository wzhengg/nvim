return {
	"ibhagwan/fzf-lua",
	dependencies = { "echasnovski/mini.icons" },
	opts = {
		"hide",
		winopts = {
			fullscreen = true,
			border = "solid",
			preview = {
				default = "builtin",
				scrollbar = false,
			},
		},
		keymap = {
			builtin = {
				false,
				["<C-c>"] = "hide",
				["<F1>"] = "toggle-help",
			},
			fzf = {
				false,
				["ctrl-y"] = "accept",
				["ctrl-u"] = "unix-line-discard",
				["ctrl-a"] = "beginning-of-line",
				["ctrl-e"] = "end-of-line",
				["alt-a"] = "toggle-all",
				["alt-g"] = "first",
				["alt-G"] = "last",
			},
		},
		fzf_opts = {
			["--cycle"] = true,
		},
	},
	config = function(_, opts)
		local fzf = require("fzf-lua")

		fzf.setup(opts)

		vim.keymap.set("n", "<leader>ff", fzf.files)
		vim.keymap.set("n", "<leader>fg", fzf.live_grep_native)
		vim.keymap.set("n", "<leader>fb", fzf.buffers)
		vim.keymap.set("n", "<leader>fh", fzf.helptags)
		vim.keymap.set("n", "<leader>fr", fzf.resume)
	end,
}
