return {
  -- https://github.com/mfussenegger/nvim-dap-python
  "mfussenegger/nvim-dap-python",
  ft = "python",
  dependencies = {
    -- https://github.com/mfussenegger/nvim-dap
    "mfussenegger/nvim-dap",
  },
  config = function()
    -- Update the path passed to setup to point to your system or virtual env python binary
    local dappython = require("dap-python")

    dappython.setup("C:\\Users\\Den\\AppData\\Local\\nvim-data\\mason\\packages\\debugpy\\venv\\Scripts\\python.exe")
  end,
}
