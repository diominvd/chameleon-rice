return {
    "nvim-lualine/lualine.nvim",
    opts = function()
        local colors = {
            accent = 4,
            fg     = 7,
            black  = 0,
        }

        return {
            options = {
                theme = "16color",
                globalstatus = true,
                section_separators = { left = '', right = '' },
                component_separators = { left = '│', right = '│' },
            },
            sections = {
                lualine_a = {
                    {
                        "mode",
                        color = { fg = colors.black, bg = colors.accent, gui = "bold" }
                    },
                },
                lualine_b = {
                    { "branch", icon = "󰊢", color = { fg = colors.accent } },
                },
                lualine_c = {
                    {
                        "filetype",
                        icon_only = true,
                        padding = { left = 1, right = 0 },
                        color = { fg = colors.accent }
                    },
                    { "filename", path = 0, color = { fg = colors.fg } },
                },
                lualine_x = {
                    { "diagnostics", symbols = { error = "󰅚 ", warn = "󰀪 ", info = "󰋽 ", hint = "󰌶 " } },
                },
                lualine_y = {
                    { "location", color = { fg = colors.accent } },
                },
                lualine_z = {
                    {
                        function() return "󰚑" end,
                        color = { fg = colors.black, bg = colors.accent },
                        padding = { left = 1, right = 1 },
                    },
                },
            },
        }
    end,
}
