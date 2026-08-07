return {
  {
    "Mofiqul/vscode.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("vscode").setup({
        transparent = false,
        italic_comments = true,
      })

      vim.cmd.colorscheme("vscode")

      -- GitSigns overrides
      vim.cmd([[
        highlight GitSignsAdd guifg=#00ff00 guibg=#003300
        highlight GitSignsChange guifg=#ffff00 guibg=#333300
        highlight GitSignsDelete guifg=#ff0000 guibg=#330000
        highlight GitSignsChangeDelete guifg=#ff00ff guibg=#330033
        highlight GitSignsTopDelete guifg=#ff5555 guibg=#330000
      ]])
    end,
  },
  -- LSP, completion, and formatting are configured by LazyVim.
  { import = "lazyvim.plugins.extras.lang.typescript" },
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    pin = true,
    lazy = false,
    build = ":TSUpdate",
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
        "regex",
        "tsx",
        "typescript",
        "c_sharp",
        "vim",
        "scss",
        "astro",
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
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "nxls",
      },
    },
  },
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        numbers = "ordinal", -- 1, 2, 3, ...
      },
    },
  },
  -- use mini.starter instead of alpha
  -- { import = "lazyvim.plugins.extras.ui.mini-starter" },
  { import = "lazyvim.plugins.extras.coding.mini-surround" },
}
