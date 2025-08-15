return {
  "tzachar/local-highlight.nvim",
  dependencies = {
    {
      "folke/snacks.nvim",
      -- Важно: загружаем snacks не лениво и с высоким приоритетом
      lazy = false,
      priority = 1000,
      config = function()
        require("snacks").setup({
          -- Отключаем модуль image (так как нет поддержки в терминале)
          image = { enabled = false },

          -- Настройки для других модулей (можно включать по необходимости)
          bigfile = { enabled = false },
          dashboard = { enabled = false },
          explorer = { enabled = false },
          input = { enabled = false },
          notifier = { enabled = false },  -- Включаем уведомления
          picker = { enabled = false },
          quickfile = { enabled = false },
          scope = { enabled = false },
          scroll = { enabled = false },
          statuscolumn = { enabled = false },
          terminal = { enabled = true },  -- Базовые терминалы
          toggle = { enabled = false },
          words = { enabled = false },

          -- Настройки для notifier (чтобы избежать ошибок)
          -- notifier = {
          --   enabled = true,
          --   timeout = 3000,
          --   max_width = 80,
          --   icons = {
          --     info = " ",
          --     warn = " ",
          --     error = " ",
          --     hint = "󰠠 ",
        })
      end
    }
  },
  config = function()
    require("local-highlight").setup({})
  end,
}
