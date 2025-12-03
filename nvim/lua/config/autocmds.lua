-- Autocommands
-- Migrated from general-display.vim and other vim configs

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- =============================================================================
-- Highlight trailing whitespace
-- =============================================================================
augroup("HighlightTrailingSpaces", { clear = true })
autocmd({ "VimEnter", "WinEnter", "ColorScheme" }, {
  group = "HighlightTrailingSpaces",
  callback = function()
    vim.api.nvim_set_hl(0, "TrailingSpaces", { bg = "#ff0000", ctermbg = "Red" })
  end,
})
autocmd({ "VimEnter", "WinEnter" }, {
  group = "HighlightTrailingSpaces",
  callback = function()
    vim.fn.matchadd("TrailingSpaces", [[\s\+$]])
  end,
})

-- =============================================================================
-- Highlight Zenkaku (full-width) spaces
-- =============================================================================
augroup("HighlightZenkakuSpace", { clear = true })
autocmd({ "VimEnter", "WinEnter", "ColorScheme" }, {
  group = "HighlightZenkakuSpace",
  callback = function()
    vim.api.nvim_set_hl(0, "ZenkakuSpace", { bg = "#005f87", ctermbg = 6 })
  end,
})
autocmd({ "VimEnter", "WinEnter" }, {
  group = "HighlightZenkakuSpace",
  callback = function()
    vim.fn.matchadd("ZenkakuSpace", "　") -- Full-width space
  end,
})

-- =============================================================================
-- Cursor line highlight
-- =============================================================================
augroup("CursorLineHighlight", { clear = true })
autocmd("WinLeave", {
  group = "CursorLineHighlight",
  callback = function()
    vim.opt_local.cursorline = false
  end,
})
autocmd({ "WinEnter", "BufRead" }, {
  group = "CursorLineHighlight",
  callback = function()
    vim.opt_local.cursorline = true
  end,
})

-- =============================================================================
-- Remove trailing whitespace on save (for specific filetypes)
-- =============================================================================
augroup("RemoveTrailingWhitespace", { clear = true })
autocmd("BufWritePre", {
  group = "RemoveTrailingWhitespace",
  pattern = { "*.ts", "*.tsx", "*.js", "*.jsx", "*.py", "*.rb", "*.go", "*.lua", "*.rs" },
  callback = function()
    local save_cursor = vim.fn.getpos(".")
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.setpos(".", save_cursor)
  end,
})

-- =============================================================================
-- Auto create directory when saving a file
-- =============================================================================
augroup("AutoCreateDir", { clear = true })
autocmd("BufWritePre", {
  group = "AutoCreateDir",
  callback = function(event)
    if event.match:match("^%w%w+://") then
      return
    end
    local file = vim.loop.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

-- =============================================================================
-- Return to last edit position when opening files
-- =============================================================================
augroup("RestoreCursor", { clear = true })
autocmd("BufReadPost", {
  group = "RestoreCursor",
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- =============================================================================
-- Highlight yanked text
-- =============================================================================
augroup("HighlightYank", { clear = true })
autocmd("TextYankPost", {
  group = "HighlightYank",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
})

-- =============================================================================
-- Resize splits when window is resized
-- =============================================================================
augroup("ResizeSplits", { clear = true })
autocmd("VimResized", {
  group = "ResizeSplits",
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

-- =============================================================================
-- Close some filetypes with <q>
-- =============================================================================
augroup("CloseWithQ", { clear = true })
autocmd("FileType", {
  group = "CloseWithQ",
  pattern = {
    "help",
    "lspinfo",
    "man",
    "notify",
    "qf",
    "query",
    "spectre_panel",
    "startuptime",
    "checkhealth",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- =============================================================================
-- Check if we need to reload the file when it changed
-- =============================================================================
augroup("CheckTime", { clear = true })
autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = "CheckTime",
  callback = function()
    if vim.o.buftype ~= "nofile" then
      vim.cmd("checktime")
    end
  end,
})
