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

-- add keybinds for typescript tooling auto fix all
vim.keymap.set("n", "<leader>cA", "<cmd>TSToolsFixAll<cr>", { noremap = true, silent = true, desc = "Fix all" })

vim.keymap.set(
  "n",
  "<leader>cr",
  "<cmd>TSToolsRemoveUnusedImports<CR>",
  { noremap = true, silent = true, desc = "Rename" }
)

vim.keymap.set(
  "n",
  "<leader>ci",
  "<cmd>TSToolsAddMissingImports<CR>",
  { noremap = true, silent = true, desc = "Add missing imports" }
)

-- undotree
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

-- map zo and zc to open and close folds
vim.keymap.set("n", "zo", "za", { noremap = true, silent = true })
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

vim.api.nvim_set_hl(0, "CopilotSuggestion", {
  fg = "#928374", -- match comment
  italic = true,
})

vim.keymap.set("i", "<C-c>", function()
  -- Exit insert mode like <Esc>
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
  -- Manually dismiss Copilot suggestion
  local ok, suggestion = pcall(require, "copilot.suggestion")
  if ok and suggestion and suggestion.is_visible() then
    suggestion.dismiss()
  end
end, { noremap = true, silent = true })

vim.api.nvim_create_autocmd("InsertLeave", {
  callback = function()
    local ok, suggestion = pcall(require, "copilot.suggestion")
    if ok and suggestion then
      suggestion.dismiss()
    end
  end,
})

vim.api.nvim_create_autocmd("User", {
  pattern = "BlinkCmpMenuOpen",
  callback = function()
    --require("copilot.suggestion").dismiss()
    vim.b.copilot_suggestion_hidden = true
  end,
})

vim.api.nvim_create_autocmd("User", {
  pattern = "BlinkCmpMenuClose",
  callback = function()
    vim.b.copilot_suggestion_hidden = false
  end,
})
