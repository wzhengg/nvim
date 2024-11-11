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
	cmd = "Telescope",
	opts = {
		defaults = {
			prompt_prefix = " ",
			selection_caret = " ",
		},
	},
	config = function(_, opts)
		local telescope = require("telescope")

		telescope.setup(opts)
		pcall(telescope.load_extension("fzf"))
	end,
	keys = {
		{ "<leader>ff", "<Cmd>Telescope find_files<CR>" },
		{ "<leader>fg", "<Cmd>Telescope live_grep<CR>" },
		{ "<leader>fb", "<Cmd>Telescope buffers<CR>" },
	},
}
