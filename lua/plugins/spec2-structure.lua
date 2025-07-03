return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = "BufReadPre",
    build = ":TSUpdate",
    opts = {
      ensure_installed = { "nix", "c", "cpp", "cmake", "lua", "markdown" },
      auto_install = true,
      ignore_install = { "v" },
      highlight = {
        enable = true,
        disable = function(lang, buf)
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.loop.fs_stat,
                                  vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
        additional_vim_regex_highlighting = false
      }
    }
  }, {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons", "nvim-telescope/telescope-ui-select.nvim"
    },
    lazy = false,
    opts = { options = { theme = "catppuccin" } }
  }, {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "VeryLazy",
    opts = {},
    config = function(_, opts)
      require("telescope").setup(opts)
      require("telescope").load_extension("ui-select")
    end,
    keys = {
      {
        "<leader>sh",
        function() require("telescope.builtin").help_tags() end,
        "n",
        desc = "[S]earch [H]elp"
      }, {
        "<leader>sf",
        function() require("telescope.builtin").find_files() end,
        "n",
        desc = "[S]earch [F]iles"
      }, {
        "<leader>si",
        function()
          require('telescope.builtin').find_files({ hidden = true })
        end,
        desc = "[S]earch Files ([i]gnored included)"
      }, {
        "<leader>sg",
        function() require("telescope.builtin").live_grep() end,
        "n",
        desc = "[S]earch [G]rep"
      }, {
        "<leader><space>",
        function() require("telescope.builtin").buffers() end,
        "n",
        desc = "Search Buffers"
      }, {
        "<leader>ss",
        function() require("telescope.builtin").builtin() end,
        "n",
        desc = "[S]earch [S]elect Telescope"
      }, {
        "<leader>sk",
        function() require("telescope.builtin").keymaps() end,
        "n",
        desc = "[S]earch [K]eys"
      }, {
        "<leader>s.",
        function() require("telescope.builtin").oldfiles() end,
        "n",
        desc = "[S]earch Recent Files (\".\" for repeat)"
      }, {
        "<leader>sw",
        function() require("telescope.builtin").grep_string() end,
        "n",
        desc = "[S]earch current [W]ord"
      }, {
        "<leader>sr",
        function() require("telescope.builtin").resume() end,
        "n",
        desc = "[S]earch [R]esume"
      }, {
        "<leader>sd",
        function() require('telescope.builtin').diagnostics() end,
        desc = "[S]earch [D]iagnostics"
      }, {
        "<leader>sGb",
        function() require('telescope.builtin').git_status() end,
        desc = "[S]earch [G]it [S]tatus"
      }, {
        "<leader>sGb",
        function() require('telescope.builtin').git_branches() end,
        desc = "[S]earch [G]it [B]ranches"
      }, {
        "<leader>sGc",
        function() require('telescope.builtin').git_commits() end,
        desc = "[S]earch [G]it [C]ommits"
      }
    }
  }, {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = vim.fn.argc() == 0 or
      vim.fn.isdirectory(vim.fn.getcwd() .. "/" .. vim.fn.argv(-1)[1]) == 0,
    init = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
    end,
    opts = {
      on_attach = nil,
      sort = { sorter = "case_sensitive" },
      view = { width = 30 },
      renderer = { group_empty = true },
      filters = { dotfiles = false, git_ignored = false }
    },
    keys = {
      {
        "<leader>ee",
        function() vim.cmd("NvimTreeToggle") end,
        "n",
        desc = "Toggle Nvim Tree"
      }, {
        "<leader>ef",
        function() vim.cmd("NvimTreeFindFileToggle") end,
        "n",
        desc = "Toggle Nvim Tree Find File"
      }, {
        "<leader>ec",
        function() vim.cmd("NvimTreeCollapse") end,
        "n",
        desc = "Collapse File Explorer"
      }, {
        "<leader>er",
        function() vim.cmd("NvimTreeRefresh") end,
        "n",
        desc = "Refresh File Explorer"
      }
    }
  }, {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPost",
    opts = {
      signs = {
        add = { text = '┃' },
        change = { text = '┃' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
        untracked = { text = '┆' }
      },
      signs_staged = {
        add = { text = '┃' },
        change = { text = '┃' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
        untracked = { text = '┆' }
      },
      signs_staged_enable = true,
      signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
      numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
      linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
      word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
      watch_gitdir = { follow_files = true },
      auto_attach = true,
      attach_to_untracked = false,
      current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false,
        virt_text_priority = 100,
        use_focus = true
      },
      current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
      sign_priority = 6,
      update_debounce = 100,
      status_formatter = nil, -- Use default
      max_file_length = 40000, -- Disable if file is longer than this (in lines)
      preview_config = {
        -- Options passed to nvim_open_win
        style = 'minimal',
        relative = 'cursor',
        row = 0,
        col = 1
      }
    }
  }, {
    "folke/which-key.nvim",
    dependencies = { "echasnovski/mini.icons", "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "<leader>?",
        function() require("which-key").show({ global = false }) end,
        desc = "Buffer Local Keymaps (which-key)"
      }
    }
  }
}
