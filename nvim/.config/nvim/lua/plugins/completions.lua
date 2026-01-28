return {
    {
        -- Code completion engine for Neovim with LSP support
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",     -- LSP completion source
            "L3MON4D3/LuaSnip",         -- Snippet engine
            "saadparwaiz1/cmp_luasnip", -- Snippet completion source
            "hrsh7th/cmp-buffer",       -- Buffer completion source
            "hrsh7th/cmp-path",         -- Path completion source
        },
        config = function()
            local cmp = require("cmp")
            cmp.setup({
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),  -- Scroll docs up
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),   -- Scroll docs down
                    ['<C-Space>'] = cmp.mapping.complete(),   -- Trigger completion
                    ['<C-e>'] = cmp.mapping.abort(),          -- Abort completion
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),  -- Confirm selection
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        -- Navigate to next item or expand snippet
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif require("luasnip").expand_or_jumpable() then
                            require("luasnip").expand_or_jump()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                    ['<S-Tab>'] = cmp.mapping(function(fallback)
                        -- Navigate to previous item
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif require("luasnip").jumpable(-1) then
                            require("luasnip").jump(-1)
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },    -- LSP completions
                    { name = 'luasnip' },     -- Snippet completions
                    { name = 'path' },        -- Path completions
                }, {
                    { name = 'buffer' },      -- Buffer word completions
                })
            })
        end
    }
}
