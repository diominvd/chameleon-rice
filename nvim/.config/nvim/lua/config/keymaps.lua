local keymap = vim.keymap

vim.keymap.set("n", "<leader>k", "2<C-w>w", { desc = "Jump to code" })

vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save" })
vim.keymap.set("n", "<leader>wq", ":wqa<CR>", { desc = "Save and exit" })
vim.keymap.set("n", "<leader>qq", ":qa!<CR>", { desc = "Exit without save" })

-- Reload current file
vim.keymap.set("n", "<leader>er", ":e!<CR>", { desc = "Reload current file (force)" })

vim.keymap.set("i", "jk", "<Esc>", { desc = "Exit insert mode" })
vim.keymap.set("i", "kj", "<Esc>", { desc = "Exit insert mode" })

vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Bottom window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Top window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Right window" })

vim.keymap.set("n", "<Esc>", ":noh<CR>", { desc = "Clear search" })

vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
