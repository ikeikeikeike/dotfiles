-- Ruby language support

return {
  -- vim-rails: Rails development
  {
    "tpope/vim-rails",
    ft = { "ruby", "eruby", "haml", "slim" },
    cmd = {
      "Rails",
      "Rake",
      "A",
      "R",
      "Emodel",
      "Eview",
      "Econtroller",
      "Emigration",
      "Eschema",
    },
    keys = {
      { "<leader>ra", "<cmd>A<cr>", ft = { "ruby", "eruby" }, desc = "Rails alternate" },
      { "<leader>rr", "<cmd>R<cr>", ft = { "ruby", "eruby" }, desc = "Rails related" },
      { "<leader>rm", "<cmd>Emodel<cr>", ft = { "ruby", "eruby" }, desc = "Rails model" },
      { "<leader>rv", "<cmd>Eview<cr>", ft = { "ruby", "eruby" }, desc = "Rails view" },
      { "<leader>rc", "<cmd>Econtroller<cr>", ft = { "ruby", "eruby" }, desc = "Rails controller" },
    },
  },

  -- vim-ruby: Ruby syntax and indentation
  {
    "vim-ruby/vim-ruby",
    ft = { "ruby", "eruby" },
  },

  -- Endwise: auto-add end keywords
  {
    "RRethy/nvim-treesitter-endwise",
    ft = { "ruby", "lua", "elixir", "bash" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("nvim-treesitter.configs").setup({
        endwise = {
          enable = true,
        },
      })
    end,
  },

  -- Additional treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, {
          "ruby",
          "embedded_template",
        })
      end
    end,
  },

  -- Neotest adapter for RSpec
  {
    "olimorris/neotest-rspec",
    ft = "ruby",
  },
}
