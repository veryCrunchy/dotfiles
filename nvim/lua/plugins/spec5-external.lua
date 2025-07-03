return {
  { "wakatime/vim-wakatime", lazy = false }, {
    'stevearc/conform.nvim',
    event = "VeryLazy",
    opts = function()
      local formatters_by_ft = {
        lua = { "lua-format" },
        nix = { "nixfmt" },
        rust = { "rustfmt", lsp_format = "fallback" },
        svelte = { "prettier" }
      }

      for _, ft in ipairs({ "c", "h", "cc", "cpp", "hpp", "cxx", "hxx" }) do
        formatters_by_ft[ft] = { "clang-format" }
      end

      return {
        formatters_by_ft = formatters_by_ft,
        formatters = {
          ["lua-format"] = {
            prepend_args = {
              "--indent-width=2", "--tab-width=2",
              "--continuation-indent-width=2", "--spaces-inside-table-braces"
            }
          }
        }
      }
    end,
    keys = {
      {
        "<leader>ff",
        function() require("conform").format({ async = true }) end,
        mode = "",
        desc = "[F]ormat [F]ile Buffer"
      }
    }
  }, { "andweeb/presence.nvim", lazy = false, opts = {} },
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    opts = { open_mapping = [[<c-\>]] }
  }
}
