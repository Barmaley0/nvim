return {
  "MeanderingProgrammer/py-requirements.nvim",
  version = "*",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local py_requirements = require("py-requirements")

    vim.filetype.add({
      filename = {
        ["requirements.txt"] = "requirements",
      },
    })

    py_requirements.setup({})
  end,
}
