vim.g.mapleader = " "
vim.g.maplocalleader = " "

local set = vim.keymap.set

-- clear search highlights
set("n", "<Esc>", "<Cmd>nohlsearch<CR>")

-- better indenting
set("v", "<", "<gv")
set("v", ">", ">gv")

-- move to window
set("n", "<C-h>", "<C-w>h")
set("n", "<C-j>", "<C-w>j")
set("n", "<C-k>", "<C-w>k")
set("n", "<C-l>", "<C-w>l")

-- split window
set("n", "<leader>-", "<C-w>s")
set("n", "<leader>|", "<C-w>v")

-- diagnostic
local function diagnostic_jump(count, severity)
	return function()
		vim.diagnostic.jump({
			count = count,
			severity = severity,
			float = true,
		})
	end
end
set("n", "<leader>cd", vim.diagnostic.open_float)
set("n", "[e", diagnostic_jump(-1, vim.diagnostic.severity.ERROR))
set("n", "]e", diagnostic_jump(1, vim.diagnostic.severity.ERROR))
set("n", "[w", diagnostic_jump(-1, vim.diagnostic.severity.WARN))
set("n", "]w", diagnostic_jump(1, vim.diagnostic.severity.WARN))

-- quickfix
set("n", "[q", "<Cmd>cprev<CR>zz")
set("n", "]q", "<Cmd>cnext<CR>zz")

-- quality-of-life yank & paste
set("v", "<leader>p", '"_dP')
set("v", "<leader>y", '"+y')
set("n", "<leader>y", '"+y')
