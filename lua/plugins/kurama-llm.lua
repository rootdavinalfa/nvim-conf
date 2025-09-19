local config = require "config/enable"

if not config.LLM then return {} end

return {
  "Kurama622/llm.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim" },
  cmd = { "LLMSessionToggle", "LLMSelectedTextHandler", "LLMAppHandler" },
  config = function()
    local tools = require "llm.tools"
    require("llm").setup {
      prompt = "You are a professional programmer.",

      models = {
        {
          name = "LM Studio",
          url = "http://localhost:1234/v1/chat/completions",
          model = "qwen/qwen3-4b-2507",
          api_type = "openai",
        },
        {
          name = "Ollama",
          url = "http://localhost:11434/v1/completions",
          model = "qwen2.5-coder:7b",
          api_type = "ollama",
        },

        {
          name = "Gemini 2.5 Flash",
          url = "https://generativelanguage.googleapis.com/v1beta/openai/",
          model = "gemini-2.5-flash",
          api_type = "openai",
          fetch_key = function() return vim.env.GEMINI_KEY end,
        },
      },

      keys = {
        -- The keyboard mapping for the input window.
        ["Input:Submit"] = { mode = "n", key = "<cr>" },
        ["Input:Cancel"] = { mode = { "n", "i" }, key = "<C-c>" },
        ["Input:Resend"] = { mode = { "n", "i" }, key = "<C-r>" },

        -- only works when "save_session = true"
        ["Input:HistoryNext"] = { mode = { "n", "i" }, key = "<C-j>" },
        ["Input:HistoryPrev"] = { mode = { "n", "i" }, key = "<C-k>" },

        ["Input:ModelsPrev"] = { mode = { "n", "i" }, key = "<C-n>" },

        -- The keyboard mapping for the output window in "split" style.
        ["Output:Ask"] = { mode = "n", key = "i" },
        ["Output:Cancel"] = { mode = "n", key = "<C-c>" },
        ["Output:Resend"] = { mode = "n", key = "<C-r>" },

        -- The keyboard mapping for the output and input windows in "float" style.
        ["Session:Toggle"] = { mode = "n", key = "<leader>aic" },
        ["Session:Close"] = { mode = "n", key = { "<esc>", "Q" } },

        -- Scroll
        ["PageUp"] = { mode = { "i", "n" }, key = "<C-b>" },
        ["PageDown"] = { mode = { "i", "n" }, key = "<C-f>" },
        ["HalfPageUp"] = { mode = { "i", "n" }, key = "<C-u>" },
        ["HalfPageDown"] = { mode = { "i", "n" }, key = "<C-d>" },
        ["JumpToTop"] = { mode = "n", key = "gg" },
        ["JumpToBottom"] = { mode = "n", key = "G" },
      },
      app_handler = {

        Completion = {
          handler = tools.completion_handler,
          opts = {

            url = "http://localhost:1234/v1/completions",
            model = "qwen/qwen3-4b-2507",
            api_type = "openai",
            -- Ollama
            -- url = "http://localhost:11434/v1/completions",
            -- model = "qwen2.5-coder:7b",
            -- api_type = "ollama",

            -- Gemini
            -- url = "https://generativelanguage.googleapis.com/v1beta/openai/",
            -- model = "gemini-2.5-pro",
            -- api_type = "openai",
            -- fetch_key = function() return vim.env.GEMINI_KEY end,

            n_completions = 3,
            context_window = 512,
            max_tokens = 256,

            -- A mapping of filetype to true or false, to enable completion.
            --filetypes = { sh = false },

            -- Whether to enable completion of not for filetypes not specifically listed above.
            default_filetype_enabled = true,

            auto_trigger = true,

            -- just trigger by { "@", ".", "(", "[", ":", " " } for `style = "nvim-cmp"`
            only_trigger_by_keywords = true,

            style = "virtual_text", -- nvim-cmp or blink.cmp

            timeout = 10, -- max request time

            -- only send the request every x milliseconds, use 0 to disable throttle.
            throttle = 500,
            -- debounce the request in x milliseconds, set to 0 to disable debounce
            debounce = 400,

            --------------------------------
            ---   just for virtual_text
            --------------------------------
            keymap = {
              virtual_text = {
                accept = {
                  mode = "i",
                  keys = "<A-a>",
                },
                next = {
                  mode = "i",
                  keys = "<A-n>",
                },
                prev = {
                  mode = "i",
                  keys = "<A-p>",
                },
                toggle = {
                  mode = "n",
                  keys = "<leader>cp",
                },
              },
            },
          },
        },
      },
    }
  end,
  keys = {
    { "<leader>aic", mode = "n", "<cmd>LLMSessionToggle<cr>", desc = "Toggle AI Chat Session" },
  },
}
