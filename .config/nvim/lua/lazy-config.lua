-- lazy.nvim configuration
require("lazy").setup({
  -- Package manager itself
  { "folke/lazy.nvim" },

  -- Modern completion framework
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
    },
    config = function()
      local cmp = require('cmp')
      local luasnip = require('luasnip')
      
      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        }),
        sources = cmp.config.sources({
          { name = 'copilot', group_index = 2 },
          { name = 'nvim_lsp', group_index = 2 },
          { name = 'luasnip', group_index = 2 },
        }, {
          { name = 'buffer' },
          { name = 'path' },
        }),
        experimental = {
          ghost_text = false, -- Disable ghost text to avoid conflict with Copilot
        },
      })

      -- Use buffer source for `/` and `?`
      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })

      -- Use cmdline & path source for ':'
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          { name = 'cmdline' }
        })
      })
    end,
  },

  -- Automatic LSP server installation
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup()
    end,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
    },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "pyright",
          "ts_ls",
          -- "gopls", -- Excluded due to special Go environment setup
          "rust_analyzer",
          "lua_ls",
        },
        automatic_installation = {
          exclude = { "gopls" }, -- Don't auto-install gopls
        },
      })
    end,
  },

  -- LSP Configuration
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      local lspconfig = require('lspconfig')
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      
      -- Setup LSP servers
      local servers = { "pyright", "ts_ls", "gopls", "rust_analyzer", "lua_ls" }
      
      for _, server in ipairs(servers) do
        local opts = {
          capabilities = capabilities,
        }
        
        -- Custom settings for specific servers
        if server == "lua_ls" then
          opts.settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" },
              },
              workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
              },
              telemetry = {
                enable = false,
              },
            },
          }
        end
        
        lspconfig[server].setup(opts)
      end
      
      -- Global mappings
      vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
      vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)
      
      -- Use LspAttach autocommand to only map after LSP attaches
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          local opts = { buffer = ev.buf }
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
          vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
          vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
          vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
          vim.keymap.set('n', '<space>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, opts)
          vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
          vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
          vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
          vim.keymap.set('n', '<space>f', function()
            vim.lsp.buf.format { async = true }
          end, opts)
        end,
      })
    end,
  },

  -- Language specific plugins
  {
    "posva/vim-vue",
    ft = "vue",
  },

  { "lighttiger2505/sqls.vim" },


  -- Modern Copilot integration for Neovim
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        panel = {
          enabled = true,
          auto_refresh = false,
          keymap = {
            jump_prev = "[[",
            jump_next = "]]",
            accept = "<CR>",
            refresh = "gr",
            open = "<M-CR>"
          },
          layout = {
            position = "bottom", -- | top | left | right
            ratio = 0.4
          },
        },
        suggestion = {
          enabled = false, -- Disable suggestion mode since we're using copilot-cmp
          auto_trigger = false,
        },
        filetypes = {
          yaml = false,
          markdown = false,
          help = false,
          gitcommit = false,
          gitrebase = false,
          hgcommit = false,
          svn = false,
          cvs = false,
          ["."] = false,
        },
        copilot_node_command = 'node', -- Node.js version must be > 16.x
        server_opts_overrides = {},
      })
    end,
  },

  -- Copilot integration with nvim-cmp
  {
    "zbirenbaum/copilot-cmp",
    dependencies = { "zbirenbaum/copilot.lua" },
    config = function()
      require("copilot_cmp").setup()
    end,
  },

  {
    "justinmk/vim-dirvish",
    config = function()
      vim.api.nvim_set_keymap('n', '<C-f>', '<Plug>(dirvish_up)', { silent = true })
    end,
  },

  -- Terraform
  {
    "hashivim/vim-terraform",
    ft = "terraform",
    config = function()
      vim.g.terraform_align = 1
      vim.g.terraform_fmt_on_save = 1
    end,
  },

  -- Dart/Flutter
  {
    "dart-lang/dart-vim-plugin",
    ft = "dart",
  },

  {
    "thosakwe/vim-flutter",
    ft = "dart",
    dependencies = { "dart-lang/dart-vim-plugin" },
  },

  -- Django
  {
    "tweekmonster/django-plus.vim",
    ft = "django",
  },

  {
    "vim-scripts/django.vim",
    ft = "django",
  },

  -- Slim
  {
    "slim-template/vim-slim",
    ft = "slim",
  },

  -- Ruby/Rails
  {
    "tpope/vim-rails",
    ft = "ruby",
  },

  {
    "vim-ruby/vim-ruby",
    ft = "ruby",
    config = function()
      vim.g.rubycomplete_rails = 1
      vim.g.rubycomplete_buffer_loading = 1
      vim.g.rubycomplete_classes_in_global = 1
      vim.g.rubycomplete_include_object = 1
      vim.g.rubycomplete_include_object_space = 1
    end,
  },

  -- Elixir
  {
    "elixir-editors/vim-elixir",
    ft = "elixir",
  },

  {
    "slashmili/alchemist.vim",
    ft = "elixir",
  },

  -- TOML & Nginx
  {
    "cespare/vim-toml",
    ft = "toml",
  },

  {
    "chr4/nginx.vim",
    ft = "nginx",
  },

  -- Go
  {
    "fatih/vim-go",
    ft = "go",
    config = function()
      vim.opt.completeopt = "menu,preview"
      vim.g.go_fmt_autosave = 1
      vim.g.go_fmt_command = "goimports"
      vim.g.go_def_mode = 'gopls'
      vim.g.go_highlight_functions = 1
      vim.g.go_highlight_methods = 1
      vim.g.go_highlight_structs = 1
      vim.g.go_highlight_operators = 1
      vim.g.go_highlight_build_constraints = 1
    end,
  },

  {
    "dgryski/vim-godef",
    ft = "go",
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "go",
        callback = function()
          vim.api.nvim_buf_set_keymap(0, 'n', '<C-\\>', '<Plug>(go-def-vertical)', {})
          vim.api.nvim_buf_set_keymap(0, 'n', '<C-]>', '<Plug>(go-def)', {})
        end,
      })
    end,
  },

  {
    "vim-jp/vim-go-extra",
    ft = "go",
  },

  -- Polyglot
  { "sheerun/vim-polyglot" },

  -- Context filetype
  { "Shougo/context_filetype.vim" },

  -- Color schemes
  { "vim-scripts/Colour-Sampler-Pack" },

  {
    "joshdick/onedark.vim",
    dependencies = { "vim-scripts/Colour-Sampler-Pack" },
  },

  -- Airline
  {
    "vim-airline/vim-airline",
    dependencies = { "vim-airline/vim-airline-themes" },
    config = function()
      vim.g["airline#extensions#tabline#enabled"] = 0
      vim.g.airline_theme = 'angr'
    end,
  },

  { "vim-airline/vim-airline-themes" },

  -- Undo tree
  {
    "simnalamburt/vim-mundo",
    config = function()
      vim.g.mundo_right = 1
    end,
  },

  -- ALE (Asynchronous Lint Engine)
  {
    "dense-analysis/ale",
    config = function()
      vim.g.ale_linters = {
        python = {'flake8', 'pylint', 'pep8', 'pyflakes'},
      }
      vim.g.ale_fixers = {
        python = {'autopep8', 'black', 'isort'},
      }
      vim.g.ale_ruby_rubocop_options = '--except Style/AsciiComments,Metrics/LineLength,Style/StringLiterals,Metrics/MethodLength,Metrics/AbcSize,Style/SpaceInsideBlockBraces,Metrics/ParameterLists,Style/FrozenStringLiteralComment,Layout/SpaceInsideHashLiteralBraces,Style/StringLiteralsInInterpolation,Style/StringLiteralsInInterpolation,Metrics/PerceivedComplexity,Metrics/CyclomaticComplexity'
      
      vim.g.ale_python_pylint_executable = vim.g.python3_host_prog
      vim.g.ale_python_flake8_executable = vim.g.python3_host_prog
      vim.g.ale_python_flake8_options = '-m flake8 --ignore=E501'
      vim.g.ale_python_autopep8_executable = vim.g.python3_host_prog
      vim.g.ale_python_autopep8_options = '-m autopep8'
      vim.g.ale_python_isort_executable = vim.g.python3_host_prog
      vim.g.ale_python_isort_options = '-m isort'
      vim.g.ale_python_black_executable = vim.g.python3_host_prog
      vim.g.ale_python_black_options = '-m black'
      
      vim.g.ale_fix_on_save = 1
      vim.g.ale_lint_on_save = 1
      vim.g["airline#extensions#ale#enabled"] = 1
    end,
  },

  -- FZF
  {
    "junegunn/fzf",
    build = "./install --all",
  },

  {
    "junegunn/fzf.vim",
    dependencies = { "junegunn/fzf" },
  },

  {
    "zackhsi/fzf-tags",
    dependencies = { "junegunn/fzf.vim" },
  },

  -- Tpope plugins
  { "tpope/vim-surround" },
  { "tpope/vim-repeat" },
  { "tpope/vim-fugitive" },

  {
    "tpope/vim-endwise",
    event = "InsertEnter",
  },

  -- DirDiff
  { "vim-scripts/DirDiff.vim" },

  -- Smart input
  {
    "kana/vim-smartinput",
    event = "InsertEnter",
    config = function()
      vim.g.smartinput_no_default_key_mappings = 1
      -- ERB configuration
      vim.cmd([[
        call smartinput#map_to_trigger('i', '%', '%', '%')
        call smartinput#define_rule({
        \   'at': '<\%#', 'char': '%', 'input': '%=  %><Left><Left><Left>',
        \   'filetype': ['eruby', 'eelixir'],
        \ })
        call smartinput#define_rule({
        \   'at': '%.*\%#%', 'char': '%', 'input': '',
        \   'filetype': ['eruby', 'eelixir'],
        \ })
      ]])
    end,
  },

  -- Modern snippet engine (already included as nvim-cmp dependency)
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "rafamadriz/friendly-snippets", -- Collection of snippets
    },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
      -- Load custom snippets if you have any
      -- require("luasnip.loaders.from_snipmate").lazy_load({paths = "~/.vim/snippets"})
    end,
  },

  -- Comment
  { "tomtom/tcomment_vim" },

  -- Rust
  {
    "rust-lang/rust.vim",
    ft = "rust",
    config = function()
      vim.g.rustfmt_autosave = 1
      vim.g.rust_clip_command = 'xclip -selection clipboard'
    end,
  },

  -- Pine Script
  { "pinecoders/vim-pine-script" },

  -- Build vimproc
  {
    "Shougo/vimproc.vim",
    build = "make",
  },
})