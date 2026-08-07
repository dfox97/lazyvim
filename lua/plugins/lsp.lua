return {
  -- Enable LazyVim angular extra (includes angularls config similar to your manual one)
  { import = "lazyvim.plugins.extras.lang.angular" },

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
}
