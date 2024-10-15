return {
  "rcarriga/nvim-notify",
  config = function()
    local notify = require("notify")

    vim.notify = notify

    notify.setup({
      notify._config(),
      background_colour = "#000000",
      fps = 75,
      timeout = 3000,
    })
  end,
}
