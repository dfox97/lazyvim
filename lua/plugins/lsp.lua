local lspconfig = require("lspconfig")

local root_patterns = { "angular.json", "nx.json" }
local node_modules_root = vim.fs.dirname(vim.fs.find(root_patterns, { upward = true })[1])
local project_root = require("lspconfig.util").root_pattern("angular.json", "nx.json")

if node_modules_root and project_root then
  local tsdkPath = node_modules_root .. "/node_modules/typescript/lib"
end

return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      inlay_hints = { enabled = false },
      ---@type lspconfig.options
      servers = {
        angularls = {
          root_dir = function(fname)
            local util = require("lspconfig.util")
            return util.root_pattern("angular.json", "nx.json")(fname)
          end,
          filetypes = { "typescript", "html", "typescriptreact", "typescript.tsx", "htmlangular" },
          init_options = {
            preferences = {
              angular = {
                enableIvy = true,
                strictTemplates = true,
              },
            },
          },
        },
        -- Add OmniSharp server here
        omnisharp = {
          cmd = {
            vim.fn.stdpath("data") .. "/mason/bin/OmniSharp",
            "--languageserver",
            "--hostPID",
            tostring(vim.fn.getpid()),
          },
          handlers = {
            ["textDocument/publishDiagnostics"] = function() end, -- Disable diagnostics
          },
          -- If you need specific configuration for OmniSharp, add it here:
          -- omnisharp_config = {
          --   FormattingOptions = {
          --     EnableEditorConfigSupport = true,
          --     IncludeInitialNewline = false,
          --   },
          -- },
        },
      },
      setup = {
        html = function(_, opts)
          opts.init_options = {
            dataPaths = {
              vim.fn.getcwd() .. "/node_modules/angular-three/metadata.json",
            },
            configurationSection = { "html", "css", "javascript" },
            embeddedLanguages = {
              css = true,
              javascript = true,
            },
            provideFormatter = true,
          }

          opts.handlers = {
            ["html/customDataContent"] = function(err, result, ctx, config)
              local function exists(name)
                if type(name) ~= "string" then
                  return false
                end
                return os.execute("test -e " .. name)
              end

              if not vim.tbl_isempty(result) and #result == 1 then
                if not exists(result[1]) then
                  return ""
                end
                local content = vim.fn.join(vim.fn.readfile(result[1]), "\n")
                return content
              end
              return ""
            end,
          }

          return false
        end,
        marksman = function(_, opts)
          opts.filetypes = { "md", "markdown", "mdx", "agx" }
        end,
        angularls = function(_, opts)
          opts.root_dir = lspconfig.util.root_pattern("angular.json", "nx.json")
        end,
        eslint = function(_, opts)
          opts.filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" }
        end,
      },
    },
  },
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
