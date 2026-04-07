-- TypeScript/JavaScript language support

return {
  -- TypeScript tools (enhanced ts_ls)
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    opts = {
      settings = {
        separate_diagnostic_server = true,
        publish_diagnostic_on = "insert_leave",
        expose_as_code_action = { "fix_all", "add_missing_imports", "remove_unused" },
        tsserver_path = nil,
        tsserver_plugins = {},
        tsserver_max_memory = "auto",
        tsserver_format_options = {},
        tsserver_file_preferences = {
          includeInlayParameterNameHints = "all",
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
          includeCompletionsForModuleExports = true,
          quotePreference = "auto",
        },
        tsserver_locale = "en",
        complete_function_calls = true,
        include_completions_with_insert_text = true,
        code_lens = "off",
        disable_member_code_lens = true,
        jsx_close_tag = {
          enable = true,
          filetypes = { "javascriptreact", "typescriptreact" },
        },
      },
    },
    keys = {
      { "<leader>to", "<cmd>TSToolsOrganizeImports<cr>", ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" }, desc = "Organize imports" },
      { "<leader>ts", "<cmd>TSToolsSortImports<cr>", ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" }, desc = "Sort imports" },
      { "<leader>tu", "<cmd>TSToolsRemoveUnused<cr>", ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" }, desc = "Remove unused" },
      { "<leader>td", "<cmd>TSToolsGoToSourceDefinition<cr>", ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" }, desc = "Go to source definition" },
      { "<leader>tr", "<cmd>TSToolsRenameFile<cr>", ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" }, desc = "Rename file" },
      { "<leader>ti", "<cmd>TSToolsAddMissingImports<cr>", ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" }, desc = "Add missing imports" },
      { "<leader>tf", "<cmd>TSToolsFixAll<cr>", ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" }, desc = "Fix all" },
    },
  },

  -- Package.json support
  {
    "vuki656/package-info.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    event = { "BufRead package.json" },
    opts = {
      colors = {
        up_to_date = "#3C4048",
        outdated = "#d19a66",
      },
      icons = {
        enable = true,
        style = {
          up_to_date = "|  ",
          outdated = "|  ",
        },
      },
      autostart = true,
      hide_up_to_date = false,
      hide_unstable_versions = false,
    },
    keys = {
      { "<leader>ns", function() require("package-info").show() end, desc = "Show package info" },
      { "<leader>nc", function() require("package-info").hide() end, desc = "Hide package info" },
      { "<leader>nu", function() require("package-info").update() end, desc = "Update package" },
      { "<leader>nd", function() require("package-info").delete() end, desc = "Delete package" },
      { "<leader>ni", function() require("package-info").install() end, desc = "Install package" },
      { "<leader>np", function() require("package-info").change_version() end, desc = "Change version" },
    },
  },

  -- Additional treesitter parsers (installed via treesitter.lua wanted list + jsdoc)
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    config = function()
      -- jsdoc is not in the main wanted list, install here
      local ts = require("nvim-treesitter")
      local installed = ts.installed_parsers and ts.installed_parsers() or {}
      if not vim.tbl_contains(installed, "jsdoc") then
        ts.install({ "jsdoc" })
      end
    end,
  },
}
