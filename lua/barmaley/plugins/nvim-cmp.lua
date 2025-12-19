return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-buffer", -- source for text in buffer
    "hrsh7th/cmp-path", -- source for file system paths
    {
      "L3MON4D3/LuaSnip",
      -- follow latest release.
      version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
      -- install jsregexp (optional!).
      build = "make install_jsregexp",
    },
    "saadparwaiz1/cmp_luasnip", -- for autocompletion
    "rafamadriz/friendly-snippets", -- useful snippets
    "onsails/lspkind.nvim", -- vs-code like pictograms
    "jmbuhr/cmp-pandoc-references",
    "kdheepak/cmp-latex-symbols",
  },
  config = function()
    local cmp = require("cmp")

    local compare = require("cmp.config.compare")

    local luasnip = require("luasnip")

    local lspkind = require("lspkind")

    -- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup({
      completion = {
        completeopt = "menu,menuone,preview,noselect",
      },
      snippet = { -- configure how nvim-cmp interacts with snippet engine
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
        ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
        ["<C-e>"] = cmp.mapping.abort(), -- close completion window
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
        ["<C-h>"] = cmp.mapping(function()
          if cmp.visible() then
            local entry = cmp.get_selected_entry()
            if entry then
              vim.cmd("help " .. entry.completion_item.label)
            end
          end
        end, { "i" }),
      }),
      -- sources for autocompletion
      sources = cmp.config.sources({
        { name = "nvim_lsp"},
        { name = "luasnip" }, -- snippets
        { name = "buffer" }, -- text within current buffer
         -- Улучшенные Python-источники
        {
          name = "python",
          option = {
            show_documentation = true,  -- Показывать документацию для методов
            documentation_format = function(doc)
              return string.format("%s\n\n%s", doc.description, doc.signature)
            end
          }
        },
        { name = "path" }, -- file system paths
        { name = "nvim_lsp_signature_help" },
        { name = "py-requirements" },
        { name = "pree-commit" },
        { name = "nvim_lua" },
        { name = "html" },
        { name = "jinja_lsp" },
        { name = "djanfohtml" },
      }),
      -- order of completion
      sorting = {
        priority_weight = 2,
        comparators = {
          compare.exact,
          compare.score,
          compare.sort_text,
          compare.offset,
        },
      },
      -- configure lspkind for vs-code like pictograms in completion menu
      formatting = {
        format = lspkind.cmp_format({
          maxwidth = 50,
          ellipsis_char = "...",
      --     -- Специальные иконки для Python-методов
      --     -- symbol_map = {
      --     --   Method = "󰆧",
      --     --   Function = "󰊕",
      --     --   Constructor = "",
      --     --   Field = "󰜢",
      --     --   Variable = "󰀫",
      --     --   Class = "󰠱",
      --     --   Module = "",
      --     --   Property = "",
      --     --   Unit = "",
      --     --   Value = "󰎠",
      --     --   Enum = "",
      --     --   Keyword = "󰌋",
      --     --   Snippet = "",
      --     --   Color = "󰏘",
      --     --   File = "󰈙",
      --     --   Reference = "󰈇",
      --     --   Folder = "󰉋",
      --     --   Constant = "󰏿",
      --     --   Struct = "󰙅",
          -- },
        }),
      },
      -- Добавляем экспериментальные фичи
      experimental = {
        ghost_text = true,  -- Показывать подсказки прямо в тексте
        native_menu = false,
      },
    })
    -- Специальная настройка для Python
    cmp.setup.filetype("python", {
      sources = cmp.config.sources({
        { name = "nvim_lsp", priority = 1000 },
        { name = "python", priority = 900 },
        { name = "luasnip", priority = 750 },
        { name = "buffer", priority = 500 },
      })
    })
  end
}
