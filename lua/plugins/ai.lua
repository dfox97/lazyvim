return {
  {
    "olimorris/codecompanion.nvim",
    cmd = { "CodeCompanionChat", "CodeCompanion", "CodeCompanionActions" },
    init = function()
      vim.cmd([[cab cc CodeCompanion]])
    end,
    opts = function()
      return {
        extensions = {
          history = {
            enabled = true,
            opts = {
              -- Keymap to open history from chat buffer (default: gh)
              keymap = "gh",
              -- Keymap to save the current chat manually (when auto_save is disabled)
              save_chat_keymap = "sc",
              -- Save all chats by default (disable to save only manually using 'sc')
              auto_save = true,
              -- Number of days after which chats are automatically deleted (0 to disable)
              expiration_days = 5,
              -- Picker interface ("telescope" or "snacks" or "fzf-lua" or "default")
              picker = "fzf-lua",
              ---Automatically generate titles for new chats
              auto_generate_title = true,
              title_generation_opts = {
                ---Adapter for generating titles (defaults to active chat's adapter)
                adapter = nil, -- e.g "copilot"
                ---Model for generating titles (defaults to active chat's model)
                model = nil, -- e.g "gpt-4o"
              },
              ---On exiting and entering neovim, loads the last chat on opening chat
              continue_last_chat = false,
              ---When chat is cleared with `gx` delete the chat from history
              delete_on_clearing_chat = false,
              ---Directory path to save the chats
              dir_to_save = vim.fn.stdpath("data") .. "/codecompanion-history",
              ---Enable detailed logging for history extension
              enable_logging = false,
            },
          },
        },
        adapters = {
          openrouter = function()
            return require("codecompanion.adapters").extend("openai_compatible", {
              env = {
                url = "https://openrouter.ai/api",
                api_key = "OPENROUTER_API_KEY",
                chat_url = "/v1/chat/completions",
              },
              schema = {
                model = {
                  default = "google/gemini-2.5-flash-preview-05-20",
                },
              },
            })
          end,
        },
        display = {
          chat = {
            auto_scroll = false,
          },
        },
        strategies = {
          inline = {
            adapter = "openrouter", --'copilot',
          },
          chat = {
            adapter = "openrouter", --'copilot',
            send = {
              callback = function(chat)
                vim.cmd("stopinsert")
                chat:add_buf_message({ role = "llm", content = "" })
                chat:submit()
              end,
              index = 1,
              description = "Send",
            },
            keymaps = {
              close = {
                modes = { n = "q", i = "<leader>aa" },
              },
              stop = {
                modes = { n = "s" },
              },
            },
            tools = {
              opts = {
                auto_submit_errors = false, -- Send any errors to the LLM automatically?
                auto_submit_success = false, -- Send any successful output to the LLM automatically?
              },
            },
          },
        },
      }
    end,
    keys = {
      { "<leader>ac", "<cmd>CodeCompanionActions<cr>", desc = "AI [C]ode Actions", mode = { "n", "v" } },
      { "<leader>at", "<cmd>CodeCompanionChat Toggle<cr>", desc = "AI [T]oggle", mode = { "n", "v" } },
      { "<leader>ap", "<cmd>CodeCompanionChat Add<cr>", desc = "AI [A]dd to Chat", mode = { "v" } },
      { "<leader>aa", "<cmd>CodeCompanionChat<cr>", desc = "AI Chat", mode = { "n", "v" } },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "ravitemer/codecompanion-history.nvim",
    },
  },
}
