-- Auto-closing brackets and quotes
return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",  -- Load on entering insert mode
  opts = {
    check_ts = true,
    disable_filetype = { "TelescopePrompt" },
  },
  config = function(_, opts)
    require("nvim-autopairs").setup(opts)
  end
}
