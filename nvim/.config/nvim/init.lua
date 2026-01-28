-- Set leader keys for Neovim
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Load core configuration modules
require("config.options")
require("config.keymaps")
require("config.autocmds")
require("custom_plugins.opencode")
require("config.lazy")

-- Apply transparency to specified highlight groups by removing background
local function apply_transparency()
  local hl_groups = {
    "Normal", "NormalNC", "NormalFloat",
    "NeoTreeNormal", "NeoTreeNormalNC", "SignColumn", "EndOfBuffer"
  }
  for _, group in ipairs(hl_groups) do
    vim.api.nvim_set_hl(0, group, { bg = "none", ctermbg = "none" })
  end
end

-- Reload the theme configuration and apply styling
local function reload_theme()
  -- Path to the matugen colors file
  local matugen_path = vim.fn.expand("$HOME/.config/nvim/lua/colors.lua")

  -- Load colors from matugen if available, otherwise fallback to base16
  local f = io.open(matugen_path, "r")
  if f then
    f:close()
    local ok, err = pcall(dofile, matugen_path)
    if not ok then
      vim.notify("Error loading colors.lua: " .. tostring(err), vim.log.levels.ERROR)
    end
  else
    pcall(vim.cmd, 'colorscheme base16')
  end

  -- Reload lualine configuration
  package.loaded["plugins.lualine"] = nil
  local status_ok, lualine = pcall(require, "plugins.lualine")

  if status_ok then
    if type(lualine) == "table" and lualine.config then
      lualine.config()
    end
  end

  -- Apply italic styling to comments
  vim.api.nvim_set_hl(0, "Comment", { italic = true })

  -- Apply transparency settings
  apply_transparency()
end

-- Create autocmd to reload theme when SIGUSR1 signal is received
vim.api.nvim_create_autocmd("Signal", {
  pattern = "SIGUSR1",
  callback = function()
    reload_theme()
    vim.notify("Matugen colors updated!", vim.log.levels.INFO)
  end,
})

-- Initialize theme on startup
reload_theme()
