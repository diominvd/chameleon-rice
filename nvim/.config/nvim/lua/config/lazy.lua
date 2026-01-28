-- ============================================================================
-- Lazy.nvim Plugin Manager Setup
-- ============================================================================

-- Bootstrap lazy.nvim if not already installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
-- Add lazy.nvim to runtime path
vim.opt.rtp:prepend(lazypath)

-- ============================================================================
-- Load all plugins from plugins directory
-- ============================================================================
require("lazy").setup("plugins", {
  -- Don't notify about changes when plugins spec files are modified
  change_detection = {
    notify = false,
  },
})
