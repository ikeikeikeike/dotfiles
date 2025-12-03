-- Rust language support

return {
  -- Rustaceanvim: comprehensive Rust support
  {
    "mrcjkb/rustaceanvim",
    version = "^5",
    ft = { "rust" },
    opts = {
      server = {
        on_attach = function(_, bufnr)
          local opts = { buffer = bufnr, silent = true }

          -- Rust-specific keymaps
          vim.keymap.set("n", "<leader>rd", function()
            vim.cmd.RustLsp("debuggables")
          end, vim.tbl_extend("force", opts, { desc = "Rust debuggables" }))

          vim.keymap.set("n", "<leader>rr", function()
            vim.cmd.RustLsp("runnables")
          end, vim.tbl_extend("force", opts, { desc = "Rust runnables" }))

          vim.keymap.set("n", "<leader>rt", function()
            vim.cmd.RustLsp("testables")
          end, vim.tbl_extend("force", opts, { desc = "Rust testables" }))

          vim.keymap.set("n", "<leader>rm", function()
            vim.cmd.RustLsp("expandMacro")
          end, vim.tbl_extend("force", opts, { desc = "Rust expand macro" }))

          vim.keymap.set("n", "<leader>rc", function()
            vim.cmd.RustLsp("openCargo")
          end, vim.tbl_extend("force", opts, { desc = "Open Cargo.toml" }))

          vim.keymap.set("n", "<leader>rp", function()
            vim.cmd.RustLsp("parentModule")
          end, vim.tbl_extend("force", opts, { desc = "Rust parent module" }))

          vim.keymap.set("n", "<leader>rJ", function()
            vim.cmd.RustLsp("joinLines")
          end, vim.tbl_extend("force", opts, { desc = "Rust join lines" }))

          vim.keymap.set("n", "K", function()
            vim.cmd.RustLsp({ "hover", "actions" })
          end, vim.tbl_extend("force", opts, { desc = "Rust hover actions" }))

          vim.keymap.set("n", "<leader>re", function()
            vim.cmd.RustLsp("explainError")
          end, vim.tbl_extend("force", opts, { desc = "Rust explain error" }))
        end,
        default_settings = {
          ["rust-analyzer"] = {
            cargo = {
              allFeatures = true,
              loadOutDirsFromCheck = true,
              buildScripts = {
                enable = true,
              },
            },
            checkOnSave = {
              command = "clippy",
              extraArgs = { "--no-deps" },
            },
            procMacro = {
              enable = true,
              ignored = {
                ["async-trait"] = { "async_trait" },
                ["napi-derive"] = { "napi" },
                ["async-recursion"] = { "async_recursion" },
              },
            },
            inlayHints = {
              bindingModeHints = { enable = false },
              chainingHints = { enable = true },
              closingBraceHints = { enable = true, minLines = 25 },
              closureReturnTypeHints = { enable = "never" },
              lifetimeElisionHints = { enable = "never", useParameterNames = false },
              maxLength = 25,
              parameterHints = { enable = true },
              reborrowHints = { enable = "never" },
              renderColons = true,
              typeHints = {
                enable = true,
                hideClosureInitialization = false,
                hideNamedConstructor = false,
              },
            },
          },
        },
      },
    },
    config = function(_, opts)
      vim.g.rustaceanvim = vim.tbl_deep_extend("keep", vim.g.rustaceanvim or {}, opts or {})
    end,
  },

  -- Crates.nvim: manage Cargo.toml dependencies
  {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    opts = {
      completion = {
        cmp = { enabled = true },
      },
    },
    keys = {
      { "<leader>rcu", function() require("crates").upgrade_crate() end, desc = "Upgrade crate" },
      { "<leader>rcU", function() require("crates").upgrade_all_crates() end, desc = "Upgrade all crates" },
      { "<leader>rci", function() require("crates").show_crate_popup() end, desc = "Show crate info" },
      { "<leader>rcf", function() require("crates").show_features_popup() end, desc = "Show features" },
      { "<leader>rcd", function() require("crates").show_dependencies_popup() end, desc = "Show dependencies" },
    },
  },
}
