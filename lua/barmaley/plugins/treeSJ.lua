return {
  "Wansmer/treesj",
  dependencies = { "nvim-treesitter/nvim-treesitter" }, -- if you install parsers with `nvim-treesitter`
  keys = { "<space>m", "<space>j", "<space>s" },
  config = function()
    require("treesj").setup({--[[ your config ]]
    })
  end,
}
