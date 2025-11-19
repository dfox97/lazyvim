return {
  "lewis6991/gitsigns.nvim",
  event = "LazyFile",
  keys = {
    { "]h", desc = "Next Hunk" },
    { "[h", desc = "Prev Hunk" },
    { "]H", desc = "Last Hunk" },
    { "[H", desc = "First Hunk" },
    { "<leader>ghs", desc = "Stage Hunk", mode = { "n", "v" } },
    { "<leader>ghr", desc = "Reset Hunk", mode = { "n", "v" } },
    { "<leader>ghS", desc = "Stage Buffer" },
    { "<leader>ghu", desc = "Undo Stage Hunk" },
    { "<leader>ghR", desc = "Reset Buffer" },
    { "<leader>ghp", desc = "Preview Hunk Inline" },
    { "<leader>ghb", desc = "Blame Line" },
    { "<leader>ghB", desc = "Blame Buffer" },
    { "<leader>Gd", desc = "Diff This vs dev" }, -- new keybinding
    { "ih", desc = "GitSigns Select Hunk", mode = { "o", "x" } },
  },
  opts = {
    signs = {
      add = { text = "▎" },
      change = { text = "▎" },
      delete = { text = "_" },
      topdelete = { text = "‾" },
      changedelete = { text = "~" },
      untracked = { text = "┆" },
    },
    signs_staged = {
      add = { text = "▎" },
      change = { text = "▎" },
      delete = { text = "_" },
      topdelete = { text = "‾" },
      changedelete = { text = "~" },
      untracked = { text = "┆" },
    },

    word_diff = true, -- Toggle with `:Gitsigns toggle_word_diff`
    current_line_blame = true,
    on_attach = function(buffer)
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, desc)
        vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
      end

      -- Hunk navigation
      map("n", "]h", function()
        if vim.wo.diff then
          vim.cmd.normal({ "]c", bang = true })
        else
          gs.nav_hunk("next")
        end
      end, "Next Hunk")
      map("n", "[h", function()
        if vim.wo.diff then
          vim.cmd.normal({ "[c", bang = true })
        else
          gs.nav_hunk("prev")
        end
      end, "Prev Hunk")
      map("n", "]H", function()
        gs.nav_hunk("last")
      end, "Last Hunk")
      map("n", "[H", function()
        gs.nav_hunk("first")
      end, "First Hunk")

      -- Hunk operations
      map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
      map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
      map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
      map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
      map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
      map("n", "<leader>ghp", gs.preview_hunk_inline, "Preview Hunk Inline")
      map("n", "<leader>ghb", function()
        gs.blame_line({ full = true })
      end, "Blame Line")
      map("n", "<leader>ghB", function()
        gs.blame()
      end, "Blame Buffer")

      -- Diff against HEAD
      map("n", "<leader>ghd", gs.diffthis, "Diff This")

      -- Diff against last commit
      map("n", "<leader>ghD", function()
        gs.diffthis("~")
      end, "Diff This ~")

      -- Diff against 'dev' branch
      map("n", "Gd", function()
        gs.diffthis("dev")
      end, "Diff This vs dev")

      -- Select hunk in visual mode
      map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
    end,
  },
}
