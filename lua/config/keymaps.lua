-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Terminal keymaps
-- Open vertical split terminal with <leader>vt
vim.keymap.set("n", "<leader>vt", ":vsplit | terminal<CR>", { desc = "Vertical split terminal" })

-- Terminal navigation: Ctrl+h to go left, Ctrl+l to go right
-- Exit terminal mode and navigate
vim.keymap.set("t", "<C-h>", "<C-\\><C-n><C-w>h", { desc = "Go to left window from terminal" })
vim.keymap.set("t", "<C-l>", "<C-\\><C-n><C-w>l", { desc = "Go to right window from terminal" })

-- Also allow Ctrl+h and Ctrl+l in normal mode for window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })
