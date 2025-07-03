return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  lazy = false,
  config = function(_, opts)
    require("catppuccin").setup(opts)
    vim.cmd.colorscheme "catppuccin"
  end,
  opts = {
    flavour = "frappe",
    background = { light = "latte", dark = "frappe" },
    transparent_background = true,
    show_end_of_buffer = true,
    term_colors = true, -- sets terminal colors (e.g. `g:terminal_color_0`)
    dim_inactive = {
      enabled = false, -- inactive windows
      shade = "dark",
      percentage = 0.15
    },
    no_italic = false, -- Force no italic
    no_bold = false, -- Force no bold
    no_underline = false, -- Force no underline
    styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
      comments = { "italic" }, -- Change the style of comments
      conditionals = { "italic" },
      loops = {},
      functions = {},
      keywords = {},
      strings = {},
      variables = {},
      numbers = {},
      booleans = {},
      properties = {},
      types = {},
      operators = {}
      -- miscs = {}, -- Uncomment to turn off hard-coded styles
    },
    color_overrides = {},
    custom_highlights = {},
    default_integrations = false,
    integrations = { -- (https://github.com/catppuccin/nvim#integrations)
      treesitter = true,
      telescope = { enabled = true },
      nvimtree = true,
      markdown = true,
      cmp = true,
      native_lsp = {
        enabled = true,
        virtual_text = {
          errors = { "italic" },
          hints = { "italic" },
          warnings = { "italic" },
          information = { "italic" },
          ok = { "italic" }
        },
        underlines = {
          errors = { "underline" },
          hints = { "underline" },
          warnings = { "underline" },
          information = { "underline" },
          ok = { "underline" }
        },
        inlay_hints = { background = true }
      }
    }
  }
}
