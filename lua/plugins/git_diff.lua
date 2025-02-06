return {
  "sindrets/diffview.nvim",
  -- leader gd to diffview open
  vim.api.nvim_set_keymap("n", "<leader>gd", "<cmd>DiffviewOpen<CR>", { noremap = true, silent = true }),
  --close diff view
  vim.api.nvim_set_keymap("n", "<leader>gc", "<cmd>DiffviewClose<CR>", { noremap = true, silent = true }),
}
