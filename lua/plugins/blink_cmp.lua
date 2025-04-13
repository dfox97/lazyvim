return {
  {
    "saghen/blink.cmp",
    optional = true,
    dependencies = { "giuxtaposition/blink-cmp-copilot" },

    opts = function(_, opts)
      opts.sources = {
        default = { "lsp", "path", "snippets", "buffer", "copilot" },
        providers = {
          copilot = {
            name = "copilot",
            module = "blink-cmp-copilot",
            kind = "Copilot",
            score_offset = 10,
            async = true,
          },
        },
      }

      opts.cmdline = {
        enabled = true,
      }
      opts.completion = {
        ghost_text = {
          enabled = vim.g.ai_cmp,
        },
      }

      opts.snippets = {
        preset = "luasnip", -- Choose LuaSnip as the snippet engine
      }

      opts.keymap = {
        preset = "none", --enter if i want to use this.
        ["<Tab>"] = { "select_and_accept" },
      }
      opts.appearance = opts.appearance or {}
      opts.appearance.kind_icons = vim.tbl_extend("force", opts.appearance.kind_icons or {}, LazyVim.config.icons.kinds)
      -- add ai_accept to <Tab> key
      if not opts.keymap["<Tab>"] then
        if opts.keymap.preset == "super-tab" then -- super-tab
          opts.keymap["<Tab>"] = {
            require("blink.cmp.keymap.presets")["super-tab"]["<Tab>"][1],
            LazyVim.cmp.map({ "snippet_forward", "ai_accept" }),
            "fallback",
          }
        else -- other presets
          opts.keymap["<Tab>"] = {
            LazyVim.cmp.map({ "snippet_forward", "ai_accept" }),
            "fallback",
          }
        end
      end

      return opts
    end,
  },
}
