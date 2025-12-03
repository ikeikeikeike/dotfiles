-- UI plugins: colorscheme, statusline, indent guides

return {
  -- Colorscheme: tokyonight
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "night",
      transparent = false,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
      },
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd.colorscheme("tokyonight-night")
    end,
  },

  -- Statusline: lualine
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    opts = {
      options = {
        theme = "tokyonight",
        globalstatus = true,
        disabled_filetypes = { statusline = { "dashboard", "lazy" } },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = {
          { "filename", path = 1 },
        },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { { "filename", path = 1 } },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      extensions = { "fugitive", "lazy", "quickfix" },
    },
  },

  -- Indent guides
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    main = "ibl",
    opts = {
      indent = {
        char = "│",
        tab_char = "│",
      },
      scope = {
        enabled = true,
        show_start = false,
        show_end = false,
      },
      exclude = {
        filetypes = {
          "help",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "dashboard",
        },
      },
    },
  },

  -- Icons (dependency for many plugins)
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
    opts = {
      default = true,  -- Use default icon when specific icon not found
      strict = true,
      override_by_extension = {
        ["go"] = { icon = "Go", name = "Go" },
        ["py"] = { icon = "Py", name = "Python" },
        ["rb"] = { icon = "Rb", name = "Ruby" },
        ["rs"] = { icon = "Rs", name = "Rust" },
        ["ts"] = { icon = "TS", name = "TypeScript" },
        ["js"] = { icon = "JS", name = "JavaScript" },
        ["lua"] = { icon = "Lu", name = "Lua" },
        ["md"] = { icon = "Md", name = "Markdown" },
        ["json"] = { icon = "Js", name = "JSON" },
        ["yaml"] = { icon = "Ym", name = "YAML" },
        ["yml"] = { icon = "Ym", name = "YAML" },
        ["sh"] = { icon = "Sh", name = "Shell" },
        ["bash"] = { icon = "Sh", name = "Bash" },
        ["toml"] = { icon = "Tm", name = "TOML" },
      },
    },
  },

  -- Better UI components
  {
    "stevearc/dressing.nvim",
    lazy = true,
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.select(...)
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.input = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.input(...)
      end
    end,
  },

  -- Notifications
  {
    "rcarriga/nvim-notify",
    keys = {
      {
        "<leader>un",
        function()
          require("notify").dismiss({ silent = true, pending = true })
        end,
        desc = "Dismiss all notifications",
      },
    },
    opts = {
      timeout = 3000,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
      on_open = function(win)
        vim.api.nvim_win_set_config(win, { zindex = 100 })
      end,
    },
    init = function()
      vim.notify = function(...)
        return require("notify")(...)
      end
    end,
  },
}
