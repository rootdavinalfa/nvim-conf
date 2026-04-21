return {
  {
    "Juksuu/worktrees.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "VeryLazy",
    opts = {
      worktree_path = ".worktrees",
    },
  },
}
