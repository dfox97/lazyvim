-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

vim.api.nvim_create_user_command("ReplaceInputSignals", function()
  vim.cmd([[
    %s/@Input()\s*\(public\|private\|protected\)\?\s*\([^:]*\)\s*:\s*\([^;]*\);/\1 \2 = input<\3>();/g
    %s/@Input()\s*\(public\|private\|protected\)\?\s*\([^:]*\)\s*=\s*\([^;]*\);/\1 \2 = input<any>(\3);/g
  ]])
end, {})

vim.api.nvim_create_user_command("ReplaceHighlightedInputSignal", function()
  -- Get the current line content
  local line = vim.fn.getline(".")

  -- Check if the line contains a type declaration or initialization
  if line:match(":") then
    -- Handle type declaration pattern
    vim.cmd([[
      '<,'>s/@Input()\s*\(public\|private\|protected\)\?\s*\([^:]*\)\s*:\s*\([^;]*\);/\1 \2 = input<\3>();/ge
    ]])
  else
    -- Handle initialization pattern
    vim.cmd([[
      '<,'>s/@Input()\s*\(public\|private\|protected\)\?\s*\([^:]*\)\s*=\s*\([^;]*\);/\1 \2 = input<any>(\3);/ge
    ]])
  end
end, { range = true })
