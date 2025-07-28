-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
-- Basic EditorConfig settings
vim.opt.nu = true
-- vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

vim.opt.smartindent = true
vim.opt.autoindent = true

vim.opt.wrap = false

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.showmatch = true
vim.opt.laststatus = 2 -- always show statusline

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"

-- Allow copy and paste from clipboard
vim.opt.clipboard = "unnamedplus"

-- Sidebar
vim.opt.numberwidth = 3
vim.opt.showcmd = true
vim.opt.cmdheight = 0

-- Search
vim.o.incsearch = true -- starts searching as soon as typing, without enter needed
vim.o.ignorecase = true -- ignore letter case when searching
vim.o.smartcase = true -- case insentive unless capitals used in searcher

-- make diffsplit vertically
vim.opt.diffopt = "vertical"

vim.opt.updatetime = 50
-- views can only be fully collapsed with the global statusline
vim.opt.laststatus = 3
-- Se t cursorline
vim.opt.cursorline = true

vim.g.mapleader = " "

vim.g.snacks_animate = false
vim.treesitter.language.register("angular", "angular.html")
-- ignore order
vim.g.lazyvim_check_order = false
-- Set the filetype for TypeScript files
vim.cmd([[
  autocmd BufNewFile,BufRead *.ts set filetype=typescript
]])

-- Set the filetype for HTML files
vim.cmd([[
  autocmd BufNewFile,BufRead *.html set filetype=html
]])

-- Set the filetype for CSS files
vim.cmd([[
  autocmd BufNewFile,BufRead *.css set filetype=css
]])

-- Set the filetype for Lua files
vim.cmd([[
  autocmd BufNewFile,BufRead *.lua set filetype=lua
]])

-- Set filetype for njk files
vim.cmd([[
  autocmd BufNewFile,BufRead *.njk set filetype=html
]])
