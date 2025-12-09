return {
  "nvim-telescope/telescope.nvim",
  keys = {
    {
      "<leader>ff",
      function()
        require("telescope.builtin").find_files({
          hidden = true,
        })
      end,
      desc = "Find Files (including hidden)",
    },
  },
}
