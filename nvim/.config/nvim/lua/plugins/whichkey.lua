-- Which-key: Keybinding guide and helper
return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    -- Enable timeout for which-key to show suggestions
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {
    -- Use helix-style keybinding layout
    preset = "helix",
    -- Optionally show icons for keybindings
    icons = {
      breadcrumb = "»",
      separator = "➜",
      group = "+",
    },
  },
}
