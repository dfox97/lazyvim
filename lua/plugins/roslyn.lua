return {
  {
    "seblyng/roslyn.nvim",
    ft = { "cs", "razor" },
    -- PINNED: Compatible with Neovim 0.11.x
    -- Commit from before the >=0.12 requirement was added
    -- See: https://github.com/seblyng/roslyn.nvim/commit/dbd677f473307f6d60a886a7f74513e2225accb3
    commit = "f2ec6ee",
    dependencies = {
      {
        -- Optional: for better logging/debugging
        "Tastyep/structlog.nvim",
        optional = true,
      },
    },
    ---@module 'roslyn.config'
    ---@type RoslynNvimConfig
    opts = {
      -- File watching: "auto" | "roslyn" | "off"
      -- "roslyn" lets Roslyn handle file watching (better performance)
      filewatching = "roslyn",

      -- Optional: Custom target selection logic
      -- choose_target = nil,

      -- Optional: Ignore specific solutions
      -- ignore_target = nil,

      -- Search for solutions in parent directories (set true for non-standard project structures)
      broad_search = false,

      -- Lock to first solution found (false = ask when multiple solutions)
      lock_target = false,

      -- Silence initialization notifications
      silent = false,

      -- Razor/Blazor support (cohosted with Roslyn)
      extensions = {
        razor = {
          enabled = true,
          -- Auto-detects razor extension path when installed via Mason
          config = function()
            local razor_extension_path = require("roslyn.utils").find_razor_extension_path()
            if razor_extension_path == nil then
              return { path = nil }
            end
            return {
              path = vim.fs.joinpath(razor_extension_path, "Microsoft.VisualStudioCode.RazorExtension.dll"),
              args = {
                "--razorSourceGenerator="
                  .. vim.fs.joinpath(razor_extension_path, "Microsoft.CodeAnalysis.Razor.Compiler.dll"),
                "--razorDesignTimePath="
                  .. vim.fs.joinpath(razor_extension_path, "Targets", "Microsoft.NET.Sdk.Razor.DesignTime.targets"),
              },
            }
          end,
        },
      },

      -- LSP Settings (passed directly to the server)
      -- Note: For Neovim 0.11.x compatibility, these are passed in the config
      config = {
        settings = {
          ["csharp|formatting"] = {
            dotnet_organize_imports_on_format = true,
          },
          ["csharp|inlay_hints"] = {
            csharp_enable_inlay_hints_for_implicit_object_creation = true,
            csharp_enable_inlay_hints_for_implicit_variable_types = true,
            csharp_enable_inlay_hints_for_lambda_parameter_types = true,
            csharp_enable_inlay_hints_for_types = true,
            dotnet_enable_inlay_hints_for_indexer_parameters = true,
            dotnet_enable_inlay_hints_for_literal_parameters = true,
            dotnet_enable_inlay_hints_for_object_creation_parameters = true,
            dotnet_enable_inlay_hints_for_other_parameters = true,
            dotnet_enable_inlay_hints_for_parameters = true,
            dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
            dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
            dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
          },
          ["csharp|code_lens"] = {
            dotnet_enable_references_code_lens = true,
            dotnet_enable_tests_code_lens = true,
          },
          ["csharp|completion"] = {
            dotnet_show_completion_items_from_unimported_namespaces = true,
            dotnet_show_name_completion_suggestions = true,
          },
        },
      },
    },
    init = function()
      -- Register Razor filetypes before plugin loads
      vim.filetype.add({
        extension = {
          razor = "razor",
          cshtml = "razor",
        },
      })
    end,
  },
}
