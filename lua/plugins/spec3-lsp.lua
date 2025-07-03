return {
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = function()
      return {
        servers = {
          clangd = { settings = {} },
          nixd = { settings = {} },
          astro = { settings = {} },
          svelte = {
            keys = {
              {
                "<leader>co",
                LazyVim.lsp.action["source.organizeImports"],
                desc = "Organize Imports"
              }
            },
            capabilities = {
              workspace = {
                didChangeWatchedFiles = vim.fn.has("nvim-0.10") == 0 and
                  { dynamicRegistration = true }
              }
            }
          },
          lua_ls = {
            settings = { Lua = {} },
            on_init = function(client)
              if client.workspace_folders then
                local path = client.workspace_folders[1].name
                if path ~= vim.fn.stdpath('config') and
                  (vim.uv.fs_stat(path .. '/.luarc.json') or
                    vim.uv.fs_stat(path .. '/.luarc.jsonc')) then
                  return
                end
              end
              client.config.settings.Lua =
                vim.tbl_deep_extend('force', client.config.settings.Lua, {
                  runtime = {
                    version = 'LuaJIT',
                    path = { 'lua/?.lua', 'lua/?/init.lua' }
                  },
                  workspace = {
                    checkThirdParty = false,
                    library = { vim.env.VIMRUNTIME }
                  }
                })
            end
          }
        }
      }
    end,
    config = function(_, opts)
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      for server, config in pairs(opts.servers) do
        config.capabilities = capabilities
        vim.lsp.enable(server)
        vim.lsp.config(server, config)
      end
    end,
    keys = {
      {
        'gD',
        function() vim.lsp.buf.declaration() end,
        "n",
        desc = "Goto Declaration"
      },
      {
        "gd",
        function() vim.lsp.buf.definition() end,
        "n",
        desc = "Goto Definition"
      },
      {
        'gr',
        function() vim.lsp.buf.references() end,
        "n",
        desc = "List References"
      }, {
        'gi',
        function() vim.lsp.buf.implementation() end,
        "n",
        desc = "Goto implementation"
      },
      {
        '<leader>ar',
        function() vim.lsp.buf.rename() end,
        "n",
        desc = "Rename all"
      }, {
        '<leader>ai',
        function() vim.lsp.buf.incoming_calls() end,
        "n",
        desc = "List all incoming calls"
      }, {
        '<leader>ao',
        function() vim.lsp.buf.outgoing_calls() end,
        "n",
        desc = "list all outgoing calls"
      }
    }
  }, {
    "hrsh7th/nvim-cmp",
    event = "BufReadPost",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer", "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline"
    },
    opts = function()
      local cmp = require("cmp")
      return {
        snippet = { expand = function(args) vim.snippet.expand(args.body) end },
        completion = { completeopt = "menu,menuone,noselect,noinsert" },
        mapping = cmp.mapping.preset.insert({
          ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item({
            behavior = cmp.SelectBehavior.Select
          }), { 'i', 'c' }),
          ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item({
            behavior = cmp.SelectBehavior.Select
          }), { 'i', 'c' }),
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = false })
        }),
        sources = cmp.config.sources({ { name = 'nvim_lsp' } },
                                     { { name = 'buffer' } })
      }
    end
  }, {
    "lewis6991/hover.nvim",
    event = "BufReadPost",
    opts = {
      init = function()
        require("hover.providers.lsp")
        require("hover.providers.diagnostic")
        require("hover.providers.man")
      end,
      preview_opts = { border = "double" },
      preview_window = false,
      title = true
    },
    keys = {
      { "K", function() require("hover").hover() end, "n", desc = "hover.nvim" },
      {
        "gK",
        function() require("hover").hover_select() end,
        "n",
        desc = "hover.nvim (select)"
      }, {
        "<C-n>",
        function() require("hover").hover_switch("next") end,
        "n",
        desc = "hover.nvim (next source)"
      }, {
        "<C-p>",
        function() require("hover").hover_switch("next") end,
        "n",
        desc = "hover.nvim (previous source)"
      }
    }
  }, { "mrcjkb/rustaceanvim", version = '^6', lazy = false }
}
