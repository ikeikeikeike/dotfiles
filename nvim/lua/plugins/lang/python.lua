-- Python language support

return {
  -- Virtual environment selector
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-telescope/telescope.nvim",
      "mfussenegger/nvim-dap-python",
    },
    branch = "regexp",
    ft = "python",
    keys = {
      { "<leader>pv", "<cmd>VenvSelect<cr>", ft = "python", desc = "Select virtualenv" },
      { "<leader>pV", "<cmd>VenvSelectCached<cr>", ft = "python", desc = "Select cached virtualenv" },
    },
    opts = {
      name = { "venv", ".venv", "env", ".env" },
      auto_refresh = true,
    },
  },

  -- Debug adapter
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = {
      "mfussenegger/nvim-dap",
    },
    config = function()
      local path = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"
      require("dap-python").setup(path)
    end,
    keys = {
      { "<leader>dPt", function() require("dap-python").test_method() end, ft = "python", desc = "Debug test method" },
      { "<leader>dPc", function() require("dap-python").test_class() end, ft = "python", desc = "Debug test class" },
    },
  },

  -- Neotest adapter for pytest
  {
    "nvim-neotest/neotest-python",
    ft = "python",
  },

  -- Additional Python treesitter textobjects
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "python", "rst", "toml" })
      end
    end,
  },
}
