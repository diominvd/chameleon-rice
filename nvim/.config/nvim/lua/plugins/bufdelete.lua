-- Smart buffer deletion that handles window management
return {
    "famiu/bufdelete.nvim",
    keys = {
        { "<leader>x", ":Bdelete<CR>", noremap = true, desc = "Delete current buffer" },
    },
}
