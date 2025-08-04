return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
	branch = "main",
	build = ":TSUpdate",
	lazy = false,
	opts = {
		parsers = {
			"dockerfile",
			"html",
			"json",
			"markdown",
			"markdown_inline",
			"sql",
			"vim",
			"vimdoc",
		},
	},
	config = function(_, opts)
		require("nvim-treesitter").install(opts.parsers)

		vim.api.nvim_create_autocmd("FileType", {
			callback = function(args)
				local buf = args.buf

				local max_filesize = 100 * 1024 -- 100 KB
				local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))

				if ok and stats and stats.size > max_filesize then
					return
				end

				if not pcall(vim.treesitter.start, buf) then
					return
				end

				vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- folds
				vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" -- indentation
			end,
		})
	end,
}
