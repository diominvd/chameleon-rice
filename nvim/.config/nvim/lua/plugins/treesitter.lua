-- Tree-sitter: Advanced syntax highlighting and code parsing
return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
        -- List of parsers to install (and auto-install if missing)
        ensure_installed = {
            "python",           -- Python support
            "lua",              -- Lua support
            "vim",              -- VimScript support
            "vimdoc",           -- Vim documentation
            "markdown",         -- Markdown support
            "markdown_inline",  -- Inline Markdown support
            "bash",             -- Bash/Shell support
            "javascript",       -- JavaScript support
            "typescript",       -- TypeScript support
            "json",             -- JSON support
        },
        -- Auto-install missing parsers on BufReadPost
        auto_install = true,
        -- Enable syntax highlighting
        highlight = {
            enable = true,
            -- Don't use regex fallback for highlighting
            additional_vim_regex_highlighting = false,
        },
        -- Enable smart indentation based on AST
        indent = { enable = true },
    },
}
