return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
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
					},
				},
			},
		},
	},
}
