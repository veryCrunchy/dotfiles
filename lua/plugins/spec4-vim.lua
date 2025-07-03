return {
  { "tpope/vim-sleuth", lazy = false },
  { "farmergreg/vim-lastplace", lazy = false },
  { "tpope/vim-commentary", event = "BufReadPost" },
  { "tpope/vim-surround", lazy = false },
  { "tpope/vim-fugitive", event = "VeryLazy" }, {
    "machakann/vim-highlightedyank",
    event = "BufReadPost",
    init = function()
      vim.g.highlightedyank_highlight_duration = 100
      vim.g.highlightedyank_highlight_in_visual = 100
    end
  }, { "chentoast/marks.nvim", event = "BufReadPost", opts = {} }, {
    "RaafatTurki/hex.nvim",
    keys = {
      {
        "<leader>hd",
        function() require("hex").dump() end,
        desc = "Switch to hex view"
      }, {
        "<leader>ha",
        function() require("hex").assemble() end,
        desc = "Switch to normal view"
      }, {
        "<leader>ht",
        function() require("hex").toggle() end,
        desc = "Switch between hex and normal views"
      }
    }
  }, {
    "folke/todo-comments.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
    opts = {
      keywords = {
        FIX = {
          icon = " ",
          color = "error",
          alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }
        },
        TODO = { icon = " ", color = "info" },
        HACK = { icon = " ", color = "warning" },
        WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
        PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
        TEST = {
          icon = "󰤑 ",
          color = "test",
          alt = { "TESTING", "PASSED", "FAILED" }
        }
      }
    },
    keys = {
      {
        "<leader>st",
        function() vim.cmd("TodoTelescope") end,
        "n",
        desc = "[S]earch [T]odos"
      }
    }
  }
}
