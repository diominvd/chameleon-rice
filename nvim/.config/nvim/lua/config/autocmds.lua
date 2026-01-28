-- ============================================================================
-- Automatic Commands (Autocmds)
-- ============================================================================

-- Most autocmds are defined in their respective plugin configs (init.lua, plugins/*)
-- This file can be used for global autocmds that don't belong to specific plugins

-- Example: You can add custom autocmds here for:
-- - Auto-format on save
-- - Highlight yanked text
-- - Custom file type handling
-- - etc.

-- Uncomment example below to highlight yanked text for 200ms:
-- vim.api.nvim_create_autocmd("TextYankPost", {
--     group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
--     callback = function()
--         vim.highlight.on_yank({ timeout = 200 })
--     end,
-- })
