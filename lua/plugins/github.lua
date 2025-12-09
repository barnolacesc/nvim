return {
  {
    "folke/snacks.nvim",
    keys = {
      {
        "<leader>gr",
        function()
          -- Use Snacks.gitbrowse to open the repo root
          Snacks.gitbrowse({ what = "repo" })
        end,
        desc = "Git Browse (repo root)",
      },
      {
        "<leader>gPR",
        function()
          -- Use Snacks.gitbrowse to open the current branch/PR
          Snacks.gitbrowse({ what = "branch" })
        end,
        desc = "Git Browse (branch/PR)",
      },
    },
  },
}
