return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-neotest/neotest-plenary",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-neotest/neotest-python",
  },
  config = function()
    local neotest = require("neotest")

    neotest.setup({
      adapters = {
        require("neotest-plenary"),
        require("neotest-python")({
          dap = {
            justMyCode = true,
            console = "internalConsole",
          },
          args = {
            "--log-level",
            "DEBUG",
            "--quiet",
          },
          runner = "pytest",
          python = "C:\\Users\\Den\\.pyconfig\\pytest\\venv\\Scripts\\python.exe",
        }),
      },
    })
  end,
}
