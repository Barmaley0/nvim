return {
  "dgrbrady/nvim-docker",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "pvsfair/reactivex.nvim",
  },
  config = function()
    local docker = require("nvim-docker")

    vim.keymap.set("n", "<leader>lc", docker.containers.list_containers)
  end,
}
