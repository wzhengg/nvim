return {
	"echasnovski/mini.icons",
	version = false,
	lazy = true,
	config = true,
	init = function()
		require("mini.icons").mock_nvim_web_devicons()
	end,
}
