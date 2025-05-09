return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false, -- set this if you want to always pull the latest change
    opts = {
      provider = "openrouter",
      vendors = {
        openrouter = {
          __inherited_from = "openai",
          disable_tools = true,
          endpoint = "https://openrouter.ai/api/v1",
          api_key_name = "OPENROUTER_API_KEY",
          model = "google/gemini-2.5-pro-preview",
          --model = "google/gemini-2.5-pro-preview-03-25",
          -- model = "openai/o3-mini",
          -- model = "anthropic/claude-3.7-sonnet",
          -- model = "deepseek/deepseek-r1",
          -- model = "google/gemini-2.0-flash-thinking-exp:free",
          -- model = "cognitivecomputations/dolphin3.0-r1-mistral-24b:free",
          max_tokens = 8192,
        },
      },

      behaviour = {
        use_cwd_as_project_root = true, -- Add this line to use current working directory as root
      },
      system_prompt = [=[
        You are a highly skilled and pragmatic software development assistant, supporting a modern full-stack JavaScript/TypeScript workflow across frontend and backend frameworks.

        General Behaviour
        - Prioritize simplicity, clarity, and practical effectiveness in all solutions.
        - Match existing code patterns in legacy files or older components unless explicitly told to refactor.
        - Do not recommend architectural changes or major refactors unless explicitly requested.
        - Do not add comments for every code change. Only include comments when the logic is non-obvious, complex, or when context is necessary for understanding.

        Frontend Development
        - When working with Angular, follow these preferences:
          - Default to modern Angular (18+): standalone components, signals over RxJS, input and output signals.
          - Use Signals where feasible for reactivity.
          - Avoid recommending refactors to old code unless asked.
          - Avoid using effect unless it's absolutely necessary; if so, consider RxJS.
        - Ensure all suggestions align with framework idioms and current best practices.

        Development Philosophy
        - Follow SOLID principles and DRY (Don't Repeat Yourself) practices.
        - Code consistency is key—adapt to the existing file’s structure, style, and conventions.
        - Focus on developer experience: short feedback loops, concise examples, minimal boilerplate.
        - Only recommend libraries, tools, or patterns that are actively maintained and widely adopted.
        - When unsure of the framework or context, ask for clarification before proceeding.
        ]=],
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua", -- for providers='copilot'
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = false,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },
  {
    "ravitemer/mcphub.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim", -- Required for Job and HTTP requests
    },
    -- comment the following line to ensure hub will be ready at the earliest
    cmd = "MCPHub", -- lazy load by default
    build = "npm install -g mcp-hub@latest", -- Installs required mcp-hub npm module
    -- uncomment this if you don't want mcp-hub to be available globally or can't use -g
    -- build = "bundled_build.lua",  -- Use this and set use_bundled_binary = true in opts  (see Advanced configuration)
    config = function()
      require("mcphub").setup({
        -- Required options
        port = 3001, -- Port for MCP Hub server
        config = vim.fn.expand("~/mcpservers.json"), -- Absolute path to config file
      })
    end,
  },
}
