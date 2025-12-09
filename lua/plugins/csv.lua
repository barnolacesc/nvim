return {
  {
    "chrisbra/csv.vim",
    ft = { "csv" },
    config = function()
      vim.g.csv_autocmd_arrange = 1
      vim.g.csv_autocmd_arrange_size = 1024 * 1024
    end,
  },
}
