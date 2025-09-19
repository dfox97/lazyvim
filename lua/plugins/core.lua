return {
  {
    "Mofiqul/vscode.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("vscode").setup({
        -- Enable transparent background
        transparent = false,
        -- Enable italic comments
        italic_comments = true,
      })
      vim.cmd.colorscheme("vscode")
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
    branch = "master",
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
    "l3mon4d3/luasnip",
    config = function()
      -- Load snippets from VSCode-style JSON files
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
    keys = function()
      return {}
    end,
  },

  { "mbbill/undotree" },
  -- use mini.starter instead of alpha
  -- { import = "lazyvim.plugins.extras.ui.mini-starter" },
  { import = "lazyvim.plugins.extras.coding.mini-surround" },
}
