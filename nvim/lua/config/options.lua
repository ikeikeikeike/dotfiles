-- Neovim options
-- Migrated from general-*.vim

local opt = vim.opt
local g = vim.g

-- =============================================================================
-- PATH configuration for Mason
-- =============================================================================
-- Add common paths for npm/node/go/gem that Mason needs
-- This ensures Mason can find these tools even when launched from GUI
local additional_paths = {
  vim.fn.expand("~/.asdf/shims"),
  vim.fn.expand("~/.asdf/bin"),
  vim.fn.expand("~/.nodebrew/current/bin"),
  vim.fn.expand("~/.nvm/versions/node/*/bin"), -- nvm
  "/opt/homebrew/bin",
  "/usr/local/bin",
  vim.fn.expand("~/go/bin"),
  vim.fn.expand("~/.cargo/bin"),
  vim.fn.expand("~/.local/share/gem/ruby/*/bin"),
  vim.fn.expand("~/.rbenv/shims"),
}

local current_path = vim.env.PATH or ""
for _, path in ipairs(additional_paths) do
  if vim.fn.isdirectory(path) == 1 and not current_path:find(path, 1, true) then
    vim.env.PATH = path .. ":" .. current_path
    current_path = vim.env.PATH
  end
end

-- =============================================================================
-- Encoding
-- =============================================================================
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"
opt.fileencodings = { "utf-8", "cp932", "euc-jp", "iso-2022-jp" }

-- =============================================================================
-- Display
-- =============================================================================
opt.number = true
opt.cursorline = true
opt.showmode = true
opt.showcmd = true
opt.showmatch = true
opt.laststatus = 2
opt.scrolloff = 5
opt.cmdheight = 2
opt.previewheight = 5
opt.termguicolors = true
opt.wildmenu = true
opt.title = true
opt.ruler = true

-- Visual bell (disable beep)
opt.visualbell = true
opt.errorbells = false

-- =============================================================================
-- Indent
-- =============================================================================
opt.expandtab = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 0
opt.autoindent = true
opt.smartindent = true
opt.backspace = { "indent", "eol", "start" }
opt.formatoptions:append("lmoq")

-- =============================================================================
-- Search
-- =============================================================================
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = false
opt.wrapscan = true
opt.history = 3000

-- =============================================================================
-- Clipboard
-- =============================================================================
opt.clipboard:append("unnamedplus")

-- macOS clipboard settings
if vim.fn.has("mac") == 1 then
  g.clipboard = {
    name = "pbcopy",
    copy = {
      ["+"] = "pbcopy",
      ["*"] = "pbcopy",
    },
    paste = {
      ["+"] = "pbpaste",
      ["*"] = "pbpaste",
    },
    cache_enabled = 0,
  }
end

-- =============================================================================
-- Backup / Undo
-- =============================================================================
opt.backup = true
opt.backupdir = vim.fn.stdpath("config") .. "/backup"
opt.swapfile = false
opt.undofile = true
opt.undodir = vim.fn.stdpath("config") .. "/undo"
opt.backupext = ".bak"

-- Create backup/undo directories if not exist
vim.fn.mkdir(vim.fn.stdpath("config") .. "/backup", "p")
vim.fn.mkdir(vim.fn.stdpath("config") .. "/undo", "p")

-- =============================================================================
-- Window
-- =============================================================================
opt.splitbelow = true
opt.splitright = true
opt.sessionoptions:append("resize")

-- =============================================================================
-- Movement
-- =============================================================================
opt.whichwrap = "b,s,h,l,<,>,[,]"

-- =============================================================================
-- Diff
-- =============================================================================
if vim.o.diff then
  vim.cmd("colorscheme leo")
end

-- =============================================================================
-- Python provider (for plugins that need it)
-- =============================================================================
-- Adjust these paths as needed for your system
if vim.fn.executable("/opt/local/bin/python3") == 1 then
  g.python3_host_prog = "/opt/local/bin/python3"
elseif vim.fn.executable("/usr/local/bin/python3") == 1 then
  g.python3_host_prog = "/usr/local/bin/python3"
elseif vim.fn.executable("/opt/homebrew/bin/python3") == 1 then
  g.python3_host_prog = "/opt/homebrew/bin/python3"
end

-- Use virtual environment python if available
if vim.env.VIRTUAL_ENV then
  g.python3_host_prog = vim.env.VIRTUAL_ENV .. "/bin/python"
end
