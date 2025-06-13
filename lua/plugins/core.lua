return {
  -- {
  --   "folke/trouble.nvim",
  --   -- opts will be merged with the parent spec
  --   opts = { use_diagnostic_signs = true },
  -- },
  {
    "gmr458/vscode_modern_theme.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("vscode_modern").setup({
        cursorline = true,
        transparent_background = false,
        nvim_tree_darker = true,
      })
      vim.cmd.colorscheme("vscode_modern")
      vim.cmd([[
      highlight GitSignsAdd guifg=#00ff00 ctermfg=green
      highlight GitSignsDelete guifg=#ff0000 ctermfg=red
      highlight DiffDelete ctermbg=red guibg=#ff6d6d
      ]])
    end,
  },
  -- treesitter, mason and typescript.nvim. So instead of the above, you can use:
  { import = "lazyvim.plugins.extras.lang.typescript" },
  {
    "nvim-treesitter/nvim-treesitter",
    -- use latest
    version = false,
    opts = {
      ensure_installed = {
        "bash",
        "html",
        "javascript",
        "json",
        "lua",
        "css",
        "vue",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "yaml",
        "scss",
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.install").prefer_git = true
      require("nvim-treesitter.configs").setup(opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "angular", "scss" })
      end
      vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
        pattern = { "*.component.html", "*.container.html" },
        callback = function()
          vim.treesitter.start(nil, "angular")
        end,
      })
      return opts
    end,
  },
  -- add any tools you want to have installed below
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "nxls",
      },
    },
  },
  {
    "l3mon4d3/luasnip",
    config = function()
      -- Load snippets from VSCode-style JSON files
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
    keys = function()
      return {}
    end,
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    event = "BufReadPost",
    opts = {
      suggestion = {
        enabled = not vim.g.ai_cmp,
        auto_trigger = false,
        hide_during_completion = vim.g.ai_cmp,
        debounce = 75,
        keymap = {
          accept = "<M-l>",
          accept_word = false,
          accept_line = false,
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-]>",
        },
      },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        help = true,
      },
      function()
        LazyVim.cmp.actions.ai_accept = function()
          if require("copilot.suggestion").is_visible() then
            LazyVim.create_undo()
            require("copilot.suggestion").accept()
            return true
          end
        end
      end,
    },
  },

  -- {
  --   "nvim-neo-tree/neo-tree.nvim",
  --   config = function()
  --     require("neo-tree").setup({
  --       filesystem = {
  --         commands = {
  --           avante_add_files = function(state)
  --             local node = state.tree:get_node()
  --             local filepath = vim.fn.getcwd() -- or use your project root finder
  --             local relative_path = require("avante.utils").relative_path(filepath)
  --
  --             local sidebar = require("avante").get()
  --
  --             local open = sidebar:is_open()
  --             -- ensure avante sidebar is open
  --             if not open then
  --               require("avante.api").ask()
  --               sidebar = require("avante").get()
  --             end
  --
  --             sidebar.file_selector:add_selected_file(relative_path)
  --
  --             -- remove neo tree buffer
  --             if not open then
  --               sidebar.file_selector:remove_selected_file("neo-tree filesystem [1]")
  --             end
  --           end,
  --         },
  --         window = {
  --           mappings = {
  --             ["oa"] = "avante_add_files",
  --           },
  --         },
  --       },
  --     })
  --   end,
  -- },
  --
  { "mbbill/undotree" },
  -- use mini.starter instead of alpha
  -- { import = "lazyvim.plugins.extras.ui.mini-starter" },
  { import = "lazyvim.plugins.extras.coding.mini-surround" },
}
