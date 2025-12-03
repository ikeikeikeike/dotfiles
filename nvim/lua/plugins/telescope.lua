-- Telescope: fuzzy finder

return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    version = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function()
          return vim.fn.executable("make") == 1
        end,
      },
    },
    keys = {
      -- Files
      { "<Leader><C-f>", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      { "<Leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      { "<Leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
      { "<Leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent files" },

      -- Buffers (matching your previous <C-b>)
      { "<C-b>", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      { "<Leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },

      -- Search
      { "<Leader>sw", "<cmd>Telescope grep_string<cr>", desc = "Search word under cursor" },
      { "<Leader>ss", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Search in buffer" },

      -- Git
      { "<Leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Git commits" },
      { "<Leader>gs", "<cmd>Telescope git_status<cr>", desc = "Git status" },
      { "<Leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Git branches" },

      -- LSP
      { "<Leader>ls", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document symbols" },
      { "<Leader>lS", "<cmd>Telescope lsp_workspace_symbols<cr>", desc = "Workspace symbols" },
      { "<Leader>ld", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document diagnostics" },
      { "<Leader>lD", "<cmd>Telescope diagnostics<cr>", desc = "Workspace diagnostics" },

      -- Help
      { "<Leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },
      { "<Leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
      { "<Leader>fc", "<cmd>Telescope commands<cr>", desc = "Commands" },

      -- Misc
      { "<Leader>f:", "<cmd>Telescope command_history<cr>", desc = "Command history" },
      { "<Leader>f/", "<cmd>Telescope search_history<cr>", desc = "Search history" },
      { "<Leader>fm", "<cmd>Telescope marks<cr>", desc = "Marks" },
      { "<Leader>fR", "<cmd>Telescope registers<cr>", desc = "Registers" },
    },
    opts = function()
      local actions = require("telescope.actions")

      return {
        defaults = {
          prompt_prefix = " ",
          selection_caret = " ",
          path_display = { "truncate" },
          sorting_strategy = "ascending",
          layout_config = {
            horizontal = {
              prompt_position = "top",
              preview_width = 0.55,
            },
            vertical = {
              mirror = false,
            },
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120,
          },
          mappings = {
            i = {
              ["<C-n>"] = actions.cycle_history_next,
              ["<C-p>"] = actions.cycle_history_prev,
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-c>"] = actions.close,
              ["<CR>"] = actions.select_default,
              ["<C-x>"] = actions.select_horizontal,
              ["<C-v>"] = actions.select_vertical,
              ["<C-t>"] = actions.select_tab,
              ["<C-u>"] = actions.preview_scrolling_up,
              ["<C-d>"] = actions.preview_scrolling_down,
              ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
              ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
              ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
              ["<C-l>"] = actions.complete_tag,
            },
            n = {
              ["<esc>"] = actions.close,
              ["<CR>"] = actions.select_default,
              ["<C-x>"] = actions.select_horizontal,
              ["<C-v>"] = actions.select_vertical,
              ["<C-t>"] = actions.select_tab,
              ["j"] = actions.move_selection_next,
              ["k"] = actions.move_selection_previous,
              ["H"] = actions.move_to_top,
              ["M"] = actions.move_to_middle,
              ["L"] = actions.move_to_bottom,
              ["gg"] = actions.move_to_top,
              ["G"] = actions.move_to_bottom,
              ["<C-u>"] = actions.preview_scrolling_up,
              ["<C-d>"] = actions.preview_scrolling_down,
              ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
              ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
              ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
              ["?"] = actions.which_key,
            },
          },
          file_ignore_patterns = {
            "node_modules",
            ".git/",
            "%.lock",
            "vendor/",
            "__pycache__/",
            "%.pyc",
            ".venv/",
          },
        },
        pickers = {
          find_files = {
            hidden = true,
            find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
          },
          live_grep = {
            additional_args = function()
              return { "--hidden", "--glob", "!**/.git/*" }
            end,
          },
          buffers = {
            show_all_buffers = true,
            sort_lastused = true,
            mappings = {
              i = {
                ["<C-d>"] = actions.delete_buffer,
              },
              n = {
                ["dd"] = actions.delete_buffer,
              },
            },
          },
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
        },
      }
    end,
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)

      -- Load fzf extension if available
      pcall(telescope.load_extension, "fzf")
    end,
  },
}
