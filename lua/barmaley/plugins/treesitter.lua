return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  dependencies = {
    "windwp/nvim-ts-autotag",
  },
  config = function()
    -- import nvim-treesitter plugin
    local treesitter = require("nvim-treesitter.configs")

    -- configure treesitter
    treesitter.setup({
      -- List of parser names, or "all"
      ensure_installed = {
        "json",
        "javascript",
        "typescript",
        "tsx",
        "yaml",
        "html",
        "css",
        "prisma",
        "markdown",
        "markdown_inline",
        "svelte",
        "graphql",
        "bash",
        "lua",
        "vim",
        "dockerfile",
        "gitignore",
        "query",
        "vimdoc",
        "c",
        "python",
        "regex",
        "hurl",
        "http",
        "requirements",
      },

      -- Install parsers synchronously (only applied to `ensure_installed`)
      sync_install = false,

      -- Automatically install missing parsers when entering buffer
      auto_install = true,

      -- List of parsers to ignore installing (for "all")
      ignore_install = {},

      ---- Modules configuration ----
      modules = {},

      -- Enable syntax highlighting
      highlight = {
        enable = true,
        -- Additional options for highlight module
        additional_vim_regex_highlighting = false,
      },

      -- Enable indentation
      indent = { 
        enable = true,
      },

      -- Enable autotagging (w/ nvim-ts-autotag plugin)
      autotag = {
        enable = true,
      },

      -- Incremental selection
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },

      -- Other available modules you might want to configure:
      -- textobjects = {},
      -- textsubjects = {},
      -- playground = {},
      -- query_linter = {},
    })
  end,
}
