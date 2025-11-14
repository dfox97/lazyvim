return {
  "sindrets/diffview.nvim",
  -- leader gd to diffview open
  vim.api.nvim_set_keymap("n", "<leader>Gd", "<cmd>DiffviewOpen<CR>", { noremap = true, silent = true }),
  --close diff view
  vim.api.nvim_set_keymap("n", "<leader>Gc", "<cmd>DiffviewClose<CR>", { noremap = true, silent = true }),
}
