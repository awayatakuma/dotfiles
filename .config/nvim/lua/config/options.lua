-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- User Custom Options
vim.opt.wrap = true
vim.opt.list = true
vim.opt.listchars = { space = "·", tab = "→ ", trail = "·", nbsp = "◊" }

-- Set absolute line numbers
vim.opt.number = true
vim.opt.relativenumber = false
