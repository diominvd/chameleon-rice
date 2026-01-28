-- Code formatter with multiple backend support
return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd   = { "ConformInfo" },
  keys  = {
    {
      "<leader>fmt",
      function()
        require("conform").format({ async = true, lsp_fallback = true })
      end,
      mode = "",
      noremap = true,
      desc = "Format buffer",
    },
  },
  opts  = {
    -- Configure formatters for each filetype
    formatters_by_ft = {
      python = { "isort", "black" },
      yaml = { "prettier" },
      lua = { "stylua" },
      javascript = { "prettier" },
      typescript = { "prettier" },
      json = { "prettier" },
    },
    -- Auto-format on save
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },
  },
}
