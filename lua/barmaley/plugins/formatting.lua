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
        python = { "ruff_format", "ruff_fix"},
      },
      -- Можно включить автоформатирование при сохранении (по желанию)
      -- format_on_save = {
      --   lsp_fallback = true,
      --   async = false,
      --   timeout_ms = 1000,
      -- },
      notify_on_error = true,
      formatters = {
        -- Ruff для исправления проблем (линтинг + импорты)
        ruff_fix = {
          command = "ruff",
          args = {
            "check",
            "--fix",
            "--exit-zero",
            "--stdin-filename",
            "$FILENAME",
            "-",
          },
          stdin = true,
          cwd = function()
            return vim.fn.getcwd()
          end,
        },
        -- Ruff для форматирования кода
        ruff_format = {
          command = "ruff",
          args = {
            "format",
            "--stdin-filename",
            "$FILENAME",
            "-",
          },
          stdin = true,
          cwd = function()
            return vim.fn.getcwd()
          end,
        },
        -- Prettier с увеличенной шириной строки
        prettier = {
          command = "prettier",
          append_args = {
            "--print-width",
            "100",
          },
        },
        -- djlint для Jinja/Django шаблонов
        djlint = {
          command = "djlint",
          append_args = {
            "--indent",
            "4",
          },
        },
      },
    })

    -- Маппинг для ручного форматирования
    vim.keymap.set({ "n", "v" }, "<leader>mp", function()
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 5000,
      })
    end, { desc = "Format file or range (in visual mode)" })

    -- Дополнительные маппинги для Python
    vim.keymap.set("n", "<leader>mf", function()
      conform.format({
        formatters = { "ruff_fix" },
        async = false,
        timeout_ms = 3000,
      })
    end, { desc = "Fix Python issues with Ruff" })

    vim.keymap.set("n", "<leader>mr", function()
      conform.format({
        formatters = { "ruff_format" },
        async = false,
        timeout_ms = 3000,
      })
    end, { desc = "Format Python code with Ruff" })
  end,
}
