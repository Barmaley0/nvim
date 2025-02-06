-- Debugging Support
return {
  -- https://github.com/rcarriga/nvim-dap-ui
  "rcarriga/nvim-dap-ui",
  event = "VeryLazy",
  dependencies = {
    -- https://github.com/mfussenegger/nvim-dap
    "mfussenegger/nvim-dap",
    "nvim-neotest/nvim-nio",
    -- https://github.com/theHamsta/nvim-dap-virtual-text
    "theHamsta/nvim-dap-virtual-text", -- inline variable text while debugging
    -- https://github.com/nvim-telescope/telescope-dap.nvim
    "nvim-telescope/telescope-dap.nvim", -- telescope integration with dap
  },
  opts = {
    controls = {
      element = "repl",
      enabled = true,
      icons = {
        disconnect = "",
        pause = "",
        play = "",
        run_last = "",
        step_back = "",
        step_into = "",
        step_out = "",
        step_over = "",
        terminate = "",
      },
    },
    element_mappings = {},
    expand_lines = true,
    floating = {
      border = "single",
      mappings = {
        close = { "q", "<Esc>" },
      },
    },
    force_buffers = true,
    icons = {
      collapsed = "",
      current_frame = "",
      expanded = "",
    },
    layouts = {
      {
        elements = {
          {
            id = "scopes",
            size = 0.50,
          },
          {
            id = "stacks",
            size = 0.30,
          },
          {
            id = "watches",
            size = 0.10,
          },
          {
            id = "breakpoints",
            size = 0.10,
          },
        },
        size = 40,
        position = "left", -- Can be "left" or "right"
      },
      {
        elements = {
          "repl",
          "console",
        },
        size = 10,
        position = "bottom", -- Can be "bottom" or "top"
      },
    },
    mappings = {
      edit = "e",
      expand = { "<CR>", "<2-LeftMouse>" },
      open = "o",
      remove = "d",
      repl = "r",
      toggle = "t",
    },
    render = {
      indent = 1,
      max_value_lines = 100,
    },
  },
  config = function(_, opts)
    local dap = require("dap")
    require("dapui").setup(opts)

    vim.api.nvim_set_hl(0, "DapBreakpoint", { ctermbg = 0, fg = "#E886A2", bg = "" })
    vim.api.nvim_set_hl(0, "DapStopped", { ctermbg = 0, fg = "#A4F766", bg = "" })
    vim.api.nvim_set_hl(0, "DapBreakpointCondition", { ctermbg = 0, fg = "#F79000", bg = "" })
    vim.api.nvim_set_hl(0, "DapLogPoint", { ctermbg = 0, fg = "#94E2D5", bg = "" })

    vim.fn.sign_define(
      "DapBreakpoint",
      { text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
    )
    vim.fn.sign_define(
      "DapStopped",
      { text = "", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" }
    )

    vim.fn.sign_define(
      "DapBreakpointCondition",
      {
        text = "󰂖",
        texthl = "DapBreakpointCondition",
        linehl = "DapBreakpointCondition",
        numhl = "DapBreakpointCondition",
      }
    )

    vim.fn.sign_define(
      "DapLogPoint",
      { text = "", texthl = "DapLogPoint", linehl = "DapLogPoint", numhl = "DapLogPoint" }
    )

    dap.listeners.after.event_initialized["dapui_config"] = function()
      require("dapui").open()
    end

    dap.listeners.before.event_terminated["dapui_config"] = function()
      -- Commented to prevent DAP UI from closing when unit tests finish
      -- require('dapui').close()
    end

    dap.listeners.before.event_exited["dapui_config"] = function()
      -- Commented to prevent DAP UI from closing when unit tests finish
      -- require('dapui').close()
    end

    -- Add dap configurations based on your language/adapter settings
    -- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
    dap.configurations.python = {
      {
        type = "python",
        request = "launch",
        name = "DAP Django",
        program = vim.loop.cwd() .. "/manage.py",
        args = { "runserver", "--nothreading" },
        justMyCode = true,
        django = true,
        console = "integratedTerminal",
      },
      {
        type = "python",
        request = "launch",
        name = "Flask",
        module = "flask",
        env = {
          -- FLASK_APP = "app.py",
          FLASK_ENV = "development",
          FLASK_DEBUG = "1"
        },
        args = { "run", "--no-debugger", "--no-reload" },
        justMyCode = true,
        jinja = true,
        console = "integratedTerminal",
      },
      {
        type = "python",
        request = "launch",
        name = "Pytest",
        module = "pytest",
        args = {
          "--log-level",
          "DEBUG",
          "--quiet",
        },
        justMyCode = true,
        python = "C:\\Users\\Den\\AppData\\Local\\nvim-data\\mason\\packages\\debugpy\\venv\\Scripts\\python.exe",
        console = "integratedTerminal",
      }
    }
    --   dap.adapters.python = {
    --     type = "executable",
    --     command = "C:\\Users\\Den\\AppData\\Local\\nvim-data\\mason\\packages\\debugpy\\venv\\Scripts\\python.exe",
    --     args = { "-m", "debugpy.adapter" },
    --   }
  end,
}
