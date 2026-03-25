vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2
vim.opt_local.expandtab = true

vim.keymap.set("n", "<localleader>cf",
	function() vim.lsp.buf.format() end,
	{ buffer = true }
)
