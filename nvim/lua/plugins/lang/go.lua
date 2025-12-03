-- Go language support

return {
  -- Go development plugin
  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    ft = { "go", "gomod", "gosum", "gowork", "gotmpl" },
    build = ':lua require("go.install").update_all_sync()',
    opts = {
      -- LSP settings (gopls is configured in lsp.lua, but we can override here)
      lsp_cfg = false, -- we handle LSP in lsp.lua
      lsp_gofumpt = true,
      lsp_on_attach = false,

      -- Formatting
      lsp_keymaps = false, -- we set keymaps in lsp.lua
      lsp_codelens = true,
      lsp_inlay_hints = {
        enable = true,
      },

      -- Diagnostics
      diagnostic = {
        hdlr = true,
        underline = true,
        virtual_text = { spacing = 2, prefix = "●" },
        signs = true,
        update_in_insert = false,
      },

      -- Test
      test_runner = "go",
      run_in_floaterm = false,
      floaterm = {
        position = "bottom",
        width = 0.8,
        height = 0.4,
      },

      -- Tags
      tag_transform = false,
      tag_options = "json=omitempty",

      -- Icons
      icons = { breakpoint = "🔴", currentpos = "👉" },

      -- Misc
      verbose = false,
      log_path = vim.fn.stdpath("cache") .. "/gonvim.log",
      trouble = true,
      luasnip = true,
    },
    config = function(_, opts)
      require("go").setup(opts)

      -- Format on save
      local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.go",
        callback = function()
          require("go.format").goimports()
        end,
        group = format_sync_grp,
      })
    end,
    keys = {
      -- Test
      { "<leader>gt", "<cmd>GoTest<cr>", ft = "go", desc = "Go test" },
      { "<leader>gT", "<cmd>GoTestFunc<cr>", ft = "go", desc = "Go test function" },
      { "<leader>gC", "<cmd>GoCoverage<cr>", ft = "go", desc = "Go coverage" },

      -- Code generation
      { "<leader>gi", "<cmd>GoImpl<cr>", ft = "go", desc = "Go implement interface" },
      { "<leader>gf", "<cmd>GoFillStruct<cr>", ft = "go", desc = "Go fill struct" },
      { "<leader>ge", "<cmd>GoIfErr<cr>", ft = "go", desc = "Go if err" },
      { "<leader>ga", "<cmd>GoAddTag<cr>", ft = "go", desc = "Go add tags" },
      { "<leader>gA", "<cmd>GoRmTag<cr>", ft = "go", desc = "Go remove tags" },

      -- Debug
      { "<leader>gd", "<cmd>GoDebug<cr>", ft = "go", desc = "Go debug" },
      { "<leader>gD", "<cmd>GoDbgStop<cr>", ft = "go", desc = "Go debug stop" },

      -- Misc
      { "<leader>gr", "<cmd>GoRun<cr>", ft = "go", desc = "Go run" },
      { "<leader>gm", "<cmd>GoModTidy<cr>", ft = "go", desc = "Go mod tidy" },
    },
  },

  -- Go test highlighting
  {
    "nvim-neotest/neotest-go",
    ft = "go",
  },
}
