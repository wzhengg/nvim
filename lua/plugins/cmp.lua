return {
	"saghen/blink.cmp",
	-- lazy = false,
	version = "*",

	--@module 'blink.cmp'
	--@type blink.cmp.Config
	opts = {
		keymap = {
			preset = "none",

			["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
			["<C-e>"] = { "hide" },
			["<C-y>"] = { "select_and_accept" },

			["<C-p>"] = { "select_prev", "fallback" },
			["<C-n>"] = { "select_next", "fallback" },

			["<C-b>"] = { "scroll_documentation_up", "fallback" },
			["<C-f>"] = { "scroll_documentation_down", "fallback" },

			["<Tab>"] = { "snippet_forward", "fallback" },
			["<S-Tab>"] = { "snippet_backward", "fallback" },

			["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
		},

		appearance = { nerd_font_variant = "normal" },

		sources = {
			default = { "lsp", "path" },
		},

		completion = {
			accept = {
				create_undo_point = true,
				auto_brackets = { enabled = false },
			},
			documentation = {},
			ghost_text = { enabled = true },
			keyword = { range = "full" },
			list = {
				selection = { preselect = false, auto_insert = false },
			},
		},

		signature = {
			enabled = true,
		},
	},
	opts_extend = { "sources.default" },
}
