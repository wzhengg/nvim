return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			parsers = {
				"go",
				"gomod",
				"gosum",
				"gotmpl",
				"gowork",
			},
		},
	},

	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				gopls = {
					settings = {
						gopls = { gofumpt = true },
					},
				},
			},
		},
	},

	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				go = { "goimports", "gofumpt" },
			},
		},
	},
}
