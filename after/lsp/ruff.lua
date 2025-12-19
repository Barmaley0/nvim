return {
  -- capabilities = capabilities,
  init_options = {
    settings = {
      -- Ruff будет читать настройки из pyproject.toml
      configurationPreference = "filesystemFirst",
      fixAll = true,
      organizeImports = true,
    },
  },
}
