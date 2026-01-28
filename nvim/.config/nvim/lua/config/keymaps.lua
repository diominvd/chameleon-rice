-- ============================================================================
-- Custom Key Mappings for Neovim
-- ============================================================================

-- ============================================================================
-- Save & Exit Commands (Leader + w/q)
-- ============================================================================
vim.keymap.set("n", "<leader>w", ":w<CR>", { noremap = true, desc = "Save current file" })
vim.keymap.set("n", "<leader>wq", ":wqa<CR>", { noremap = true, desc = "Save all and exit" })
vim.keymap.set("n", "<leader>qq", ":qa!<CR>", { noremap = true, desc = "Exit without saving" })
vim.keymap.set("n", "<leader>er", ":e!<CR>", { noremap = true, desc = "Reload current file (force)" })

-- ============================================================================
-- Insert Mode Escape
-- ============================================================================
vim.keymap.set("i", "jk", "<Esc>", { noremap = true, desc = "Exit insert mode" })
vim.keymap.set("i", "kj", "<Esc>", { noremap = true, desc = "Exit insert mode" })

-- ============================================================================
-- Window Navigation (Ctrl + hjkl)
-- ============================================================================
vim.keymap.set("n", "<C-h>", "<C-w>h", { noremap = true, desc = "Navigate to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { noremap = true, desc = "Navigate to bottom window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { noremap = true, desc = "Navigate to top window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { noremap = true, desc = "Navigate to right window" })

-- ============================================================================
-- Search
-- ============================================================================
vim.keymap.set("n", "<Esc>", ":noh<CR>", { noremap = true, desc = "Clear search highlights" })
vim.keymap.set("n", "n", "nzzzv", { noremap = true, desc = "Next search result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { noremap = true, desc = "Previous search result (centered)" })

-- ============================================================================
-- Visual Mode: Indentation & Block Movement
-- ============================================================================
vim.keymap.set("v", "<", "<gv", { noremap = true, desc = "Decrease indentation (keep selection)" })
vim.keymap.set("v", ">", ">gv", { noremap = true, desc = "Increase indentation (keep selection)" })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { noremap = true, desc = "Move selection down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { noremap = true, desc = "Move selection up" })

-- ============================================================================
-- Line Operations
-- ============================================================================
vim.keymap.set("n", "<leader>d", "dd", { noremap = true, desc = "Delete current line" })
vim.keymap.set("n", "<leader>y", "yy", { noremap = true, desc = "Yank current line" })
vim.keymap.set("n", "Y", "y$", { noremap = true, desc = "Yank to end of line" })

-- ============================================================================
-- Window Management
-- ============================================================================
vim.keymap.set("n", "<leader>sv", ":vsplit<CR>", { noremap = true, desc = "Split window vertically" })
vim.keymap.set("n", "<leader>sh", ":split<CR>", { noremap = true, desc = "Split window horizontally" })
vim.keymap.set("n", "<leader>se", "<C-w>=", { noremap = true, desc = "Equalize window sizes" })
vim.keymap.set("n", "<leader>sx", ":close<CR>", { noremap = true, desc = "Close current window" })

-- ============================================================================
-- Buffer Management
-- ============================================================================
vim.keymap.set("n", "<leader>bn", ":bnext<CR>", { noremap = true, desc = "Next buffer" })
vim.keymap.set("n", "<leader>bp", ":bprevious<CR>", { noremap = true, desc = "Previous buffer" })
vim.keymap.set("n", "<leader>bd", ":bdelete<CR>", { noremap = true, desc = "Delete buffer" })
vim.keymap.set("n", "<leader>ba", ":%bd<CR>", { noremap = true, desc = "Delete all buffers" })

-- ============================================================================
-- Quick Navigation
-- ============================================================================
vim.keymap.set("n", "gg", "gg", { noremap = true, desc = "Go to start of file" })
vim.keymap.set("n", "G", "G", { noremap = true, desc = "Go to end of file" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true, desc = "Page down (centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true, desc = "Page up (centered)" })

-- ============================================================================
-- Terminal Mode (if terminal plugin is used)
-- ============================================================================
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { noremap = true, desc = "Exit terminal mode" })
vim.keymap.set("t", "<C-h>", [[<C-\><C-n><C-w>h]], { noremap = true, desc = "Navigate left from terminal" })
vim.keymap.set("t", "<C-j>", [[<C-\><C-n><C-w>j]], { noremap = true, desc = "Navigate down from terminal" })
vim.keymap.set("t", "<C-k>", [[<C-\><C-n><C-w>k]], { noremap = true, desc = "Navigate up from terminal" })
vim.keymap.set("t", "<C-l>", [[<C-\><C-n><C-w>l]], { noremap = true, desc = "Navigate right from terminal" })
