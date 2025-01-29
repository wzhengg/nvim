return {
	"stevearc/conform.nvim",
	event = "BufWritePre",
	cmd = "ConformInfo",
	opts = {
		formatters_by_ft = {
			go = { "goimports", "gofumpt" },
			json = { "prettier" },
			lua = { "stylua" },
			nix = { "nixfmt" },
			sh = { "shfmt" },
		},
		formatters = {
			injected = { options = { ignore_errors = true } },
		},
		format_on_save = function()
			if vim.g.disable_autoformat then
				return
			end
			return {
				timeout_ms = 500,
				lsp_format = "fallback",
			}
		end,
	},
	keys = {
		{
			"<leader>cf",
			function()
				require("conform").format({ async = true, lsp_format = "fallback" })
			end,
			mode = { "n", "v" },
		},
		{
			"<leader>cF",
			function()
				require("conform").format({ async = true, formatters = { "injected" } })
			end,
			mode = { "n", "v" },
		},
		{
			"<leader>uF",
			function()
				if vim.g.disable_autoformat then
					vim.g.disable_autoformat = false
					print("Disabled format-on-save (global)")
				else
					vim.g.disable_autoformat = true
					print("Enabled format-on-save (global)")
				end
			end,
		},
	},
}
