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

-- wrap and linebreak
vim.opt.wrap = false
vim.opt.linebreak = true

-- scrolloff
vim.opt.sidescrolloff = 8

-- better search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- split direction
vim.opt.splitbelow = true
vim.opt.splitright = true

-- disable swapfile
vim.opt.swapfile = false

-- set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.pack.add({
	{ src = "https://github.com/catppuccin/nvim" },
	{ src = "https://github.com/ibhagwan/fzf-lua" },
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/nvim-mini/mini.icons",                        version = "main", },
	{ src = "https://github.com/nvim-mini/mini.statusline",                   version = "main", },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter",             version = "main", },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects", version = "main", },
	{ src = "https://github.com/stevearc/oil.nvim" },
})

-- colorscheme

vim.cmd.colorscheme("catppuccin")

-- lsp

vim.lsp.enable({ "gopls", "lua_ls", "nixd", "ts_ls" })
vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format)

-- fzf

require("fzf-lua").setup({
	"hide",
	winopts = {
		fullscreen = true,
		border = "solid",
		preview = {
			default = "builtin",
			scrollbar = false,
		},
	},
	keymap = {
		builtin = {
			false,
			["<C-c>"] = "hide",
			["<F1>"] = "toggle-help",
		},
		fzf = {
			false,
			["ctrl-y"] = "accept",
			["ctrl-u"] = "unix-line-discard",
			["ctrl-a"] = "beginning-of-line",
			["ctrl-e"] = "end-of-line",
			["alt-a"] = "toggle-all",
			["alt-g"] = "first",
			["alt-G"] = "last",
		},
	},
	fzf_opts = {
		["--cycle"] = true,
	},
})

vim.keymap.set("n", "<leader>ff", require("fzf-lua").files)
vim.keymap.set("n", "<leader>fg", require("fzf-lua").live_grep_native)
vim.keymap.set("n", "<leader>fb", require("fzf-lua").buffers)
vim.keymap.set("n", "<leader>fh", require("fzf-lua").helptags)
vim.keymap.set("n", "<leader>fr", require("fzf-lua").resume)

-- gitsigns

