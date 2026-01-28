-- Transparent background support for terminal themes
return {
    "xiyaowong/transparent.nvim",
    lazy = false,
    priority = 1000,  -- Load with high priority
    config = function()
        require("transparent").setup({
            -- Groups to apply transparency to
            extra_groups = {
                "NormalFloat",
                "NvimTreeNormal",
                "BufferLineTabSelected",
                "BufferLineFill",
                "StatusLine",
            },
        })
        -- Enable transparency on startup
        vim.cmd("TransparentEnable")
    end,
}
