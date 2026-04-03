-- line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- indent and shift
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.shiftround = true
vim.opt.smartindent = true

-- appearance
vim.opt.cursorline = true
vim.opt.laststatus = 3
vim.opt.signcolumn = "yes"

-- no wrap
vim.opt.wrap = false

-- better search
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.path:append("**")

-- set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.cmd.colorscheme("retrobox")

-- lsp
vim.lsp.enable({ "gopls" })

-- configure diagnostics
vim.diagnostic.config({
	jump = { on_jump = function() vim.diagnostic.open_float() end },
	severity_sort = true,
	virtual_text = true,
})

-- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function() vim.hl.on_yank() end
})
