-- Treesitter: syntax highlighting, text objects, and more

return {
  -- Treesitter (main branch — required for Neovim 0.12+)
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    version = false,
    lazy = false,
    build = ":TSUpdate",
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall", "TSUninstall" },
    config = function()
      local ts = require("nvim-treesitter")
      ts.setup({})

      -- Install parsers (replaces ensure_installed)
      local wanted = {
        -- Core
        "lua", "vim", "vimdoc", "query", "regex",
        -- Languages
        "go", "gomod", "gosum", "python", "ruby", "rust",
        "typescript", "tsx", "javascript", "elixir", "dart",
        -- Web
        "html", "css", "scss", "vue",
        -- Data/Config
        "json", "yaml", "toml", "dockerfile", "terraform",
        -- Shell
        "bash",
        -- Markup
        "markdown", "markdown_inline",
      }
      local installed = ts.installed_parsers and ts.installed_parsers() or {}
      local to_install = vim.iter(wanted)
        :filter(function(p) return not vim.tbl_contains(installed, p) end)
        :totable()
      if #to_install > 0 then
        ts.install(to_install)
      end

      -- Enable highlighting and indentation
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("treesitter_features", { clear = true }),
        callback = function()
          pcall(vim.treesitter.start)
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })

      -- Incremental selection (Neovim 0.12 built-in)
      vim.keymap.set("n", "<C-space>", function()
        vim.cmd("normal! v")
        require("vim.treesitter._select").select_parent(1)
      end, { desc = "Init treesitter selection" })
      vim.keymap.set({ "x", "o" }, "<C-space>", function()
        require("vim.treesitter._select").select_parent(vim.v.count1)
      end, { desc = "Expand treesitter selection" })
      vim.keymap.set("x", "<bs>", function()
        require("vim.treesitter._select").select_child(vim.v.count1)
      end, { desc = "Shrink treesitter selection" })
    end,
  },

  -- Textobjects (main branch)
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    event = "VeryLazy",
    config = function()
      require("nvim-treesitter-textobjects").setup({
        select = { lookahead = true },
        move = { set_jumps = true },
      })

      -- Select keymaps
      local sel = require("nvim-treesitter-textobjects.select")
      for key, query in pairs({
        ["af"] = "@function.outer", ["if"] = "@function.inner",
        ["ac"] = "@class.outer",    ["ic"] = "@class.inner",
        ["aa"] = "@parameter.outer", ["ia"] = "@parameter.inner",
        ["ai"] = "@conditional.outer", ["ii"] = "@conditional.inner",
        ["al"] = "@loop.outer",     ["il"] = "@loop.inner",
      }) do
        vim.keymap.set({ "x", "o" }, key, function()
          sel.select_textobject(query, "textobjects")
        end)
      end

      -- Move keymaps
      local move = require("nvim-treesitter-textobjects.move")
      for method, keymaps in pairs({
        goto_next_start     = { ["]f"] = "@function.outer", ["]c"] = "@class.outer", ["]a"] = "@parameter.inner" },
        goto_next_end       = { ["]F"] = "@function.outer", ["]C"] = "@class.outer" },
        goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer", ["[a"] = "@parameter.inner" },
        goto_previous_end   = { ["[F"] = "@function.outer", ["[C"] = "@class.outer" },
      }) do
        for key, query in pairs(keymaps) do
          vim.keymap.set({ "n", "x", "o" }, key, function()
            move[method](query, "textobjects")
          end)
        end
      end

      -- Swap keymaps
      local swap = require("nvim-treesitter-textobjects.swap")
      vim.keymap.set("n", "<leader>a", function()
        swap.swap_next("@parameter.inner")
      end, { desc = "Swap next parameter" })
      vim.keymap.set("n", "<leader>A", function()
        swap.swap_previous("@parameter.inner")
      end, { desc = "Swap prev parameter" })
    end,
  },

  -- Show context of current function
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      enable = true,
      max_lines = 3,
      min_window_height = 0,
      line_numbers = true,
      multiline_threshold = 20,
      trim_scope = "outer",
      mode = "cursor",
    },
  },
}
