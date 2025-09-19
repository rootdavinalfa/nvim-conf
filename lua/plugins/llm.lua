local config = require "config/enable"

if not config.LLM then return {} end
return {
  "saghen/blink.cmp",
  dependencies = { "Kurama622/llm.nvim" },
  opts = {
    completion = {
      trigger = {
        prefetch_on_insert = false,
        -- allow triggering by white space
        show_on_blocked_trigger_characters = {},
      },
    },

    keymap = {
      ["<C-y>"] = {
        function(cmp) cmp.show { providers = { "llm" } } end,
      },
    },

    sources = {
      -- if you want to use auto-complete
      default = { "llm" },

      per_filetype = {
        -- optionally inherit from the `default` sources
        -- e.g. set completion for llm buffer
        -- llm = { inherit_defaults = true, "path" }, -- enable: "llm", "llm_cmds", "path"
        llm = { inherit_defaults = false }, -- enbale: "llm_cmds"
      },

      ---@note Windsurf does not require the following configuration
      providers = {
        llm = {
          name = "LLM",
          module = "llm.common.completion.frontends.blink",
          timeout_ms = 10000,
          score_offset = 100,
          async = true,
        },
      },
    },
  },
}
