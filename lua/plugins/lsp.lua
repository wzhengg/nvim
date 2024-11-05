return {
	"neovim/nvim-lspconfig",
	dependencies = { "saghen/blink.cmp" },
	event = { "BufReadPost", "BufWritePost", "BufNewFile" },

	opts = {
		servers = {
			gopls = {},

			lua_ls = {
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			},

			nixd = {},

			ts_ls = {},
		},
	},

	config = function(_, opts)
		local lspconfig = require("lspconfig")

		for server, config in pairs(opts.servers) do
			config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
			lspconfig[server].setup(config)
		end

		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(args)
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = args.buf })
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = args.buf })
				vim.keymap.set("n", "gI", vim.lsp.buf.implementation, { buffer = args.buf })
				vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = args.buf })
				vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = args.buf })
				vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { buffer = args.buf })
				vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = args.buf })
			end,
		})
	end,
}
