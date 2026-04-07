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

  -- Additional treesitter parsers (installed via treesitter.lua wanted list + rst)
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    config = function()
      -- rst is not in the main wanted list, install here
      local ts = require("nvim-treesitter")
      local installed = ts.installed_parsers and ts.installed_parsers() or {}
      if not vim.tbl_contains(installed, "rst") then
        ts.install({ "rst" })
      end
    end,
  },
}
