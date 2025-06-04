return {
  "neovim/nvim-lspconfig",
  version = "^1.0.0",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "folke/neodev.nvim", opts = {} },
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    -- import lspconfig plugin
    local lspconfig = require("lspconfig")

    -- import mason_lspconfig plugin
    local mason_lspconfig = require("mason-lspconfig")

    -- import cmp-nvim-lsp plugin
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    local keymap = vim.keymap -- for conciseness
    local api = vim.api

    vim.diagnostic.config({
      virtual_text = {
        prefix = " ",
        spacing = 4,
      },
      signs = true,
      underline = true,
      update_in_insert = true,
      float = {
        source = "always", -- Or "if_many"
        border = "rounded",
      },
    })

    -- Change the Diagnostic symbols in the sign column (gutter)
    -- (not in youtube nvim video)
    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end


    -- configure mapping lspconfig
    api.nvim_create_autocmd("LspAttach", {
      group = api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf, silent = true }

        -- set keybinds
        opts.desc = "Show LSP references"
        keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

        opts.desc = "Go to declaration"
        keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

        opts.desc = "Show LSP definitions"
        keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

        opts.desc = "Show LSP implementations"
        keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

        opts.desc = "Show LSP type definitions"
        keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

        opts.desc = "See available code actions"
        keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

        opts.desc = "Smart rename"
        keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

        opts.desc = "Show buffer diagnostics"
        keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

        opts.desc = "Show line diagnostics"
        keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

        opts.desc = "Go to previous diagnostic"
        keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

        opts.desc = "Go to next diagnostic"
        keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

        opts.desc = "Show documentation for what is under cursor"
        keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

        opts.desc = "Restart LSP"
        keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
      end,
    })

    -- used to enable autocompletion (assign to every lsp server config)
    local capabilities = cmp_nvim_lsp.default_capabilities()

    mason_lspconfig.setup_handlers({
      -- default handler for installed servers
      function(server_name)
        lspconfig[server_name].setup({
          capabilities = capabilities,
        })
      end,
    -- vim.lsp.config("*", {
    --     capabilities = capabilities,
    --     on_attach = on_attach,
    --     handlers = handlers,
    --   })
      ["svelte"] = function()
        -- configure svelte server
        lspconfig["svelte"].setup({
          capabilities = capabilities,
          on_attach = function(client, bufnr)
            vim.api.nvim_create_autocmd("BufWritePost", {
              pattern = { "*.js", "*.ts" },
              callback = function(ctx)
                -- Here use ctx.match instead of ctx.file
                client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
              end,
            })
          end,
        })
      end,
      ["dockerls"] = function()
        -- configure docker language server
        lspconfig["dockerls"].setup({
          capabilities = capabilities,
          settings = {
            docker = {
              languageserver = {
                formatter = {
                  ignoreMultilineInstructions = true,
                },
              },
            },
          },
        })
      end,
      ["docker_compose_language_service"] = function()
        -- configure docker compose language server
        lspconfig["docker_compose_language_service"].setup({
          capabilities = capabilities,
          settings = {
            docker = {
              languageserver = {
                formatter = {
                  ignoreMultilineInstructions = true,
                },
              },
            },
          },
        })
      end,
      ["yamlls"] = function()
        -- configure yaml language server
        lspconfig["yamlls"].setup({
          capabilities = capabilities,
          settings = {
            yaml = {
              schemas = {
                ["https://raw.githubusercontent.com/quantumblacklabs/kedro/develop/static/jsonschema/kedro-catalog-0.17.json"] = "conf/**/*catalog*",
                ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
              },
            },
          },
        })
      end,
      ["jinja_lsp"] = function()
        -- configure jinja language server
        lspconfig["jinja_lsp"].setup({
          capabilities = capabilities,
          filetypes = { "jinja", "rust", "jinja.html", "html" },
          args = {
            "--indent=2",
          }
        })
      end,
      ["graphql"] = function()
        -- configure graphql language server
        lspconfig["graphql"].setup({
          capabilities = capabilities,
          filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
        })
      end,
      -- ["ruff_lsp"] = function()
      --   -- configure ruff language server
      --   lspconfig["ruff_lsp"].setup({
      --     capabilities = capabilities,
      --     init_options = {
      --       settings = {
      --         args = {
      --           "--select=E,T201",
      --           "--line-length=120",
      --         },
      --       },
      --     },
      --   })
      -- end,
      ["ruff"] = function()
        -- configure ruff language server
        lspconfig["ruff"].setup({
          capabilities = capabilities,
          init_options = {
            settings = {
              args = {
              }
            }
          }
        })
      end,
      ["pyright"] = function()
        -- configure pyright language server
        lspconfig["pyright"].setup({
          capabilities = capabilities,
          settings = {
            python = {
              analysis = {
                typeCheckingMode = "basic",
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
              }
            }
          }
        })
      end,
      ["pylsp"] = function()
        -- configure pylsp language server
        lspconfig["pylsp"].setup({
          capabilities = capabilities,
          settings = {
            pylsp = {
              plugins = {
                pycodestyle = {
                  -- ignore = { "W391", "E501", "E265" },
                  maxLineLength = 120,
                },
              },
            },
          },
        })
      end,
      ["html"] = function()
        -- configure html server
        lspconfig["html"].setup({
          capabilities = capabilities,
          filetypes = { "html", "css", "templ" },
        })
      end,
      ["emmet_ls"] = function()
        -- configure emmet language server
        lspconfig["emmet_ls"].setup({
          capabilities = capabilities,
          filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
          init_options = {
            html = {
              options = {
                -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79
                ["bem.enabled"] = true,
              },
            },
          },
        })
      end,
      ["emmet_language_server"] = function()
        -- configure emmet language server
        lspconfig["emmet_language_server"].setup({
          capabilities = capabilities,
        })
      end,
      ["lua_ls"] = function()
        -- configure lua server (with special settings)
        lspconfig["lua_ls"].setup({
          capabilities = capabilities,
          settings = {
            Lua = {
              -- make the language server recognize "vim" global
              diagnostics = {
                globals = { "vim" },
              },
              completion = {
                callSnippet = "Replace",
              },
            },
          },
        })
      end,
    })
  end,
}
