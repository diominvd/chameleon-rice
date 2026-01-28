-- ============================================================================
-- OpenCode CLI Integration
-- ============================================================================

-- Toggle OpenCode terminal window (create or close)
local function opencode_toggle()
  local opencode_winid = nil
  local opencode_bufnr = nil

  -- Search for existing OpenCode window in current tab
  for _, winid in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    local bufnr = vim.api.nvim_win_get_buf(winid)
    if vim.bo[bufnr].buftype == "terminal" and vim.api.nvim_buf_get_name(bufnr):match("opencode") then
      opencode_winid = winid
      opencode_bufnr = bufnr
      break
    end
  end

  -- If window exists, close it
  if opencode_winid then
    vim.api.nvim_win_close(opencode_winid, false)
  else
    -- Search for OpenCode buffer in all buffers
    for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
      if vim.bo[bufnr].buftype == "terminal" and vim.api.nvim_buf_get_name(bufnr):match("opencode") then
        opencode_bufnr = bufnr
        break
      end
    end

    -- Create new vertical split window
    vim.cmd("botright vertical new")
    vim.cmd("vertical resize 60")

    -- Set local directory to project root
    local cwd = vim.fn.getcwd()
    vim.cmd("lcd " .. vim.fn.fnameescape(cwd))

    -- Reuse buffer or create new terminal
    if opencode_bufnr then
      vim.api.nvim_win_set_buf(0, opencode_bufnr)
    else
      vim.cmd("terminal opencode")
      vim.bo.buflisted = false  -- Don't list in buffers
    end
  end
end

-- Focus OpenCode window if it exists
local opencode_focus = function()
  local opencode_winid = nil
  for _, winid in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    local bufnr = vim.api.nvim_win_get_buf(winid)
    if vim.bo[bufnr].buftype == "terminal" and vim.api.nvim_buf_get_name(bufnr):match("opencode") then
      opencode_winid = winid
      break
    end
  end
  if opencode_winid then
    vim.api.nvim_set_current_win(opencode_winid)
  else
    vim.notify("OpenCode is not open. Use <leader>ai first", vim.log.levels.WARN)
  end
end

-- ============================================================================
-- OpenCode Keybindings
-- ============================================================================
vim.keymap.set("n", "<leader>ai", opencode_toggle, 
  { noremap = true, desc = "Toggle OpenCode CLI" })
vim.keymap.set("n", "<leader>af", opencode_focus, 
  { noremap = true, desc = "Focus OpenCode window" })
