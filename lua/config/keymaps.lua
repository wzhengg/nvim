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
set("n", "<leader>cd", vim.diagnostic.open_float)

-- quickfix
set("n", "[q", vim.cmd.cprev)
set("n", "]q", vim.cmd.cnext)
