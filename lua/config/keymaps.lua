vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local set = vim.keymap.set

-- clear search
set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>")

-- better indenting
set("v", "<", "<gv")
set("v", ">", ">gv")

-- move to window
set("n", "<c-h>", "<c-w>h")
set("n", "<c-j>", "<c-w>j")
set("n", "<c-k>", "<c-w>k")
set("n", "<c-l>", "<c-w>l")

-- split window
set("n", "<leader>-", "<c-w>s")
set("n", "<leader>|", "<c-w>v")

-- diagnostic
set("n", "<leader>cd", vim.diagnostic.open_float)
