return {
  "folke/flash.nvim",
  event = "VeryLazy",
  config = true,
  keys = {
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end },
    { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end },
  }
}
