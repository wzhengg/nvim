return {
	"neovim/nvim-lspconfig",
	dependencies = { "saghen/blink.cmp" },
	event = { "BufReadPost", "BufWritePost", "BufNewFile" },

	opts = {
		servers = {
			dockerls = {},

			nixd = {},

			tailwindcss = {},
		},
	},

	config = function(_, opts)
		for server, config in pairs(opts.servers) do
			vim.lsp.enable(server)
			vim.lsp.config(server, config)
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
