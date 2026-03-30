-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- User Custom Keymaps

-- Exit insert mode with 'jj'
map("i", "jj", "<Esc>", { desc = "Exit insert mode" })

-- Line navigation: Start and End of line
-- These override LazyVim defaults:
--   <leader>h: Original LazyVim usually maps this to "Health" or "Home"
--   <leader>l: Original LazyVim usually maps this to "Lazy" (Plugin Manager)
map("n", "<leader>h", "^", { desc = "Go to beginning of line" })
map("n", "<leader>l", "$", { desc = "Go to end of line" })

-- GUIDE: Accessing original LazyVim functionality
-- If you need to access the features previously mapped to <leader>h or <leader>l:
-- 1. Use the Command Line:
--    - For Health check: Type ':checkhealth'
--    - For Lazy UI: Type ':Lazy'
-- 2. Use the Main Menu (if applicable):
--    - Press <leader> to see the Which-Key popup and find the alternative keys.
