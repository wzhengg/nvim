return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPost", "BufWritePost", "BufNewFile" },
	config = function()
		local lspconfig = require("lspconfig")

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

		lspconfig.gopls.setup({})

		lspconfig.lua_ls.setup({
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
				},
			},
		})
	end,
}
