-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Set leader key to space (LazyVim already sets this by default, but being explicit)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set shell to zsh (prefer homebrew zsh if available, otherwise use system zsh)
if vim.fn.executable("/opt/homebrew/bin/zsh") == 1 then
  vim.opt.shell = "/opt/homebrew/bin/zsh"
elseif vim.fn.executable("/bin/zsh") == 1 then
  vim.opt.shell = "/bin/zsh"
end
