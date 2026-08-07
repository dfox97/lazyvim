return {
  {
    "ibhagwan/fzf-lua",
    cmd = "FzfLua",
    opts = function()
      local fzf_bin = vim.fn.exepath("fzf")
      if fzf_bin == "" and vim.fn.has("win32") == 1 then
        local matches = vim.fn.glob(
          vim.env.LOCALAPPDATA .. "/Microsoft/WinGet/Packages/junegunn.fzf_*/fzf.exe",
          false,
          true
        )
        fzf_bin = matches[1] or ""
      end
      return fzf_bin ~= "" and { fzf_bin = fzf_bin } or {}
    end,
    keys = {
      { "<leader><leader>", "<cmd>FzfLua files<cr>", desc = "Find Files" },
      { "<leader>fD", "<cmd>FzfLua files cwd=%:p:h<cr>", desc = "Find Files in Current Dir" },
    },
  },
}