require("gitsigns").setup({
	signs = {
		add = { text = "+" },
		change = { text = "~" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
		untracked = { text = "┆" },
	},
	signs_staged = {
		add = { text = "+" },
		change = { text = "~" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
		untracked = { text = "┆" },
	},
	on_attach = function(bufnr)
		local gs = package.loaded.gitsigns

		local function map(mode, l, r, opts)
			opts = opts or {}
			opts.buffer = bufnr
			vim.keymap.set(mode, l, r, opts)
		end

		map("n", "]c", function()
			if vim.wo.diff then
				vim.cmd.normal({ "]c", bang = true })
			else
				gs.nav_hunk("next")
			end
		end)
		map("n", "[c", function()
			if vim.wo.diff then
				vim.cmd.normal({ "[c", bang = true })
			else
				gs.nav_hunk("prev")
			end
		end)

		map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>")
		map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>")
		map("n", "<leader>hS", gs.stage_buffer)
		map("n", "<leader>hR", gs.reset_buffer)
		map("n", "<leader>hu", gs.undo_stage_hunk)

		map("n", "<leader>hp", gs.preview_hunk_inline)
		map("n", "<leader>hb", function() gs.blame_line() end)
		map("n", "<leader>hB", function() gs.blame() end)
		map("n", "<leader>tb", gs.toggle_current_line_blame)

		map("n", "<leader>hd", gs.diffthis)
		map("n", "<leader>hD", function() gs.diffthis("~") end)

		map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
	end,
})

-- icons

require("mini.icons").setup()

-- statusline

require("mini.statusline").setup()

-- treesitter

require("nvim-treesitter").install({
	"c",
	"html", "json",
	"javascript", "typescript", "jsx", "tsx",
	"go", "gomod", "gosum",
	"lua",
	"markdown",
	"nix",
	"sql",
	"vim", "vimdoc",
})

vim.api.nvim_create_autocmd("FileType", {
	callback = function(ev)
		local max_filesize = 100 * 1024 -- 100 KB

		local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(ev.buf))
		if not ok or not stats or stats.size > max_filesize then return end

		if not pcall(vim.treesitter.start, ev.buf) then return end
		vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
		vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end
})

-- treesitter-textobjects

require("nvim-treesitter-textobjects").setup({
	select = {
		lookahead = true,
		selection_modes = {
			["@assignment.lhs"] = "v",
			["@assignment.rhs"] = "v",
			["@assignment.outer"] = "v",
			["@call.inner"] = "v",
			["@call.outer"] = "v",
			["@class.inner"] = "v",
			["@class.outer"] = "v",
			["@conditional.inner"] = "v",
			["@conditional.outer"] = "v",
			["@function.inner"] = "v",
			["@function.outer"] = "v",
			["@loop.inner"] = "v",
			["@loop.outer"] = "v",
			["@parameter.inner"] = "v",
			["@parameter.outer"] = "v",
			["@statement.outer"] = "v",
		},
		include_surrounding_whitespace = false,
	},
	move = {
		set_jumps = true,
	},
})

local ts_select_mappings = {
	{ mode = { "x", "o" }, lhs = "a=", query_string = "@assignment.lhs" },
	{ mode = { "x", "o" }, lhs = "i=", query_string = "@assignment.rhs" },
	{ mode = { "x", "o" }, lhs = "a:", query_string = "@assignment.outer" },
	{ mode = { "x", "o" }, lhs = "im", query_string = "@call.inner" },
	{ mode = { "x", "o" }, lhs = "am", query_string = "@call.outer" },
	{ mode = { "x", "o" }, lhs = "ic", query_string = "@class.inner" },
	{ mode = { "x", "o" }, lhs = "ac", query_string = "@class.outer" },
	{ mode = { "x", "o" }, lhs = "ii", query_string = "@conditional.inner" },
	{ mode = { "x", "o" }, lhs = "ai", query_string = "@conditional.outer" },
	{ mode = { "x", "o" }, lhs = "if", query_string = "@function.inner" },
	{ mode = { "x", "o" }, lhs = "af", query_string = "@function.outer" },
	{ mode = { "x", "o" }, lhs = "il", query_string = "@loop.inner" },
	{ mode = { "x", "o" }, lhs = "al", query_string = "@loop.outer" },
	{ mode = { "x", "o" }, lhs = "ia", query_string = "@parameter.inner" },
	{ mode = { "x", "o" }, lhs = "aa", query_string = "@parameter.outer" },
	{ mode = { "x", "o" }, lhs = "a;", query_string = "@statement.outer" },
}

for _, mapping in ipairs(ts_select_mappings) do
	vim.keymap.set(mapping.mode, mapping.lhs, function()
		require("nvim-treesitter-textobjects.select").select_textobject(mapping.query_string, "textobjects")
	end)
end

local ts_swap_mappings = {
	{ mode = { "n" }, lhs = "<leader>a", swap_fn = require("nvim-treesitter-textobjects.swap").swap_next,     query_string = "@parameter.inner" },
	{ mode = { "n" }, lhs = "<leader>A", swap_fn = require("nvim-treesitter-textobjects.swap").swap_previous, query_string = "@parameter.inner" },
	{ mode = { "n" }, lhs = "<leader>}", swap_fn = require("nvim-treesitter-textobjects.swap").swap_next,     query_string = "@function.outer" },
	{ mode = { "n" }, lhs = "<leader>{", swap_fn = require("nvim-treesitter-textobjects.swap").swap_previous, query_string = "@function.outer" },
}

for _, mapping in ipairs(ts_swap_mappings) do
	vim.keymap.set(mapping.mode, mapping.lhs, function()
		mapping.swap_fn(mapping.query_string)
	end)
end

local ts_move_mappings = {
	{ mode = { "n", "x", "o" }, lhs = "]f", goto_fn = require("nvim-treesitter-textobjects.move").goto_next_start,     query_string = "@function.outer" },
	{ mode = { "n", "x", "o" }, lhs = "[f", goto_fn = require("nvim-treesitter-textobjects.move").goto_previous_start, query_string = "@function.outer" },
	{ mode = { "n", "x", "o" }, lhs = "]c", goto_fn = require("nvim-treesitter-textobjects.move").goto_next_start,     query_string = "@class.outer" },
	{ mode = { "n", "x", "o" }, lhs = "[c", goto_fn = require("nvim-treesitter-textobjects.move").goto_previous_start, query_string = "@class.outer" },
	{ mode = { "n", "x", "o" }, lhs = "]a", goto_fn = require("nvim-treesitter-textobjects.move").goto_next_start,     query_string = "@parameter.inner" },
	{ mode = { "n", "x", "o" }, lhs = "[a", goto_fn = require("nvim-treesitter-textobjects.move").goto_previous_start, query_string = "@parameter.inner" },
	{ mode = { "n", "x", "o" }, lhs = "]F", goto_fn = require("nvim-treesitter-textobjects.move").goto_next_end,       query_string = "@function.outer" },
	{ mode = { "n", "x", "o" }, lhs = "[F", goto_fn = require("nvim-treesitter-textobjects.move").goto_previous_end,   query_string = "@function.outer" },
	{ mode = { "n", "x", "o" }, lhs = "]C", goto_fn = require("nvim-treesitter-textobjects.move").goto_next_end,       query_string = "@class.outer" },
	{ mode = { "n", "x", "o" }, lhs = "[C", goto_fn = require("nvim-treesitter-textobjects.move").goto_previous_end,   query_string = "@class.outer" },
	{ mode = { "n", "x", "o" }, lhs = "]A", goto_fn = require("nvim-treesitter-textobjects.move").goto_next_end,       query_string = "@parameter.inner" },
	{ mode = { "n", "x", "o" }, lhs = "[A", goto_fn = require("nvim-treesitter-textobjects.move").goto_previous_end,   query_string = "@parameter.inner" },
}

for _, mapping in ipairs(ts_move_mappings) do
	vim.keymap.set(mapping.mode, mapping.lhs, function()
		mapping.goto_fn(mapping.query_string, "textobjects")
	end)
end

-- oil

require("oil").setup({
	default_file_explorer = true,
	delete_to_trash = true,
	skip_confirm_for_simple_edits = true,
})

vim.keymap.set("n", "-", ":Oil<CR>")

-- configure diagnostics
vim.diagnostic.config({
	jump = { float = true },
	severity_sort = true,
	virtual_text = true,
})

-- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	pattern = "*",
	callback = function() vim.highlight.on_yank() end
})

