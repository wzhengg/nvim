return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			parsers = {
				"javascript",
				"jsx",
				"typescript",
				"tsx",
			},
		},
	},

	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				ts_ls = {},
			},
		},
	},

	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
			},
		},
	},
}
