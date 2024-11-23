local opt = vim.opt

-- line numbers
opt.number = true
opt.relativenumber = true

-- indent & shift
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = false
opt.shiftround = true
opt.autoindent = true
opt.smartindent = true

-- scrolloff
opt.scrolloff = 4
opt.sidescrolloff = 8

-- appearance
opt.termguicolors = true
opt.cursorline = true
opt.showmode = false
opt.laststatus = 3
opt.signcolumn = "yes"

-- wrap & linebreak
opt.linebreak = true
opt.wrap = false

-- better search
opt.ignorecase = true
opt.smartcase = true

-- split direction
opt.splitbelow = true
opt.splitright = true

-- confirm
opt.confirm = true

-- don't have 'o' add a comment
opt.formatoptions:remove("o")
