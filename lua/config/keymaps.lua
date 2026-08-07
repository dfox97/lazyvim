-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.g.mapleader = " "

-- Ignore CTRL-Z
vim.keymap.set("n", "<C-z>", "<NOP>", { noremap = true, silent = true })
vim.keymap.set("v", "<C-z>", "<NOP>", { noremap = true, silent = true })

-- Split window
vim.keymap.set("n", "<leader>w", ":vsp<CR>", { noremap = true, silent = true })
-- Map Ctrl + h/j/k/l to switch between split windows
vim.keymap.set("n", "<c-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<c-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<c-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<c-l>", ":wincmd l<CR>")

-- move lines up and down using alt + arrow up/down
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { noremap = true, silent = true })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { noremap = true, silent = true })
vim.keymap.set("n", "<A-Up>", ":m .-2<CR>==", { noremap = true, silent = true }) -- learn to stop using arrow keys but keep this for now
vim.keymap.set("n", "<A-Down>", ":m .+1<CR>==", { noremap = true, silent = true })

-- Add custom keybindings for code actions
vim.keymap.set(
  "n",
  "<leader>ca",
  vim.lsp.buf.code_action,
  { noremap = true, silent = true, desc = "Code Action (Quickfix)" }
)

-- Native Super-Tab completion: start/cycle LSP completion with Tab and move
-- backwards with Shift-Tab. Outside completion it behaves as a normal tab.
local function super_tab(direction)
  return function()
    if vim.fn.pumvisible() == 1 then
      return direction == 1 and "<C-n>" or "<C-p>"
    end
    if vim.bo.omnifunc ~= "" then
      return direction == 1 and "<C-x><C-o>" or "<S-Tab>"
    end
    return direction == 1 and "<Tab>" or "<S-Tab>"
  end
end

vim.keymap.set("i", "<Tab>", super_tab(1), { expr = true, desc = "Next Completion" })
vim.keymap.set("i", "<S-Tab>", super_tab(-1), { expr = true, desc = "Previous Completion" })

-- map zo and zc to open and close folds
vim.keymap.set("n", "zo", "za", { noremap = true, silent = true })
vim.keymap.set("i", "<C-c>", "<Esc>", { noremap = true, silent = true })
