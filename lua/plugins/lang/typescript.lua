return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			parsers = {
				"javascript",
				"typescript",
				"tsx",
			},
		},
	},

	{
		"neovim/nvim-lspconfig",
		opts = function(_, opts)
			local lspconfig = require("lspconfig")

			opts.servers.denols = {
				root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
			}

			opts.servers.ts_ls = {
				root_dir = lspconfig.util.root_pattern("package.json"),
				single_file_support = false,
			}
		end,
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
