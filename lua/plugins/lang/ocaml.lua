return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			ensure_installed = {
				"ocaml",
			},
		},
	},

	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				ocamllsp = {},
			},
		},
	},

	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				ocaml = { "ocamlformat" },
			},
		},
	},
}
