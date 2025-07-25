return {
  "ibhagwan/fzf-lua",
  cmd = "FzfLua",
  opts = function(_, opts)
    local config = require("fzf-lua.config")
    local actions = require("fzf-lua.actions")

    -- Quickfix
    config.defaults.keymap.fzf["ctrl-q"] = "select-all+accept"
    config.defaults.keymap.fzf["ctrl-u"] = "half-page-up"
    config.defaults.keymap.fzf["ctrl-d"] = "half-page-down"
    config.defaults.keymap.fzf["ctrl-x"] = "jump"
    config.defaults.keymap.fzf["ctrl-f"] = "preview-page-down"
    config.defaults.keymap.fzf["ctrl-b"] = "preview-page-up"
    config.defaults.keymap.builtin["<c-f>"] = "preview-page-down"
    config.defaults.keymap.builtin["<c-b>"] = "preview-page-up"

    -- Trouble
    if LazyVim.has("trouble.nvim") then
      config.defaults.actions.files["ctrl-t"] = require("trouble.sources.fzf").actions.open
    end

    -- Toggle root dir / cwd
    config.defaults.actions.files["ctrl-r"] = function(_, ctx)
      local o = vim.deepcopy(ctx.__call_opts)
      o.root = o.root == false
      o.cwd = nil
      o.buf = ctx.__CTX.bufnr
      LazyVim.pick.open(ctx.__INFO.cmd, o)
    end
    config.defaults.actions.files["alt-c"] = config.defaults.actions.files["ctrl-r"]
    config.set_action_helpstr(config.defaults.actions.files["ctrl-r"], "toggle-root-dir")

    local img_previewer ---@type string[]?
    for _, v in ipairs({
      { cmd = "ueberzug", args = {} },
      { cmd = "chafa", args = { "{file}", "--format=symbols" } },
      { cmd = "viu", args = { "-b" } },
    }) do
      if vim.fn.executable(v.cmd) == 1 then
        img_previewer = vim.list_extend({ v.cmd }, v.args)
        break
      end
    end

    return {
      "default-title",
      fzf_colors = true,
      fzf_opts = {
        ["--no-scrollbar"] = true,
      },
      defaults = {
        -- formatter = "path.filename_first",
        formatter = "path.dirname_first",
      },
      previewers = {
        builtin = {
          extensions = {
            ["png"] = img_previewer,
            ["jpg"] = img_previewer,
            ["jpeg"] = img_previewer,
            ["gif"] = img_previewer,
            ["webp"] = img_previewer,
          },
          ueberzug_scaler = "fit_contain",
        },
      },
      -- Custom LazyVim option to configure vim.ui.select
      ui_select = function(fzf_opts, items)
        return vim.tbl_deep_extend("force", fzf_opts, {
          prompt = " ",
          winopts = {
            title = " " .. vim.trim((fzf_opts.prompt or "Select"):gsub("%s*:%s*$", "")) .. " ",
            title_pos = "center",
          },
        }, fzf_opts.kind == "codeaction" and {
          winopts = {
            layout = "vertical",
            -- height is number of items minus 15 lines for the preview, with a max of 80% screen height
            height = math.floor(math.min(vim.o.lines * 0.8 - 16, #items + 2) + 0.5) + 16,
            width = 0.5,
            preview = not vim.tbl_isempty(LazyVim.lsp.get_clients({ bufnr = 0, name = "vtsls" })) and {
              layout = "vertical",
              vertical = "down:15,border-top",
              hidden = "hidden",
            } or {
              layout = "vertical",
              vertical = "down:15,border-top",
            },
          },
        } or {
          winopts = {
            width = 0.5,
            -- height is number of items, with a max of 80% screen height
            height = math.floor(math.min(vim.o.lines * 0.8, #items + 2) + 0.5),
          },
        })
      end,
      winopts = {
        width = 0.8,
        height = 0.8,
        row = 0.5,
        col = 0.5,
        preview = {
          scrollchars = { "┃", "" },
        },
      },
      files = {
        cwd_prompt = false,
        actions = {
          ["alt-i"] = { actions.toggle_ignore },
          ["alt-h"] = { actions.toggle_hidden },
        },
      },
      grep = {
        rg_opts = "--column --line-number --no-heading --color=always --smart-case --fixed-strings",
        actions = {
          ["alt-i"] = { actions.toggle_ignore },
          ["alt-h"] = { actions.toggle_hidden },
        },
      },
      lsp = {
        symbols = {
          symbol_hl = function(s)
            return "TroubleIcon" .. s
          end,
          symbol_fmt = function(s)
            return s:lower() .. "\t"
          end,
          child_prefix = false,
        },
        code_actions = {
          previewer = vim.fn.executable("delta") == 1 and "codeaction_native" or nil,
        },
      },
    }
  end,
  config = function(_, opts)
    if opts[1] == "default-title" then
      -- use the same prompt for all pickers for profile `default-title` and
      -- profiles that use `default-title` as base profile
      local function fix(t)
        t.prompt = t.prompt ~= nil and " " or nil
        for _, v in pairs(t) do
          if type(v) == "table" then
            fix(v)
          end
        end
        return t
      end
      opts = vim.tbl_deep_extend("force", fix(require("fzf-lua.profiles.default-title")), opts)
      opts[1] = nil
    end
    require("fzf-lua").setup(opts)
  end,
  init = function()
    LazyVim.on_very_lazy(function()
      vim.ui.select = function(...)
        require("lazy").load({ plugins = { "fzf-lua" } })
        local opts = LazyVim.opts("fzf-lua") or {}
        require("fzf-lua").register_ui_select(opts.ui_select or nil)
        return vim.ui.select(...)
      end
    end)
  end,
  keys = {
    {
      "<leader>,",
      "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>",
      desc = "Switch Buffer",
    },
    { "<leader><leader>", "<cmd>FzfLua oldfiles<cr>", desc = "[?] Find recently opened files" },
    { "<C-p>", "<cmd>FzfLua files<cr>", desc = "Find [F]iles" },
    { "<leader>p", "<cmd>FzfLua files<cr>", noremap = true },
    { "<leader>f", "<cmd>FzfLua live_grep<cr>", desc = "Search [A]ll" },
    {
      "<leader>fl",
      function()
        require("fzf-lua").live_grep({
          rg_opts = "--column --line-number --no-heading --color=always --smart-case --fixed-strings",
        })
      end,
      desc = "Live Grep (Literal)",
    },
    { "<leader>sd", "<cmd>FzfLua diagnostics_workspace<cr>", desc = "[S]earch [D]iagnostics" },
    { "<leader>sj", "<cmd>FzfLua jumps<cr>", desc = "Jumplist" },
    { "<leader>sq", "<cmd>FzfLua quickfix<cr>", desc = "Quickfix List" },
    { "<leader>jl", "<cmd>FzfLua jumps<cr>", desc = "[J]ump [L]ist" },
    { "<leader>gf", "<cmd>FzfLua git_files<cr>", desc = "Find [G]it [F]iles" },
    { "<leader>km", "<cmd>FzfLua keymaps<cr>", desc = "[K]ey[M]aps" },
    { "<leader>rg", "<cmd>FzfLua registers<cr>", desc = "[R]egisters" },
    { "<leader>ht", "<cmd>FzfLua help_tags<cr>", desc = "[H]elp [T]ags" },
    { "<leader>gb", "<cmd>FzfLua git_branches<cr>", desc = "[G]it [B]ranches" },
    { "<leader>sw", LazyVim.pick("grep_cword"), desc = "Word (Root Dir)" },
    { "<leader>sW", LazyVim.pick("grep_cWORD", { root = false }), desc = "Word (cwd)" },
    { "<leader>sw", LazyVim.pick("grep_visual"), mode = "v", desc = "Selection (Root Dir)" },
    { "<leader>sW", LazyVim.pick("grep_visual", { root = false }), mode = "v", desc = "Selection (cwd)" },
    -- Search last thing searched
    {
      "<leader>#",
      function()
        require("fzf-lua").grep_last({}) -- Uses the last search term
      end,
      desc = "Search Last Query",
    },
  },
}
