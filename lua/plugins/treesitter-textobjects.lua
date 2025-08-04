return {
	"nvim-treesitter/nvim-treesitter-textobjects",
	branch = "main",
	opts = {
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
	},
	config = function(_, opts)
		require("nvim-treesitter-textobjects").setup(opts)

		local select = require("nvim-treesitter-textobjects.select")

		vim.keymap.set({ "x", "o" }, "a=", function()
			select.select_textobject("@assignment.lhs", "textobjects")
		end)
		vim.keymap.set({ "x", "o" }, "i=", function()
			select.select_textobject("@assignment.rhs", "textobjects")
		end)
		vim.keymap.set({ "x", "o" }, "a:", function()
			select.select_textobject("@assignment.outer", "textobjects")
		end)
		vim.keymap.set({ "x", "o" }, "im", function()
			select.select_textobject("@call.inner", "textobjects")
		end)
		vim.keymap.set({ "x", "o" }, "am", function()
			select.select_textobject("@call.outer", "textobjects")
		end)
		vim.keymap.set({ "x", "o" }, "ic", function()
			select.select_textobject("@class.inner", "textobjects")
		end)
		vim.keymap.set({ "x", "o" }, "ac", function()
			select.select_textobject("@class.outer", "textobjects")
		end)
		vim.keymap.set({ "x", "o" }, "ii", function()
			select.select_textobject("@conditional.inner", "textobjects")
		end)
		vim.keymap.set({ "x", "o" }, "ai", function()
			select.select_textobject("@conditional.outer", "textobjects")
		end)
		vim.keymap.set({ "x", "o" }, "if", function()
			select.select_textobject("@function.inner", "textobjects")
		end)
		vim.keymap.set({ "x", "o" }, "af", function()
			select.select_textobject("@function.outer", "textobjects")
		end)
		vim.keymap.set({ "x", "o" }, "il", function()
			select.select_textobject("@loop.inner", "textobjects")
		end)
		vim.keymap.set({ "x", "o" }, "al", function()
			select.select_textobject("@loop.outer", "textobjects")
		end)
		vim.keymap.set({ "x", "o" }, "ia", function()
			select.select_textobject("@parameter.inner", "textobjects")
		end)
		vim.keymap.set({ "x", "o" }, "aa", function()
			select.select_textobject("@parameter.outer", "textobjects")
		end)
		vim.keymap.set({ "x", "o" }, "a;", function()
			select.select_textobject("@statement.outer", "textobjects")
		end)

		local swap = require("nvim-treesitter-textobjects.swap")

		vim.keymap.set("n", "<leader>a", function()
			swap.swap_next("@parameter.inner")
		end)
		vim.keymap.set("n", "<leader>A", function()
			swap.swap_previous("@parameter.inner")
		end)
		vim.keymap.set("n", "<leader>}", function()
			swap.swap_next("@function.outer")
		end)
		vim.keymap.set("n", "<leader>{", function()
			swap.swap_previous("@function.outer")
		end)

		local move = require("nvim-treesitter-textobjects.move")

		vim.keymap.set({ "n", "x", "o" }, "]f", function()
			move.goto_next_start("@function.outer", "textobjects")
		end)
		vim.keymap.set({ "n", "x", "o" }, "[f", function()
			move.goto_previous_start("@function.outer", "textobjects")
		end)
		vim.keymap.set({ "n", "x", "o" }, "]c", function()
			move.goto_next_start("@class.outer", "textobjects")
		end)
		vim.keymap.set({ "n", "x", "o" }, "[c", function()
			move.goto_previous_start("@class.outer", "textobjects")
		end)
		vim.keymap.set({ "n", "x", "o" }, "]a", function()
			move.goto_next_start("@parameter.inner", "textobjects")
		end)
		vim.keymap.set({ "n", "x", "o" }, "[a", function()
			move.goto_previous_start("@parameter.inner", "textobjects")
		end)
		vim.keymap.set({ "n", "x", "o" }, "]F", function()
			move.goto_next_end("@function.outer", "textobjects")
		end)
		vim.keymap.set({ "n", "x", "o" }, "[F", function()
			move.goto_previous_end("@function.outer", "textobjects")
		end)
		vim.keymap.set({ "n", "x", "o" }, "]C", function()
			move.goto_next_end("@class.outer", "textobjects")
		end)
		vim.keymap.set({ "n", "x", "o" }, "[C", function()
			move.goto_previous_end("@class.outer", "textobjects")
		end)
		vim.keymap.set({ "n", "x", "o" }, "]A", function()
			move.goto_next_end("@parameter.inner", "textobjects")
		end)
		vim.keymap.set({ "n", "x", "o" }, "[A", function()
			move.goto_previous_end("@parameter.inner", "textobjects")
		end)
	end,
}
