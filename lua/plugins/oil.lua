return {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	lazy = false,
	opts = {
		default_file_browser = true,
		delete_to_trash = true,
		skip_confirm_for_simple_edits = true,
		keymaps = {
			["<C-h>"] = false,
			["<C-l>"] = false,
		},
	},
	keys = {
		{ "-", "<CMD>Oil<CR>" },
	},
}
