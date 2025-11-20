-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Terminal keymaps
-- Open vertical split terminal with <leader>vt in current file's directory
vim.keymap.set("n", "<leader>vt", function()
  -- Get the directory of the current file, fallback to cwd if no file
  local current_file = vim.fn.expand("%:p")
  local file_dir

  if current_file ~= "" and vim.fn.filereadable(current_file) == 1 then
    file_dir = vim.fn.fnamemodify(current_file, ":h")
  else
    file_dir = vim.fn.getcwd()
  end

  -- Create a new vertical split
  vim.cmd("vnew")

  -- Change directory locally (only for this window)
  vim.cmd("lcd " .. vim.fn.fnameescape(file_dir))

  -- Start the terminal
  vim.cmd("terminal")

  -- Enter insert mode automatically
  vim.cmd("startinsert")
end, { desc = "Vertical split terminal (current file dir)" })

-- Open horizontal split terminal with <leader>ht in current file's directory
vim.keymap.set("n", "<leader>ht", function()
  -- Get the directory of the current file, fallback to cwd if no file
  local current_file = vim.fn.expand("%:p")
  local file_dir

  if current_file ~= "" and vim.fn.filereadable(current_file) == 1 then
    file_dir = vim.fn.fnamemodify(current_file, ":h")
  else
    file_dir = vim.fn.getcwd()
  end

  -- Create a new horizontal split
  vim.cmd("new")

  -- Change directory locally (only for this window)
  vim.cmd("lcd " .. vim.fn.fnameescape(file_dir))

  -- Start the terminal
  vim.cmd("terminal")

  -- Enter insert mode automatically
  vim.cmd("startinsert")
end, { desc = "Horizontal split terminal (current file dir)" })

-- Exit terminal mode with Esc (but not in Lazygit)
vim.keymap.set("t", "<Esc>", function()
  local buf_name = vim.api.nvim_buf_get_name(0)
  if string.match(buf_name, "lazygit") then
    -- Let Lazygit handle Esc normally
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
  else
    -- Exit terminal mode for other terminals
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, false, true), "n", false)
  end
end, { desc = "Exit terminal mode (except in Lazygit)" })

-- Terminal navigation: Ctrl+h to go left, Ctrl+l to go right
-- Exit terminal mode and navigate
vim.keymap.set("t", "<C-h>", "<C-\\><C-n><C-w>h", { desc = "Go to left window from terminal" })
vim.keymap.set("t", "<C-l>", "<C-\\><C-n><C-w>l", { desc = "Go to right window from terminal" })
vim.keymap.set("t", "<C-j>", "<C-\\><C-n><C-w>j", { desc = "Go to bottom window from terminal" })
vim.keymap.set("t", "<C-k>", "<C-\\><C-n><C-w>k", { desc = "Go to top window from terminal" })

-- Also allow Ctrl+hjkl in normal mode for window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to bottom window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to top window" })

-- Resize windows with leader + arrow keys (no conflicts with macOS)
vim.keymap.set("n", "<leader><Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
vim.keymap.set("n", "<leader><Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })
vim.keymap.set("n", "<leader><Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
vim.keymap.set("n", "<leader><Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })

-- Alternative: Use leader+hjkl for resize (vim-style)
vim.keymap.set("n", "<leader>wh", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
vim.keymap.set("n", "<leader>wl", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })
vim.keymap.set("n", "<leader>wk", "<cmd>resize +2<cr>", { desc = "Increase window height" })
vim.keymap.set("n", "<leader>wj", "<cmd>resize -2<cr>", { desc = "Decrease window height" })

-- Save current buffer with <leader>w
vim.keymap.set("n", "<leader>w", "<cmd>write<cr>", { desc = "Save current buffer (Write)" })
