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
			{ "<bs>" },
		},
		opts = {
			highlight = { enable = true },
			indent = { enable = true },
			ensure_installed = {
				"go",
				"gomod",
				"gosum",
				"gotmpl",
				"gowork",
				"lua",
				"nix",
				"sql",
				"vim",
				"vimdoc",
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_incremental = false,
					node_decremental = "<bs>",
				},
			},
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["i="] = "@assignment.inner",
						["a="] = "@assignment.outer",
						["l="] = "@assignment.lhs",
						["r="] = "@assignment.rhs",
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

			local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")

			vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
			vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)

			vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
			vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
			vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
			vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		lazy = true,
	},
}
