return {
	"neovim/nvim-lspconfig",
	dependencies = { "saghen/blink.cmp" },
	event = { "BufReadPost", "BufWritePost", "BufNewFile" },

	opts = {
		servers = {
			dockerls = {},

			gopls = {
				settings = {
					gopls = { gofumpt = true },
				},
			},

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

			tailwindcss = {},
		},
	},

	config = function(_, opts)
		local lspconfig = require("lspconfig")

		for server, config in pairs(opts.servers) do
			config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
			lspconfig[server].setup(config)
		end

		vim.diagnostic.config({
			jump = {
				float = true,
			},
			severity_sort = true,
			virtual_text = {
				prefix = "",
			},
		})

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),

			callback = function(event)
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = event.buf })
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = event.buf })
				vim.keymap.set("n", "gI", vim.lsp.buf.implementation, { buffer = event.buf })
				vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = event.buf })
				vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = event.buf })
				vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { buffer = event.buf })
				vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = event.buf })
			end,
		})
	end,
}
