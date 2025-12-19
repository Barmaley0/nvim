return {
  -- capabilities = capabilities,
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = {
          enabled = true,
          maxLineLength = 120,
        },
        pyflakes = { enabled = true },
        autopep8 = { enabled = true },
        yapf = { enabled = true },
        mccable = { enabled = true },
        pylsp_mypy = { enabled = true },
        pylsp_black = { enabled = true },
        pylsp_isort = { enabled = true },
      },
    },
  },
}
