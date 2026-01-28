-- Git signs and blame display in sign column
return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    -- Git change indicators
    signs = {
      add          = { text = '┃' },
      change       = { text = '┃' },
      delete       = { text = '_' },
      topdelete    = { text = '‾' },
      changedelete = { text = '~' },
      untracked    = { text = '┆' },
    },
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigate hunks (changes)
      map('n', ']c', function()
        if vim.wo.diff then return ']c' end
        vim.schedule(function() gs.next_hunk() end)
        return '<Ignore>'
      end, { expr = true, noremap = true, desc = "Next git change" })

      map('n', '[c', function()
        if vim.wo.diff then return '[c' end
        vim.schedule(function() gs.prev_hunk() end)
        return '<Ignore>'
      end, { expr = true, noremap = true, desc = "Previous git change" })

      -- Git operations
      map('n', '<leader>hb', function() gs.blame_line { full = true } end, 
        { noremap = true, desc = "Show git blame" })
      map('n', '<leader>hp', function() gs.preview_hunk() end, 
        { noremap = true, desc = "Preview git changes" })
      map('n', '<leader>hr', function() gs.reset_hunk() end, 
        { noremap = true, desc = "Reset hunk" })
    end
  }
}
