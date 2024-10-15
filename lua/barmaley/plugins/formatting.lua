return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        svelte = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        jinja = { "djlint" },
        django = { "djlint" },
        htmljinja = { "djlint" },
        htmldjango = { "djlint" },
        hurl = { "jq" },
        json = { "jq" },
        yaml = { "yamlfmt", "yamlfix" },
        markdown = { "prettier" },
        graphql = { "prettier" },
        liquid = { "prettier" },
        lua = { "stylua" },
        python = { "ruff", "isort", "black" },

        -- },
        -- format_on_save = {
        --   lsp_fallback = true,
        --   async = false,
        --   timeout_ms = 1000,
      },
      notify_on_error = true,
      formatters = {
        isort = {
          known_flask = "flask",
          sections = "FUTURE", "STDLIB", "THIRDPARTY", "FLASK", "FIRSTPARTY", "LOCALFOLDER",
          include_trailing_comma = true,
          command = "isort",
          args = {
            "--profile",
            "black",
            "--lines-between-types",
            "1",
            "--lines-after-imports",
            "2",
            "-",
          },
        },
        prettier = {
          command = "prettier",
          append_args = {
            "--print-width",
            "120",
          },
        },
        djlint = {
          command = "djlint",
          append_args = {
            "--indent",
            "4",
          },
        },
        black = {
          command = "black",
          args = {
            "--line-length",
            "120",
            "-",
          },
        },
      },
    })

    vim.keymap.set({ "n", "v" }, "<leader>mp", function()
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      })
    end, { desc = "Format file or range (in visual mode)" })
  end,
}
