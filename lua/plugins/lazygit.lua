return {
  {
    "kdheepak/lazygit.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
    config = function()
      -- Configure Lazygit to handle terminal properly
      vim.api.nvim_create_autocmd("TermOpen", {
        pattern = "*lazygit*",
        callback = function()
          -- For Lazygit terminal, map Ctrl+C to quit gracefully
          vim.keymap.set("t", "<C-c>", function()
            vim.cmd("close")
          end, { buffer = true, desc = "Close Lazygit" })
        end,
      })
    end,
  },
}
