return {
	"saghen/blink.cmp",
	lazy = false,
	version = "v0.*",
	opts = {
		keymap = { preset = "default" },

		completion = {
			list = {
				selection = "manual",
			},
			accept = {
				create_undo_point = true,
				auto_brackets = { enabled = false },
			},
			menu = {
				enabled = true,
			},
			ghost_text = {
				enabled = true,
			},
		},

		signature = { enabled = true },

		sources = {
			completion = {
				enabled_providers = { "lsp", "path" },
			},
		},

		appearance = { nerd_font_variant = "normal" },
	},
}
