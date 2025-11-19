return {
  { "Hoffs/omnisharp-extended-lsp.nvim", lazy = true },
  --
  -- Enable LazyVim angular extra (includes angularls config similar to your manual one)
  { import = "lazyvim.plugins.extras.lang.angular" },

  -- If you want default tsserver instead of typescript-tools, enable this LazyVim extra
  -- { import = "lazyvim.plugins.extras.lang.typescript" },
  -- But keeping typescript-tools as your custom replacement

  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = function(_, opts)
      -- Ensure opts.servers exists
      opts.servers = opts.servers or {}

      -- OmniSharp (custom, not handled by LazyVim)
      opts.servers.omnisharp = {
        cmd = {
          vim.fn.stdpath("data") .. "/mason/bin/OmniSharp",
          "--languageserver",
          "--hostPID",
          tostring(vim.fn.getpid()),
        },
        handlers = {
          ["textDocument/publishDiagnostics"] = function() end, -- Disable diagnostics
        },
      }

      -- Copilot (official LazyVim style)
      local sk = LazyVim.opts("sidekick.nvim") ---@type sidekick.Config|{}
      if vim.tbl_get(sk, "nes", "enabled") ~= false then
        opts.servers.copilot = {
          cmd = { "copilot-lsp" },
          filetypes = {
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
            "lua",
            "python",
            "go",
            "rust",
            "markdown",
            "*",
          },
        }
      end

      -- Custom setup overrides
      opts.setup = opts.setup or {}

      -- Disable default HTML setup if needed
      opts.setup.html = function(_, _)
        return false
      end

      -- Marksman custom filetypes
      opts.setup.marksman = function(_, opts)
        opts.filetypes = { "md", "markdown", "mdx", "agx" }
      end

      -- ESLint custom filetypes
      opts.setup.eslint = function(_, opts)
        opts.filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" }
      end

      -- Disable inlay hints globally
      opts.inlay_hints = { enabled = false }
    end,
  },

  -- Your custom typescript-tools (kept as-is, disable LazyVim typescript extra if using)
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {
      settings = {
        separate_diagnostic_server = true,
        publish_diagnostic_on = "insert_leave",
        expose_as_code_action = {},
        tsserver_path = nil,
        tsserver_plugins = {},
        tsserver_max_memory = "auto",
        tsserver_format_options = {},
        tsserver_file_preferences = {
          importModuleSpecifierPreference = "relative",
          importModuleSpecifierEnding = "minimal",
          quotePreference = "single",
        },
        tsserver_locale = "en",
        complete_function_calls = false,
        include_completions_with_insert_text = true,
        code_lens = "off",
        disable_member_code_lens = true,
        jsx_close_tag = {
          enable = false,
          filetypes = { "javascriptreact", "typescriptreact" },
        },
      },
    },
  },
}
