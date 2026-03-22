-- line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- indent and shift
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false
vim.opt.shiftround = true
vim.opt.autoindent = true
vim.opt.smartindent = true

-- appearance
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.showmode = true
vim.opt.laststatus = 3
vim.opt.signcolumn = "yes"
vim.opt.winborder = "single"
vim.opt.pumborder = "single"

-- wrap and linebreak
vim.opt.wrap = false
vim.opt.linebreak = true

-- better search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- split direction
vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.path:append("**")

-- set leader key
vim.g.mapleader = " "

-- lsp
vim.lsp.enable({ "gopls", "lua_ls", "nixd" })

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

-- quality-of-life yank, delete, paste
vim.keymap.set({ "n", "v", "x" }, "<leader>y", '"+y')
vim.keymap.set({ "v", "x" }, "<leader>d", '"_d')
vim.keymap.set({ "v", "x" }, "<leader>p", '"_dP')
