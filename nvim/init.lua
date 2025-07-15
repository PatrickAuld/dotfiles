-- Basic Neovim Configuration
-- Migrated from vim dotfiles

-- General Settings
vim.opt.history = 700
vim.opt.autoread = true

-- Leader key
vim.g.mapleader = ","

-- UI Settings
vim.opt.scrolloff = 7
vim.opt.wildmenu = true
vim.opt.wildignore = "*.o,*~,*.pyc"
vim.opt.ruler = true
vim.opt.cmdheight = 2
vim.opt.hidden = true
vim.opt.backspace = "eol,start,indent"
vim.opt.whichwrap:append("<,>,h,l")

-- Search Settings
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.magic = true
vim.opt.showmatch = true
vim.opt.matchtime = 2

-- Performance
vim.opt.lazyredraw = true

-- No bells
vim.opt.errorbells = false
vim.opt.visualbell = false

-- Colors and Fonts
vim.cmd("syntax enable")
vim.cmd("colorscheme desert")
vim.opt.background = "dark"
vim.opt.encoding = "utf8"
vim.opt.fileformats = "unix,dos,mac"

-- Files and Backups
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false

-- Indentation
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.linebreak = true
vim.opt.textwidth = 500
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.wrap = true

-- Status Line
vim.opt.laststatus = 2

-- Key Mappings
vim.keymap.set("n", "<leader>w", ":w!<CR>")
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")
vim.keymap.set("n", "<space>", "/")
vim.keymap.set("n", "<C-space>", "?")
vim.keymap.set("n", "<leader><CR>", ":noh<CR>", { silent = true })

-- Window navigation
vim.keymap.set("n", "<C-j>", "<C-W>j")
vim.keymap.set("n", "<C-k>", "<C-W>k")
vim.keymap.set("n", "<C-h>", "<C-W>h")
vim.keymap.set("n", "<C-l>", "<C-W>l")

-- Tab management
vim.keymap.set("n", "<leader>tn", ":tabnew<CR>")
vim.keymap.set("n", "<leader>to", ":tabonly<CR>")
vim.keymap.set("n", "<leader>tc", ":tabclose<CR>")
vim.keymap.set("n", "<leader>te", ":tabedit <C-r>=expand('%:p:h')<CR>/")

-- Buffer management
vim.keymap.set("n", "<leader>bd", ":bdelete<CR>")
vim.keymap.set("n", "<leader>ba", ":bufdo bdelete<CR>")

-- Change directory
vim.keymap.set("n", "<leader>cd", ":cd %:p:h<CR>:pwd<CR>")

-- Miscellaneous
vim.keymap.set("n", "0", "^")
vim.keymap.set("n", "<leader>q", ":e ~/buffer<CR>")
vim.keymap.set("n", "<leader>pp", ":set paste!<CR>")

-- Spell checking
vim.keymap.set("n", "<leader>ss", ":setlocal spell!<CR>")
vim.keymap.set("n", "<leader>sn", "]s")
vim.keymap.set("n", "<leader>sp", "[s")
vim.keymap.set("n", "<leader>sa", "zg")
vim.keymap.set("n", "<leader>s?", "z=")

-- Auto commands
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    local line = vim.fn.line("'\"")
    if line > 0 and line <= vim.fn.line("$") then
      vim.cmd("normal! g`\"")
    end
  end,
})

vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = "*.md",
  command = "setlocal spell",
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "gitcommit",
  command = "setlocal spell",
})

-- Delete trailing whitespace on save
local function delete_trailing_ws()
  local save_cursor = vim.fn.getpos(".")
  vim.cmd([[%s/\s\+$//ge]])
  vim.fn.setpos(".", save_cursor)
end

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = {"*.py", "*.coffee"},
  callback = delete_trailing_ws,
})