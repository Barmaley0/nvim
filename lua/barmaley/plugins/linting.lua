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
      python = { "pylint", "ruff", "mypy" },
      dockerfile = { "hadolint" },
      yaml = { "yamllint" },
      html = { "htmlhint" },
      jinja = { "djlint" },
      htmljinja = { "djlint" },
      htmldjango = { "djlint" },
      django = { "djlint" },
    }

    local mypy = require("lint").linters.mypy

		mypy.args = vim.list_extend(mypy.args, {
			"--ignore-missing-imports",
      "--disallow-untyped-defs",
      -- "--disallow-incomplete-defs",
      -- "--disallow-untyped-decorators",
      -- "--strict",
      -- "--no-strict-optional",
      -- "--warn-unused-ignores",
		})

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })

    vim.keymap.set("n", "<leader>lr", function()
      lint.try_lint()
    end, { desc = "Trigger linting for current file" })
  end,
}
