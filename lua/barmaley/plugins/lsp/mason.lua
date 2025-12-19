return {
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      -- list of servers for mason to install
      ensure_installed = {
        "cmake",
        "docker_compose_language_service",
        "dockerls",
        "emmet_language_server",
        "eslint",
        "jinja_lsp",
        "pylsp",
        "yamlls",
        "ts_ls",
        "html",
        "cssls",
        "tailwindcss",
        "svelte",
        "lua_ls",
        "graphql",
        "emmet_ls",
        "prismals",
        "pyright",
        "ruff",
      },
      -- automatic_installation = true,
      -- automatic_enable = false,
    },
    dependencies = {
      {
      "williamboman/mason.nvim",
      opts = {
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      },
      -- log_level = vim.log.levels.INFO,
      -- max_concurrent_installers = 4,
    },
    "neovim/nvim-lspconfig",
  },
},
{
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  opts = {
    ensure_installed = {
      "mypy",
      "cmakelang",
      "cmakelint",
      "debugpy",
      "djlint",
      "hadolint",
      "htmlhint",
      "pydocstyle",
      "yamlfmt",
      "yamlfix",
      "yamllint",
      "jq",
      "prettier", -- prettier formatter
      "stylua", -- lua formatter
      "ruff",
      "pylint",
      "eslint_d",
    },
      -- auto_update = true,
      -- run_on_start = true,
    },
    dependencies = {
      "williamboman/mason.nvim",
    },
  }
}
