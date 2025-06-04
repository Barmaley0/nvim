return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    { "mason-org/mason.nvim", version = "^1.0.0" },
    { "mason-org/mason-lspconfig.nvim", version = "^1.0.0" },
  },
  config = function()
    -- import mason
    local mason = require("mason")

    -- import mason-lspconfig
    local mason_lspconfig = require("mason-lspconfig")

    -- import mason-tool-installer
    local mason_tool_installer = require("mason-tool-installer")

    -- enable mason and configure icons
    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
      log_level = vim.log.levels.DEBUG,
      max_concurrent_installers = 4,
    })

    mason_lspconfig.setup({
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
        -- "ruff_lsp",
        "ruff",
      },
      -- auto-install configured servers (with lspconfig)
      automatic_enable = true,
      automatic_installation = true,
    })


    mason_tool_installer.setup({
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
      auto_update = true,
      run_on_start = true,
    })
  end,
}
