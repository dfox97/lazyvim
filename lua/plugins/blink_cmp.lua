return {
  {
    "saghen/blink.cmp",
    optional = true,
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    opts = function(_, opts)
      opts.sources = {
        default = { "lsp", "path", "snippets", "buffer" },
        providers = {},
      }
      opts.completion = {
        documentation = { auto_show = true },
        ghost_text = {
          enabled = vim.g.ai_cmp,
        },
      }

      opts.snippets = {
        preset = "luasnip", -- Choose LuaSnip as the snippet engine
      }

      opts.keymap = {
        preset = "super-tab", --enter if i want to use this.
      }
      opts.appearance = opts.appearance or {}
      opts.appearance.kind_icons = vim.tbl_extend("force", opts.appearance.kind_icons or {}, LazyVim.config.icons.kinds)

      opts.fuzzy = { implementation = "prefer_rust_with_warning" }

      return opts
    end,
  },
}
