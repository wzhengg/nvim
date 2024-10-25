return {
	"saghen/blink.cmp",
	dependencies = { "rafamadriz/friendly-snippets" },
	lazy = false,
	version = "v0.*",
	opts = {
		highlight = {
			use_nvim_cmp_as_default = true,
		},

		nerd_font_variant = "normal",

		keymap = {
			show = "<C-space>",
			hide = "<C-e>",
			accept = "<cr>",
			select_prev = "<C-p>",
			select_next = "<C-n>",

			show_documentation = "<C-space>",
			hide_documentation = "<C-space>",
			scroll_documentation_up = "<C-b>",
			scroll_documentation_down = "<C-f",

			snippet_forward = "<Tab>",
			snippet_backward = "<S-Tab>",
		},

		windows = {
			autocomplete = {
				border = "single",
			},
			documenatation = {
				border = "single",
			},
		},
	},
}
