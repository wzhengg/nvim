return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = { "BufReadPost", "BufWritePost", "BufNewFile", "VeryLazy" },
	cmd = { "TSUpdate" },
	keys = {
		{ "<c-space>" },
		{ "<bs>" },
	},
	opts = {
		highlight = { enable = true },
		indent = { enable = true },
		ensure_installed = {
			"go",
			"gomod",
			"gosum",
			"gotmpl",
			"gowork",
			"lua",
			"nix",
			"vim",
			"vimdoc",
		},
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "<c-space>",
				node_incremental = "<c-space>",
				scope_incremental = false,
				node_decremental = "<bs>",
			},
		},
	},
	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)
	end,
}
