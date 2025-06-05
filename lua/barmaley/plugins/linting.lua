return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      svelte = { "eslint_d" },
      python = { "pylint", "mypy" },  -- Убираем ruff из nvim-lint, так как он теперь через LSP
      dockerfile = { "hadolint" },
      yaml = { "yamllint" },
      html = { "htmlhint" },
      jinja = { "djlint" },
      htmljinja = { "djlint" },
      htmldjango = { "djlint" },
      django = { "djlint" },
    }

    -- Настройка mypy (согласованно с pyproject.toml)
    local mypy = lint.linters.mypy
    mypy.args = {
      "--ignore-missing-imports",
      "--disallow-untyped-defs",
      "--check-untyped-defs",
      "--show-error-codes",
      "--warn-redundant-casts",
      "--warn-unused-ignores",
      "--warn-no-return",
      "--strict-equality",
      "--no-implicit-optional",
      "--disallow-any-generics",
      "--disallow-subclassing-any",
      "--warn-return-any",
    }

    -- Настройка pylint для более мягкой проверки
    local pylint = lint.linters.pylint
    pylint.args = vim.list_extend(pylint.args or {}, {
      "--disable=C0111,C0103,R0903,W0613",  -- Отключаем некоторые строгие правила
      "--max-line-length=120",
    })

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        -- Добавляем проверку на существование файла и его читаемость
        local bufnr = vim.api.nvim_get_current_buf()
        local filepath = vim.api.nvim_buf_get_name(bufnr)

        if filepath ~= "" and vim.fn.filereadable(filepath) == 1 then
          lint.try_lint()
        end
      end,
    })

    vim.keymap.set("n", "<leader>lr", function()
      lint.try_lint()
    end, { desc = "Trigger linting for current file" })
  end,
}
