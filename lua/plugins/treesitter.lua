return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
	branch = "main",
	build = ":TSUpdate",
	lazy = false,
	config = function()
		require("nvim-treesitter").install({
			"dockerfile",
			"html",
			"json",
			"markdown",
			"markdown_inline",
			"nix",
			"sql",
			"vim",
			"vimdoc",

			"go",
			"gomod",
			"gosum",
			"gotmpl",
			"gowork",

			"lua",

			"javascript",
			"typescript",
			"tsx",
		})

		vim.api.nvim_create_autocmd("FileType", {
			-- pattern = opts.languages,
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
