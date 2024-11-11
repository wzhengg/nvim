return {
	"saghen/blink.cmp",
	lazy = false,
	version = "v0.*",
	opts = {
		keymap = { preset = "default" },

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
