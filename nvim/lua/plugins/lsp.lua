-- LSP Configuration for Neovim 0.11+
-- Uses vim.lsp.config (native API) + mason for LSP server management

return {
  -- Mason: LSP server installer
  {
    "mason-org/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    opts = {
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    },
  },

  -- Mason-lspconfig: bridge between mason and lspconfig
  {
    "mason-org/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason-org/mason.nvim",
    },
    opts = {
      -- Only include LSPs that can be installed without npm/go/gem
      -- These are downloaded as pre-built binaries
      ensure_installed = {
        "lua_ls",        -- Downloaded binary
        "rust_analyzer", -- Downloaded binary
        "terraformls",   -- Downloaded binary
        -- The following require npm/go/gem which are not in PATH:
        -- "gopls",       -- requires: go
        -- "pyright",     -- requires: npm
        -- "ruby_lsp",    -- requires: gem + Ruby 3.1+
        -- "ts_ls",       -- requires: npm
        -- "html",        -- requires: npm
        -- "cssls",       -- requires: npm
        -- "jsonls",      -- requires: npm
        -- "yamlls",      -- requires: npm
        -- "bashls",      -- requires: npm
        -- "dockerls",    -- requires: npm
      },
      -- Disable automatic installation to prevent repeated errors
      automatic_installation = false,
    },
    config = function(_, opts)
      require("mason-lspconfig").setup(opts)

      -- Diagnostic settings
      vim.diagnostic.config({
        virtual_text = {
          prefix = "●",
          source = "if_many",
        },
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
          border = "rounded",
          source = "always",
        },
      })

      -- Diagnostic signs
      local signs = { Error = " ", Warn = " ", Hint = "󰌵 ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end

      -- LSP keymaps (set on LspAttach)
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          local opts_keymap = { buffer = ev.buf, silent = true }

          -- Navigation
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", opts_keymap, { desc = "Go to declaration" }))
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts_keymap, { desc = "Go to definition" }))
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, vim.tbl_extend("force", opts_keymap, { desc = "Go to implementation" }))
          vim.keymap.set("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts_keymap, { desc = "Show references" }))
          vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, vim.tbl_extend("force", opts_keymap, { desc = "Go to type definition" }))

          -- Legacy keymaps (matching your previous config)
          vim.keymap.set("n", "<C-]>", vim.lsp.buf.definition, vim.tbl_extend("force", opts_keymap, { desc = "Go to definition" }))
          vim.keymap.set("n", "<C-\\>", function()
            vim.cmd("vsplit")
            vim.lsp.buf.definition()
          end, vim.tbl_extend("force", opts_keymap, { desc = "Go to definition (vsplit)" }))
          vim.keymap.set("n", "<Leader>\\", vim.lsp.buf.references, vim.tbl_extend("force", opts_keymap, { desc = "Show references" }))
          vim.keymap.set("n", "<Leader>]", vim.lsp.buf.type_definition, vim.tbl_extend("force", opts_keymap, { desc = "Go to type definition" }))

          -- Hover and signature
          vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts_keymap, { desc = "Hover documentation" }))
          vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, vim.tbl_extend("force", opts_keymap, { desc = "Signature help" }))

          -- Actions
          vim.keymap.set("n", "<Leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts_keymap, { desc = "Rename symbol" }))
          vim.keymap.set({ "n", "v" }, "<Leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts_keymap, { desc = "Code action" }))
          vim.keymap.set("n", "<Leader>f", function()
            vim.lsp.buf.format({ async = true })
          end, vim.tbl_extend("force", opts_keymap, { desc = "Format buffer" }))

          -- Diagnostics
          vim.keymap.set("n", "<Leader>e", vim.diagnostic.open_float, vim.tbl_extend("force", opts_keymap, { desc = "Show diagnostic" }))
          vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, vim.tbl_extend("force", opts_keymap, { desc = "Previous diagnostic" }))
          vim.keymap.set("n", "]d", vim.diagnostic.goto_next, vim.tbl_extend("force", opts_keymap, { desc = "Next diagnostic" }))
          vim.keymap.set("n", "<Leader>q", vim.diagnostic.setloclist, vim.tbl_extend("force", opts_keymap, { desc = "Diagnostic list" }))

          -- Workspace
          vim.keymap.set("n", "<Leader>wa", vim.lsp.buf.add_workspace_folder, vim.tbl_extend("force", opts_keymap, { desc = "Add workspace folder" }))
          vim.keymap.set("n", "<Leader>wr", vim.lsp.buf.remove_workspace_folder, vim.tbl_extend("force", opts_keymap, { desc = "Remove workspace folder" }))
          vim.keymap.set("n", "<Leader>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, vim.tbl_extend("force", opts_keymap, { desc = "List workspace folders" }))
        end,
      })

      -- Get capabilities (with blink.cmp if available)
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local ok, blink = pcall(require, "blink.cmp")
      if ok then
        capabilities = blink.get_lsp_capabilities(capabilities)
      end

      -- Configure LSP servers using Neovim 0.11 native API
      -- Lua
      vim.lsp.config.lua_ls = {
        cmd = { "lua-language-server" },
        filetypes = { "lua" },
        root_markers = { ".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml", "stylua.toml", "selene.toml", "selene.yml", ".git" },
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = { enable = false },
          },
        },
        capabilities = capabilities,
      }

      -- Go
      vim.lsp.config.gopls = {
        cmd = { "gopls" },
        filetypes = { "go", "gomod", "gowork", "gotmpl" },
        root_markers = { "go.work", "go.mod", ".git" },
        settings = {
          gopls = {
            analyses = { unusedparams = true },
            staticcheck = true,
            gofumpt = true,
          },
        },
        capabilities = capabilities,
      }

      -- Python
      vim.lsp.config.pyright = {
        cmd = { "pyright-langserver", "--stdio" },
        filetypes = { "python" },
        root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile", "pyrightconfig.json", ".git" },
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "basic",
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
            },
          },
        },
        capabilities = capabilities,
      }

      -- Ruby
      vim.lsp.config.ruby_lsp = {
        cmd = { "ruby-lsp" },
        filetypes = { "ruby", "eruby" },
        root_markers = { "Gemfile", ".git" },
        capabilities = capabilities,
      }

      -- Rust (basic, rustaceanvim handles the full setup)
      vim.lsp.config.rust_analyzer = {
        cmd = { "rust-analyzer" },
        filetypes = { "rust" },
        root_markers = { "Cargo.toml", ".git" },
        settings = {
          ["rust-analyzer"] = {
            checkOnSave = { command = "clippy" },
          },
        },
        capabilities = capabilities,
      }

      -- TypeScript/JavaScript
      vim.lsp.config.ts_ls = {
        cmd = { "typescript-language-server", "--stdio" },
        filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
        root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
        settings = {
          typescript = {
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
            },
          },
          javascript = {
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
            },
          },
        },
        capabilities = capabilities,
      }

      -- Simple servers
      local simple_servers = {
        html = { filetypes = { "html" }, root_markers = { ".git" } },
        cssls = { filetypes = { "css", "scss", "less" }, root_markers = { ".git" } },
        jsonls = { filetypes = { "json", "jsonc" }, root_markers = { ".git" } },
        yamlls = { filetypes = { "yaml", "yaml.docker-compose" }, root_markers = { ".git" } },
        bashls = { filetypes = { "sh", "bash" }, root_markers = { ".git" } },
        dockerls = { filetypes = { "dockerfile" }, root_markers = { ".git" } },
        terraformls = { filetypes = { "terraform", "terraform-vars" }, root_markers = { ".terraform", ".git" } },
      }

      for server, config in pairs(simple_servers) do
        vim.lsp.config[server] = vim.tbl_extend("force", {
          capabilities = capabilities,
        }, config)
      end

      -- Enable only servers that are installed (pre-built binaries)
      -- Other servers will be enabled when you install npm/go/gem and run :MasonInstall
      vim.lsp.enable({
        "lua_ls",
        "rust_analyzer",
        "terraformls",
        -- Uncomment these after installing npm/go/gem and running :MasonInstall <server>
        -- "gopls",
        -- "pyright",
        "ruby_lsp",
        -- "ts_ls",
        -- "html",
        -- "cssls",
        -- "jsonls",
        -- "yamlls",
        -- "bashls",
        -- "dockerls",
      })
    end,
  },

  -- Trouble: better diagnostics list
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "Trouble", "TroubleToggle" },
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
      { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
      { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
      { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
    },
    opts = {},
  },
}
