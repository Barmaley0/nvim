return {
  "rcarriga/nvim-notify",
  config = function()
    local notify = require("notify")
    -- Переопределяем стандартный vim.notify

    vim.notify = notify

    notify.setup({
      -- Основные параметры
      timeout = 3000,
      fps = 60,
      background_colour = "#000000",
      max_width = math.floor(vim.o.columns * 0.3),
      max_height = math.floor(vim.o.lines * 0.3),

      stages = "slide", -- Другие варианты: "fade", "fade_in_slide_out", "static"

      -- Стиль уведомлений
      render = "default", -- Или "minimal", "wrapped-compact"
      top_down = false,

      -- Исправление диагностики
      merge_duplicates = true, -- Объединять одинаковые уведомления

      -- Кастомные иконки (опционально)
      icons = {
        ERROR = "",
        WARN = "",
        INFO = "",
        DEBUG = "",
        TRACE = "",
      },

      -- Настройки для Windows (особенно важно для анимаций)
      on_open = function(win)
        vim.api.nvim_win_set_config(win, { zindex = 100 })
      end,
    })
    vim.lsp.handlers["window/showMessage"] = function(_, result, ctx)
      local level = ({
        "ERROR",
        "WARN",
        "INFO",
        "DEBUG",
      })[result.type]
      notify(result.message, level, {
        title = "LSP: " .. ctx.client.name,
        timeout = 5000,
      })
    end
  end,
}
