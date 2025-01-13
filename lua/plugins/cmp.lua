return {
	"saghen/blink.cmp",
	lazy = false,
	version = "*",
	opts = {
		keymap = { preset = "default" },

		appearance = { nerd_font_variant = "normal" },

		sources = {
			default = { "lsp", "path" },
			cmdline = {},
		},

		completion = {
			accept = {
				create_undo_point = true,
				auto_brackets = { enabled = false },
			},
			documentation = {
				window = { border = "single" },
			},
			ghost_text = { enabled = true },
			list = {
				selection = { preselect = false, auto_insert = false },
			},
			menu = { border = "single" },
		},

		signature = {
			enabled = true,
			window = { border = "single" },
		},
	},
	opts_extend = { "sources.default" },
}