-- clear search highlights
vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>")

-- keep selection on indent
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- jump to diagnostics
local function diagnostic_jump(count, severity)
	return function()
		vim.diagnostic.jump({ count = count, severity = severity })
	end
end
vim.keymap.set("n", "[e", diagnostic_jump(-1, vim.diagnostic.severity.ERROR))
vim.keymap.set("n", "]e", diagnostic_jump(1, vim.diagnostic.severity.ERROR))
vim.keymap.set("n", "[w", diagnostic_jump(-1, vim.diagnostic.severity.WARN))
vim.keymap.set("n", "]w", diagnostic_jump(1, vim.diagnostic.severity.WARN))
vim.keymap.set("n", "[i", diagnostic_jump(-1, vim.diagnostic.severity.INFO))
vim.keymap.set("n", "]i", diagnostic_jump(1, vim.diagnostic.severity.INFO))
vim.keymap.set("n", "[h", diagnostic_jump(-1, vim.diagnostic.severity.HINT))
vim.keymap.set("n", "]h", diagnostic_jump(1, vim.diagnostic.severity.HINT))

-- navigate quickfix
vim.keymap.set("n", "[q", ":cprev<CR>zz")
vim.keymap.set("n", "]q", ":cnext<CR>zz")

-- quality-of-life yank, delete, paste
vim.keymap.set({ "n", "v", "x" }, "<leader>y", '"+y')
vim.keymap.set({ "v", "x" }, "<leader>d", '"_d')
vim.keymap.set({ "v", "x" }, "<leader>p", '"_dP')
