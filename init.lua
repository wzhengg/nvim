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

-- set leader key
vim.g.mapleader = " "

vim.pack.add({
	{ src = "https://github.com/ibhagwan/fzf-lua" },
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/nvim-mini/mini.icons",            version = "main", },
	{ src = "https://github.com/nvim-mini/mini.statusline",       version = "main", },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main", },
	{ src = "https://github.com/rebelot/kanagawa.nvim" },
	{ src = "https://github.com/stevearc/conform.nvim" },
	{ src = "https://github.com/stevearc/oil.nvim" },
})

-- colorscheme

require("kanagawa").setup({
	undercurl = false,
	colors = { theme = { all = { ui = { bg_gutter = "none" } } } },
	overrides = function(colors)
		local theme = colors.theme
		return {
			-- transparent floating windows
			NormalFloat = { bg = "none" },
			FloatBorder = { bg = "none" },
			FloatTitle = { bg = "none" },

			-- dark popup menus
			Pmenu = { fg = theme.ui.shade0, bg = "none" },
			PmenuSel = { fg = "none", bg = theme.ui.bg_p2 },
			PmenuSbar = { bg = theme.ui.bg_m1 },
			PmenuThumb = { bg = theme.ui.bg_p2 },
		}
	end,
})

vim.cmd.colorscheme("kanagawa")

-- lsp

vim.lsp.enable({ "gopls", "lua_ls", "nixd", "ts_ls" })

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
		local gitsigns = require("gitsigns")

		local function map(mode, l, r, opts)
			opts = opts or {}
			opts.buffer = bufnr
			vim.keymap.set(mode, l, r, opts)
		end

		map("n", "]c", function()
			if vim.wo.diff then
				vim.cmd.normal({ "]c", bang = true })
			else
				gitsigns.nav_hunk("next")
			end
		end)
		map("n", "[c", function()
			if vim.wo.diff then
				vim.cmd.normal({ "[c", bang = true })
			else
				gitsigns.nav_hunk("prev")
			end
		end)

		map("n", "<leader>hs", gitsigns.stage_hunk)
		map("n", "<leader>hr", gitsigns.reset_hunk)

		map("v", "<leader>hs", function() gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end)
		map("v", "<leader>hr", function() gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end)

		map("n", "<leader>hS", gitsigns.stage_buffer)
		map("n", "<leader>hR", gitsigns.reset_buffer)

		map("n", "<leader>hu", gitsigns.undo_stage_hunk)

		map("n", "<leader>hp", gitsigns.preview_hunk_inline)
		map("n", "<leader>hb", gitsigns.blame_line)
		map("n", "<leader>hB", gitsigns.blame)
		map("n", "<leader>tb", gitsigns.toggle_current_line_blame)

		map("n", "<leader>hd", gitsigns.diffthis)
		map("n", "<leader>hD", function() gitsigns.diffthis("~") end)

		map({ "o", "x" }, "ih", gitsigns.select_hunk)
	end,
})

-- icons

require("mini.icons").setup()

-- statusline

require("mini.statusline").setup()

-- treesitter

require("nvim-treesitter").install({
	"c", "cpp",
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
	end,
})

-- oil

require("oil").setup({
	default_file_explorer = true,
	skip_confirm_for_simple_edits = true,
})

vim.keymap.set("n", "-", "<Cmd>Oil<CR>")

-- conform

require("conform").setup({
	formatters_by_ft = {
		go = { "goimports", "gofmt" },
		nix = { "nixfmt" },
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
	},
	default_format_opts = {
		lsp_format = "fallback",
	},
})

vim.keymap.set({ "n", "v" }, "<leader>cf", require("conform").format)

-- configure diagnostics
vim.diagnostic.config({
	jump = { float = true },
	severity_sort = true,
	virtual_text = true,
})

-- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function() vim.highlight.on_yank() end
})

-- clear search highlights
vim.keymap.set("n", "<Esc>", "<Cmd>nohlsearch<CR>")

-- quality-of-life yank, delete, paste
vim.keymap.set({ "n", "v", "x" }, "<leader>y", '"+y')
vim.keymap.set({ "v", "x" }, "<leader>d", '"_d')
vim.keymap.set({ "v", "x" }, "<leader>p", '"_dP')
