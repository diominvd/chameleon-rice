-- Toggle terminal emulator inside Neovim
return {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = function()
        require("toggleterm").setup({
            size = 10,
            open_mapping = [[<C-t>]],  -- Toggle with Ctrl+t
            direction = 'horizontal',
            start_in_insert = true,
            persist_size = true,
        })

        -- Setup terminal mode keybindings
        function _G.set_terminal_keymaps()
            local opts = {buffer = 0, noremap = true}
            vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
            vim.keymap.set('t', '<C-h>', [[<C-\><C-n><C-w>h]], vim.tbl_extend("force", opts, { desc = "Navigate left from terminal" }))
            vim.keymap.set('t', '<C-j>', [[<C-\><C-n><C-w>j]], vim.tbl_extend("force", opts, { desc = "Navigate down from terminal" }))
            vim.keymap.set('t', '<C-k>', [[<C-\><C-n><C-w>k]], vim.tbl_extend("force", opts, { desc = "Navigate up from terminal" }))
            vim.keymap.set('t', '<C-l>', [[<C-\><C-n><C-w>l]], vim.tbl_extend("force", opts, { desc = "Navigate right from terminal" }))
            vim.keymap.set("t", "<C-t>", [[<C-\><C-n>:ToggleTerm<CR>]], vim.tbl_extend("force", opts, { desc = "Toggle terminal" }))
        end

        -- Auto-setup keymaps when terminal opens
        vim.api.nvim_create_autocmd("TermOpen", {
            pattern = "term://*",
            callback = function()
                _G.set_terminal_keymaps()
            end,
        })

        -- ============================================================================
        -- Terminal Window Resize Keybindings
        -- ============================================================================
        vim.keymap.set('n', '<C-Up>', ':resize +2<CR>', 
            { noremap = true, desc = "Increase window height" })
        vim.keymap.set('n', '<C-Down>', ':resize -2<CR>', 
            { noremap = true, desc = "Decrease window height" })
    end
}
