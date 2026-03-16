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
	{ src = "https://github.com/nvim-mini/mini.diff",             version = "main" },
	{ src = "https://github.com/nvim-mini/mini.pick",             version = "main" },
	{ src = "https://github.com/nvim-mini/mini.statusline",       version = "main", },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main", },
	{ src = "https://github.com/rebelot/kanagawa.nvim" },
	{ src = "https://github.com/stevearc/conform.nvim" },
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

vim.lsp.enable({ "gopls", "lua_ls", "nixd" })

-- diff

require("mini.diff").setup({
	view = {
		style = "sign",
		signs = { add = "+", change = "~", delete = "_" },
	},
	mappings = { apply = "", reset = "" },
})

vim.keymap.set("n", "<leader>hd", function() require("mini.diff").toggle_overlay(0) end)

-- pick

require("mini.pick").setup({
	mappings = { choose = "<C-y>" },
})

vim.keymap.set("n", "<leader>fb", require("mini.pick").builtin.buffers)
vim.keymap.set("n", "<leader>ff", require("mini.pick").builtin.files)
vim.keymap.set("n", "<leader>fg", require("mini.pick").builtin.grep_live)
vim.keymap.set("n", "<leader>fh", require("mini.pick").builtin.help)
vim.keymap.set("n", "<leader>fr", require("mini.pick").builtin.resume)

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
	jump = {
		on_jump = function() vim.diagnostic.open_float() end
	},
	severity_sort = true,
	virtual_text = true,
})

-- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function() vim.hl.on_yank() end
})

-- clear search highlights
vim.keymap.set("n", "<Esc>", "<Cmd>nohlsearch<CR>")

-- quality-of-life yank, delete, paste
vim.keymap.set({ "n", "v", "x" }, "<leader>y", '"+y')
vim.keymap.set({ "v", "x" }, "<leader>d", '"_d')
vim.keymap.set({ "v", "x" }, "<leader>p", '"_dP')
