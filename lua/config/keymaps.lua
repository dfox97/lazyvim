-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.g.mapleader = " "

-- Alt + arrow left to jump to older cursor position (back in jump list) keep existing ctrl + o keymap
-- vim.api.nvim_set_keymap("n", "<A-Left>", "<C-o>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("i", "<A-Left>", "<C-o>", { noremap = true, silent = true })
-- Alt + arrow right to jump to newer cursor position (forward in jump list) keep existing ctrl + i keymap
vim.api.nvim_set_keymap("n", "<A-Right>", "<C-i>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<A-Down>", "<C-i>", { noremap = true, silent = true })

-- Define keybindings for undo and redo
vim.api.nvim_set_keymap("n", "<C-z>", ":undo<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-y>", ":redo<CR>", { noremap = true, silent = true })

-- Ignore CTRL-Z
vim.api.nvim_set_keymap("n", "<C-z>", "<NOP>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<C-z>", "<NOP>", { noremap = true, silent = true })

-- Split window
vim.api.nvim_set_keymap("n", "<leader>w", ":vsp<CR>", { noremap = true, silent = true })
-- Map Ctrl + h/j/k/l to switch between split windows
vim.keymap.set("n", "<c-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<c-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<c-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<c-l>", ":wincmd l<CR>")

-- move lines up and down using alt + arrow up/down
vim.api.nvim_set_keymap("n", "<A-j>", ":m .+1<CR>==", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-k>", ":m .-2<CR>==", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-Up>", ":m .-2<CR>==", { noremap = true, silent = true }) -- learn to stop using arrow keys but keep this for now
vim.api.nvim_set_keymap("n", "<A-Down>", ":m .+1<CR>==", { noremap = true, silent = true })

-- Add custom keybindings for code actions
vim.api.nvim_set_keymap(
  "n",
  "<leader>ca",
  "<cmd>lua vim.lsp.buf.code_action()<CR>",
  { noremap = true, silent = true, desc = "Code Action (Quickfix)" }
)

-- add keybinds for typescript tooling auto fix all
vim.api.nvim_set_keymap(
  "n",
  "<leader>cA",
  "<cmd>TSToolsFixAll<cr>",
  { noremap = true, silent = true, desc = "Fix all" }
)

vim.api.nvim_set_keymap(
  "n",
  "<leader>cr",
  "<cmd>TSToolsRemoveUnusedImports<CR>",
  { noremap = true, silent = true, desc = "Rename" }
)

vim.api.nvim_set_keymap(
  "n",
  "<leader>ci",
  "<cmd>TSToolsAddMissingImports<CR>",
  { noremap = true, silent = true, desc = "Add missing imports" }
)

-- undotree
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

-- map zo and zc to open and close folds
vim.api.nvim_set_keymap("n", "zo", "za", { noremap = true, silent = true })
--
-- Angular Input signal replacement mappings
vim.keymap.set(
  "n",
  "<leader>ri",
  "<cmd>ReplaceInputSignals<CR>",
  { noremap = true, silent = true, desc = "Replace all Input() signals" }
)
vim.keymap.set(
  "v",
  "<leader>ri",
  "<cmd>ReplaceHighlightedInputSignal<CR>",
  { noremap = true, silent = true, desc = "Replace selected Input() signals" }
)

-- remove arrow keys binding
vim.keymap.set("n", "<Up>", "<NOP>")
vim.keymap.set("n", "<Down>", "<NOP>")
vim.keymap.set("n", "<Left>", "<NOP>")
vim.keymap.set("n", "<Right>", "<NOP>")
