vim.opt.number         = true  -- line numbers
vim.opt.relativenumber = true  -- relative line numbers
vim.opt.tabstop        = 4     -- tabs are 4 columns wide
vim.opt.shiftwidth     = 0     -- use tabstop for indent width
vim.opt.shiftround     = true  -- round indent to multiple of shiftwidth
vim.opt.smartindent    = true  -- smart auto-indent
vim.opt.laststatus     = 3     -- global statusline
vim.opt.signcolumn     = "yes" -- always draw signcolumn
vim.opt.wrap           = false -- disable line wrap
vim.opt.ignorecase     = true  -- case-insensitive search
vim.opt.smartcase      = true  -- case-sensitive search if pattern contains uppercase

-- search subdirectories with :find
vim.opt.path:append({"**"})

-- colorscheme
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
