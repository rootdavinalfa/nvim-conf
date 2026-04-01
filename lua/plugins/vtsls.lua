return {
  {
    "AstroNvim/astrolsp",
    ---@param opts AstroLSPOpts
    opts = function(_, opts)
      opts.servers = opts.servers or {}
      table.insert(opts.servers, "vtsls")

      opts.config = require("astrocore").extend_tbl(opts.config or {}, {
        vtsls = {
          settings = {
            vtsls = {
              tsserver = {
                -- 6 GB in MB
                maxTsServerMemory = 6144,
              },
            },
          },
        },
      })
    end,
  },
  {
    "mason-org/mason-lspconfig.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "vtsls" })
    end,
  },
}
