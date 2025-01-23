return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "echasnovski/mini.icons" },
	event = "VeryLazy",
	opts = {
		options = {
			section_separators = "",
			component_separators = "",
		},
		sections = {
			lualine_c = {
				{
					"filename",
					symbols = {
						modified = "●",
						readonly = "-",
					},
				},
			},
		},
	},
}
