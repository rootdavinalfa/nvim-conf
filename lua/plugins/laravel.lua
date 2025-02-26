return {
  "adalessa/laravel.nvim",
  dependencies = {
    "tpope/vim-dotenv",
    "nvim-telescope/telescope.nvim",
    "MunifTanjim/nui.nvim",
    "kevinhwang91/promise-async",
  },
  cmd = { "Laravel" },
  keys = {
    { "<leader>lra", ":Laravel artisan<cr>" },
    { "<leader>lrr", ":Laravel routes<cr>" },
    { "<leader>lrm", ":Laravel related<cr>" },
  },
  event = { "VeryLazy" },
  opts = {
    lsp_server = "intelephense",
  },
  config = true,
}
