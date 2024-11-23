return {
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		build = ":TSUpdate",
		event = { "BufReadPost", "BufWritePost", "BufNewFile", "VeryLazy" },
		cmd = { "TSUpdate" },
		keys = {
			{ "<C-space>" },
			{ "<BS>" },
		},
		opts = {
			highlight = { enable = true },
			indent = { enable = true },
			ensure_installed = {
				"html",
				"go",
				"gomod",
				"gosum",
				"gotmpl",
				"gowork",
				"javascript",
				"json",
				"lua",
				"markdown",
				"markdown_inline",
				"nix",
				"sql",
				"typescript",
				"tsx",
				"vim",
				"vimdoc",
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_incremental = false,
					node_decremental = "<BS>",
				},
			},
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["a="] = "@assignment.lhs",
						["i="] = "@assignment.rhs",
						["im"] = "@call.inner",
						["am"] = "@call.outer",
						["ic"] = "@class.inner",
						["ac"] = "@class.outer",
						["ii"] = "@conditional.inner",
						["ai"] = "@conditional.outer",
						["if"] = "@function.inner",
						["af"] = "@function.outer",
						["il"] = "@loop.inner",
						["al"] = "@loop.outer",
						["ia"] = "@parameter.inner",
						["aa"] = "@parameter.outer",
					},
				},
				swap = {
					enable = true,
					swap_next = {
						["<leader>a"] = "@parameter.inner",
					},
					swap_previous = {
						["<leader>A"] = "@parameter.inner",
					},
				},
				move = {
					enable = true,
					set_jumps = true,
					goto_next_start = {
						["]f"] = "@function.outer",
						["]c"] = "@class.outer",
						["]a"] = "@parameter.inner",
					},
					goto_next_end = {
						["]F"] = "@function.outer",
						["]C"] = "@class.outer",
						["]A"] = "@parameter.inner",
					},
					goto_previous_start = {
						["[f"] = "@function.outer",
						["[c"] = "@class.outer",
						["[a"] = "@parameter.inner",
					},
					goto_previous_end = {
						["[F"] = "@function.outer",
						["[C"] = "@class.outer",
						["[A"] = "@parameter.inner",
					},
				},
			},
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
}
