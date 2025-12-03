-- Key mappings
-- Migrated from general-move.vim, general-search.vim, dein.vim

local map = vim.keymap.set

-- =============================================================================
-- Better movement (visual lines)
-- =============================================================================
-- j/k moves by visual line (wrapped lines)
map({ "n", "v" }, "j", "gj", { silent = true, desc = "Move down (visual line)" })
map({ "n", "v" }, "k", "gk", { silent = true, desc = "Move up (visual line)" })
map({ "n", "v" }, "gj", "j", { silent = true, desc = "Move down (actual line)" })
map({ "n", "v" }, "gk", "k", { silent = true, desc = "Move up (actual line)" })
map({ "n", "v" }, "$", "g$", { silent = true, desc = "End of visual line" })
map({ "n", "v" }, "g$", "$", { silent = true, desc = "End of actual line" })

-- =============================================================================
-- Center after search/jump
-- =============================================================================
map("n", "n", "nzz", { desc = "Next search result (centered)" })
map("n", "N", "Nzz", { desc = "Previous search result (centered)" })
map("n", "*", "*zz", { desc = "Search word under cursor (centered)" })
map("n", "#", "#zz", { desc = "Search word under cursor backward (centered)" })
map("n", "g*", "g*zz", { desc = "Search partial word (centered)" })
map("n", "g#", "g#zz", { desc = "Search partial word backward (centered)" })
map("n", "G", "Gzz", { desc = "Go to end of file (centered)" })

-- =============================================================================
-- Search
-- =============================================================================
-- Clear search highlight
map("n", "<Esc><Esc>", "<cmd>nohlsearch<CR>", { silent = true, desc = "Clear search highlight" })

-- =============================================================================
-- Window navigation
-- =============================================================================
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- =============================================================================
-- QuickFix toggle
-- =============================================================================
local function toggle_quickfix()
  local qf_exists = false
  for _, win in pairs(vim.fn.getwininfo()) do
    if win.quickfix == 1 then
      qf_exists = true
      break
    end
  end
  if qf_exists then
    vim.cmd("cclose")
  else
    vim.cmd("copen 10")
  end
end

map("n", "<C-c><C-c><C-c>", toggle_quickfix, { silent = true, desc = "Toggle QuickFix" })

-- =============================================================================
-- LSP keymaps (basic, more will be added in lsp.lua)
-- Note: Neovim 0.11 provides default LSP keymaps (grn, gra, grr, gri, gO)
-- =============================================================================
-- These are legacy keymaps, keeping for muscle memory
-- Will be properly set in lsp.lua with actual LSP functions
map("n", "<C-]>", "<cmd>lua vim.lsp.buf.definition()<CR>", { silent = true, desc = "Go to definition" })
map("n", "<C-\\>", "<cmd>vsplit | lua vim.lsp.buf.definition()<CR>", { silent = true, desc = "Go to definition (vsplit)" })
map("n", "<Leader>\\", "<cmd>lua vim.lsp.buf.references()<CR>", { silent = true, desc = "Show references" })
map("n", "<Leader>]", "<cmd>lua vim.lsp.buf.type_definition()<CR>", { silent = true, desc = "Go to type definition" })

-- =============================================================================
-- Better escape
-- =============================================================================
map("i", "jk", "<Esc>", { desc = "Exit insert mode" })
map("i", "jj", "<Esc>", { desc = "Exit insert mode" })

-- =============================================================================
-- Save
-- =============================================================================
map("n", "<Leader>w", "<cmd>w<CR>", { desc = "Save file" })
map("n", "<Leader>q", "<cmd>q<CR>", { desc = "Quit" })
map("n", "<Leader>x", "<cmd>x<CR>", { desc = "Save and quit" })

-- =============================================================================
-- Better indenting (stay in visual mode)
-- =============================================================================
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

-- =============================================================================
-- Move lines
-- =============================================================================
map("n", "<A-j>", "<cmd>m .+1<CR>==", { desc = "Move line down" })
map("n", "<A-k>", "<cmd>m .-2<CR>==", { desc = "Move line up" })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
