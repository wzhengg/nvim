vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2
vim.opt_local.expandtab = true

vim.keymap.set("n", "<leader>cf", function() vim.lsp.buf.format() end)
