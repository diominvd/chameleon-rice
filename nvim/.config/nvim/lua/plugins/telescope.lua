return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local telescope = require("telescope")
    local builtin = require("telescope.builtin")

    -- Configure Telescope appearance and behavior
    telescope.setup({
      defaults = {
        borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            preview_width = 0.5,
          },
        },
      }
    })
    
    -- ============================================================================
    -- Telescope Keybindings
    -- ============================================================================
    
    -- Find files with hidden files support
    vim.keymap.set("n", "<leader>ff", function()
      builtin.find_files({
        hidden = true,
        no_ignore = false
      })
    end, { noremap = true, desc = "Find files" })
    
    -- Live grep (search content in files)
    vim.keymap.set("n", "<leader>fg", function()
      builtin.live_grep({
        additional_args = function()
          return { "--hidden" }
        end
      })
    end, { noremap = true, desc = "Live grep (search files)" })
    
    -- Search in open buffers
    vim.keymap.set("n", "<leader>fb", builtin.buffers, 
      { noremap = true, desc = "Find buffers" })
    
    -- Search keybindings
    vim.keymap.set("n", "<leader>fk", builtin.keymaps, 
      { noremap = true, desc = "Find keymaps" })
    
    -- Help tags
    vim.keymap.set("n", "<leader>fh", builtin.help_tags, 
      { noremap = true, desc = "Find help tags" })
    
    -- Git files (faster than find_files in git repos)
    vim.keymap.set("n", "<leader>fgf", builtin.git_files, 
      { noremap = true, desc = "Find git files" })
    
    -- Recent files (oldfiles)
    vim.keymap.set("n", "<leader>fo", builtin.oldfiles, 
      { noremap = true, desc = "Find recent files" })
    
    -- Search current word under cursor
    vim.keymap.set("n", "<leader>fw", builtin.grep_string, 
      { noremap = true, desc = "Search word under cursor" })
    
    -- Fuzzy search in current file
    vim.keymap.set("n", "<leader>fs", builtin.current_buffer_fuzzy_find, 
      { noremap = true, desc = "Search in current file" })
  end
}
