return {
  "folke/persistence.nvim",
  event = "BufReadPre",
  config = true,
  keys = {
    { "<leader>qs", function() require("persistence").load() end },
  },
}
