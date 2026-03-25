vim.keymap.set("n", "<localleader>cf",
	function() vim.lsp.buf.format() end,
	{ buffer = true }
)
