return {
  {
    "AstroNvim/astrolsp",
    ---@param opts AstroLSPOpts
    opts = function(_, opts)
      opts.servers = opts.servers or {}
      table.insert(opts.servers, "laravel_lsp")

      -- extend our configuration table to have our new prolog server
      opts.config = require("astrocore").extend_tbl(opts.config or {}, {
        -- this must be a function to get access to the `lspconfig` module
        laravel_lsp = {
          -- the command for starting the server
          cmd = {
            "laravel-ls",
          },
          -- the filetypes to attach the server to
          filetypes = { "php", "blade" },
          -- root directory detection for detecting the project root
          root_dir = require("lspconfig.util").root_pattern "composer.json",
        },
      })
    end,
  },
  {
    "adalessa/laravel.nvim",
    dependencies = {
      "tpope/vim-dotenv",
      "nvim-telescope/telescope.nvim",
      "MunifTanjim/nui.nvim",
      "kevinhwang91/promise-async",
    },
    cmd = { "Laravel" },
    keys = {
      { "<leader>lra", function() Laravel.pickers.laravel() end, desc = "Laravel: Open Laravel Picker" },
      { "<leader>lrr", function() Laravel.pickers.routes() end, desc = "Laravel: Open Routes Picker" },
      { "<leader>lrm", function() Laravel.pickers.make() end, desc = "Laravel: Open Make Picker" },
    },
    event = { "VeryLazy" },
    opts = {},
    config = true,
  },
}
