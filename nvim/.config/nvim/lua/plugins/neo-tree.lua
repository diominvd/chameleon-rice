return {
  -- File explorer with git integration and file tree navigation
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  lazy = false,
  config = function()
    require("neo-tree").setup({
      window = {
        position = "left",
        width = "35",
        fixed_width = true,
        -- Custom keybindings for navigation within tree
        mappings = {
          ["l"] = "open",      -- Open file/folder with 'l'
          ["h"] = "close_node" -- Close folder with 'h'
        }
      },
      filesystem = {
        filtered_items = {
          visible = true,                         -- Show hidden files by default
        },
        follow_current_file = { enabled = true }, -- Follow currently edited file
        hijack_netrw_behavior = "open_default",   -- Replace netrw
      },
      default_component_configs = {
        git_status = {
          highlight = "NeoTreeGitStatus",
          -- Git status symbols for file states
          symbols = {
            added     = "✚",
            modified  = "",
            deleted   = "✖",
            untracked = "",
            ignored   = "",
            unstaged  = "󰄱",
            staged    = "",
            conflict  = "",
          }
        },
      },
    })

    -- Custom git status colors for better visibility
    local colors = {
      add    = "#88b369",
      change = "#92a1b1",
      delete = "#b36969",
    }

    local groups = {
      NeoTreeGitAdded = colors.add,
      NeoTreeGitModified = colors.change,
      NeoTreeGitDeleted = colors.delete,
      NeoTreeGitUntracked = colors.add,
      NeoTreeGitStatusAdded = colors.add,
      NeoTreeGitStatusModified = colors.change,
      NeoTreeGitStatusDeleted = colors.delete,
    }

    -- Apply git status highlight groups
    for group, color in pairs(groups) do
      vim.api.nvim_set_hl(0, group, { fg = color, force = true })
    end

    -- Auto-open Neo-tree on startup if no files are specified
    vim.api.nvim_create_autocmd("VimEnter", {
      desc = "Open Neo-tree on startup if directory is opened",
      group = vim.api.nvim_create_augroup("NeotreeAutoOpen", { clear = true }),
      callback = function()
        local no_args = vim.fn.argc() == 0
        local is_dir = vim.fn.argc() == 1 and vim.fn.isdirectory(vim.fn.argv(0)) == 1

        if no_args or is_dir then
          vim.cmd("Neotree show")
        end
      end,
    })

    -- ============================================================================
    -- Neo-tree Keybindings
    -- ============================================================================
    vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>",
      { noremap = true, desc = "Toggle file explorer" })
    vim.keymap.set("n", "<leader>o", ":Neotree focus<CR>",
      { noremap = true, desc = "Focus file explorer" })
  end
}
