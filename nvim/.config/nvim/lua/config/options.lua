local opt = vim.opt

-- ============================================================================
-- Interface Options
-- ============================================================================
opt.number = true                    -- Show line numbers
opt.relativenumber = false           -- Disable relative line numbers
opt.signcolumn = "yes"               -- Always show sign column (for git, LSP, etc)
opt.cursorline = true                -- Highlight current line
opt.scrolloff = 8                    -- Keep 8 lines visible above/below cursor
opt.wrap = false                     -- Don't wrap long lines
opt.termguicolors = true             -- Enable 24-bit color support

-- ============================================================================
-- Indentation Settings
-- ============================================================================
opt.tabstop = 2                      -- Number of spaces that <Tab> counts for
opt.shiftwidth = 2                   -- Number of spaces for each indentation level
opt.expandtab = true                 -- Use spaces instead of tabs
opt.smartindent = true               -- Smart automatic indentation
opt.autoindent = true                -- Maintain current indentation level

-- ============================================================================
-- Search Behavior
-- ============================================================================
opt.ignorecase = true                -- Ignore case in search patterns
opt.smartcase = true                 -- Override 'ignorecase' if search contains uppercase
opt.hlsearch = true                  -- Highlight search results

-- ============================================================================
-- File Handling
-- ============================================================================
opt.swapfile = false                 -- Don't create swap files
opt.backup = false                   -- Don't create backup files
opt.undofile = true                  -- Persist undo history across sessions
opt.updatetime = 250                 -- Faster update time for triggers (ms)
opt.timeoutlen = 300                 -- Timeout for mapped sequences (ms)

-- ============================================================================
-- Window & Display
-- ============================================================================
opt.splitright = true                -- Open new splits to the right
opt.splitbelow = true                -- Open new splits below
opt.clipboard = "unnamedplus"        -- Use system clipboard
opt.mouse = "a"                      -- Enable mouse support in all modes
opt.pumheight = 10                   -- Maximum height of completion menu

-- ============================================================================
-- Appearance: Make background transparent for terminal theme
-- ============================================================================
vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    callback = function()
        local hl_groups = {
            "Normal", "NonText", "SignColumn", "EndOfBuffer", "MsgArea"
        }
        for _, group in ipairs(hl_groups) do
            -- Set background to NONE for transparency support
            vim.api.nvim_set_hl(0, group, { bg = "NONE", ctermbg = "NONE" })
        end
    end,
})
