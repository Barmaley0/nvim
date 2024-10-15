return {
  "Bekaboo/deadcolumn.nvim",
  event = "VeryLazy",
  config = function()
    vim.opt.colorcolumn = "120"

    local column = require("deadcolumn")

    column.setup({
      opts = {
        blending = {
          threshold = 0.75,
          colorcode = "#f8f9fe",
        },
        warning = {
          alpha = 0.9,
          colorcode = "#b3003f",
        },
      },
    })
  end,
}
