return {
	"saghen/blink.cmp",
	lazy = false,
	version = "v0.*",
	opts = {
		keymap = {
			["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
			["<C-e>"] = { "hide" },
			["<C-y>"] = { "select_and_accept" },
			["<CR>"] = { "accept", "fallback" },

			["<C-p>"] = { "select_prev", "fallback" },
			["<C-n>"] = { "select_next", "fallback" },

			["<C-b>"] = { "scroll_documentation_up", "fallback" },
			["<C-f>"] = { "scroll_documentation_down", "fallback" },

			["<Tab>"] = { "snippet_forward", "fallback" },
			["<S-Tab>"] = { "snippet_backward", "fallback" },
		},

		accept = {
			create_undo_point = true,
			auto_brackets = { enabled = false },
		},

		nerd_font_variant = "normal",

		trigger = {
			signature_help = { enabled = true },
		},

		sources = {
			enabled_providers = { "lsp", "path", "buffer" },
		},

		windows = {
			autocomplete = {
				border = "single",
				selection = "manual",
			},
			documenatation = {
				border = "single",
			},
			signature_help = {
				border = "single",
			},
		},
	},
}
