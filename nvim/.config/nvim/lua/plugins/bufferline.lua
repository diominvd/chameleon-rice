-- Buffer tabs with smooth navigation
return {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
        require("bufferline").setup({
            options = {
                -- Offset for neo-tree to avoid covering tabs
                offsets = {
                    {
                        filetype = "neo-tree",
                        text = "File Explorer",
                        highlight = "Directory",
                        text_align = "left",
                    }
                },
            }
        })
        
        -- ============================================================================
        -- Buffer Navigation Keybindings
        -- ============================================================================
        vim.keymap.set("n", "<Tab>", "<cmd>BufferLineCycleNext<cr>", 
            { noremap = true, desc = "Next buffer" })
        vim.keymap.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", 
            { noremap = true, desc = "Previous buffer" })
    end,
}
