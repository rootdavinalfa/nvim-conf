-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE
-- Customize Treesitter
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    treesitter = {
      enabled = function(_, bufnr) return not require("astrocore.buffer").is_large(bufnr) end,
      ensure_installed = { "vim", "lua" },
      textobjects = {
        select = {
          select_textobject = {
            ["ak"] = { query = "@block.outer", desc = "around block" },
            ["af"] = { query = "@function.outer", desc = "around function" },
            ["if"] = { query = "@function.inner", desc = "around function" },
          },
        },
      },
    },
  },
}
