return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
		{ "echasnovski/mini.icons" },
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local builtin = require("telescope.builtin")

		telescope.setup({
			defaults = {
				prompt_prefix = " ",
				selection_caret = " ",
				mappings = {
					i = {
						["<C-y>"] = actions.select_default,
					},
				},
			},
			pickers = {
				buffers = {
					theme = "ivy",
					mappings = {
						i = {
							["<C-d>"] = actions.delete_buffer + actions.move_to_top,
						},
					},
				},
			},
			extensions = {
				fzf = {},
			},
		})

		pcall(telescope.load_extension, "fzf")

		vim.keymap.set("n", "<leader>ff", builtin.find_files)
		vim.keymap.set("n", "<leader>fg", builtin.live_grep)
		vim.keymap.set("n", "<leader>fb", builtin.buffers)
		vim.keymap.set("n", "<leader>fh", builtin.help_tags)
	end,
}
