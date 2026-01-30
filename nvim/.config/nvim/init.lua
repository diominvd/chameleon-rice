-- Set leader keys for Neovim
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Load lazy.nvim first (plugin manager)
require("config.lazy")

-- Load core configuration modules in proper order
require("config.options")
require("config.keymaps")
require("config.autocmds")
require("custom_plugins.opencode")

-- Theme management with matugen integration
local function setup_theme()
  -- Path to the matugen colors file
  local colors_path = vim.fn.expand("$HOME/.config/nvim/lua/colors.lua")

  -- Load colors from matugen if available, otherwise fallback to default
  local file = io.open(colors_path, "r")
  if file then
    file:close()
    local ok, err = pcall(dofile, colors_path)
    if not ok then
      vim.notify("Error loading colors.lua: " .. tostring(err), vim.log.levels.ERROR)
      vim.cmd('colorscheme default')
    end
  else
    vim.cmd('colorscheme default')
  end

  -- Apply italic styling to comments
  vim.api.nvim_set_hl(0, "Comment", { italic = true })
end

-- Create autocmd to reload theme when SIGUSR1 signal is received (for matugen)
vim.api.nvim_create_autocmd("Signal", {
  pattern = "SIGUSR1",
  callback = function()
    setup_theme()
    local status_ok, lualine = pcall(require, "lualine")
    if status_ok then
      lualine.setup(require('lualine').get_config()) -- Пересобирает lualine с новыми цветами
    end

    vim.notify("Theme colors updated!", vim.log.levels.INFO)
  end,
})

-- Initialize theme on startup
setup_theme()

